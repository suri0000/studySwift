//
//  BookListViewController.swift
//  BookShelf
//
//  Created by 예슬 on 5/3/24.
//

import SnapKit
import UIKit

class BookListViewController: UIViewController {
  
  private lazy var bookListTitle: UILabel = {
    let label = UILabel()
    
    label.text = "담은 책"
    label.font = UIFont.preferredFont(for: .title2, weight: .bold)
    
    return label
  }()
  
  private let deleteAllButton: UIButton = {
    let button = UIButton()
    
    button.setTitle("전체 삭제", for: .normal)
    button.setTitleColor(.systemGray3, for: .normal)
    button.addTarget(BookListViewController.self, action: #selector(tabbedDeleteAllButton), for: .touchUpInside)
    
    return button
  }()
  
  private lazy var addButton: UIButton = {
    let button = UIButton()
    
    button.setTitle("추가", for: .normal)
    button.setTitleColor(.orange, for: .normal)
    button.addTarget(BookListViewController.self, action: #selector(addButtonTabbed), for: .touchUpInside)
    
    return button
  }()
  
  private let bookListCollectionViewFlowLayout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    let spacing: CGFloat = 20
    let deviceWidth = UIScreen.main.bounds.width
    let itemInLine: CGFloat = 2
    let inset: CGFloat = 15
    let cellWidth = (deviceWidth - spacing - 1 - inset * 2) / itemInLine
    
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = spacing
    layout.minimumInteritemSpacing = spacing
    layout.itemSize = .init(width: cellWidth, height: cellWidth + 20)
    
    return layout
  }()
  
  private lazy var bookListCollectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: bookListCollectionViewFlowLayout)
    
    collectionView.showsVerticalScrollIndicator = false
    collectionView.backgroundColor = .orange
    
    return collectionView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setConstraints()
  }
  
  private func setConstraints() {
    [bookListTitle, addButton, deleteAllButton, bookListCollectionView].forEach {
      view.addSubview($0)
    }
    
    bookListTitle.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.centerX.equalToSuperview()
    }
    
    addButton.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
      make.centerY.equalTo(bookListTitle)
    }
    
    deleteAllButton.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
      make.centerY.equalTo(bookListTitle)
    }
    
    bookListCollectionView.snp.makeConstraints { make in
      make.top.equalTo(bookListTitle.snp.bottom).inset(-10)
      make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  @objc func tabbedDeleteAllButton() {
    
  }
  
  @objc func addButtonTabbed() {
    
  }
  
}
