#!/bin/bash

OUTPUT_FILE="testfile.txt"

PROJECT_FILE=$(find . -maxdepth 1 -name "*.xcodeproj" | head -n 1)
if [ -z "$PROJECT_FILE" ]; then
    echo "Error: No .xcodeproj found."
    exit 1
fi

declare -a ITEMS_NAME
declare -a ITEMS_TYPE
declare -a ITEMS_LEVEL
declare -a ITEMS_PARENT
declare -a ITEMS_EXPANDED
declare -a ITEMS_SELECTED
declare -a ITEMS_ID

add_item() {
    local name="$1"
    local type="$2"
    local level="$3"
    local parent="$4"
    local id="$5"
    
    if [ -z "$name" ]; then return; fi

    local idx=${#ITEMS_NAME[@]}
    ITEMS_NAME[$idx]="$name"
    ITEMS_TYPE[$idx]="$type"
    ITEMS_LEVEL[$idx]="$level"
    ITEMS_PARENT[$idx]="$parent"
    ITEMS_EXPANDED[$idx]=0
    ITEMS_SELECTED[$idx]=0
    ITEMS_ID[$idx]="$id"
}

echo "Parsing project structure... (Please wait)"

SCHEME_PATHS=$(find "$PROJECT_FILE" -name "*.xcscheme")

for scheme_path in $SCHEME_PATHS; do
    scheme_name=$(basename "$scheme_path" .xcscheme)
    scheme_idx=${#ITEMS_NAME[@]}
    
    add_item "$scheme_name" "SCHEME" 0 -1 "$scheme_name"
    
    TEST_TARGETS=$(grep -o 'BlueprintName = "[^"]*"' "$scheme_path" | cut -d '"' -f 2 | sort | uniq)
    
    for target in $TEST_TARGETS; do
        TARGET_DIR=$(find . -type d -name "$target" -not -path "*/.*" | head -n 1)
        if [ -z "$TARGET_DIR" ]; then continue; fi
        
        while IFS= read -r file; do
            class_name=$(grep -m 1 "class .*XCTestCase" "$file" | sed -E -n 's/.*class[[:space:]]+([A-Za-z0-9_]+)[[:space:]]*:.*XCTestCase.*/\1/p')
            
            if [ -z "$class_name" ]; then continue; fi
            
            class_idx=${#ITEMS_NAME[@]}
            add_item "$class_name" "CLASS" 1 "$scheme_idx" "$target/$class_name"
            
            funcs=$(grep "func test" "$file" | sed -E -n 's/.*func[[:space:]]+(test[A-Za-z0-9_]*).*/\1/p')
            
            for func in $funcs; do
                add_item "$func" "FUNC" 2 "$class_idx" "$target/$class_name/$func"
            done
        done < <(grep -r -l "class .*XCTestCase" "$TARGET_DIR")
    done
done

if [ ${#ITEMS_NAME[@]} -eq 0 ]; then
    echo "Error: No tests found."
    exit 1
fi

CURSOR=0
TOTAL=${#ITEMS_NAME[@]}

tput civis
tput clear

update_selection() {
    local idx=$1
    local new_state=$2
    
    ITEMS_SELECTED[$idx]=$new_state
    
    if [ "${ITEMS_TYPE[$idx]}" == "CLASS" ]; then
        for ((i=idx+1; i<TOTAL; i++)); do
            # Stop if we hit an item of same or higher level (end of children)
            if [ "${ITEMS_LEVEL[$i]}" -le "${ITEMS_LEVEL[$idx]}" ]; then break; fi
            ITEMS_SELECTED[$i]=$new_state
        done
    fi

    local parent=${ITEMS_PARENT[$idx]}
    if [ "$parent" -ne -1 ]; then
        
        if [ "${ITEMS_TYPE[$idx]}" == "FUNC" ]; then
            ITEMS_SELECTED[$parent]=0
        fi
    fi
}

get_display_row() {
    local idx=$1
    local parent=${ITEMS_PARENT[$idx]}
    
    if [ "$parent" -ne -1 ]; then
        if [ "${ITEMS_EXPANDED[$parent]}" -eq 0 ]; then echo "HIDDEN"; return; fi
        local grand_parent=${ITEMS_PARENT[$parent]}
        if [ "$grand_parent" -ne -1 ]; then
            if [ "${ITEMS_EXPANDED[$grand_parent]}" -eq 0 ]; then echo "HIDDEN"; return; fi
        fi
    fi
    echo "VISIBLE"
}

draw_menu() {
    tput cup 0 0
    echo "=================================================="
    echo "  TEST SELECTOR"
    echo "  [Arrows] Nav  [Space] Toggle  [Enter] Done"
    echo "=================================================="

    local row=4
    
    for ((i=0; i<TOTAL; i++)); do
        local visibility=$(get_display_row $i)
        if [ "$visibility" == "HIDDEN" ]; then continue; fi
        
        local prefix=""
        for ((l=0; l<${ITEMS_LEVEL[$i]}; l++)); do prefix+="  "; done
        
        local icon=" "
        if [ "${ITEMS_TYPE[$i]}" != "FUNC" ]; then
            if [ "${ITEMS_EXPANDED[$i]}" -eq 1 ]; then icon="▼"; else icon="▶"; fi
        else
            icon="•"
        fi
        
        local check="[ ]"
        if [ "${ITEMS_SELECTED[$i]}" -eq 1 ]; then check="[x]"; fi
        
        tput cup $row 0
        tput el
        
        if [ "$i" -eq "$CURSOR" ]; then
            tput rev
            echo "${prefix}${icon} ${check} ${ITEMS_NAME[$i]}"
            tput sgr0
        else
            echo "${prefix}${icon} ${check} ${ITEMS_NAME[$i]}"
        fi
        ((row++))
    done
    tput cup $row 0
    tput ed
}

trap "tput cnorm; exit" INT TERM

while true; do
    draw_menu
    IFS= read -rsn1 key

    if [[ "$key" == $'\x1b' ]]; then
        read -rsn2 key
        if [[ "$key" == "[A" ]]; then
            while true; do
                ((CURSOR--))
                if [ "$CURSOR" -lt 0 ]; then CURSOR=$((TOTAL - 1)); fi
                if [ "$(get_display_row $CURSOR)" == "VISIBLE" ]; then break; fi
            done
        elif [[ "$key" == "[B" ]]; then
            while true; do
                ((CURSOR++))
                if [ "$CURSOR" -ge $TOTAL ]; then CURSOR=0; fi
                if [ "$(get_display_row $CURSOR)" == "VISIBLE" ]; then break; fi
            done
        elif [[ "$key" == "[C" ]]; then
            if [ "${ITEMS_TYPE[$CURSOR]}" != "FUNC" ]; then ITEMS_EXPANDED[$CURSOR]=1; fi
        elif [[ "$key" == "[D" ]]; then
            if [ "${ITEMS_EXPANDED[$CURSOR]}" -eq 1 ]; then ITEMS_EXPANDED[$CURSOR]=0; else
                local parent=${ITEMS_PARENT[$CURSOR]}
                if [ "$parent" -ne -1 ]; then CURSOR=$parent; fi
            fi
        fi
    elif [[ "$key" == "" ]]; then break
    elif [[ "$key" == " " ]]; then
        if [ "${ITEMS_SELECTED[$CURSOR]}" -eq 1 ]; then
            update_selection "$CURSOR" 0
        else
            update_selection "$CURSOR" 1
        fi
    elif [[ "$key" == "q" ]]; then
        tput cnorm; tput clear; exit 0
    fi
done

tput cnorm
tput clear
> "$OUTPUT_FILE"
COUNT=0

i=0
while [ $i -lt $TOTAL ]; do
    if [ "${ITEMS_TYPE[$i]}" == "CLASS" ] && [ "${ITEMS_SELECTED[$i]}" -eq 1 ]; then
        echo "${ITEMS_ID[$i]}" >> "$OUTPUT_FILE"
        ((COUNT++))
        
        current_level=${ITEMS_LEVEL[$i]}
        ((i++))
        while [ $i -lt $TOTAL ] && [ "${ITEMS_LEVEL[$i]}" -gt "$current_level" ]; do
            ((i++))
        done
        continue
    fi

    if [ "${ITEMS_TYPE[$i]}" == "FUNC" ] && [ "${ITEMS_SELECTED[$i]}" -eq 1 ]; then
        echo "${ITEMS_ID[$i]}" >> "$OUTPUT_FILE"
        ((COUNT++))
    fi
    
    ((i++))
done

echo "✅ Written $COUNT items to $OUTPUT_FILE"
