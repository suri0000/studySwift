//
//  ViewController.swift
//  BookShelf
//
//  Created by 예슬 on 5/3/24.
//

import SnapKit
import UIKit

class SearchViewController: UIViewController {
  
  lazy var searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.searchBarStyle = .minimal
    searchBar.placeholder = "책 제목을 검색해 주세요"
    return searchBar
  }()
  
  let searchResultsCollectionViewLayout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    
    let spacing: CGFloat = 20
    layout.minimumLineSpacing = spacing
    layout.minimumInteritemSpacing = spacing
    
    let deviceWidth = UIScreen.main.bounds.width
    let itemInLine: CGFloat = 2
    let inset: CGFloat = 15
    let cellWidth = (deviceWidth - spacing - 1 - inset * 2) / itemInLine
    layout.itemSize = .init(width: cellWidth, height: cellWidth + 20)
    
    return layout
  }()
  
  lazy var searchResultsCollectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: searchResultsCollectionViewLayout)
    collectionView.showsVerticalScrollIndicator = false
    return collectionView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    setLayout()
    setCollectionView()
  }
  
  func setLayout() {
    view.addSubview(searchBar)
    searchBar.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(5)
    }
    
    view.addSubview(searchResultsCollectionView)
    searchResultsCollectionView.snp.makeConstraints {
      $0.top.equalTo(searchBar.snp.bottom).offset(20)
      $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(15)
    }
  }
  
  func setCollectionView() {
    searchResultsCollectionView.delegate = self
    searchResultsCollectionView.dataSource = self
    
    searchResultsCollectionView.register(SearchResultsCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultsCollectionViewCell.identifier)
    
    searchResultsCollectionView.backgroundColor = .brown
  }

}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultsCollectionViewCell.identifier, for: indexPath) as? SearchResultsCollectionViewCell else { return UICollectionViewCell() }
    
    return cell
  }
  
  
}

#Preview {
  SearchViewController()
}

