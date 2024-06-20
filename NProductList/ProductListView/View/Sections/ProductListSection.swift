//
//  ProductListSection.swift
//  NProductList
//
//  Created by Can Özcan on 8.06.2024.
//

import UIKit

protocol ProductListSectionDelegate: AnyObject {
    func didSelectItem(productId: Int?)
}

class ProductListSection: BaseCollectionSection, BaseCollectionSectionProtocol {
    
    enum Constants {
        static let cellHeight: CGFloat = 400
        static let spacingCell: CGFloat = 5
        static let numberOfCellInRow: CGFloat = 2
    }
    
    var numberOfItems: Int {
        return viewModelList.count
    }
    
    var cellSize: CGSize = CGSize(width: (UIScreen.main.bounds.width / Constants.numberOfCellInRow) - Constants.spacingCell,
                                  height: Constants.cellHeight)
    
    var reuseIdentifierDefined: String = "ProductItemCell"
    
    var cellType: (UICollectionViewCell & BaseCollectionCellProtocol).Type = ProductItemCell.self
    
    private var viewModelList: [ProductItemCellViewModel] = []
    weak var delegate: ProductListSectionDelegate?
    
    func getCell(at indexPath: IndexPath, collectionView: UICollectionView) -> BaseCollectionCellProtocol {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifierDefined, for: indexPath) as! ProductItemCell
        cell.loadViewModel(viewModel: viewModelList[indexPath.row])
        return cell
    }
    
    func loadData(viewModelList: [ProductItemCellViewModel]) {
        self.viewModelList.append(contentsOf: viewModelList)
    }
    
    func didSelect(at index: Int) { 
        delegate?.didSelectItem(productId: viewModelList[index].id)
    }
    
}
