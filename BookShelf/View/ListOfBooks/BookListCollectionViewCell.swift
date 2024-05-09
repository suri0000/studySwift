//
//  BookListCollectionViewCell.swift
//  BookShelf
//
//  Created by 예슬 on 5/9/24.
//

import SnapKit
import UIKit

class BookListCollectionViewCell: UICollectionViewCell {
  
  static let identifier = String(describing: BookListCollectionViewCell.self)
  
  private lazy var bookImage: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private lazy var bookTitle: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.font = UIFont.preferredFont(for: .body, weight: .bold)
    
    return label
  }()
  
  private lazy var author: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setConstraints() {
    [bookImage, bookTitle, author].forEach {
      contentView.addSubview($0)
    }
    
    bookImage.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.height.equalToSuperview().multipliedBy(2.0 / 3.0)
    }
    
    bookTitle.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(bookImage.snp.bottom).offset(10)
      $0.horizontalEdges.greaterThanOrEqualToSuperview().inset(10)
    }
    
    author.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.horizontalEdges.greaterThanOrEqualToSuperview().inset(10)
      $0.top.equalTo(bookTitle.snp.bottom).offset(5)
      $0.bottom.equalToSuperview().inset(5)
    }
  }
}
