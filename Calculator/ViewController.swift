//
//  ViewController.swift
//  Calculator
//
//  Created by Sergey on 22/08/2019.
//  Copyright © 2019 Sergey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    var stillTyping = false
    var dotIsPlaced: Bool = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operationSign: String = ""
    var currentInput: Double{
        get {
            return Double(resultLabel.text!)!
        }
        set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            if valueArray[1] == "0"{
                resultLabel.text = "\(valueArray[0])"
            } else {
                resultLabel.text = "\(newValue)"
            }
            resultLabel.text = "\(newValue)"
            stillTyping = false
        }
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        
        let number = sender.currentTitle!
        
        if stillTyping{
            if resultLabel.text!.count < 15{
                resultLabel.text = resultLabel.text! + number
            }
        } else {
            resultLabel.text = number
            stillTyping = true
        }
    }
    
    @IBAction func operatorPressed(_ sender: UIButton) {
        operationSign = sender.currentTitle!
        firstOperand = currentInput
        stillTyping = false
        dotIsPlaced = false
    }
    
    func operateWithTwoOperands(operation:(Double, Double) -> Double){
        currentInput = operation(firstOperand,secondOperand)
        stillTyping = false
    }
    
    @IBAction func equalButtonPressed(_ sender: UIButton) {
        if stillTyping{
            secondOperand = currentInput
        }
        
        dotIsPlaced = false
        
        switch operationSign {
        case "+":
            operateWithTwoOperands{$0 + $1}
        case "-":
            operateWithTwoOperands{$0 - $1}
        case "✕":
            operateWithTwoOperands{$0 * $1}
        case "÷":
            operateWithTwoOperands{$0 / $1}
        default: break
        }
    }
    
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        resultLabel.text = "0"
        stillTyping = false
        operationSign = ""
        dotIsPlaced = false
    }
    
    @IBAction func changeSignButtonPressed(_ sender: UIButton) {
        currentInput = -currentInput
    }
    
    
    @IBAction func percentButtonPressed(_ sender: UIButton) {
        if firstOperand == 0{
            currentInput /= 100
        }
        else {
            secondOperand = firstOperand * currentInput / 100
        }
        stillTyping = false
    }
    
    @IBAction func squareRootButtonPressed(_ sender: UIButton) {
        currentInput = sqrt(currentInput)
    }
    
    @IBAction func dotButtonPressed(_ sender: UIButton) {
        if stillTyping && !dotIsPlaced{
            resultLabel.text = resultLabel.text! + "."
            dotIsPlaced = true
        }
        else if !stillTyping && !dotIsPlaced {
            resultLabel.text = "0."
        }
    }
}

