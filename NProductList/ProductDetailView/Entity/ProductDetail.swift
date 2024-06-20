//
//  ProductDetail.swift
//  NProductList
//
//  Created by Can Özcan on 19.06.2024.
//

import Foundation

struct ProductDetail: Codable {
    
    let title: String?
    let description: String?
    let images: [String]?
    let price: Double?
    let instantDiscountPrice: Double?
    let rate: Double?
    let sellerName: String?
    
}
