//
//  SearchResultViewModel.swift
//  BookShelf
//
//  Created by 예슬 on 5/8/24.
//

import UIKit

class SearchResultViewModel {
  
  var results: [Document]?
  
  func fetchBooks(query: String, completion: @escaping (Result<[Document], Error>) -> Void) {
    NetworkManager.shared.fetchBookAPI(query: query) { result in
      switch result {
        case .success(let book):
          self.results = book.documents
          completion(.success(self.results!))
        case .failure(let error):
          completion(.failure(error))
      }
    }
  }
}
