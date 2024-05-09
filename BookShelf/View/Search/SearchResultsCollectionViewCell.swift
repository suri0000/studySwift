//
//  SearchResultsCollectionViewCell.swift
//  BookShelf
//
//  Created by 예슬 on 5/7/24.
//

import SnapKit
import UIKit

class SearchResultsCollectionViewCell: UICollectionViewCell {
  static let identifier = String(describing: SearchResultsCollectionViewCell.self)
  
  lazy var bookImage: UIImageView = {
    let bookImage = UIImageView()
    bookImage.contentMode = .scaleAspectFit
    return bookImage
  }()
  
  lazy var bookTitle: UILabel = {
    let bookTitle = UILabel()
    bookTitle.textAlignment = .center
    bookTitle.font = UIFont.preferredFont(for: .body, weight: .bold)
    
    return bookTitle
  }()
  
  lazy var authors: UILabel = {
    let authors = UILabel()
    authors.textAlignment = .center
    return authors
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setLayout() {
    contentView.addSubview(bookImage)
    contentView.addSubview(bookTitle)
    contentView.addSubview(authors)
    
    bookImage.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.height.equalToSuperview().multipliedBy(2.0 / 3.0)
    }
    
    bookTitle.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(bookImage.snp.bottom).offset(10)
      $0.horizontalEdges.greaterThanOrEqualToSuperview().inset(10)
    }
    
    authors.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.horizontalEdges.greaterThanOrEqualToSuperview().inset(10)
      $0.top.equalTo(bookTitle.snp.bottom).offset(5)
      $0.bottom.equalToSuperview().inset(5)
    }
  }
  
  func configureUI(book: Document) {
    bookTitle.text = book.title
    authors.text = book.authors.joined(separator: ", ")
    
    NetworkManager.shared.fetchBookImage(document: book) { [weak self] result in
      switch result {
        case .success(let image):
          DispatchQueue.main.async {
            self?.bookImage.image = image
          }
        case .failure(let error):
          print("Error fetching book image: \(error)")
      }
    }
  }
}
