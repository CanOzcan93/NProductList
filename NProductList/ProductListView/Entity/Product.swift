//
//  Product.swift
//  NProductList
//
//  Created by Can Özcan on 7.06.2024.
//

import Foundation

struct Product: Codable {
    
    let id: Int?
    let title: String?
    let image: String?
    let price: Double?
    let instantDiscountPrice: Double?
    let rate: Double?
    let sellerName: String?
    
}
