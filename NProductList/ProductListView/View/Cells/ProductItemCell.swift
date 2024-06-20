//
//  ProductItemCell.swift
//  NProductList
//
//  Created by Can Özcan on 7.06.2024.
//

import UIKit
import SnapKit

protocol ProductItemCellProtocol: BaseCollectionCellProtocol {
    func loadViewModel(viewModel: ProductItemCellViewModel)
}

class ProductItemCell: BaseCollectionCell, ProductItemCellProtocol {
    
    private lazy var imageView: UIImageView = {
        let imageViewTemp = UIImageView()
        imageViewTemp.contentMode = .scaleAspectFit
        imageViewTemp.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageViewTemp)
        return imageViewTemp
    }()
    
    private lazy var labelTitle: UILabel = {
        let labelTemp = UILabel()
        labelTemp.numberOfLines = 3
        labelTemp.translatesAutoresizingMaskIntoConstraints = false
        addSubview(labelTemp)
        return labelTemp
    }()
    
    private lazy var starRateView: StarRateView = {
        let viewTemp = StarRateView()
        viewTemp.translatesAutoresizingMaskIntoConstraints = false
        addSubview(viewTemp)
        return viewTemp
    }()
    
    private lazy var discountPriceView: DiscountPriceView = {
        let viewTemp = DiscountPriceView()
        viewTemp.translatesAutoresizingMaskIntoConstraints = false
        addSubview(viewTemp)
        return viewTemp
    }()
    
    private lazy var labelSeller: UILabel = {
        let labelTemp = UILabel()
        labelTemp.numberOfLines = 1
        labelTemp.translatesAutoresizingMaskIntoConstraints = false
        labelTemp.setContentHuggingPriority(.defaultHigh, for: .vertical)
        labelTemp.adjustsFontSizeToFitWidth = true
        addSubview(labelTemp)
        return labelTemp
    }()

    override func initialize() {
        
        self.backgroundColor = .white
        self.clipsToBounds = true
        
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(imageView.snp.width)
        }
        
        labelTitle.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(70)
        }
        
        starRateView.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.equalTo(labelTitle.snp.bottom).offset(10)
            make.leading.equalToSuperview()
        }
        
        discountPriceView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(starRateView.snp.bottom).offset(10)
        }
        
        labelSeller.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().offset(-5)
            make.height.equalTo(20)
            make.top.equalTo(discountPriceView.snp.bottom).offset(5)
        }
        
    }
    
    func loadViewModel(viewModel: ProductItemCellViewModel) {
        imageView.loadImageFromURL(urlString: viewModel.imageUrlStr.stringValue)
        starRateView.rateDidLoad(rate: viewModel.rate ?? .zero)
        labelTitle.text = viewModel.title
        labelSeller.text = viewModel.seller
        discountPriceView.pricesLoad(firstPrice: viewModel.price, secondPrice: viewModel.discountPrice)
    }
    
}

struct ProductItemCellViewModel {
    let id: Int?
    let imageUrlStr: String?
    let title: String?
    let rate: Double?
    let seller: String?
    let price: Double?
    let discountPrice: Double?
}
