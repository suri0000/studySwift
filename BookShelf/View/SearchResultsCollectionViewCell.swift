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
    bookImage.image = UIImage(systemName: "star")
    bookImage.backgroundColor = .lightGray
    bookImage.contentMode = .scaleAspectFit
    return bookImage
  }()
  
  lazy var bookTitle: UILabel = {
    let bookTitle = UILabel()
    bookTitle.text = "유니버스"
    bookTitle.backgroundColor = .white
    return bookTitle
  }()
  
  lazy var authors: UILabel = {
    let authors = UILabel()
    authors.text = "닐 타이슨"
    authors.backgroundColor = .green
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
    contentView.backgroundColor = .blue
    
    contentView.addSubview(bookImage)
    contentView.addSubview(bookTitle)
    contentView.addSubview(authors)
    
    bookImage.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
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
}
