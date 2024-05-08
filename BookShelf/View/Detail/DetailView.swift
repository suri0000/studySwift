//
//  DetailView.swift
//  BookShelf
//
//  Created by 예슬 on 5/8/24.
//

import SnapKit
import UIKit

class DetailView: UIView {
  
  var didSelectItem: Document? {
    didSet {
      configureUI()
    }
  }
  
  private lazy var bookTitle: UILabel = {
    let label = UILabel()
    
    label.font = UIFont.preferredFont(for: .title3, weight: .bold)
    
    return label
  }()
  
  private lazy var author: UILabel = {
    let label = UILabel()
    
    label.font = UIFont.preferredFont(forTextStyle: .body)
    
    return label
  }()
  
  private lazy var publisher: UILabel = {
    let label = UILabel()
    
    label.font = UIFont.preferredFont(forTextStyle: .subheadline)
    label.textColor = .secondaryLabel
    
    return label
  }()
  
  private lazy var content: UILabel = {
    let label = UILabel()
    
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.numberOfLines = 0
    label.textAlignment = .justified
    
    return label
  }()
  
  private lazy var bookImage: UIImageView = {
    let image = UIImageView()
    
    image.contentMode = .scaleAspectFit
    
    return image
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setLayout()
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setLayout() {
    [bookImage, bookTitle, author, publisher, content].forEach {
      self.addSubview($0)
    }
    
    bookImage.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.centerX.equalToSuperview()
      make.height.equalToSuperview().multipliedBy(1.0 / 2.0)
      make.horizontalEdges.equalToSuperview().inset(20)
    }
    
    bookTitle.snp.makeConstraints { make in
      make.top.equalTo(bookImage.snp.bottom).offset(10)
      make.centerX.equalToSuperview()
    }
    
    author.snp.makeConstraints { make in
      make.top.equalTo(bookTitle.snp.bottom).offset(20)
      make.centerX.equalToSuperview()
    }
    
    publisher.snp.makeConstraints { make in
      make.top.equalTo(author.snp.bottom).offset(5)
      make.centerX.equalToSuperview()
    }
    
    content.snp.makeConstraints { make in
      make.top.equalTo(publisher.snp.bottom).offset(30)
      make.centerX.equalToSuperview()
      make.horizontalEdges.equalToSuperview().inset(20)
      make.bottom.equalToSuperview()
    }
    
  }
  
  private func configureUI() {
    guard let selectedDocument = didSelectItem else { return }
    
    bookTitle.text = selectedDocument.title
    author.text = selectedDocument.authors.joined(separator: ",")
    publisher.text = selectedDocument.publisher
    content.text = selectedDocument.contents
    
    NetworkManager.shared.fetchBookImage(document: selectedDocument) { [weak self] result in
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
