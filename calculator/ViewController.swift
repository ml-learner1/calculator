//
//  ViewController.swift
//  calculator
//
//  Created by Garg, Smith on 2/21/15.
//  Copyright (c) 2015 Garg, Smith. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{


    @IBOutlet weak var CalcScreen: UILabel!
    
    @IBOutlet weak var historyCalc: UILabel!
    
    var sombuttonpressed = false
    var decimalUsed = false


    @IBAction func Calcpress(sender: UIButton){
        let digit = sender.currentTitle!
        
        if sombuttonpressed
        {
            if digit == "." && decimalUsed == true {
                return
            } else if digit == "." && decimalUsed == false {
                decimalUsed = true
            }
            
            CalcScreen.text = CalcScreen.text! + digit
            
        }
        else{
            CalcScreen.text = digit
            sombuttonpressed = true
            if digit == "." {
                decimalUsed = true
                CalcScreen.text = "0."
            } else {
                CalcScreen.text = digit
            }
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        
        if sombuttonpressed{
            enter()
        }
        loadHistory(operation)
        
        switch operation {
        case "×": performoperation { $0 * $1 }
        case "+": performoperation { $0 + $1 }
        case "−": performoperation { $1 - $0 }
        case "÷": performoperation { $1 / $0 }
        case "√": performoperation {sqrt($0) }
        case "sin": performoperation {sin($0) }
        case "cos": performoperation {sin($0) }
        case "∏": displayValue = M_PI
        default:break
        }
    }
    
    func performoperation(operation: (Double, Double) -> (Double)){
        if operandstack.count >= 2 {
            displayValue = operation(operandstack.removeLast(),operandstack.removeLast())
        }
    }
    
    func performoperation(operation: (Double) -> (Double)){
        if operandstack.count >= 1 {
            displayValue = operation(operandstack.removeLast())
        }
    }
    
    
    var operandstack = Array<Double>()
    
    @IBAction func enter() {
        sombuttonpressed = false
        loadHistory("⏎")
        operandstack.append(displayValue)
        println("operandstack = \(operandstack)")
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(CalcScreen.text!)!.doubleValue
        }
        set {
            CalcScreen.text = "\(newValue)"
            sombuttonpressed = false
            
        }
    }
    
    func loadHistory (inputOperand: String) {
        
        if inputOperand == "⏎"{
            
            println(historyCalc.text!)

            if historyCalc.text!.isEmpty{
                historyCalc.text! = CalcScreen.text!
                println("this 1")
            } else {
                historyCalc.text! = historyCalc.text! + inputOperand
                + CalcScreen.text!
                println("this 2")
            }
        } else {
            historyCalc.text = historyCalc.text!.stringByReplacingOccurrencesOfString("⏎", withString: inputOperand, options: NSStringCompareOptions.LiteralSearch, range: nil)
            
        }
        
        
    }
    
    @IBAction func clearScreen(sender: UIButton) {
        historyCalc.text! = " "
        CalcScreen.text! = "0"
    }
    
}

