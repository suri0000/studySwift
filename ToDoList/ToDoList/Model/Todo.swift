//
//  Todo.swift
//  ToDoList
//
//  Created by 예슬 on 3/28/24.
//

import Foundation

struct ToDo {
  let id: Int
  let title: String
  var isComplete: Bool = false
  let dueDate: Date
}

extension ToDo {
  static var toDo: [ToDo] = [ToDo(id: 0, title: "알고리즘 풀기", isComplete: true, dueDate: Date()),
                             ToDo(id: 1, title: "강의 듣기", isComplete: false, dueDate: Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()),
                             ToDo(id: 2, title: "과제", isComplete: true, dueDate: Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()),
                             ToDo(id: 3, title: "운동", isComplete: false, dueDate: Calendar.current.date(byAdding: .day, value: 2, to: Date()) ?? Date())]
}
