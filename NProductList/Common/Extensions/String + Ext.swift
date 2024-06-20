//
//  String + Ext.swift
//  NProductList
//
//  Created by Can Özcan on 8.06.2024.
//

import UIKit
import CommonCrypto

extension String {
    
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                     value: NSUnderlineStyle.single.rawValue,
                                     range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    var md5: String {
        let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
        var digest = Array<UInt8>(repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        
        CC_MD5_Init(context)
        CC_MD5_Update(context, self, CC_LONG(lengthOfBytes(using: .utf8)))
        CC_MD5_Final(&digest, context)
        context.deallocate()
        
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
    
    
}
