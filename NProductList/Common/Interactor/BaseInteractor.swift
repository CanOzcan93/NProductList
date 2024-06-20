//
//  BaseInteractor.swift
//  NProductList
//
//  Created by Can Özcan on 7.06.2024.
//

import Foundation
import Factory
import Alamofire

protocol BaseBusinessLogic { 
    var basePresenter: BasePresentationLogic? { get set }
}

class BaseInteractor: BaseBusinessLogic {
    
    var basePresenter: BasePresentationLogic?
    
    @LazyInjected(\.networkService) var networkService
    
    func callService<T: Codable>(_ urlString: String, 
                                 of: T.Type,
                                 completionHandler: @escaping (Result<T, AFError>) -> Void) {
        
        networkService.execute(urlString, of: of) { result in
            switch result {
            case .success(let model):
                completionHandler(.success(model))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
        
    }
    
}
