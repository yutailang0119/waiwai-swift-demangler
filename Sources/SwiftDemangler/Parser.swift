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

    private func moveIndex(offsetBy offset: Int) {
        self.index = self.name.index(self.index, offsetBy: offset)
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
        self.moveIndex(offsetBy: int / 10 + 1)
        return int
    }

    func parseIdentifier(length: Int) -> String {
        defer {
            self.moveIndex(offsetBy: length)
        }
        return String(remains.prefix(upTo: String.Index(encodedOffset: length)))
    }

    func parseIdentifier() -> String? {
        guard let int = parseInt() else {
            return nil
        }
        return parseIdentifier(length: int)
    }

}

extension Parser {

    func parsePrefix() -> String {
        let symble = "$S"
        guard name.hasPrefix(symble) else {
            fatalError()
        }
        self.moveIndex(offsetBy: symble.count)
        return symble
    }

    func parseModule() -> String {
        return parseIdentifier()!
    }
}

extension Parser {

    func parseDeclName() -> String {
        return parseIdentifier()!
    }

    func parseLabelList() -> [String] {
        var labelList: [String] = []
        while let identifier = parseIdentifier() {
            labelList.append(identifier)
        }
        return labelList
    }

}

extension Parser {

    func peek() -> String {
        return remains.first.map(String.init) ?? ""
    }

    func skip(length: Int) {
        self.moveIndex(offsetBy: length)
    }

}
