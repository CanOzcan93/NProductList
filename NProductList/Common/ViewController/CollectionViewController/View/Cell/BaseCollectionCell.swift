//
//  BaseCollectionCell.swift
//  NProductList
//
//  Created by Can Özcan on 7.06.2024.
//

import UIKit

class BaseCollectionCell: UICollectionViewCell {
    
    func initialize() { }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
}
