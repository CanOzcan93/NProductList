//
//  Container.swift
//  NProductList
//
//  Created by Can Özcan on 7.06.2024.
//

import Foundation
import Factory

extension Container {
    var networkService: Factory<BaseNetworkServiceProtocol> {
        Factory(self) { NNetworkService() }
    }
}
