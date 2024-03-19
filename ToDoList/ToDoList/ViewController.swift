//
//  ViewController.swift
//  ToDoList
//
//  Created by 예슬 on 3/19/24.
//

import UIKit

class ViewController: UIViewController {
  
  let addButton = UIButton()
  let toDo: [ToDo] = [ToDo(id: 0, title: "알고리즘 풀기", complete: true),
                      ToDo(id: 1, title: "강의 듣기", complete: true)]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    setAddButton()
    setTableView()
    
  }
  
  func setAddButton() {
    
    addButton.setTitle("추가하기", for: .normal)
    addButton.setTitleColor(.systemBlue, for: .normal)
    
    view.addSubview(addButton)
    addButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
    ])
  }
  
  
  func setTableView() {
    let tableView = UITableView()
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    
    self.view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 20),
      tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
      tableView.heightAnchor.constraint(equalTo: view.heightAnchor)
    ])
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return toDo.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = toDo[indexPath.row].title
    cell.accessoryView = UISwitch()
    
    return cell
  }
  
}

struct ToDo {
  let id: Int
  let title: String
  var complete: Bool = false
}

#Preview {
  ViewController()
}
