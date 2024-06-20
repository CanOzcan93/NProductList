//
//  ProductListInteractor.swift
//  NProductList
//
//  Created by Can Özcan on 7.06.2024.
//

import Foundation

protocol ProductListBusinessLogic: BaseBusinessLogic {
    
    var presenter: ProductListPresentationLogic? { get set }
    
    func retrieveData()
}

class ProductListInteractor: BaseInteractor, ProductListBusinessLogic {
    
    var presenter: ProductListPresentationLogic?
    private var nextPageNumber: Int = 1
    
    func retrieveData() {
        
        guard nextPageNumber != 0 else { return }
        
        callService("http://private-d3ae2-n11case.apiary-mock.com/listing/\(nextPageNumber)", of: ProductListResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.nextPageNumber = response.nextPage.intValue
                self?.presenter?.presentListFromData(response: response)
            case .failure(let _):
                return
            }
        }
    }
}
