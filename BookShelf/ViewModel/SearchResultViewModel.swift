//
//  SearchResultViewModel.swift
//  BookShelf
//
//  Created by 예슬 on 5/8/24.
//

import UIKit

class SearchResultViewModel {
  
  var results: [Document]?
  
  func fetchBookAPI(query: String, completion: @escaping (Result<Book, Error>) -> Void) {
    guard var url = URL(string: "https://dapi.kakao.com/v3/search/book") else { return }
    url = URL(string: url.absoluteString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
    // 한글 인코딩 추가
    url.append(queryItems: [URLQueryItem(name: "query", value: query)])
    
    var urlRequest = URLRequest(url: url)
    urlRequest.addValue("KakaoAK \(Bundle.main.API_KEY)", forHTTPHeaderField: "Authorization")
    
    URLSession.shared.dataTask(with: urlRequest) { data, response, error in
      
      if let error = error {
        print("에러 발생!!", error)
      }
      
      guard let data = data else { return }
      
      do {
        let book = try JSONDecoder().decode(Book.self, from: data)
        completion(.success(book))
        self.results = book.documents
        print("책 검색 결과", book)
        
      } catch {
        completion(.failure(error))
      }
      
    }.resume()
    
  }
  
  func fetchBookImage(document: Document, completion: @escaping (Result<UIImage, Error>) -> Void) {
    if let url = URL(string: document.thumbnail) {
      let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
          completion(.failure(error))
        }
        if let data = data {
          let bookImage = UIImage(data: data)
          completion(.success(bookImage!))
        }
      }
      task.resume()
    }
  }

}
