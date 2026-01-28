//
//  Journey6UITest.swift
//  TestsPOC
//
//  Created by Uladzislau Makei on 14/01/2026.
//

import XCTest

final class Journey6UITest: XCTestCase {
    
    @MainActor
    func test() async throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        guard app.waitForExistence(timeout: 5) else {
            XCTFail("app does not exist")
            throw NSError(domain: "dom", code: 001, userInfo: nil)
        }
        
        let a = XCTAttachment(string: "qweasd J6: \(UIDevice.current.name)")
        a.name = "Device Name"
        a.lifetime = .keepAlways
        add(a)
        let entryPoint = app.buttons["6"].firstMatch
        
        guard entryPoint.waitForExistence(timeout: 5) else {
            XCTFail("entry point does not exist")
            throw NSError(domain: "dom", code: 001, userInfo: nil)
        }
        
        entryPoint.tap()
        
        let button = app.buttons["button6"].firstMatch
        
        guard button.waitForExistence(timeout: 5) else {
            XCTFail("button does not exist")
            throw NSError(domain: "dom", code: 001, userInfo: nil)
        }
        
        XCTAssertEqual(button.label, "Button 6")
        
        button.tap()
        
        XCTAssertEqual(button.label, "ButtonPressed 6")
        
        button.tap()
        
        XCTAssertEqual(button.label, "Button 6")
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
        
        let a = XCTAttachment(string: "qweasd J6 testANOTHER: \(UIDevice.current.name)")
        a.name = "Device Name"
        a.lifetime = .keepAlways
        add(a)
        let entryPoint = app.buttons["6"].firstMatch
        
        guard entryPoint.waitForExistence(timeout: 5) else {
            XCTFail("entry point does not exist")
            throw NSError(domain: "dom", code: 001, userInfo: nil)
        }
        
        entryPoint.tap()
        
        let button = app.buttons["button6"].firstMatch
        
        guard button.waitForExistence(timeout: 5) else {
            XCTFail("button does not exist")
            throw NSError(domain: "dom", code: 001, userInfo: nil)
        }
        
        XCTAssertEqual(button.label, "Button 6")
        
        button.tap()
        
        XCTAssertEqual(button.label, "ButtonPressed 6")
        
        button.tap()
        
        XCTAssertEqual(button.label, "Button 6")
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
        
        let a = XCTAttachment(string: "qweasd J6 testONEMORE: \(UIDevice.current.name)")
        a.name = "Device Name"
        a.lifetime = .keepAlways
        add(a)
        let entryPoint = app.buttons["6"].firstMatch
        
        guard entryPoint.waitForExistence(timeout: 5) else {
            XCTFail("entry point does not exist")
            throw NSError(domain: "dom", code: 001, userInfo: nil)
        }
        
        entryPoint.tap()
        
        let button = app.buttons["button6"].firstMatch
        
        guard button.waitForExistence(timeout: 5) else {
            XCTFail("button does not exist")
            throw NSError(domain: "dom", code: 001, userInfo: nil)
        }
        
        XCTAssertEqual(button.label, "Button 6")
        
        button.tap()
        
        XCTAssertEqual(button.label, "ButtonPressed 6")
        
        button.tap()
        
        XCTAssertEqual(button.label, "Button 6")
    }
}

