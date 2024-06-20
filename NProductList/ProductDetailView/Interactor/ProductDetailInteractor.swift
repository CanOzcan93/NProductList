//
//  ProductDetailInteractor.swift
//  NProductList
//
//  Created by Can Özcan on 17.06.2024.
//

import Foundation

protocol ProductDetailDataStore {
    var productId: Int? { get set }
}

protocol ProductDetailBusinessLogic: BaseBusinessLogic {
    
    var presenter: ProductDetailPresentationLogic? { get set }
    
    func retrieveData()
    
}

class ProductDetailInteractor: BaseInteractor, ProductDetailDataStore, ProductDetailBusinessLogic {
    
    var productId: Int?
    var presenter: ProductDetailPresentationLogic?
    
    func retrieveData() {
        
        let urlString = "http://private-d3ae2-n11case.apiary-mock.com/product?productId=\(productId.intValue)"
        debugPrint(urlString)
        callService(urlString, of: ProductDetail.self) { [weak self] result in
            debugPrint(result)
            switch result {
            case .success(let response):
                self?.presenter?.presentData(productDetail: response)
            case .failure(let _):
                return
            }
        }
    }
    
}
