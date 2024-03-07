
class Calculator {
  
  var operation: AbstractOperation
  
  init(operation: AbstractOperation) {
    self.operation = operation
  }
  
  func changeOperation(operation: AbstractOperation) {
    self.operation = operation
  }
  
  func calculate(firstNumber: Double, secondNumber: Double) -> Double {
    return operation.calculate(firstNumber: firstNumber, secondNumber: secondNumber)
  }
}

// 프로토콜을 배우지 않아 클래스의 상속으로 처리
class AbstractOperation {
  func calculate(firstNumber: Double, secondNumber: Double) -> Double {
    return 0
  }
}


class AddOperation: AbstractOperation {
  override func calculate(firstNumber: Double, secondNumber: Double) -> Double {
    return firstNumber + secondNumber
  }
}

class SubtractOperation: AbstractOperation {
  override func calculate(firstNumber: Double, secondNumber: Double) -> Double {
    return firstNumber - secondNumber
  }
}

class MultiplyOperation: AbstractOperation {
  override func calculate(firstNumber: Double, secondNumber: Double) -> Double {
    return firstNumber * secondNumber
  }
}

class DivideOperation: AbstractOperation {
  override func calculate(firstNumber: Double, secondNumber: Double) -> Double {
      if firstNumber == 0 || secondNumber == 0 {
        return 0
      }
      return firstNumber / secondNumber
    }
}

class RemianderOperation: AbstractOperation {
  override func calculate(firstNumber: Double, secondNumber: Double) -> Double {
    if firstNumber == 0 || secondNumber == 0 {
      return 0
    }
    return Double(Int(firstNumber) % Int(secondNumber))
  }
}

let calculator = Calculator(operation: AddOperation())

let addResult = calculator.calculate(firstNumber: 3, secondNumber: 5)

// calculator에 뺄셈 기능하도록 프로퍼티 변경함수 호출
calculator.changeOperation(operation: SubtractOperation())
let subtractResult = calculator.calculate(firstNumber: 3, secondNumber: 5)

// calculator에 곱셈 기능하도록 프로퍼티 변경함수 호출
calculator.changeOperation(operation: MultiplyOperation())
let multiplyResult = calculator.calculate(firstNumber: 3, secondNumber: 5)

// calculator에 나눗셈 기능하도록 프로퍼티 변경함수 호출
calculator.changeOperation(operation: DivideOperation())
let divideResult = calculator.calculate(firstNumber: 3, secondNumber: 5)

calculator.changeOperation(operation: RemianderOperation())
let remainderResult = calculator.calculate(firstNumber: 5, secondNumber: 3)

print("addResult : \(addResult)")
print("subtractResult : \(subtractResult)")
print("multiplyResult : \(multiplyResult)")
print("divideResult : \(divideResult)")
print("remainderResult : \(remainderResult)")

