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
  var dateTextField = UITextField()
  
  // To-Do 데이터
  var todo = ToDo.toDo
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setAddButton()
    setTableView()
    
  }
  // MARK: - 추가하기 버튼
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
    let alertController = UIAlertController(title: "할 일 추가", message: "날짜도 설정해주세요", preferredStyle: .alert)
    
    // DatePicker
    let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 100, height: 300))
    datePicker.datePickerMode = .date
    datePicker.preferredDatePickerStyle = .wheels
    datePicker.locale = NSLocale(localeIdentifier: "ko_KO") as Locale
    datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
    
    // To-do
    alertController.addTextField { textField in
      textField.placeholder = "할 일을 입력해주세요"
    }
    
    // Date
    alertController.addTextField { textField in
      textField.inputView = datePicker
      textField.text = self.dateFormat(date: Date())
      self.dateTextField = textField
    }
    
    // 추가, 취소
    let addAction = UIAlertAction(title: "추가", style: .default) { alertAction in
      let newItem = alertController.textFields?.first?.text
      let selectedDate = datePicker.date
      self.todo.append(ToDo(id: (self.todo.last?.id ?? -1) + 1, title: newItem ?? "다시 입력해주세요", isComplete: false, dueDate: selectedDate))
      self.tableView.reloadData()
    }
    
    let cancelAction = UIAlertAction(title: "취소", style: .cancel)
    
    alertController.addAction(addAction)
    alertController.addAction(cancelAction)
    present(alertController, animated: true)
  }
  
  func dateFormat(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy년 MM월 dd일"
    
    return dateFormatter.string(from: date)
  }
  
  @objc func dateChange(_ sender: UIDatePicker) {
    // 값이 변하면 UIDatePicker에서 날자를 받아와 형식을 변형해서 textField에 넣어줍니다.
    self.dateTextField.text = dateFormat(date: sender.date)
  }
  
  // MARK: - TableView
  func setTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.cellId)
    
    self.view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 20),
      tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
      tableView.heightAnchor.constraint(equalTo: view.heightAnchor)
    ])
  }
}

// MARK: - DataSource, Delegate
extension ViewController: UITableViewDataSource, UITableViewDelegate, ToDoTableViewCellDelegate {
  // Section
  func numberOfSections(in tableView: UITableView) -> Int {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM월 dd일"
    
    // dueDate를 날짜 형식에 맞게 바꿈. 그리고 중복 없애서 배열에 넣기
    let dueDates = Array(Set(todo.map { dateFormatter.string(from: $0.dueDate) })).sorted()
    
    return dueDates.count
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM월 dd일"
    
    let dueDates = Array(Set(todo.map { dateFormatter.string(from: $0.dueDate) })).sorted()
    
    return dueDates[section]
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM월 dd일"
    
    let dueDates = Array(Set(todo.map { dateFormatter.string(from: $0.dueDate) })).sorted()
    
    // titleForHeaderInSection
    let sectionDate = dueDates[section]
    
    return todo.filter { dateFormatter.string(from: $0.dueDate) == sectionDate }.count
  }
  
  // MARK: - Cell
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.cellId, for: indexPath) as? ToDoTableViewCell else {
      fatalError("Failed to dequeue ToDoTableViewCell")
    }
    
    cell.delegate = self
    cell.setToDoCell(indexPath: indexPath, with: todo)
    
    return cell
  }
  
  // Switch 값 변경
  func switchValueChanged(for cell: ToDoTableViewCell, isOn: Bool) {
    guard let indexPath = tableView.indexPath(for: cell) else {
      return
    }
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM월 dd일"
    
    let dueDates = Array(Set(todo.map { dateFormatter.string(from: $0.dueDate) })).sorted()
    let sectionDate = dueDates[indexPath.section]
    let toDoByDate = todo.filter { dateFormatter.string(from: $0.dueDate) == sectionDate }
    
    // 섹션의 날짜와 같고, 선택된 행에 해당하는 할 일의 타이틀이 같은 경우
    if let index = todo.firstIndex(where: { dateFormatter.string(from: $0.dueDate) == sectionDate && $0.title == toDoByDate[indexPath.row].title }) {
      todo[index].isComplete = isOn
    }
    
    tableView.reloadData()
  }
  
  // Delete
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM월 dd일"
    
    var dueDates = Array(Set(todo.map { dateFormatter.string(from: $0.dueDate) })).sorted()
    let sectionDate = dueDates[indexPath.section]
    let toDoByDate = todo.filter { dateFormatter.string(from: $0.dueDate) == sectionDate }
    let todoToDelete = toDoByDate[indexPath.row]
    
    todo.removeAll { $0.id == todoToDelete.id }
    
    let remainingToDoInSection = todo.filter { dateFormatter.string(from: $0.dueDate) == sectionDate }
    
    if remainingToDoInSection.isEmpty {
      if let sectionIndex = dueDates.firstIndex(of: sectionDate) {
        dueDates.remove(at: sectionIndex)
        tableView.deleteSections(IndexSet(integer: sectionIndex), with: .automatic)
      }
    } else {
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

#Preview {
  ViewController()
}
