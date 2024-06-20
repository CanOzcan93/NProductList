//
//  ProductDetailPresenter.swift
//  NProductList
//
//  Created by Can Özcan on 17.06.2024.
//

import Foundation

protocol ProductDetailPresentationLogic: BasePresentationLogic {
    var viewController: (BaseViewController & ProductDetailDisplayLogic)? { get set }
    var interactor: ProductDetailBusinessLogic? { get set }
    var router: ProductDetailRouter? { get set }
    
    func getData()
    func presentData(productDetail: ProductDetail)
    
}

class ProductDetailPresenter: BasePresenter, ProductDetailPresentationLogic {
    
    var viewController: (BaseViewController & ProductDetailDisplayLogic)?
    var interactor: ProductDetailBusinessLogic?
    var router: ProductDetailRouter?
    
    func getData() {
        interactor?.retrieveData()
    }
    
    func presentData(productDetail: ProductDetail) {
        viewController?.displayData(productDetail: productDetail)
    }
    
}
