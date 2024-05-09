//
//  BookDetailViewController.swift
//  BookShelf
//
//  Created by 예슬 on 5/3/24.
//

import SnapKit
import UIKit

class BookDetailViewController: UIViewController {
  
  var bookData: Document?
  
  let detailView = DetailView()
      
  private let contentScrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.showsVerticalScrollIndicator = false
    
    return scrollView
  }()
  
  private let contentView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
  }()
  
  lazy var closeButton: UIButton = {
    let button = UIButton()
    let imageConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .light)
    
    button.setImage(UIImage(systemName: "x.circle.fill", withConfiguration: imageConfig), for: .normal)
    button.tintColor = .systemGray4
    button.addTarget(self, action: #selector(closeButtonTabbed), for: .touchUpInside)
    
    return button
  }()
  
  lazy var addButton: UIButton = {
    let buttonConfig = UIButton.Configuration.tinted()
    let button = UIButton(configuration: buttonConfig)
    
    button.setTitle("담기", for: .normal)
    button.addTarget(self, action: #selector(addButtonTabbed), for: .touchUpInside)
    
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setLayout()
  }
  
  private func setLayout() {
    view.addSubview(contentScrollView)
    contentScrollView.addSubview(contentView)
    contentView.addSubview(detailView)
    view.addSubview(closeButton)
    view.addSubview(addButton)
    
    closeButton.snp.makeConstraints { make in
      make.top.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
    }
    
    addButton.snp.makeConstraints { make in
      make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
      make.bottom.equalTo(view.safeAreaLayoutGuide).inset(5)
    }
    
    contentScrollView.snp.makeConstraints { make in
      make.top.equalTo(closeButton.snp.bottom).inset(-3)
      make.bottom.equalTo(addButton.snp.top).inset(-10)
      make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
    }
    
    contentView.snp.makeConstraints { make in
      make.edges.width.equalTo(contentScrollView)
    }
    
    detailView.snp.makeConstraints { make in
      make.edges.equalTo(contentView)
    }
    
    contentScrollView.contentSize = contentView.bounds.size
  }
  
  @objc func closeButtonTabbed() {
      self.dismiss(animated: true, completion: nil)
  }
  
  @objc func addButtonTabbed() {
    guard let book = bookData else { return }
    CoreDataManager.shared.saveBook(book)
    self.dismiss(animated: true, completion: nil)
  }
  
}
