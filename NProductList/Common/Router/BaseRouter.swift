//
//  BaseRouter.swift
//  NProductList
//
//  Created by Can Özcan on 7.06.2024.
//

import Foundation
import UIKit

protocol BaseRoutingLogic {
    func routeToBack()
}

class BaseRouter: BaseRoutingLogic {
    
    weak var baseViewController: BaseViewController?
    
    func routeToBack() {
        if let baseViewController = baseViewController {
            navigateToBack(source: baseViewController)
        }
    }
    
    func navigateToBack(source: UIViewController) {
        source.navigationController?.popViewController(animated: true)
    }
    
}
