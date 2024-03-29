//
//  Extension.swift
//  ToDoList
//
//  Created by 예슬 on 3/28/24.
//

import Foundation
import UIKit

extension String {
  func strikeThrough() -> NSMutableAttributedString {
    let attributeString = NSMutableAttributedString(string: self)
    attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
    return attributeString
  }
  
  func removeStrikethrough() -> NSMutableAttributedString {
    let attributeString = NSMutableAttributedString(string: self)
    attributeString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSRange(location: 0, length: attributeString.length))
    return attributeString
  }
}
