//
//  ViewController.swift
//  BookShelf
//
//  Created by 예슬 on 5/3/24.
//

import SnapKit
import UIKit

class SearchViewController: UIViewController {
  
  let viewModel = SearchResultViewModel()
  var documents: [Document] = []
  
  lazy var searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.searchBarStyle = .minimal
    searchBar.placeholder = "책 제목을 검색해 주세요"
    return searchBar
  }()
  
  let noResultLable = UILabel()
  
//  let recentlyViewedBookTitle = UILabel(text: "최근 본 책")
  let searchResultTitle = UILabel(text: "검색 결과")
//  
//  let recentlyViewedBookCollectionViewLayout: UICollectionViewFlowLayout = {
//    let layout = UICollectionViewFlowLayout()
//    layout.scrollDirection = .horizontal
//    
//    let spacing: CGFloat = 10
//    layout.minimumLineSpacing = spacing
//    
//    return layout
//  }()
//  
//  lazy var recentlyViewedBookCollectionView: UICollectionView = {
//    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: recentlyViewedBookCollectionViewLayout)
//    
//    collectionView.backgroundColor = .cyan
//    
//    return collectionView
//  }()
  
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
  
  // MARK: - ViewDidLoad

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    
    setLayout()
    setCollectionView()
    
    searchBar.delegate = self
  }
  
  // MARK: - UI관련 함수들
  
  func setLayout() {
    view.addSubview(searchBar)
    view.addSubview(searchResultTitle)
    view.addSubview(searchResultsCollectionView)
    
    searchBar.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(5)
    }
    
//    view.addSubview(recentlyViewedBookTitle)
//    recentlyViewedBookTitle.snp.makeConstraints {
//      $0.top.equalTo(searchBar.snp.bottom).offset(10)
//      $0.leading.equalTo(view.safeAreaLayoutGuide).inset(15)
//    }
//    
//    view.addSubview(recentlyViewedBookCollectionView)
//    recentlyViewedBookCollectionView.snp.makeConstraints {
//      $0.top.equalTo(recentlyViewedBookTitle.snp.bottom).offset(20)
//      $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
//    }
    
    searchResultTitle.snp.makeConstraints {
      $0.top.equalTo(searchBar.snp.bottom).offset(20)
      $0.leading.equalTo(view.safeAreaLayoutGuide).inset(15)
    }
    
    searchResultsCollectionView.snp.makeConstraints {
      $0.top.equalTo(searchResultTitle.snp.bottom).offset(20)
      $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(15)
    }
  }
  
  func setCollectionView() {
    searchResultsCollectionView.delegate = self
    searchResultsCollectionView.dataSource = self
    
    searchResultsCollectionView.register(SearchResultsCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultsCollectionViewCell.identifier)
  }
  
  func noResult() {
    noResultLable.text = "검색 결과가 없습니다."
    
    self.view.addSubview(noResultLable)
    noResultLable.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }

}

// MARK: - CollectionView
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return documents.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultsCollectionViewCell.identifier, for: indexPath) as? SearchResultsCollectionViewCell else { return UICollectionViewCell() }
    
    let document = documents[indexPath.item]
    cell.configureUI(book: document)
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let selectedDocument = documents[indexPath.item]
    
    let bookDetailViewController = BookDetailViewController()
    bookDetailViewController.document = selectedDocument
    
    // 모달로 표시
    present(bookDetailViewController, animated: true, completion: nil)
  }
  
}

// MARK: - UISearchBar

extension SearchViewController: UISearchBarDelegate {

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let searchKeyword = searchBar.text else { return }
    
    viewModel.fetchBookAPI(query: searchKeyword) { [weak self] result in
          switch result {
          case .success(let book):
              self?.documents = book.documents
              DispatchQueue.main.async {
                if self?.documents.isEmpty ?? true  {
                  self?.noResult()
                } else {
                  self?.noResultLable.removeFromSuperview()
                }
                self?.searchResultsCollectionView.reloadData()
              }
          case .failure(let error):
              print("Error loading data: \(error)")
          }
      }
  }
  
  
}
