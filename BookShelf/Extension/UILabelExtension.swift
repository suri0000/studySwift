//
//  UILabelExtension.swift
//  BookShelf
//
//  Created by 예슬 on 5/8/24.
//

import UIKit

extension UILabel {
  convenience init(text: String) {
          self.init()
          self.text = text
          self.adjustsFontForContentSizeCategory = true
          self.font = UIFont.preferredFont(for: .title2, weight: .bold)
      }
}
