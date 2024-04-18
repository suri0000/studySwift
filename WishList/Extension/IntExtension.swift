//
//  IntExtension.swift
//  WishList
//
//  Created by 예슬 on 4/18/24.
//

import Foundation

extension Int {
  func numberFormmat(_ number: Int) -> String {
    let numberFommatter = NumberFormatter()
    numberFommatter.numberStyle = .decimal
    return numberFommatter.string(from: NSNumber(value: number)) ?? ""
  }
}
