//
//  FunctionSignatureTests.swift
//  SwiftDemanglerTests
//
//  Created by Yutaro Muta on 2018/12/16.
//

import XCTest
@testable import SwiftDemangler

class FunctionSignatureTests: XCTestCase {

    func testParseFunctionSignature() {
        XCTAssertEqual(Parser(name: "SbSi_t").parseFunctionSignature(),
                       FunctionSignature(returnType: .bool,
                                         argsType: .list([.int]))
        )
    }

}
