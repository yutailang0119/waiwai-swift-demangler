//
//  Parser.swift
//  SwiftDemangler
//
//  Created by Yutaro Muta on 2018/12/16.
//

import Foundation

internal class Parser {
    private let name: String
    private var index: String.Index

    var remains: String {
        return String(name[index...])
    }

    init(name: String) {
        self.name = name
        self.index = name.startIndex
    }
}

extension Parser {
    func parseInt() -> Int? {
        let remains = self.remains

        if let allInteger = Int(remains) {
            self.index = name.endIndex
            return allInteger
        }

        guard let index = remains.firstIndex(where: { c in
            return Int(String(c)) == nil
        }) else {
            return nil
        }

        guard let int = Int(remains.prefix(upTo: index)) else {
            return nil
        }
        self.index = self.name.index(self.index, offsetBy: int / 10 + 1)
        return int
    }

    func parseIdentifier(length: Int) -> String {
        defer {
            self.index = self.name.index(self.index, offsetBy: length)
        }
        return String(remains.prefix(upTo: String.Index(encodedOffset: length)))
    }
}
