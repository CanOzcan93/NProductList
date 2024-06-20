//
//  NNetworkService.swift
//  NProductList
//
//  Created by Can Özcan on 7.06.2024.
//

import UIKit
import Alamofire
import AlamofireImage

public final class NNetworkService: BaseNetworkServiceProtocol {
    
    public func execute<T : Codable>(_ urlString: String,
                                     of: T.Type,
                                     completionHandler: ((Result<T, AFError>) -> Void)? = nil) -> DataRequest {
    
        return AF.request(urlString).responseDecodable(of: T.self) { response in
            completionHandler?(response.result)
        }
        
    }
    
    public func executeImage(_ urlString: String,
                             completionHandler: ((Result<UIImage, AFError>) -> Void)? = nil) -> DataRequest {
    
        return AF.request(urlString).responseImage { response in
            completionHandler?(response.result)
        }
        
    }

}
