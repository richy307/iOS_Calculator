//
//  ViewController.swift
//  Calculator
//
//  Created by 王麒翔 on 2022/12/10.
//

import UIKit

class ViewController: UIViewController {

    // IBOutlet
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
    
    // IBAction
    // 清空數字
    @IBAction func clear(_ sender: UIButton) {
        label.text = "0"
        numberOnScreen = 0
        previousNumber = 0
        performingMath = false
        operation = "none"
        startNew = true
    }
    
    // 每個數字按鈕都 connect 到這個 IBAction
    @IBAction func numbers(_ sender: UIButton) {
        let inputNumber = sender.tag - 1 // 取得 按鈕的 tag屬性
        
        if label.text != nil {
            if startNew == true {
                // 新的運算開始
                label.text = "\(inputNumber)"
                startNew = false
            } else {
                // 運算中
                // 運算符號
                if label.text == "0" || label.text == "+" || label.text == "-" || label.text == "*" || label.text == "/" {
                    label.text = "\(inputNumber)"
                } else {
                    label.text = label.text! + "\(inputNumber)" // 數字 string 串連
                }
            }
            numberOnScreen = Double(label.text!) ?? 0
        }
    }
    
    // 加號
    @IBAction func add(_ sender: UIButton) {
        rightNowAnswer()
        label.text = "+" // 顯示畫面
        operation = "add" // 記錄運算符號
        performingMath = true // 狀態運算中
        previousNumber = numberOnScreen // 暫存前一個數字
    }
    
    // 減號
    @IBAction func substract(_ sender: UIButton) {
        rightNowAnswer()
        label.text = "-"
        operation = "substract"
        performingMath = true
        previousNumber = numberOnScreen
    }
    
    // 乘號
    @IBAction func multiply(_ sender: UIButton) {
        rightNowAnswer()
        label.text = "*"
        operation = "multiply"
        performingMath = true
        previousNumber = numberOnScreen
    }
    
    // 除號
    @IBAction func divide(_ sender: UIButton) {
        rightNowAnswer()
        label.text = "/"
        operation = "divide"
        performingMath = true
        previousNumber = numberOnScreen
    }
    
    // 等號 算出結果
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
            performingMath = false // 狀態運算結束
            startNew = true
        }
    }
    
    // 設定 手機狀態列顏色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent // 白色 亮色
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
        
        // floor 去掉小數 變成整數 // Int // Double
        okText = floor(number) == number ? "\( Int(number) )": "\(number)"
        // 取前面9個字元
        okText = okText.count >= 9 ? String(okText.prefix(9)) : okText
        
        label.text = okText
    }
    
    // ViewController 屬性
    var numberOnScreen:Double = 0
    var previousNumber:Double = 0 // 暫存雲算數字
    var performingMath = false // 是否在運算中
    var operation = "none" // 運算符號
    var startNew = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

