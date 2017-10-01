//
//  ViewController.swift
//  calculator
//
//  Created by Eugene Rozenberg on 28/08/2017.
//  Copyright © 2017 Eugene Rozenberg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var operationsDisplay: UILabel!
    
    var userIsInTheMiddleOfTyping = false
    
    private var calculatorBrain = CalculatorBrain()
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            let currentTextInDisplay = display.text!
            
            if digit != "." || !currentTextInDisplay.contains(".") {
                display.text = currentTextInDisplay + digit
            }
        } else {
            if digit == "." {
                display.text = "0."
            } else {
                display.text = digit
            }
            
            userIsInTheMiddleOfTyping = true
        }
        
    }
    
    var displayValue: Double? {
        get {
            if let text = display.text, let value = NumberFormatter().number(from: text)?.doubleValue {
                return value
            } else {
                return nil
            }
            
        }
        set {
            if let value = newValue {
                display.text = String(value)
                operationsDisplay.text = calculatorBrain.description
            } else {
                display.text = "0"
                operationsDisplay.text = nil
                userIsInTheMiddleOfTyping = false
            }
        }
    }
    
    @IBAction func performAction(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            calculatorBrain.setOperand(displayValue!)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            calculatorBrain.performOperation(mathematicalSymbol)
        }
        
        if let result = calculatorBrain.result {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
