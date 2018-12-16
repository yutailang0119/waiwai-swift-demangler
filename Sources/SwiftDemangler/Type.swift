//
//  Type.swift
//  SwiftDemangler
//
//  Created by Yutaro Muta on 2018/12/16.
//

import Foundation

enum Type {
    case bool
    case int
    case string
    case float
    indirect case list([Type])
}

extension Type: Equatable {
    static func == (lhs: Type, rhs: Type) -> Bool {
        switch (lhs, rhs) {
        case (.bool, .bool): return true
        case (.int, .int): return true
        case (.string, .string): return true
        case (.float, .float): return true
        case let (.list(list1), .list(list2)):
            return list1 == list2
        default:
            return false
        }

    }
}
