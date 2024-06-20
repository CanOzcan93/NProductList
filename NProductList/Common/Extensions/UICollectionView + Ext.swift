//
//  UICollectionView + Ext.swift
//  NProductList
//
//  Created by Can Özcan on 7.06.2024.
//

import UIKit

extension UICollectionView {

    var registeredNibs: [String: UINib] {
        let dict = value(forKey: "_nibMap") as? [String: UINib]
        return dict ?? [:]
    }

    var registeredClasses: [String: Any] {
        let dict = value(forKey: "_cellClassDict") as? [String: Any]
        return dict ?? [:]
    }
    
}
