//
//  Optional + Ext.swift
//  NProductList
//
//  Created by Can Özcan on 18.06.2024.
//

import Foundation

public extension Optional where Wrapped == String {

    var stringValue: String {
        return self ?? ""
    }

    var intValue: Int {
        return Int(stringValue) ?? 0
    }

    var doubleValue: Double {
        return Double(stringValue) ?? 0
    }

    var floatValue: Float {
        return Float(stringValue) ?? 0
    }

    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
    
}

public extension Optional where Wrapped == Bool {

    var boolValue: Bool {
        return self ?? false
    }
    
}

public extension Optional where Wrapped == Double {

    var doubleValue: Double {
        return self ?? .zero
    }
    
}

public extension Optional where Wrapped == Int {

    var intValue: Int {
        return self ?? .zero
    }

}
