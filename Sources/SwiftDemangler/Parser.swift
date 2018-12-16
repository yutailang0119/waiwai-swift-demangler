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

    // indexはそのままに一文字先読みする
    func peek() -> String {
        return remains.first.map(String.init) ?? ""
    }

     // length分だけindexを進める
    func skip(length: Int) {
        self.moveIndex(offsetBy: length)
    }

}

extension Parser {

    func parseKnownType() -> Type {
        guard peek() == "S" else {
            fatalError()
        }
        switch parseIdentifier(length: 2) {
        case "Sb":
            return .bool
        case "Si":
            return .int
        case "Sf":
            return .float
        case "SS":
            return .string
        default:
            fatalError()
        }
    }

    func parseType() -> Type {
        let first = parseKnownType()
        guard peek() == "_" else {
            return first
        }
        skip(length: 1)
        var types: [Type] = [first]
        while peek() != "t" {
            types.append(parseKnownType())
        }
        return Type.list(types)
    }
}

extension Parser {
    func parseFunctionSignature() -> FunctionSignature {
        return FunctionSignature(returnType: parseType(), argsType: parseType())
    }
}

extension Parser {
    func parseFunctionEntity() -> FunctionEntity {
        return FunctionEntity(module: parseModule(),
                              declName: parseDeclName(),
                              labelList: parseLabelList(),
                              functionSignature: parseFunctionSignature())
    }

    func parse() -> FunctionEntity {
        let _ = self.parsePrefix()
        return self.parseFunctionEntity()
    }

}
