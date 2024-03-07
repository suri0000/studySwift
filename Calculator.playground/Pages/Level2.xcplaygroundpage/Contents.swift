
class Calculator {
  func calculate(operation: String, firstNumber: Double, secondNumber: Double) -> Double {
    switch operation {
    case "+":
      return firstNumber + secondNumber
    case "-":
      return firstNumber - secondNumber
    case "*":
      return firstNumber * secondNumber
    case "/":
      if firstNumber == 0 || secondNumber == 0 {
        return 0
      }
      return firstNumber / secondNumber
    case "%":
      if firstNumber == 0 || secondNumber == 0 {
        return 0
      }
      return Double(Int(firstNumber) % Int(secondNumber))
    default:
      return 0
    }
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
