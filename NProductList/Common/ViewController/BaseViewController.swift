//
//  BaseViewController.swift
//  NProductList
//
//  Created by Can Özcan on 7.06.2024.
//

import UIKit

protocol BaseViewDisplayLogic {
    
}

class BaseViewController: UIViewController, BaseViewDisplayLogic {
    
    var basePresenter: BasePresenter?
    var navigationBarHidden: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = navigationBarHidden
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(navigationBarHidden, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if !navigationBarHidden {
            UIView.setAnimationsEnabled(false)
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if !navigationBarHidden {
            UIView.setAnimationsEnabled(true)
        }
        
        self.navigationController?.setNavigationBarHidden(navigationBarHidden, animated: animated)
    }
    
}
