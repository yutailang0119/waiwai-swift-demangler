//
//  ParserTests.swift
//  SwiftDemanglerTests
//
//  Created by Yutaro Muta on 2018/12/16.
//

import XCTest
@testable import SwiftDemangler

class ParserTests: XCTestCase {

    func testParseInt() {
        var parser = Parser(name: "0")

        // 0
        XCTAssertEqual(parser.parseInt(), 0)
        XCTAssertEqual(parser.remains, "")

        // 1
        parser = Parser(name: "1")
        XCTAssertEqual(parser.parseInt(), 1)
        XCTAssertEqual(parser.remains, "")

        // 12
        parser = Parser(name: "12")
        XCTAssertEqual(parser.parseInt(), 12)
        XCTAssertEqual(parser.remains, "")

        // 12
        parser = Parser(name: "12A")
        XCTAssertEqual(parser.parseInt(), 12)
        XCTAssertEqual(parser.remains, "A")

        // 1
        parser = Parser(name: "1B2A")
        XCTAssertEqual(parser.parseInt(), 1)
        XCTAssertEqual(parser.remains, "B2A")
        XCTAssertEqual(parser.parseInt(), nil)
    }

    func testParseIdentifier() {
        let parser = Parser(name: "3ABC4DEFG")

        XCTAssertEqual(parser.parseInt(), 3)
        XCTAssertEqual(parser.remains, "ABC4DEFG")
        XCTAssertEqual(parser.parseIdentifier(length: 3), "ABC")
        XCTAssertEqual(parser.remains, "4DEFG")

        XCTAssertEqual(parser.parseInt(), 4)
        XCTAssertEqual(parser.remains, "DEFG")
        XCTAssertEqual(parser.parseIdentifier(length: 4), "DEFG")
    }

}
