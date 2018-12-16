//
//  FunctionSignature.swift
//  SwiftDemangler
//
//  Created by Yutaro Muta on 2018/12/16.
//

import Foundation

struct FunctionSignature: Equatable {
    let returnType: Type
    let argsType: Type
}
