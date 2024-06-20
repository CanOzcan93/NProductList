//
//  BaseNetworkServiceProtocol.swift
//  NProductList
//
//  Created by Can Özcan on 7.06.2024.
//

import Alamofire
import UIKit

public protocol BaseNetworkServiceProtocol {
    
    @discardableResult
    func execute<T : Codable>(_ urlString: String,
                              of: T.Type,
                              completionHandler: ((Result<T, AFError>) -> Void)?) -> DataRequest
    
    @discardableResult
    func executeImage(_ urlString: String,
                      completionHandler: ((Result<UIImage, AFError>) -> Void)?) -> DataRequest
    
}
