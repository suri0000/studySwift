//
//  SearchResultViewModel.swift
//  BookShelf
//
//  Created by 예슬 on 5/8/24.
//

import UIKit

class SearchResultViewModel {
  var bookImage: UIImage?
  var bookTitle: String?
  var authors: String?
  
  func fetchSearchResult() {
    let url = URL(string: "https://dapi.kakao.com/v3/search/book?query=세이노")!
    
    var request = URLRequest(url: url)
    
    request.allHTTPHeaderFields = ["Authorization": "KakaoAK <이 곳에 RESTAPI Key 를 넣으세요.>"]
    
    URLSession.shared.dataTask(with: request) { data, _, _ in
      print(String(data: data!, encoding: .utf8))
    }.resume()
  }
}
