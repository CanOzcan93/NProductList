//
//  ProductListResponse.swift
//  NProductList
//
//  Created by Can Özcan on 7.06.2024.
//

import Foundation

struct ProductListResponse: Codable {
    
    let page: String?
    let nextPage: String?
    let published_at: String?
    let sponsoredProducts: [Product]?
    let products: [Product]?
    
}
