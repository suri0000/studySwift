//
//  BookListViewController.swift
//  BookShelf
//
//  Created by 예슬 on 5/3/24.
//

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
    button.tintColor = .systemGray4
    button.addTarget(BookListViewController.self, action: #selector(tabbedDeleteAllButton), for: .touchUpInside)
    
    return button
  }()
  
  private lazy var addButton: UIButton = {
    let button = UIButton()
    
    button.setTitle("추가", for: .normal)
    button.tintColor = .systemBlue
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
  }
  
  @objc func tabbedDeleteAllButton() {
    
  }
  
  @objc func addButtonTabbed() {
    
  }
  
}
