
class Calculator {
  let addOperation = AddOperation()
  let subtractOperation = SubtractOperation()
  let multiplyOperation = MultiplyOperation()
  let divideOperation = MultiplyOperation()
  let remainderOperation = RemianderOperation()
  
  func calculate(operation: String, firstNumber: Double, secondNumber: Double) -> Double {
    switch operation {
    case "+":
      return addOperation.operate(firstNumber: firstNumber, secondNumber: secondNumber)
    case "-":
      return subtractOperation.operate(firstNumber: firstNumber, secondNumber: secondNumber)
    case "*":
      return multiplyOperation.operate(firstNumber: firstNumber, secondNumber: secondNumber)
    case "/":
      return divideOperation.operate(firstNumber: firstNumber, secondNumber: secondNumber)
    case "%":
      return remainderOperation.operate(firstNumber: firstNumber, secondNumber: secondNumber)
    default:
      return 0
    }
  }
}


class AddOperation {
    func operate(firstNumber: Double, secondNumber: Double) -> Double {
      return firstNumber + secondNumber
    }
}

class SubtractOperation {
    func operate(firstNumber: Double, secondNumber: Double) -> Double {
      firstNumber - secondNumber
    }
}

class MultiplyOperation {
    func operate(firstNumber: Double, secondNumber: Double) -> Double {
      firstNumber * secondNumber
    }
}

class DivideOperation {
    func operate(firstNumber: Double, secondNumber: Double) -> Double {
      if firstNumber == 0 || secondNumber == 0 {
        return 0
      }
      return firstNumber / secondNumber
    }
}

class RemianderOperation {
  func operate(firstNumber: Double, secondNumber: Double) -> Double {
    if firstNumber == 0 || secondNumber == 0 {
      return 0
    }
    return Double(Int(firstNumber) % Int(secondNumber))
  }
}

let calculator = Calculator()

let addResult = calculator.calculate(operation: "+", firstNumber: 3, secondNumber: 5)
let subtractResult = calculator.calculate(operation: "-", firstNumber: 3, secondNumber: 5)
let multiplyResult = calculator.calculate(operation: "*", firstNumber: 3, secondNumber: 5)
let divideResult = calculator.calculate(operation: "/", firstNumber: 3, secondNumber: 5)
let remainderResult = calculator.calculate(operation: "%", firstNumber: 5, secondNumber: 3)

print("addResult : \(addResult)")
print("subtractResult : \(subtractResult)")
print("multiplyResult : \(multiplyResult)")
print("divideResult : \(divideResult)")
print("remainderResult : \(remainderResult)")
