//
//  ProductManager.swift
//  WishList
//
//  Created by 예슬 on 4/17/24.
//

import Foundation

protocol ProductManagerDelegate {
  func retrieveProductData (product: Product)
}

class ProductManager {
  
  var delegate: ProductManagerDelegate?
  
  func getProduct() {
    let productID = Int.random(in: 1...100)
    
    if let url = URL(string: "https://dummyjson.com/products/\(productID)") {
      let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
          print("Error: \(error)")
        } else if let data = data {
          do {
            let product = try JSONDecoder().decode(Product.self, from: data)
            DispatchQueue.main.async {
              self.delegate?.retrieveProductData(product: product)
            }
            print("Decoded Product: \(product)")
          } catch {
            print("Decode Error: \(error)")
          }
        }
      }
      task.resume()
    }
  }
  
}
