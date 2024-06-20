//
//  UIImageView + Network.swift
//  NProductList
//
//  Created by Can Özcan on 8.06.2024.
//

import UIKit

extension UIImageView {
    
    func loadImageFromURL(urlString: String) {
        
        ImageHelper.shared.fetchImage(from: urlString) { [weak self] image in
            self?.image = image
        }
        
    }
    
}
