//
//  StarRateView.swift
//  NProductList
//
//  Created by Can Özcan on 10.06.2024.
//

import UIKit
import SnapKit

class StarRateView: UIStackView {
    
    enum Constants {
        static let size: CGFloat = 20
        static let starCount: Int = 5
        static let activeImageName: String = "star.fill"
        static let imageName: String = "star"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    private func configureView() {
        
        axis = .horizontal
        distribution = .equalSpacing
        
        for _ in 0..<Constants.starCount {
            createStarView()
        }
    }
    
    private func createStarView() {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.tintColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        imageView.image = .init(systemName: Constants.imageName)
        self.addArrangedSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalTo(imageView.snp.height)
        }
    }
    
    func rateDidLoad(rate: Double) {
        
        let activeStarCount = Int(rate.rounded())
        
        for i in 0..<Constants.starCount {
            let isActiveStar = i <= activeStarCount
            guard let imageView = self.arrangedSubviews[safe: i] as? UIImageView else { return }
            imageView.image = .init(systemName: isActiveStar ? Constants.activeImageName : Constants.imageName)
        }
        
    }
    
}

