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
  @IBOutlet weak var showWishListButton: UIButton!
  @IBOutlet weak var scrollView: UIScrollView!
  
  let productManager = ProductManager()
  let coreDataManager = CoreDataManager.shared
  var currentProduct: Product?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    productManager.delegate = self
    productManager.getProduct()
    setRefresh()
    addBadgeShowWishProductCount()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "updateBadgeCount" {
      let wishListTableViewController = segue.destination as? WishListTableViewController
      wishListTableViewController?.delegate = self
    }
  }
  
  @IBAction func updateProduct(_ sender: Any) {
    productManager.getProduct()
  }
  
  @IBAction func addWishList(_ sender: Any) {
    guard let product = currentProduct else { return }
    coreDataManager.saveWishProduct(product: product)
    addBadgeShowWishProductCount()
  }
  
  func setRefresh() {
    scrollView.refreshControl = UIRefreshControl()
    scrollView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
  }
  
  @objc func refresh() {
    productManager.getProduct()
  }
  
  func addBadgeShowWishProductCount() {
    let badge = UILabel()
    
    badge.text = "\(coreDataManager.fetchWishProduct().count)"
    badge.font = UIFont.systemFont(ofSize: 10)
    badge.backgroundColor = .black
    badge.textColor = .white
    badge.textAlignment = .center
    badge.clipsToBounds = true
    badge.layer.cornerRadius = 10
    
    showWishListButton.superview?.addSubview(badge)
    
    badge.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      badge.topAnchor.constraint(equalTo: showWishListButton.topAnchor),
      badge.trailingAnchor.constraint(equalTo: showWishListButton.trailingAnchor, constant: -10),
      badge.widthAnchor.constraint(equalToConstant: 20),
      badge.heightAnchor.constraint(equalToConstant: 20)
    ])
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
          self?.scrollView.refreshControl?.endRefreshing()
        }
      }
    }
  }
  
}

extension ViewController: WishListTableViewDelegate {
  func updateBadge() {
    addBadgeShowWishProductCount()
  }
}

