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
    print("⚾️ 안녕하세요! 야구 게임을 시작합니다 ⚾️")
    print("1에서 9까지의 서로 다른 임의의 수 3개를 정하고 맞추는 게임입니다")
    print("0도 포함되면 안 됩니다!")
    print("숫자를 입력해주세요!")

    var correctNumber: Bool = true
    var answerNumbers = Array(answer)
    
    while correctNumber {
      
      var input = readLine()!
      var inputNumbers = Array(input)
      var strike = 0
      var ball = 0
      
      if (Int(input) == nil) {
        print("문자열 말고, 숫자를 입력해주세요.")
      } else if Int(input) ?? -1 < 0 {
        print("음수입니다. 양수를 입력해주세요.")
      } else if input.count != 3 {
        print("세 자리 숫자를 입력해주세요.")
      } else if input[input.startIndex] == input[input.index(after: input.startIndex)] ||
                  input[input.index(after: input.startIndex)] == input[input.index(before: input.endIndex)] ||
                  input[input.startIndex] == input[input.index(before: input.endIndex)] ||
                  input.contains("0") {
        print("1-9까지의 서로 다른 임의의 수 3개를 입력해주세요. 0이 들어가도 안 됩니다.")
      } else if input.count == 3 {
        for index in 0...2 {
          if inputNumbers[index] == answerNumbers[index] {
            strike += 1
          } else if answerNumbers.contains(inputNumbers[index]) {
            ball += 1
          }
        }
        
        if strike == 3 {
          print("정답입니다! 게임이 끝났습니다.")
          correctNumber = false
        } else if strike == 0 && ball == 0 {
          print("스트라이크와 볼 중 아무것도 해당되지 않습니다.")
        } else {
          print("\(strike) 스트라이크, \(ball) 볼")
        }
      }
      
    }
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


