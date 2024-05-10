//
//  RecentlyViewdBookCollectionViewCell.swift
//  BookShelf
//
//  Created by 예슬 on 5/10/24.
//

import UIKit

class RecentlyViewdBookCollectionViewCell: UICollectionViewCell {
  static let identifier = String(describing: RecentlyViewdBookCollectionViewCell.self)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .orange
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
