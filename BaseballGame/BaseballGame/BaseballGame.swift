//
//  BaseballGame.swift
//  BaseballGame
//
//  Created by 예슬 on 3/13/24.
//

import Foundation

class BaseballGame {
  func start() {
    let answer = makeAnswer()
  }
  
  func makeAnswer() -> String {
    
    var numbers: [Int] = []
    var stringNumbers: [String] = []
    var answers: [String] = []
    
    for number in 102...987 {
      numbers.append(number)
    }
    
    stringNumbers = numbers.map({ number in
      String(number)
    })
    
    for str in stringNumbers {
      if str[str.startIndex] != str[str.index(after: str.startIndex)] &&
          str[str.index(after: str.startIndex)] != str[str.index(before: str.endIndex)] &&
          str[str.startIndex] != str[str.index(before: str.endIndex)] &&
          !str.contains("0") {
        answers.append(str)
      }
    }
    
    return answers.randomElement() ?? "잘못된 숫자입니다."
  }
}


