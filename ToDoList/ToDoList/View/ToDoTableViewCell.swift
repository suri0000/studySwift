//
//  ToDoTableViewCell.swift
//  ToDoList
//
//  Created by 예슬 on 3/28/24.
//

import UIKit

protocol ToDoTableViewCellDelegate {
  func switchValueChanged(for cell: ToDoTableViewCell, isOn: Bool)
}

class ToDoTableViewCell: UITableViewCell {
  
  static let cellId = "Cell"
  var todo = ToDo.toDo
  
  var delegate: ToDoTableViewCellDelegate?
  
  func setToDoCell(indexPath: IndexPath, with todo: [ToDo]) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM월 dd일"
    
    let dueDates = Array(Set(ToDo.toDo.map { dateFormatter.string(from: $0.dueDate) })).sorted()
    let sectionDate = dueDates[indexPath.section]
    let toDoByDate = todo.filter { dateFormatter.string(from: $0.dueDate) == sectionDate }
    
    // Image
    imageView?.image = UIImage(named: "choonsik")
    
    // Label
    self.textLabel?.attributedText = toDoByDate[indexPath.row].isComplete ? toDoByDate[indexPath.row].title.strikeThrough() : toDoByDate[indexPath.row].title.removeStrikethrough()
    
    // Switch
    let completeSwitch = UISwitch()
    completeSwitch.isOn = toDoByDate[indexPath.row].isComplete
    completeSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
    
    accessoryView = completeSwitch
  }
  
  @objc func switchValueChanged(_ sender: UISwitch) {
    delegate?.switchValueChanged(for: self, isOn: sender.isOn)
  }
  
  override func prepareForReuse() {       // 셀을 초기화 해주는 코드
    super.prepareForReuse()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
}
