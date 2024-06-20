//
//  ProductDetailRouter.swift
//  NProductList
//
//  Created by Can Özcan on 17.06.2024.
//

import Foundation

protocol ProductDetailDataPassing {
    var dataStore: ProductDetailDataStore? { get set }
}

final class ProductDetailRouter: BaseRouter, ProductDetailDataPassing {
    
    var dataStore: ProductDetailDataStore?
    
}
