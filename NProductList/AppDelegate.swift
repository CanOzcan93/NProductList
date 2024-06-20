//
//  AppDelegate.swift
//  NProductList
//
//  Created by Can Özcan on 7.06.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: ProductListViewController())
        window?.makeKeyAndVisible()

        return true
    }

}

