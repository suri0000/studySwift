//
//  BaseballGame.swift
//  BaseballGame
//
//  Created by 예슬 on 3/13/24.
//

import Foundation

class BaseballGame {
  
  func start() {
    print("\n게임을 시작합니다.")
    print("0에서 9까지의 서로 다른 임의의 수 3개를 정하고 맞추는 게임입니다")
    print("숫자를 입력해주세요.")

    let answer = makeAnswer()
    
    print(answer)
    
    var correctNumber: Bool = true
    
    while correctNumber {
      
      let input = readLine()!
      let inputNumbers = input.map { Int(String($0)) ?? 0 }
      var strike = 0
      var ball = 0
      
      if ((Int(input)) == nil) {
        print("문자열 말고, 숫자를 입력해주세요.")
      } else if Int(input) ?? -1 < 0 {
        print("음수입니다. 양수를 입력해주세요.")
      } else if input.count != 3 {
        print("세 자리 숫자를 입력해주세요.")
      } else if Array(input).count != Set(input).count {
        print("0-9까지의 서로 다른 임의의 수 3개를 입력해주세요.")
      } else if input.count == 3 {
        for index in 0...2 {
          if inputNumbers[index] == answer[index] {
            strike += 1
          } else if answer.contains(inputNumbers[index]) {
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
  
  func makeAnswer() -> [Int] {
    var answer: [Int] = []
    
    while answer.count < 3 {
      answer.append(Int.random(in: 0...9))
      
      if answer.first == 0 {
        answer.remove(at: 0)
      } else if answer.count != Set(answer).count {
        answer.removeAll()
      }
    }
    return answer
  }
}
