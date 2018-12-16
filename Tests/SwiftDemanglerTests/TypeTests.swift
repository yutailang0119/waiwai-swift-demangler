//
//  TypeTests.swift
//  SwiftDemanglerTests
//
//  Created by Yutaro Muta on 2018/12/16.
//

import XCTest
@testable import SwiftDemangler

class TypeTests: XCTestCase {

    func testParseKnownType() {
        XCTAssertEqual(Parser(name: "Si").parseKnownType(), .int)
        XCTAssertEqual(Parser(name: "Sb").parseKnownType(), .bool)
        XCTAssertEqual(Parser(name: "SS").parseKnownType(), .string)
        XCTAssertEqual(Parser(name: "Sf").parseKnownType(), .float)
    }

    func testParseType() {
        XCTAssertEqual(Parser(name: "Si").parseType(), .int)
        XCTAssertEqual(Parser(name: "Sb").parseType(), .bool)
        XCTAssertEqual(Parser(name: "SS").parseType(), .string)
        XCTAssertEqual(Parser(name: "Sf").parseType(), .float)
        XCTAssertEqual(Parser(name: "Sf_SfSft").parseType(), .list([.float, .float, .float]))
    }

}
