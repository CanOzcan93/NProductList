//
//  ProductListViewController.swift
//  NProductList
//
//  Created by Can Özcan on 7.06.2024.
//

import UIKit

protocol ProductListDisplayLogic: BaseCollectionViewDisplayLogic {
    func isUpdatingEndsBottomList()
}

final class ProductListViewController: BaseCollectionViewController, ProductListDisplayLogic {
    
    var presenter: ProductListPresentationLogic?
    
   override var navigationBarHidden: Bool {
        get { return true }
        set { }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter?.getData()
    }
    
    private func setup() {
        
        let productListPresenter = ProductListPresenter()
        let productListInteractor = ProductListInteractor()
        let productListRouter = ProductListRouter()
        self.presenter = productListPresenter
        self.presenter?.interactor = productListInteractor
        self.presenter?.router = productListRouter
        self.presenter?.viewController = self
        self.presenter?.interactor?.presenter = productListPresenter
        self.presenter?.router?.viewController = self
        
        // base setup
        self.basePresenter = productListPresenter
        self.basePresenter?.baseInteractor = productListInteractor
        self.basePresenter?.baseRouter = productListRouter
        self.basePresenter?.baseViewController = self
        self.basePresenter?.baseInteractor?.basePresenter = productListPresenter
        self.basePresenter?.baseRouter?.baseViewController = self
        
    }
    
    override func updateEndOfCollection() {
        presenter?.getData()
    }
    
    func isUpdatingEndsBottomList() {
        super.updateEndOfCollection()
    }

}

