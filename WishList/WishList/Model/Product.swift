//
//  Product.swift
//  WishList
//
//  Created by 예슬 on 4/17/24.
//

import Foundation

struct Product: Decodable {
  let id: Int
  let title: String
  let description: String
  let price: Int
  let thumbnail: URL
  let images: [String]
}
