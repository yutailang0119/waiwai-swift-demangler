import XCTest
@testable import SwiftDemangler

final class SwiftDemanglerTests: XCTestCase {
//    func testEx1() {
//        XCTAssertEqual(demangle(name: "$S13ExampleNumber6isEven6numberSbSi_tF"),
//                       "ExampleNumber.isEven(number: Swift.Int) -> Swift.Bool")
//    }

    func testIsSwiftSymbol() {
        let correctName = "$S13ExampleNumber6isEven6numberSbSi_tF"
        XCTAssertTrue(isSwiftSymbol(name: correctName))

        let incorrectName1 = "13ExampleNumber6isEven6numberSbSi_tF"
        XCTAssertFalse(isSwiftSymbol(name: incorrectName1))

        let incorrectName2 = "S13ExampleNumber6isEven6numberSbSi_tF"
        XCTAssertFalse(isSwiftSymbol(name: incorrectName2))

        let incorrectName3 = "$13ExampleNumber6isEven6numberSbSi_tF"
        XCTAssertFalse(isSwiftSymbol(name: incorrectName3))

    }

    func testIsFunctionEntitySpec() {
        let correctName = "$S13ExampleNumber6isEven6numberSbSi_tF"
        XCTAssertTrue(isFunctionEntitySpec(name: correctName))

        let incorrectName1 = "$S13ExampleNumber6isEven6numberSbSi_t"
        XCTAssertFalse(isFunctionEntitySpec(name: incorrectName1))

        let incorrectName2 = "$S13ExampleNumber6isEven6numberSbSi_tf"
        XCTAssertFalse(isFunctionEntitySpec(name: incorrectName2))

    }


    static var allTests = [
//        ("testEx1", testEx1),
        ("testIsSwiftSymbol", testIsSwiftSymbol),
        ("testIsFunctionEntitySpec", testIsFunctionEntitySpec),
    ]
}
