//
//  BaseCollectionSectionProtocol.swift
//  NProductList
//
//  Created by Can Özcan on 7.06.2024.
//

import UIKit

public protocol BaseCollectionSectionProtocol {
    
    var numberOfItems: Int { get }
    var cellSize: CGSize { get }
    var reuseIdentifierDefined: String { get }
    var cellType: (UICollectionViewCell & BaseCollectionCellProtocol).Type { get }
    
    func getCell(at indexPath: IndexPath, collectionView: UICollectionView) -> BaseCollectionCellProtocol
    func didSelect(at index: Int)
    
}
