//
//  BookListViewController.swift
//  BookShelf
//
//  Created by 예슬 on 5/3/24.
//

import SnapKit
import UIKit

class BookListViewController: UIViewController {
  
  var addedBook: [AddedBook] = CoreDataManager.shared.fetchBook()
  
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
    button.addTarget(self, action: #selector(tabbedDeleteAllButton), for: .touchUpInside)
    
    return button
  }()
  
  private lazy var addButton: UIButton = {
    let button = UIButton()
    
    button.setTitle("추가", for: .normal)
    button.setTitleColor(.orange, for: .normal)
    button.addTarget(self, action: #selector(addButtonTabbed), for: .touchUpInside)
    
    return button
  }()
  
  lazy var bookListTableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .orange
    
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    bookListTableView.delegate = self
    bookListTableView.dataSource = self
    bookListTableView.register(BookListTableViewCell.self, forCellReuseIdentifier: BookListTableViewCell.identifier)
    bookListTableView.reloadData()
    setConstraints()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    addedBook = CoreDataManager.shared.fetchBook()
    bookListTableView.reloadData()
  }
  
  private func setConstraints() {
    [bookListTitle, addButton, deleteAllButton, bookListTableView].forEach {
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
    
    bookListTableView.snp.makeConstraints { make in
      make.top.equalTo(bookListTitle.snp.bottom).inset(-10)
      make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
    }
    
  }
  
  @objc func tabbedDeleteAllButton() {
    CoreDataManager.shared.deleteAllBook()
    addedBook.removeAll()
    bookListTableView.reloadData()
  }
  
  @objc func addButtonTabbed() {
    
  }
  
}

extension BookListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return addedBook.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: BookListTableViewCell.identifier, for: indexPath) as? BookListTableViewCell else { return UITableViewCell() }
    
    let book = addedBook[indexPath.row]
    cell.configureUI(book: book)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let height = tableView.bounds.height / 3
    return CGFloat(height)
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
    CoreDataManager.shared.deleteOneBook(addedBook[indexPath.row])
    addedBook.remove(at: indexPath.row)
    tableView.deleteRows(at: [indexPath], with: .fade)
    tableView.reloadData()
  }
}
