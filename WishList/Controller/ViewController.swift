//
//  ViewController.swift
//  WishList
//
//  Created by 예슬 on 4/12/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {

  @IBOutlet weak var productImage: UIImageView!
  @IBOutlet weak var productPrice: UILabel!
  @IBOutlet weak var productDescription: UILabel!
  @IBOutlet weak var productName: UILabel!
  
  let productManager = ProductManager()
  let coreDataManager = CoreDataManager.shared
  var currentProduct: Product?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    productManager.delegate = self
    productManager.getProduct()
  }
  
  @IBAction func updateProduct(_ sender: Any) {
    productManager.getProduct()
  }
  
  @IBAction func addWishList(_ sender: Any) {
    guard let product = currentProduct else { return }
      coreDataManager.saveWishProduct(product: product)
  }
  
}

extension ViewController: ProductManagerDelegate {
  func retrieveProductData(product: Product) {
    currentProduct = product
    productName.text = product.title
    productDescription.text = product.description
    productPrice.text = product.price.numberFormmat(product.price) + "$"
    
    DispatchQueue.global().async { [weak self] in
      if let data = try? Data(contentsOf: product.thumbnail), let image = UIImage(data: data) {
        DispatchQueue.main.async {
          self?.productImage.image = image
        }
      }
    }
  }
  
}

