//
//  ProductListPresenter.swift
//  NProductList
//
//  Created by Can Özcan on 7.06.2024.
//

import UIKit

protocol ProductListPresentationLogic: BasePresentationLogic {
    
    var viewController: (BaseCollectionViewController & ProductListDisplayLogic)? { get set }
    var interactor: ProductListBusinessLogic? { get set }
    var router: ProductListRouter? { get set }
    
    func getData()
    func presentListFromData(response: ProductListResponse)
    
}

final class ProductListPresenter: BasePresenter, ProductListPresentationLogic {
    
    var viewController: (BaseCollectionViewController & ProductListDisplayLogic)?
    var interactor: ProductListBusinessLogic?
    var router: ProductListRouter?
    
    private var productListSection: ProductListSection!
    
    func getData() {
        interactor?.retrieveData()
    }
    
    func presentListFromData(response: ProductListResponse) {

        if productListSection == nil {
            productListSection = ProductListSection()
            productListSection.delegate = self
        }
        
        productListSection.loadData(viewModelList: mapViewModel(response.products.valueOrEmpty))
        
        if response.page.intValue == 1 {
            
            let sponsoredProductSection = SponsoredProductSection()
            sponsoredProductSection.delegate = self
            sponsoredProductSection.loadViewModel(viewModelList: mapViewModel(response.sponsoredProducts.valueOrEmpty))
            
            viewController?.displaySections(sections: [sponsoredProductSection,
                                                       productListSection])
        }
        
        viewController?.isUpdatingEndsBottomList()
        
    }
    
    private func mapViewModel(_ productList: [Product]) -> [ProductItemCellViewModel] {
        
        return productList.map { product in
            return ProductItemCellViewModel(id: product.id,
                                            imageUrlStr: product.image,
                                            title: product.title,
                                            rate: product.rate,
                                            seller: product.sellerName,
                                            price: product.price,
                                            discountPrice: product.instantDiscountPrice)
        }
        
    }
    
}

extension ProductListPresenter: SponsoredProductListCellDelegate, ProductListSectionDelegate {
    
    func didSelectItem(productId: Int?) {
        router?.routeToProductDetailPage(productId: productId.intValue)
    }
    
}

