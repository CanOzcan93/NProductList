//
//  Array + Ext.swift
//  NProductList
//
//  Created by Can Özcan on 8.06.2024.
//

import UIKit

/// A type that has an empty value representation, as opposed to `nil`.
public protocol EmptyValueRepresentable {
    /// Provide the empty value representation of the conforming type.
    static var emptyValue: Self { get }

    /// - returns: `true` if `self` is the empty value.
    var isEmpty: Bool { get }

    /// `nil` if `self` is the empty value, `self` otherwise.
    /// An appropriate default implementation is provided automatically.
    func nilIfEmpty() -> Self?
}

public extension EmptyValueRepresentable {
    func nilIfEmpty() -> Self? {
        return self.isEmpty ? nil : self
    }
}

extension Array: EmptyValueRepresentable {
    public static var emptyValue: [Element] { return [] }
}

public extension Optional where Wrapped: EmptyValueRepresentable {
    /// If `self == nil` returns the empty value, otherwise returns the value.

    var valueOrEmpty: Wrapped {
        switch self {
        case .some(let value):
            return value
        case .none:
            return Wrapped.emptyValue
        }
    }

    var hasValue: Bool {
        switch self {
        case .some(let value):
            return !value.isEmpty
        case .none:
            return false
        }
    }
}

public extension Array {
    func filteredByType<T> (_: T.Type) -> [T] {
        return compactMap { $0 as? T }
    }
}

public extension Array {
    subscript(safe index: Int) -> Element? {
        return self.indices ~= index ? self[index] : nil
    }

    mutating func removeFirstIfExist() {
        if !isEmpty {
            removeFirst()
        }
    }
}
