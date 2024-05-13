//
//  RecentlyViewdBookCollectionViewCell.swift
//  BookShelf
//
//  Created by 예슬 on 5/10/24.
//

import SnapKit
import UIKit

class RecentlyViewdBookCollectionViewCell: UICollectionViewCell {
  static let identifier = String(describing: RecentlyViewdBookCollectionViewCell.self)
  
  private lazy var bookImage: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "star")
    imageView.layer.cornerRadius = (self.frame.width / 2) - 10
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    
    return imageView
  }()
  
  private lazy var booktitle: UILabel = {
    let label = UILabel()
    label.text = "제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목"
    
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setConstaints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setConstaints() {
    contentView.addSubview(bookImage)
    contentView.addSubview(booktitle)
    
    bookImage.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(5)
      make.horizontalEdges.equalToSuperview().inset(10)
      make.width.equalTo(bookImage.snp.width).multipliedBy(1.0 / 1.0)
    }
    
    booktitle.snp.makeConstraints { make in
      make.top.equalTo(bookImage.snp.bottom).inset(-5)
      make.bottom.equalToSuperview()
      make.horizontalEdges.equalToSuperview()
    }
  }
}
