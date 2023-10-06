//
//  MathModel.swift
//  Assignment01
//
//  Created by Simon Fong on 2023-09-29.
//

import Foundation


/// This is a model class to handle calculation logic.
class CalculatorBrain{
    
    /// A String array vairable to store input
    var expressionArr : [String]
    
    /// A String array constant to store operators.
    let operatorArr : [String] = ["+","-","*","/"]
    
    /// Constructor to initialize the expressionArr to be an empty array.
    init(){
        self.expressionArr = [String]()
    }
    
    /// Reset the expressionArr to be an empty array.
    /// - Returns: String An empty String
    func reset() -> String{
        expressionArr = [String]()
        return ""
    }
    
    /// Push the input character into the stored expression.
    /// - Parameter char:String?  The input character.
    /// - Returns: String All stored input.
    func push(char:String?) -> String {
        expressionArr.append(char!)
        return expressionArr.joined()
    }
    
    /// Calculate the result based on the stored expression.
    /// - Returns: String The output message.
    ///                 The calculated result will be returned If stored expression has no error. Otherwise, return an empty String.
    ///            String? The possible error message.
    ///                 Nil if the stored expression has no erro. Otherwise, return the error message.
    func calculate() -> (String, String?) {
        
        /// Declear a String variable for  output message.
        var result:String = ""
        
        /// Determine whether the stored expression is empty.
        guard expressionArr.count != 0 else{
            result = ""
            return (result, "Error: Expression cannot be empty!")
        }
        
        /// Determine whether the first operand is missing.
        guard !operatorArr.contains(expressionArr[0]) else{
            /// update the output message.
            result = "\(expressionArr.joined()) = Error!"
            /// set the expression to be empty string array.
            expressionArr = [String]()
            return (result,"Error: Missing the first operand!")
        }
        
        /// Determine whether the second operand is missing.
        guard !operatorArr.contains(expressionArr.last!) else{
            result = "\(expressionArr.joined()) = Error!"
            expressionArr = [String]()
            return (result,"Error: Missing the second operand!")
        }
        
        /// Create a dictionary help in validating the expression.
        var opDict = [String:Int]()
        
        /// Loop each character in the expression
        for ch in expressionArr{
            /// Determine whether the current character is an operator
            /// if true, then store the operator and its count into the dictionary.
            if operatorArr.contains(ch){
                if opDict.keys.contains(ch){
                    opDict[ch]! += 1
                }else{
                    opDict[ch] = 1
                }
            }
        }
        
        
        /// Determine whether the expression contains operator by counting keys in the dictionary.
        if opDict.keys.count == 0 {
            result = "\(expressionArr.joined()) = Error!"
            expressionArr = [String]()
            return (result,"Error: Missing operator!")
        }
        
        /// Determing whether the expression has only one operator.
        guard opDict.keys.count == 1 && opDict.first?.value == 1 else {
            result = "\(expressionArr.joined()) = Error!"
            expressionArr = [String]()
            return (result,"Error: Multiple operators!")
        }
        
        /// Extract operator
        let op = opDict.first!.key
        
        /// Extract operands by spliting the expression into 2 arrays and then converting  into integer.
        let spiltArr = expressionArr.split(separator: op)
        let operand01 = Int(spiltArr[0].joined())!
        let operand02 = Int(spiltArr[1].joined())!
        
        /// Calculate based on the operator.
        switch op {
        case "+":
            result = "\(expressionArr.joined()) = \(operand01 + operand02)"
            
        case "-":
            result = "\(expressionArr.joined()) = \(operand01 - operand02)"
            
        case "*":
            result = "\(expressionArr.joined()) = \(operand01 * operand02)"
            
        case "/":
            /// Determine whether the divisor is zero.
            guard operand02 != 0 else {
                result = "\(expressionArr.joined()) = Error!"
                expressionArr = [String]()
                return (result,"Error: Divisor cannot be zero!")
            }
            result = "\(expressionArr.joined()) = \(operand01 / operand02)"
            /// A warning message if operator cannot match.
        default:
            print("Warning: Switch case default!")
        }
        
        /// reset expression after calculation
        expressionArr = [String]()
        
        /// return the calculated result and set error massage as nil.
        return (result,nil)
    }
}
