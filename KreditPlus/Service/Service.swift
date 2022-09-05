//
//  Service.swift
//  KreditPlus
//
//  Created by Novi Gunawan on 05/09/22.
//

import Foundation
import UIKit

enum ResponseImage {
    case success(image: UIImage)
    case fail
    
}
class Service {
    static let shared = Service()
    let productURL = "https://fakestoreapi.com/products"
    
    func fetchProducts(completion: @escaping ([Products]?, Error?) -> ()){
        // Create url
        if let url = URL(string: productURL) {
            let session = URLSession(configuration: .default)
            // MARK: -Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                // MARK: -Check Response
                if let safeData = data {
                    let dataString = String(data: safeData, encoding: .utf8)
//                    print(dataString)
                    do {
                        let products = try JSONDecoder().decode([Products].self, from: safeData)
                        DispatchQueue.main.async {
                            completion(products, nil)
                        }
                    } catch let jsonError {
                        print("Failed to decode:", jsonError)
                    }
                }
            }
            task.resume()
        }
    }
    
    func loadFrom(urlAddress: String, completion: @escaping (ResponseImage) -> ()){
        var result = UIImage()
        guard let url = URL(string: urlAddress) else {return}
        let queue = DispatchQueue.global(qos: .background)
        
        queue.async {
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        result = loadedImage
                         completion(ResponseImage.success(image: result))
                    }
                
                } else {
                    DispatchQueue.main.async {
                        completion(ResponseImage.fail)

                    }
                }
            }
        }
     
 
    }
}
