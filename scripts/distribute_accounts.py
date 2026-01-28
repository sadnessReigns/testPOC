#!/usr/bin/env python3
import os
import json
import sys
import argparse

# Colors for terminal output
GREEN = "\033[92m"
RED = "\033[91m"
RESET = "\033[0m"

def log_step(message):
    print(f"{GREEN}✓{RESET} {message}")

def log_substep(test_case, user):
    print(f"  - {test_case} : {user}")

def find_swift_file(class_name, search_path):
    """
    Recursively searches for a file named {class_name}.swift inside search_path
    """
    target_filename = f"{class_name}.swift"
    for root, dirs, files in os.walk(search_path):
        # Exclude hidden directories and DerivedData to speed up search
        dirs[:] = [d for d in dirs if not d.startswith('.') and d != "DerivedData"]
        
        if target_filename in files:
            return os.path.join(root, target_filename)
    return None

def main():
    errors = []
    
    script_location = os.path.abspath(__file__)
    scripts_dir = os.path.dirname(script_location)
    project_root = os.path.dirname(scripts_dir)
    
    default_creds = os.path.join(project_root, "test_user_creds/users_creds.json")
    default_dist = os.path.join(scripts_dir, "input", "account_distribution.json")

    print(f"📂 Project Root detected: {project_root}")

    parser = argparse.ArgumentParser(description="Distribute user accounts to test files.")
    
    parser.add_argument("creds_file", nargs="?", default=default_creds, help="Path to credentials JSON")
    parser.add_argument("dist_file", nargs="?", default=default_dist, help="Path to distribution JSON")
    
    parser.add_argument("-s", "--shard", help="Process only a specific shard (e.g. 'shard_1')", default=None)
    
    args = parser.parse_args()

    creds_file_path = args.creds_file
    dist_file_path = args.dist_file
    target_shard = args.shard

    print(f"📂 Using credentials file: {creds_file_path}")
    print(f"📂 Using distribution file: {dist_file_path}")
    
    if target_shard:
        print(f"🎯 Target Shard: {target_shard}")
    else:
        print(f"🌍 Mode: Processing ALL shards")

    if not os.path.exists(dist_file_path):
        print(f"{RED}❌ Error: Accounts distribution file '{dist_file_path}' is missing.{RESET}")
        sys.exit(1)
    
    if not os.path.exists(creds_file_path):
        print(f"{RED}❌ Error: User credentials file '{creds_file_path}' is missing.{RESET}")
        sys.exit(1)
    
    log_step("Input files located.")

    try:
        with open(creds_file_path, 'r') as f:
            creds_data = json.load(f)
    except json.JSONDecodeError as e:
        print(f"{RED}❌ Error: Credentials file is not valid JSON.{RESET}")
        print(e)
        sys.exit(1)

    try:
        with open(dist_file_path, 'r') as f:
            dist_data = json.load(f)
    except json.JSONDecodeError as e:
        print(f"{RED}❌ Error: Distribution file is not valid JSON.{RESET}")
        print(e)
        sys.exit(1)

    print("Distributing account details...")

    processed_count = 0

    # Structure: { "shard_1": { "user": "...", "tests": [...] } }
    for shard_name, shard_data in dist_data.items():
        
        if target_shard and shard_name != target_shard:
            continue

        if not isinstance(shard_data, dict):
            errors.append(f"Format error: '{shard_name}' must contain an object.")
            continue
            
        user_key = shard_data.get("user")
        test_list = shard_data.get("tests")

        if not user_key:
            errors.append(f"Missing Data: '{shard_name}' is missing the 'user' field.")
            continue
        
        if not test_list or not isinstance(test_list, list):
            errors.append(f"Missing Data: '{shard_name}' is missing a 'tests' list.")
            continue

        user_key = user_key.strip()
        
        if user_key not in creds_data:
            errors.append(f"Creds missing: User '{user_key}' (from {shard_name}) not found in creds file.")
            continue

        user_payload = creds_data[user_key]

        for path_part in test_list:
            try:
                path_part = path_part.strip()
                if "/" in path_part:
                    _, test_class_name = path_part.rsplit('/', 1)
                else:
                    test_class_name = path_part
                
                test_class_name = test_class_name.strip()

                file_path = find_swift_file(test_class_name, search_path=project_root)
                
                if not file_path:
                    errors.append(f"File missing: Could not find '{test_class_name}.swift'")
                    continue

                dir_path = os.path.dirname(file_path)
                json_filename = f"{test_class_name}Account.json"
                json_output_path = os.path.join(dir_path, json_filename)

                try:
                    should_write = True
                    if os.path.exists(json_output_path):
                        with open(json_output_path, 'r') as existing_f:
                            try:
                                existing_data = json.load(existing_f)
                                if existing_data == user_payload:
                                    should_write = False
                                    log_substep(test_class_name, f"{user_key} (Skipped)")
                            except:
                                should_write = True

                    if should_write:
                        with open(json_output_path, 'w') as jf:
                            json.dump(user_payload, jf, indent=2)
                        log_substep(test_class_name, f"{user_key} (Updated)")
                        processed_count += 1
                        
                except Exception as e:
                    errors.append(f"Write error for {test_class_name}: {e}")

            except Exception as e:
                errors.append(f"Processing error on test '{path_part}': {e}")

    print("\n========================================")
    if not errors:
        print(f"{GREEN}✅ SUCCESS: No errors. {processed_count} files processed.{RESET}")
    else:
        print(f"{RED}⚠️  COMPLETED WITH ERRORS:{RESET}")
        for err in errors:
            print(f"  - {err}")
        sys.exit(1)

if __name__ == "__main__":
    main()
