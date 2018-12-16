public func demangle(name: String) -> String {
    return name //TODO: implement
}

internal func isSwiftSymbol(name: String) -> Bool {
    return name.hasPrefix("$S")
}

internal func isFunctionEntitySpec(name: String) -> Bool {
    return name.hasSuffix("F")
}
