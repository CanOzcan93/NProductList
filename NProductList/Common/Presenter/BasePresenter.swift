//
//  BasePresenter.swift
//  NProductList
//
//  Created by Can Özcan on 17.06.2024.
//

import Foundation

protocol BasePresentationLogic { 
    
    var baseViewController: (BaseViewController & BaseViewDisplayLogic)? { get set }
    var baseInteractor: BaseBusinessLogic? { get set }
    var baseRouter: BaseRouter? { get set }
    
}

class BasePresenter {
    
    var baseViewController: (BaseViewController & BaseViewDisplayLogic)?
    var baseInteractor: BaseBusinessLogic?
    var baseRouter: BaseRouter?
    
}
