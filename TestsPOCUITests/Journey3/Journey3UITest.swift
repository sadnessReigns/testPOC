//
//  Journey3UITest.swift
//  TestsPOC
//
//  Created by Uladzislau Makei on 14/01/2026.
//

import XCTest

final class Journey3UITest: XCTestCase {

    @MainActor
    func test() async throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        guard app.waitForExistence(timeout: 5) else {
            XCTFail("app does not exist")
            throw NSError(domain: "dom", code: 001, userInfo: nil)
        }
        
        let a = XCTAttachment(string: "qweasd J3: \(UIDevice.current.name)")
        a.name = "Device Name"
        a.lifetime = .keepAlways
        add(a)
        let entryPoint = app.buttons["3"].firstMatch
        
        guard entryPoint.waitForExistence(timeout: 5) else {
            XCTFail("entry point does not exist")
            throw NSError(domain: "dom", code: 001, userInfo: nil)
        }
        
        entryPoint.tap()
        
        let button = app.buttons["button3"].firstMatch
        
        guard button.waitForExistence(timeout: 5) else {
            XCTFail("button does not exist")
            throw NSError(domain: "dom", code: 001, userInfo: nil)
        }
        
        XCTAssertEqual(button.label, "Button 3")
        
        button.tap()
        
        XCTAssertEqual(button.label, "ButtonPressed 3")
        
        button.tap()
        
        XCTAssertEqual(button.label, "Button 3")
    }
    
    @MainActor
    func testAnother() async throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        guard app.waitForExistence(timeout: 5) else {
            XCTFail("app does not exist")
            throw NSError(domain: "dom", code: 001, userInfo: nil)
        }
        
        let a = XCTAttachment(string: "qweasd J3 testANOTHER: \(UIDevice.current.name)")
        a.name = "Device Name"
        a.lifetime = .keepAlways
        add(a)
        let entryPoint = app.buttons["3"].firstMatch
        
        guard entryPoint.waitForExistence(timeout: 5) else {
            XCTFail("entry point does not exist")
            throw NSError(domain: "dom", code: 001, userInfo: nil)
        }
        
        entryPoint.tap()
        
        let button = app.buttons["button3"].firstMatch
        
        guard button.waitForExistence(timeout: 5) else {
            XCTFail("button does not exist")
            throw NSError(domain: "dom", code: 001, userInfo: nil)
        }
        
        XCTAssertEqual(button.label, "Button 3")
        
        button.tap()
        
        XCTAssertEqual(button.label, "ButtonPressed 3")
        
        button.tap()
        
        XCTAssertEqual(button.label, "Button 3")
    }
    
    @MainActor
    func testOneMore() async throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        guard app.waitForExistence(timeout: 5) else {
            XCTFail("app does not exist")
            throw NSError(domain: "dom", code: 001, userInfo: nil)
        }
        
        let a = XCTAttachment(string: "qweasd J3 testONEMORE: \(UIDevice.current.name)")
        a.name = "Device Name"
        a.lifetime = .keepAlways
        add(a)
        let entryPoint = app.buttons["3"].firstMatch
        
        guard entryPoint.waitForExistence(timeout: 5) else {
            XCTFail("entry point does not exist")
            throw NSError(domain: "dom", code: 001, userInfo: nil)
        }
        
        entryPoint.tap()
        
        let button = app.buttons["button3"].firstMatch
        
        guard button.waitForExistence(timeout: 5) else {
            XCTFail("button does not exist")
            throw NSError(domain: "dom", code: 001, userInfo: nil)
        }
        
        XCTAssertEqual(button.label, "Button 3")
        
        button.tap()
        
        XCTAssertEqual(button.label, "ButtonPressed 3")
        
        button.tap()
        
        XCTAssertEqual(button.label, "Button 3")
    }
}
