//
//  SponsoredProductSection.swift
//  NProductList
//
//  Created by Can Özcan on 14.06.2024.
//

import UIKit

class SponsoredProductSection: BaseCollectionSection, BaseCollectionSectionProtocol {
    
    enum Constants {
        static let cellHeight: CGFloat = 200
    }
    
    var numberOfItems: Int = 1
    
    var cellSize: CGSize = CGSize(width: UIScreen.main.bounds.width,
                                  height: Constants.cellHeight)
    
    var reuseIdentifierDefined: String = "SponsoredProductListCell"
    
    var cellType: (UICollectionViewCell & BaseCollectionCellProtocol).Type = SponsoredProductListCell.self
    
    weak var delegate: SponsoredProductListCellDelegate?
    
    private var viewModelList: [ProductItemCellViewModel] = []
    
    func getCell(at indexPath: IndexPath, collectionView: UICollectionView) -> BaseCollectionCellProtocol {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifierDefined, for: indexPath) as! SponsoredProductListCell
        cell.delegate = delegate
        cell.loadViewModelList(viewModelList: viewModelList)
        return cell
    }
    
    func didSelect(at index: Int) { }
    
    func loadViewModel(viewModelList: [ProductItemCellViewModel]) {
        self.viewModelList = viewModelList
    }
    
}
