//
//  DiscountPriceView.swift
//  NProductList
//
//  Created by Can Özcan on 12.06.2024.
//

import UIKit
import SnapKit

class DiscountPriceView: UIStackView {
    
    enum Constants {
        static let triangleWidth: CGFloat = 10
    }
    
    override var frame: CGRect {
        didSet {
            updatePath()
        }
    }
    
    override var bounds: CGRect {
        didSet {
            updatePath()
        }
    }
    
    private lazy var shapeView: UIView = {
        let viewTemp = UIView()
        viewTemp.translatesAutoresizingMaskIntoConstraints = false
        addArrangedSubview(viewTemp)
        return viewTemp
    }()
    
    private lazy var discountRateLabel: UILabel = {
        let labelTemp = UILabel()
        labelTemp.translatesAutoresizingMaskIntoConstraints = false
        labelTemp.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        labelTemp.setContentHuggingPriority(.defaultHigh, for: .vertical)
        shapeView.addSubview(labelTemp)
        return labelTemp
    }()
    
    private lazy var priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addArrangedSubview(stackView)
        return stackView
    }()
    
    private lazy var firstLabel: UILabel = {
        let labelTemp = UILabel()
        labelTemp.numberOfLines = 1
        labelTemp.adjustsFontSizeToFitWidth = true
        labelTemp.translatesAutoresizingMaskIntoConstraints = false
        labelTemp.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return labelTemp
    }()
    
    private lazy var secondLabel: UILabel = {
        let labelTemp = UILabel()
        labelTemp.numberOfLines = 1
        labelTemp.adjustsFontSizeToFitWidth = true
        labelTemp.translatesAutoresizingMaskIntoConstraints = false
        labelTemp.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return labelTemp
    }()
    
    
    private var triangleLayer: CALayer?
    
    func updatePath() {
        
        guard bounds != .zero else { return }
        
        let bounds = shapeView.bounds
        let path = CGMutablePath()
        
        path.move(to: .init(x: CGFloat.zero, y: CGFloat.zero))
        path.addLine(to: .init(x: bounds.width - Constants.triangleWidth, y: .zero))
        path.addLine(to: .init(x: bounds.width, y: bounds.height / 2 ))
        path.addLine(to: .init(x: bounds.width - Constants.triangleWidth, y: bounds.height))
        path.addLine(to: .init(x: .zero, y: bounds.height))
        path.addLine(to: .init(x: CGFloat.zero, y: CGFloat.zero))
        
        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = UIColor.red.cgColor
        
        if let oldLayer = triangleLayer {
            shapeView.layer.replaceSublayer(oldLayer, with: shape)
        } else {
            shapeView.layer.insertSublayer(shape, at: 0)
        }
        
        triangleLayer = shape
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        
        axis = .horizontal
        alignment = .fill
        distribution = .fillProportionally
        spacing = 5
        
        configureLayouts()
        
    }
    
    private func configureLayouts() {
        
        shapeView.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(4)
        }
        
        discountRateLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        priceStackView.addArrangedSubview(firstLabel)
        priceStackView.addArrangedSubview(secondLabel)
        
        firstLabel.snp.makeConstraints { make in
            make.height.equalTo(secondLabel).dividedBy(2)
        }
    }
    
    func pricesLoad(firstPrice: Double?, secondPrice: Double?) {
        
        if let firstPrice = firstPrice, let secondPrice = secondPrice {
            let isFirstPriceBigger = firstPrice > secondPrice
            
            let biggerPrice = isFirstPriceBigger ? firstPrice : secondPrice
            let lowerPrice = isFirstPriceBigger ? secondPrice : firstPrice
            
            let percentage = (1 - (lowerPrice / biggerPrice)) * 100
            
            discountRateLabel.text = "%\(Int(percentage.rounded(.up)))"
            firstLabel.attributedText = String(format: "%.2f", biggerPrice).strikeThrough()
            secondLabel.text = String(format: "%.2f", lowerPrice)
            layoutIfNeeded()
            updatePath()
        } else if let price = firstPrice ?? secondPrice {
            discountRateLabel.isHidden = true
            shapeView.isHidden = true
            firstLabel.isHidden = true
            secondLabel.text = String(format: "%.2f", price)
        }
        
    }
    
}
