//
//  SponsoredProductListCell.swift
//  NProductList
//
//  Created by Can Özcan on 14.06.2024.
//

import UIKit
import SnapKit

protocol SponsoredProductListCellDelegate: AnyObject {
    func didSelectItem(productId: Int?)
}

class SponsoredProductListCell: BaseCollectionCell, BaseCollectionCellProtocol {
    
    weak var delegate: SponsoredProductListCellDelegate?
    
    private var viewModelList: [ProductItemCellViewModel] = []
    
    private lazy var labelInfo: UILabel = {
        let labelTemp = UILabel()
        labelTemp.text = "Bu ürünleri gördünüz mü?"
        labelTemp.numberOfLines = 1
        labelTemp.adjustsFontSizeToFitWidth = true
        labelTemp.translatesAutoresizingMaskIntoConstraints = false
        addSubview(labelTemp)
        return labelTemp
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = .zero
        
        let collectionViewTemp = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionViewTemp.isPagingEnabled = true
        collectionViewTemp.translatesAutoresizingMaskIntoConstraints = false
        collectionViewTemp.showsHorizontalScrollIndicator = false
        
        collectionViewTemp.dataSource = self
        collectionViewTemp.delegate = self
        collectionViewTemp.register(SponsoredProductItemCell.self, forCellWithReuseIdentifier: "SponsoredProductItemCell")
        addSubview(collectionViewTemp)
        return collectionViewTemp
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControlTemp = UIPageControl()
        pageControlTemp.translatesAutoresizingMaskIntoConstraints = false
        pageControlTemp.pageIndicatorTintColor = .lightGray
        pageControlTemp.currentPageIndicatorTintColor = .black
        addSubview(pageControlTemp)
        return pageControlTemp
    }()
    
    override func initialize() {
        
        backgroundColor = .white
        
        labelInfo.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(30)
        }
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-5)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(labelInfo.snp.bottom).offset(5)
            make.bottom.equalTo(pageControl.snp.top).offset(-5)
        }
        
    }
    
    func loadViewModelList(viewModelList: [ProductItemCellViewModel]) {
        self.viewModelList = viewModelList
        collectionView.reloadData()
        pageControl.currentPage = .zero
        pageControl.numberOfPages = viewModelList.count
    }
    
}

extension SponsoredProductListCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem(productId: viewModelList[indexPath.item].id)
    }
    
}

extension SponsoredProductListCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModelList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SponsoredProductItemCell", for: indexPath) as! SponsoredProductItemCell
        cell.loadViewModel(viewModel: viewModelList[indexPath.row])
        return cell
    }
    
}
