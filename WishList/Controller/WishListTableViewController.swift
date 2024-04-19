//
//  WishListTableViewController.swift
//  WishList
//
//  Created by 예슬 on 4/16/24.
//

import UIKit

class WishListTableViewController: UITableViewController {
  
  let coreDataManager = CoreDataManager.shared
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return coreDataManager.fetchWishProduct().count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "WishListTableViewCell", for: indexPath) as! WishListTableViewCell
    
    let wishProductList = coreDataManager.fetchWishProduct()
    let wishProduct = wishProductList[indexPath.row]
    
    cell.wishProductNumber.text = String(wishProduct.id) + "."
    cell.wishProductTitle.text = wishProduct.title
    cell.wishProductPrice.text = Int(wishProduct.price).numberFormmat(Int(wishProduct.price)) + "$"
    
    if let thumbnailURL = wishProduct.thumbnail {
      URLSession.shared.dataTask(with: thumbnailURL) { (data, response, error) in
        guard let data = data, error == nil else { return }
        
        // 썸네일 이미지 데이터를 UIImage로 변환
        if let thumbnailImage = UIImage(data: data) {
          // UITableViewCell의 이미지뷰에 이미지 설정 (UI 업데이트는 메인 스레드에서 수행되어야 함)
          DispatchQueue.main.async {
            cell.wishProductImage.image = thumbnailImage
          }
        }
      }.resume()
    }
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50))
    
    let wishListTitle = UILabel()
    wishListTitle.text = "Wish List"
    wishListTitle.font = .systemFont(ofSize: 24)
    
    header.addSubview(wishListTitle)
    
    wishListTitle.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      wishListTitle.centerXAnchor.constraint(equalTo: header.centerXAnchor),
      wishListTitle.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 20)
    ])
    
    return header
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }

  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    let wishProductList = coreDataManager.fetchWishProduct()
    
    if editingStyle == .delete {
      coreDataManager.deleteWishProduct(wishProductList[indexPath.row])
      tableView.deleteRows(at: [indexPath], with: .automatic)
      
    }
  }
  
}
