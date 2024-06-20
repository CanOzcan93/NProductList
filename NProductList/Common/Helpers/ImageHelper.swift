//
//  ImageHelper.swift
//  NProductList
//
//  Created by Can Özcan on 8.06.2024.
//

import UIKit
import Factory

class ImageHelper {
    
    @LazyInjected(\.networkService) var networkService
    
    static let shared = ImageHelper()
    private let fileManager = FileManager.default
    
    private init() {}
    
    private var cacheDirectory: URL {
        return fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }
    
    func fetchImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let fileURL = cacheDirectory.appendingPathComponent(urlString.md5)
        
        if let cachedImage = loadImage(from: fileURL) {
            completion(cachedImage)
            return
        }
        
        networkService.executeImage(urlString) { result in
            switch result {
            case .success(let image):
                self.saveImage(data: image.pngData(), to: fileURL)
                DispatchQueue.main.async {
                    completion(image)
                }
            case .failure(let _):
                completion(nil)
            }
        }
        
    }
    
    private func saveImage(data: Data?, to url: URL) {
        do {
            try data?.write(to: url)
        } catch {
            print("Error saving image to cache: \(error)")
        }
    }
    
    private func loadImage(from url: URL) -> UIImage? {
        if fileManager.fileExists(atPath: url.path) {
            return UIImage(contentsOfFile: url.path)
        }
        return nil
    }
}
