//
//  BookListTableViewCell.swift
//  BookShelf
//
//  Created by 예슬 on 5/10/24.
//

import SnapKit
import UIKit

class BookListTableViewCell: UITableViewCell {
  
  static let identifier = String(describing: BookListTableViewCell.self)
  
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
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setConstraints()
    self.backgroundColor = .yellow
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setConstraints() {
    [bookImage, bookTitle, author].forEach {
      contentView.addSubview($0)
    }
    
    bookImage.snp.makeConstraints { make in
      make.top.leading.equalToSuperview().inset(10)
    }
    
    bookTitle.snp.makeConstraints { make in
      make.top.equalTo(bookImage.snp.top).inset(10)
      make.leading.equalTo(bookImage.snp.trailing).offset(10)
    }
    
    author.snp.makeConstraints { make in
      make.top.equalTo(bookTitle.snp.bottom).offset(10)
      make.leading.equalTo(bookTitle.snp.leading)
    }
  }
  
  func configureUI(book: AddedBook) {
    bookTitle.text = book.title
    author.text = book.author
    
    NetworkManager.shared.fetchSelectedBookImage(document: book) { [weak self] result in
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
