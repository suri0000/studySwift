//
//  BookDetailViewController.swift
//  BookShelf
//
//  Created by 예슬 on 5/3/24.
//

import UIKit

class BookDetailViewController: UIViewController {
  
  var document: Document?
  
  private let contentScrollView: UIScrollView = {
          let scrollView = UIScrollView()
          scrollView.translatesAutoresizingMaskIntoConstraints = false
          scrollView.backgroundColor = .white
          //scrollView.showsVerticalScrollIndicator = false
          
          return scrollView
      }()
  
  lazy var closeButton: UIButton = {
    let button = UIButton()
    let imageConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .light)
    
    button.setImage(UIImage(systemName: "x.circle.fill", withConfiguration: imageConfig), for: .normal)
    button.tintColor = .systemGray4
    button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    
    return button
  }()
  
  lazy var addButton: UIButton = {
    let button = UIButton()
    
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    setLayout()
  }
  
  private func setLayout() {
    view.addSubview(contentScrollView)
    view.addSubview(closeButton)
    
    closeButton.snp.makeConstraints { make in
      make.top.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
    }
  }
  
  @objc func closeButtonTapped() {
      // 뷰 컨트롤러를 닫는 코드를 여기에 작성
      self.dismiss(animated: true, completion: nil)
  }
  
  
}
