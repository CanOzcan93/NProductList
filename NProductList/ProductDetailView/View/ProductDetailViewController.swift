//
//  ProductDetailViewController.swift
//  NProductList
//
//  Created by Can Özcan on 17.06.2024.
//

import UIKit
import SnapKit

protocol ProductDetailDisplayLogic: BaseViewDisplayLogic {
    
    func displayData(productDetail: ProductDetail)
    
}

class ProductDetailViewController: BaseViewController, ProductDetailDisplayLogic {
    
    var presenter: ProductDetailPresentationLogic?
    
    private lazy var scrollView: UIScrollView = {
        let scrollViewTemp = UIScrollView()
        scrollViewTemp.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollViewTemp)
        return scrollViewTemp
    }()
    
    private lazy var contentView: UIView = {
        let viewTemp = UIView()
        viewTemp.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(viewTemp)
        return viewTemp
    }()
    
    private lazy var imageShowroomView: ImageShowroomView = {
        let viewTemp = ImageShowroomView()
        viewTemp.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(viewTemp)
        return viewTemp
    }()
    
    private lazy var labelTitle: UILabel = {
        let labelTemp = UILabel()
        labelTemp.numberOfLines = .zero
        labelTemp.translatesAutoresizingMaskIntoConstraints = false
        labelTemp.font = .systemFont(ofSize: 18, weight: .bold)
        contentView.addSubview(labelTemp)
        return labelTemp
    }()
    
    private lazy var labelDescription: UILabel = {
        let labelTemp = UILabel()
        labelTemp.numberOfLines = .zero
        labelTemp.translatesAutoresizingMaskIntoConstraints = false
        labelTemp.font = .systemFont(ofSize: 14)
        labelTemp.textColor = .lightGray
        contentView.addSubview(labelTemp)
        return labelTemp
    }()
    
    private lazy var starRateView: StarRateView = {
        let viewTemp = StarRateView()
        contentView.addSubview(viewTemp)
        return viewTemp
    }()
    
    private lazy var labelRate: UILabel = {
        let labelTemp = UILabel()
        labelTemp.numberOfLines = 1
        labelTemp.translatesAutoresizingMaskIntoConstraints = false
        labelTemp.font = .systemFont(ofSize: 12, weight: .bold)
        contentView.addSubview(labelTemp)
        return labelTemp
    }()
    
    private lazy var dividerView: UIView = {
        let viewTemp = UIView()
        viewTemp.backgroundColor = .lightGray.withAlphaComponent(0.3)
        viewTemp.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(viewTemp)
        return viewTemp
    }()
    
    private lazy var labelPrice: UILabel = {
        let labelTemp = UILabel()
        labelTemp.numberOfLines = 1
        labelTemp.translatesAutoresizingMaskIntoConstraints = false
        labelTemp.font = .systemFont(ofSize: 18, weight: .bold)
        contentView.addSubview(labelTemp)
        return labelTemp
    }()
    
    private lazy var labelOldPrice: UILabel = {
        let labelTemp = UILabel()
        labelTemp.numberOfLines = 1
        labelTemp.translatesAutoresizingMaskIntoConstraints = false
        labelTemp.font = .systemFont(ofSize: 14)
        labelTemp.textColor = .lightGray
        contentView.addSubview(labelTemp)
        return labelTemp
    }()
    
    private lazy var labelDiscount: UILabel = {
        let labelTemp = UILabel()
        labelTemp.numberOfLines = 1
        labelTemp.translatesAutoresizingMaskIntoConstraints = false
        labelTemp.font = .systemFont(ofSize: 12, weight: .bold)
        labelTemp.textColor = .red
        contentView.addSubview(labelTemp)
        return labelTemp
    }()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initContraints()
        presenter?.getData()
    }
    
    private func setup() {
        
        let productDetailPresenter = ProductDetailPresenter()
        let productDetailInteractor = ProductDetailInteractor()
        let productDetailRouter = ProductDetailRouter()
        self.presenter = productDetailPresenter
        self.presenter?.interactor = productDetailInteractor
        self.presenter?.router = productDetailRouter
        self.presenter?.viewController = self
        self.presenter?.interactor?.presenter = productDetailPresenter
        productDetailRouter.dataStore = productDetailInteractor
        
        // base setup
        self.basePresenter = productDetailPresenter
        self.basePresenter?.baseInteractor = productDetailInteractor
        self.basePresenter?.baseRouter = productDetailRouter
        self.basePresenter?.baseViewController = self
        self.basePresenter?.baseInteractor?.basePresenter = productDetailPresenter
        
    }
    
    private func initContraints() {
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.bottom.width.height.equalToSuperview()
            make.leading.trailing.equalTo(view)
        }
        
        imageShowroomView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().dividedBy(3)
        }
        
        labelTitle.snp.makeConstraints { make in
            make.top.equalTo(imageShowroomView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        
        labelDescription.snp.makeConstraints { make in
            make.top.equalTo(labelTitle.snp.bottom).offset(10)
            make.leading.trailing.equalTo(labelTitle)
        }
        
        starRateView.snp.makeConstraints { make in
            make.top.equalTo(labelDescription.snp.bottom).offset(10)
            make.leading.equalTo(labelDescription)
            make.height.equalTo(20)
        }
        
        labelRate.snp.makeConstraints { make in
            make.leading.equalTo(starRateView.snp.trailing).offset(10)
            make.top.height.equalTo(starRateView)
        }
        
        dividerView.snp.makeConstraints { make in
            make.leading.equalTo(starRateView)
            make.centerX.equalToSuperview()
            make.top.equalTo(starRateView.snp.bottom).offset(20)
            make.height.equalTo(1)
        }
        
        labelPrice.snp.makeConstraints { make in
            make.leading.equalTo(dividerView)
            make.top.equalTo(dividerView.snp.bottom).offset(20)
        }
        
        labelOldPrice.snp.makeConstraints { make in
            make.centerY.equalTo(labelPrice)
            make.leading.equalTo(labelPrice.snp.trailing).offset(10)
        }
        
        labelDiscount.snp.makeConstraints { make in
            make.centerY.equalTo(labelOldPrice)
            make.leading.equalTo(labelOldPrice.snp.trailing).offset(10)
            make.trailing.lessThanOrEqualToSuperview().inset(10)
        }
        
    }
    
    func displayData(productDetail: ProductDetail) {
        
        imageShowroomView.imageUrlList = productDetail.images.valueOrEmpty
        labelTitle.text = productDetail.title
        labelDescription.text = productDetail.description
        starRateView.rateDidLoad(rate: productDetail.rate.doubleValue)
        labelRate.text = String(format: "%.1f", productDetail.rate.doubleValue)
        labelPrice.text = String(format: "%.2f", productDetail.instantDiscountPrice.doubleValue)
        labelOldPrice.attributedText = String(format: "%.2f", productDetail.price.doubleValue).strikeThrough()
        
        let discount = Int((productDetail.instantDiscountPrice.doubleValue / productDetail.price.doubleValue).rounded())
        labelDiscount.text = "%\(discount)"
        
    }

}
