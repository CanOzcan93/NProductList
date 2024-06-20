//
//  ProductListRouter.swift
//  NProductList
//
//  Created by Can Özcan on 7.06.2024.
//

import Foundation

protocol ProductListRoutingLogic: BaseRoutingLogic {

    func routeToProductDetailPage(productId: Int)
    
}

protocol ProductListDataStore { 
    
}

final class ProductListRouter: BaseRouter, ProductListRoutingLogic, ProductListDataStore {
    
    weak var viewController: ProductListViewController?
    
    // MARK: Routing
    func routeToProductDetailPage(productId: Int) {
        let destinationViewController = ProductDetailViewController()
        var destinationDataStore = destinationViewController.presenter!.router!.dataStore
        passDataToProductDetail(productId: productId, destination: &destinationDataStore)
        navigateToProductDetail(source: viewController!, destination: destinationViewController)
    }
    
    // MARK: Navigating
    private func navigateToProductDetail(source: ProductListViewController, destination: ProductDetailViewController) {
        source.show(destination, sender: nil)
    }

    // MARK: Passing data
    private func passDataToProductDetail(productId: Int?, destination: inout ProductDetailDataStore?) {
        destination?.productId = productId
    }
    
}
