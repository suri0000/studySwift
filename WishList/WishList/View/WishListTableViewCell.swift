//
//  WishListTableViewCell.swift
//  WishList
//
//  Created by 예슬 on 4/18/24.
//

import UIKit

class WishListTableViewCell: UITableViewCell {
  
  static let cellID = "WishListTableViewCell"
  
  @IBOutlet weak var wishProductImage: UIImageView!
  @IBOutlet weak var wishProductPrice: UILabel!
  @IBOutlet weak var wishProductTitle: UILabel!
  @IBOutlet weak var wishProductNumber: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
