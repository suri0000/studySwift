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
  var toDo: [ToDo] = [ToDo(id: 0, title: "알고리즘 풀기", isComplete: true, dueDate: Date()),
                      ToDo(id: 1, title: "강의 듣기", isComplete: false, dueDate: Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()),
                      ToDo(id: 2, title: "과제", isComplete: true, dueDate: Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()),
                      ToDo(id: 3, title: "운동", isComplete: false, dueDate: Calendar.current.date(byAdding: .day, value: 2, to: Date()) ?? Date())]
  
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
    alertController.view.frame = CGRect(x: 0, y: 0, width: 300, height: 500)
    
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
    
    let addAction = UIAlertAction(title: "추가", style: .default) { alertAction in
      let newItem = alertController.textFields?.first?.text
      let selectedDate = datePicker.date
      self.toDo.append(ToDo(id: (self.toDo.last?.id ?? -1) + 1, title: newItem ?? "다시 입력해주세요", isComplete: false, dueDate: selectedDate))
      self.tableView.reloadData()
    }
    
    let cancelAction = UIAlertAction(title: "취소", style: .cancel)
    
    alertController.addAction(addAction)
    alertController.addAction(cancelAction)
    present(alertController, animated: true)
  }
  
  func dateFormat(date: Date) -> String {
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy년 MM월 dd일"
      
      return formatter.string(from: date)
  }
  
  @objc func dateChange(_ sender: UIDatePicker) {
      // 값이 변하면 UIDatePicker에서 날자를 받아와 형식을 변형해서 textField에 넣어줍니다.
    self.dateTextField.text = dateFormat(date: sender.date)
  }

  // MARK: - TableView
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

// MARK: - Datasource, Delegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
  
  // Section
  func numberOfSections(in tableView: UITableView) -> Int {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM월 dd일"
    
    // dueDate를 날짜 형식에 맞게 바꿈. 그리고 중복 없애서 배열에 넣기
    let dueDates = Array(Set(toDo.map { dateFormatter.string(from: $0.dueDate) })).sorted()
    
    return dueDates.count
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM월 dd일"
    
    let dueDates = Array(Set(toDo.map { dateFormatter.string(from: $0.dueDate) })).sorted()
    
    return dueDates[section]
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM월 dd일"
    
    let dueDates = Array(Set(toDo.map { dateFormatter.string(from: $0.dueDate) })).sorted()
    
    // titleForHeaderInSection
    let sectionDate = dueDates[section]

    return toDo.filter { dateFormatter.string(from: $0.dueDate) == sectionDate }.count
  }
  
  // MARK: - Cell
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM월 dd일"
    
    let dueDates = Array(Set(toDo.map { dateFormatter.string(from: $0.dueDate) })).sorted()
    let sectionDate = dueDates[indexPath.section]
    let toDoByDate = toDo.filter { dateFormatter.string(from: $0.dueDate) == sectionDate }
    
    cell.imageView?.image = UIImage(named: "choonsik")
    
    // Switch
    let attributeString = NSMutableAttributedString(string: toDoByDate[indexPath.row].title)
    
    if toDoByDate[indexPath.row].isComplete {
      attributeString.addAttribute(.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
      cell.textLabel?.attributedText = attributeString
    } else {
      attributeString.removeAttribute(.strikethroughStyle, range: NSMakeRange(0, attributeString.length))
      cell.textLabel?.attributedText = attributeString
    }
    
    let completeSwitch = UISwitch()
    completeSwitch.isOn = toDoByDate[indexPath.row].isComplete
    completeSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
    
    cell.accessoryView = completeSwitch
    
    return cell
  }
  
  @objc func switchValueChanged(_ sender: UISwitch) {
    guard let cell = sender.superview as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {
      return
    }
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM월 dd일"
    
    let dueDates = Array(Set(toDo.map { dateFormatter.string(from: $0.dueDate) })).sorted()
    let sectionDate = dueDates[indexPath.section]
    let toDoByDate = toDo.filter { dateFormatter.string(from: $0.dueDate) == sectionDate }
    
    // 섹션의 날짜와 같고, 선택된 행에 해당하는 할 일의 타이틀이 같은 경우
    if let index = toDo.firstIndex(where: { dateFormatter.string(from: $0.dueDate) == sectionDate && $0.title == toDoByDate[indexPath.row].title }) {
      toDo[index].isComplete = sender.isOn
    }
    
    self.tableView.reloadData()
  }
  
  // Delete
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM월 dd일"
    
    var dueDates = Array(Set(toDo.map { dateFormatter.string(from: $0.dueDate) })).sorted()
    let sectionDate = dueDates[indexPath.section]
    let toDoByDate = toDo.filter { dateFormatter.string(from: $0.dueDate) == sectionDate }
    let todoToDelete = toDoByDate[indexPath.row]
    
    toDo.removeAll { $0.id == todoToDelete.id }
    
    let remainingToDoInSection = toDo.filter { dateFormatter.string(from: $0.dueDate) == sectionDate }
    
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

struct ToDo {
  let id: Int
  let title: String
  var isComplete: Bool = false
  let dueDate: Date
}

#Preview {
  ViewController()
}
