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

  override func viewDidLoad() {
    super.viewDidLoad()
    setLayout()
  }
  
  func setLayout() {
    view.addSubview(searchBar)
    searchBar.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(10)
      $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(10)
    }
  }

}

#Preview {
  SearchViewController()
}

