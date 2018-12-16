//
//  FunctionSignatureTests.swift
//  SwiftDemanglerTests
//
//  Created by Yutaro Muta on 2018/12/16.
//

import XCTest
@testable import SwiftDemangler

class FunctionSignatureTests: XCTestCase {

    func testParseFunctionEntity() {
        let sig = FunctionSignature(returnType: .bool, argsType: .list([.int]))
        XCTAssertEqual(Parser(name: "13ExampleNumber6isEven6numberSbSi_tF").parseFunctionEntity(),
                       FunctionEntity(module: "ExampleNumber",
                                      declName: "isEven",
                                      labelList: ["number"],
                                      functionSignature: sig)
        )
    }

}
