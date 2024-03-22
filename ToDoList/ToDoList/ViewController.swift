//
//  ViewController.swift
//  ToDoList
//
//  Created by 예슬 on 3/19/24.
//

import UIKit

class ViewController: UIViewController {
  
  let addButton = UIButton()
  let tableView = UITableView()
  
  var toDo: [ToDo] = [ToDo(id: 0, title: "알고리즘 풀기", isComplete: true),
                      ToDo(id: 1, title: "강의 듣기", isComplete: false)]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setAddButton()
    setTableView()
    
  }
  
  func setAddButton() {
    addButton.setTitle("추가하기", for: .normal)
    addButton.setTitleColor(.systemBlue, for: .normal)
    addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    
    view.addSubview(addButton)
    addButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
    ])
  }
  @objc func addButtonTapped() {
    let alertController = UIAlertController(title: "할 일 추가", message: nil, preferredStyle: .alert)
    
    alertController.addTextField { textField in
      textField.placeholder = "할 일을 입력해주세요."
    }
    
    let addAction = UIAlertAction(title: "추가", style: .default) { alertAction in
      let newItem = alertController.textFields?.first?.text
      self.toDo.append(ToDo(id: (self.toDo.last?.id ?? -1) + 1, title: newItem ?? "다시 입력해주세요", isComplete: false))
      self.tableView.reloadData()
    }
    
    let cancelAction = UIAlertAction(title: "취소", style: .cancel)
    
    alertController.addAction(addAction)
    alertController.addAction(cancelAction)
    present(alertController, animated: true)
  }
  
  func setTableView() {
    tableView.dataSource = self
    tableView.delegate = self
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
    let attributeString = NSMutableAttributedString(string: toDo[indexPath.row].title)
    
    if toDo[indexPath.row].isComplete {
      attributeString.addAttribute(.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
      cell.textLabel?.attributedText = attributeString
    } else {
      attributeString.removeAttribute(.strikethroughStyle, range: NSMakeRange(0, attributeString.length))
      cell.textLabel?.attributedText = attributeString
    }
    
    let completeSwitch = UISwitch()
    completeSwitch.isOn = toDo[indexPath.row].isComplete
    completeSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
    
    cell.accessoryView = completeSwitch
    
    return cell
  }
  
  @objc func switchValueChanged(_ sender: UISwitch) {
    guard let cell = sender.superview as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {
      return
    }
    toDo[indexPath.row].isComplete = sender.isOn
    self.tableView.reloadData()
  }
  
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    toDo.remove(at: indexPath.row)
    tableView.deleteRows(at: [indexPath], with: .fade)
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

struct ToDo {
  let id: Int
  let title: String
  var isComplete: Bool = false
}

#Preview {
  ViewController()
}
