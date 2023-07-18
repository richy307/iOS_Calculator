//
//  ViewController.swift
//  Calculator
//
//  Created by 王麒翔 on 2022/12/10.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
    
    @IBAction func clear(_ sender: UIButton) {
        label.text = "0"
        numberOnScreen = 0
        previousNumber = 0
        performingMath = false
        operation = "none"
        startNew = true
    }
    
    @IBAction func numbers(_ sender: UIButton) {
        let inputNumber = sender.tag - 1
        
        if label.text != nil {
            if startNew == true {
                label.text = "\(inputNumber)"
                startNew = false
            } else {
                if label.text == "0" || label.text == "+" || label.text == "-" || label.text == "*" || label.text == "/" {
                    label.text = "\(inputNumber)"
                } else {
                    label.text = label.text! + "\(inputNumber)"
                }
            }
            numberOnScreen = Double(label.text!) ?? 0
        }
    }
    
    @IBAction func add(_ sender: UIButton) {
        rightNowAnswer()
        label.text = "+"
        operation = "add"
        performingMath = true
        previousNumber = numberOnScreen
    }
    
    @IBAction func substract(_ sender: UIButton) {
        rightNowAnswer()
        label.text = "-"
        operation = "substract"
        performingMath = true
        previousNumber = numberOnScreen
    }
    
    @IBAction func multiply(_ sender: UIButton) {
        rightNowAnswer()
        label.text = "*"
        operation = "multiply"
        performingMath = true
        previousNumber = numberOnScreen
    }
    
    @IBAction func divide(_ sender: UIButton) {
        rightNowAnswer()
        label.text = "/"
        operation = "divide"
        performingMath = true
        previousNumber = numberOnScreen
    }
    
    @IBAction func giveMeAnswer(_ sender: UIButton) {
        if performingMath == true {
            switch operation {
                case "add":
//                    label.text = "\(previousNumber+numberOnScreen)"
                    numberOnScreen = previousNumber+numberOnScreen
                    makeOKNumberString(from: numberOnScreen)
                
                case "substract":
//                    label.text = "\(previousNumber-numberOnScreen)"
                    numberOnScreen = previousNumber-numberOnScreen
                    makeOKNumberString(from: numberOnScreen)
                    
                case "multiply":
//                    label.text = "\(previousNumber*numberOnScreen)"
                    numberOnScreen = previousNumber*numberOnScreen
                    makeOKNumberString(from: numberOnScreen)
                
                case "divide":
//                    label.text = "\(previousNumber/numberOnScreen)"
                    if numberOnScreen == 0{
                        let alert = UIAlertController(title: "Error", message: nil, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default))
                        present(alert, animated: true, completion: nil)
                    }else{
                        numberOnScreen = previousNumber / numberOnScreen
                        makeOKNumberString(from: numberOnScreen)
                    }
                
                default: // "none"
                    label.text = "0"
            }
            performingMath = false
            startNew = true
        }
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func rightNowAnswer(){
        if performingMath == true{
            if operation == "add"{
                numberOnScreen = previousNumber + numberOnScreen
            }else if operation == "substract"{
                numberOnScreen = previousNumber - numberOnScreen
            }else if operation == "multiply"{
                numberOnScreen = previousNumber * numberOnScreen
            }else if operation == "divide"{
                if numberOnScreen == 0{
                    let alert = UIAlertController(title: "Error", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    present(alert, animated: true, completion: { self.clear(self.btnCancel) })
                }else{
                    numberOnScreen = previousNumber / numberOnScreen
                }
            }else if operation == "none"{
                label.text = "0"
            }
                //startNew = true
        }
    }
    
    func makeOKNumberString(from number:Double) {
        var okText:String
        
        okText = floor(number) == number ? "\( Int(number) )": "\(number)"
        okText = okText.count >= 9 ? String(okText.prefix(9)) : okText
        
        label.text = okText
    }
    
    var numberOnScreen:Double = 0
    var previousNumber:Double = 0
    var performingMath = false
    var operation = "none"
    var startNew = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

