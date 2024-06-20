//
//  SponsoredProductItemCell.swift
//  NProductList
//
//  Created by Can Özcan on 14.06.2024.
//

import UIKit
import SnapKit

class SponsoredProductItemCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let imageViewTemp = UIImageView()
        imageViewTemp.backgroundColor = .brown
        imageViewTemp.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageViewTemp)
        return imageViewTemp
    }()
    
    private lazy var starView: StarRateView = {
        let viewTemp = StarRateView()
        viewTemp.translatesAutoresizingMaskIntoConstraints = false
        addSubview(viewTemp)
        return viewTemp
    }()
    
    private lazy var labelTitle: UILabel = {
        let labelTemp = UILabel()
        labelTemp.font = .systemFont(ofSize: 16)
        labelTemp.numberOfLines = 2
        labelTemp.translatesAutoresizingMaskIntoConstraints = false
        addSubview(labelTemp)
        return labelTemp
    }()
    
    
    private lazy var discountPriceView: DiscountPriceView = {
        let viewTemp = DiscountPriceView()
        viewTemp.translatesAutoresizingMaskIntoConstraints = false
        addSubview(viewTemp)
        return viewTemp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConstraints()
    }
    
    func setupConstraints() {
        
        imageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
            make.height.equalToSuperview().multipliedBy(0.8)
            make.width.equalTo(imageView.snp.height)
        }
        
        starView.snp.makeConstraints { make in
            make.centerX.equalTo(imageView)
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(imageView).multipliedBy(0.8)
        }
        
        labelTitle.snp.makeConstraints { make in
            make.top.equalTo(imageView)
            make.leading.equalTo(imageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(50)
        }
        
        discountPriceView.snp.makeConstraints { make in
            make.leading.equalTo(labelTitle)
            make.top.equalTo(labelTitle.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(250)
        }
        
    }
    
    func loadViewModel(viewModel: ProductItemCellViewModel) {
        
        imageView.loadImageFromURL(urlString: viewModel.imageUrlStr.stringValue)
        starView.rateDidLoad(rate: viewModel.rate ?? .zero)
        labelTitle.text = viewModel.title
        discountPriceView.pricesLoad(firstPrice: viewModel.price, secondPrice: viewModel.discountPrice)
        
    }
    
}
