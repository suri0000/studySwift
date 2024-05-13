//
//  ViewController.swift
//  BookShelf
//
//  Created by 예슬 on 5/3/24.
//

import SnapKit
import UIKit

class SearchViewController: UIViewController {
  
  var documents: [Document] = []
  var recentlyViewedBooks: [Document] = []
  
  lazy var searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    
    searchBar.searchBarStyle = .minimal
    searchBar.placeholder = "제목, 저자 등을 검색해 주세요"
    
    return searchBar
  }()
  
  lazy var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.showsVerticalScrollIndicator = false
    
    return scrollView
  }()
  
  lazy var contentView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
  }()
  
  let noResultLable = UILabel()
  
  let recentlyViewedBookTitle = UILabel(text: "최근 본 책")
  let searchResultTitle = UILabel(text: "검색 결과")
  
  let recentlyViewedBookCollectionViewLayout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    let deviceWidth = UIScreen.main.bounds.width
    let spacing: CGFloat = 10
    let inset: CGFloat = 15
    let cellWidth = (deviceWidth - spacing - inset * 2) / 3
    
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = spacing
    layout.itemSize = .init(width: cellWidth, height: cellWidth)
    
    return layout
  }()
  
  lazy var recentlyViewedBookCollectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: recentlyViewedBookCollectionViewLayout)
    
    return collectionView
  }()
  
  let searchResultsCollectionViewLayout: UICollectionViewFlowLayout = {
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
    view.addSubview(scrollView)
    scrollView.addSubview(contentView)
    contentView.addSubview(searchResultTitle)
    contentView.addSubview(searchResultsCollectionView)
    contentView.addSubview(recentlyViewedBookTitle)
    contentView.addSubview(recentlyViewedBookCollectionView)
    
    searchBar.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(5)
    }
    
    scrollView.snp.makeConstraints { make in
      make.top.equalTo(searchBar.snp.bottom).inset(-5)
      make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
    }
    
    contentView.snp.makeConstraints { make in
      make.edges.width.equalTo(scrollView)
    }
    
    recentlyViewedBookTitle.snp.makeConstraints {
      $0.top.equalTo(contentView.snp.top)
      $0.leading.equalTo(contentView.snp.leading).inset(15)
    }
    
    recentlyViewedBookCollectionView.snp.makeConstraints {
      $0.top.equalTo(recentlyViewedBookTitle.snp.bottom).offset(20)
      $0.horizontalEdges.equalTo(contentView).inset(15)
      $0.height.equalToSuperview().multipliedBy(1.0 / 6.0)
    }
    
    searchResultTitle.snp.makeConstraints {
      $0.top.equalTo(recentlyViewedBookCollectionView.snp.bottom).offset(20)
      $0.leading.equalTo(contentView.snp.leading).inset(15)
    }
    
    searchResultsCollectionView.snp.makeConstraints {
      $0.top.equalTo(searchResultTitle.snp.bottom).offset(20)
      $0.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(15)
      $0.bottom.equalTo(contentView.snp.bottom)
      $0.height.equalToSuperview().multipliedBy(2.0 / 3.0)
    }
    
    scrollView.contentSize = contentView.bounds.size
  }
  
  func setCollectionView() {
    searchResultsCollectionView.delegate = self
    searchResultsCollectionView.dataSource = self
    searchResultsCollectionView.register(SearchResultsCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultsCollectionViewCell.identifier)
    
    recentlyViewedBookCollectionView.delegate = self
    recentlyViewedBookCollectionView.dataSource = self
    recentlyViewedBookCollectionView.register(RecentlyViewdBookCollectionViewCell.self, forCellWithReuseIdentifier: RecentlyViewdBookCollectionViewCell.identifier)
  }
  
  func noResult() {
    noResultLable.text = "검색 결과가 없습니다."
    
    self.view.addSubview(noResultLable)
    noResultLable.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
  
}

// MARK: - CollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch collectionView {
      case searchResultsCollectionView:
        
        return documents.count
      case recentlyViewedBookCollectionView:
        
        //return recentlyViewedBooks.count
        return 5
      default:
        return 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch collectionView {
      case searchResultsCollectionView:
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultsCollectionViewCell.identifier, for: indexPath) as? SearchResultsCollectionViewCell else { return UICollectionViewCell() }
        
        let document = documents[indexPath.item]
        
        cell.configureUI(book: document)
        
        return cell
      case recentlyViewedBookCollectionView:
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentlyViewdBookCollectionViewCell.identifier, for: indexPath) as? RecentlyViewdBookCollectionViewCell else { return UICollectionViewCell() }
        
        //let document = documents[indexPath.item]
        
        return cell
        
      default:
        return UICollectionViewCell()
    }
  
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let selectedDocument = documents[indexPath.item]
    let bookDetailViewController = BookDetailViewController()
    let detailView = bookDetailViewController.detailView
    
    detailView.didSelectItem = selectedDocument
    bookDetailViewController.bookData = selectedDocument
    
    present(bookDetailViewController, animated: true, completion: nil)
  }
  
}

// MARK: - UISearchBar

extension SearchViewController: UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let searchKeyword = searchBar.text else { return }
    
    NetworkManager.shared.fetchBookAPI(query: searchKeyword) { [weak self] result in
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
