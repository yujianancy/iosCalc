//
//  ViewController.swift
//  iosCalc
//
//  Created by iGuest on 10/21/15.
//  Copyright (c) 2015 Jia Yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var one: UIButton!
    @IBOutlet weak var two: UIButton!
    @IBOutlet weak var three: UIButton!
    @IBOutlet weak var four: UIButton!
    @IBOutlet weak var five: UIButton!
    @IBOutlet weak var six: UIButton!
    @IBOutlet weak var seven: UIButton!
    @IBOutlet weak var eight: UIButton!
    @IBOutlet weak var nine: UIButton!
    @IBOutlet weak var zero: UIButton!
    @IBOutlet weak var dot: UIButton!
    @IBOutlet weak var equal: UIButton!
    @IBOutlet weak var sub: UIButton!
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var mul: UIButton!
    @IBOutlet weak var div: UIButton!
    @IBOutlet weak var count: UIButton!
    @IBOutlet weak var avg: UIButton!
    @IBOutlet weak var fact: UIButton!
    @IBOutlet weak var screen: UITextField!
    
    @IBAction func Clear(sender: AnyObject) {
        
        nums = [""]
        
        exp = ""
        
        screen.text = ""
    
    }
    
    var nums:[String] = [""]
    
    var exp:String = "+"
    
    var RPN:Bool = false
    
    func convertDouble(incoming:String) -> Double {
        
        return NSNumberFormatter().numberFromString(incoming)!.doubleValue
        
    }
    
    func calc(nums:[String], exp:String) ->String{
        
        var result:Double = 0.0
        
        var res:String = ""
            
            switch exp {
                
            case "+":
                
                for index in 0...nums.count-1{
                    
                    result = result + convertDouble(nums[index])
                    
                }
                
            case "-":
                
                result = convertDouble(nums[0])
                
                for index in 1...nums.count-1{
                    
                    result = result - convertDouble(nums[index])
                }
                
            case "*":
                
                result = 1.0
                
                for index in 0...nums.count-1{
                    
                    result = result * convertDouble(nums[index])
                }
                
            case "/":
                
                result = convertDouble(nums[0])
                
                for index in 1...nums.count-1{
                    
                    result = result / convertDouble(nums[index])
                }
                
            case "mod":
                
                result = convertDouble(nums[0])
                
                for index in 1...nums.count-1{
                    
                    result = result % convertDouble(nums[index])
                }
                
            case "count":
                
                result = Double(nums.count)
                
            case "avg":
                
                for index in 0...nums.count-1{
                    
                    result = result + convertDouble(nums[index])
                }
                
                result = result / Double(nums.count)
                
            default:
                
                result = 0.0
            }
        
        res = String(stringInterpolationSegment: result)
        
        return res
    }
    @IBAction func pushRPN(sender: AnyObject) {
        
        RPN = !RPN
        
        if RPN{
        
        screen.text = "Entered RPN mode."
            
        } else{
            
            screen.text = "Entered traditional mode."
        }
        
        nums = [""]
        
    }
    @IBAction func pushEnter(sender: AnyObject) {
        
        if RPN{
            
            nums.append("")
            
        }
    
    }
    @IBAction func pushFact(sender: AnyObject) {
        
        exp = "fact"
        
        var number = Int(convertDouble(nums[nums.count-1]))
        
        if number < 0{
            
            screen.text = "Please enter a non-negative number."
            
        } else if number == 0{
            
            screen.text = "0"
            
        } else{
        
        screen.text = String(fact(number))
        }
    }
    
    @IBAction func pushAvg(sender: AnyObject) {
        
        exp = "avg"
        
        if RPN{
            
            screen.text = calc(nums, exp: exp)
            
        } else{
        
        screen.text = exp
            
        }
    }
    @IBAction func pushCount(sender: AnyObject) {
        
        exp = "count"
        
        if RPN{
            
            screen.text = calc(nums, exp: exp)
            
        } else{
            
            screen.text = exp
            
        }
    }
    @IBAction func pushEqual(sender: AnyObject) {
        
        screen.text = calc(nums, exp: exp)
        
        nums = [""]
        
    }
    
    func fact(number:Int) -> Int{
        
        var result:Int = 1
        
        if number == 0{
            
            result = 0
            
        } else{
        
        for index in 1...number{
            
            result = result * index
            
        }
        }
        
        return result
    }
    
    @IBAction func pushPlus(sender: AnyObject) {
        
        exp = "+"
        
        if RPN{
            
            screen.text = calc(nums, exp: exp)
            
        } else{
            
            screen.text = exp
            
        }
        
    }
    @IBAction func pushSub(sender: AnyObject) {
        
        if nums[nums.count-1] == ""{
            
            nums[nums.count-1] = "-"
            
            screen.text = nums[nums.count-1]
            
        } else {
            
            exp = "-"
            
            if RPN{
                
                screen.text = calc(nums, exp: exp)
                
            } else{
                
                screen.text = exp
                
            }
        }
    }
    @IBAction func pushDiv(sender: AnyObject) {
        
        exp = "/"
        
        if RPN{
            
            screen.text = calc(nums, exp: exp)
            
        } else{
            
            screen.text = exp
            
        }
        
    }
    @IBAction func pushMul(sender: AnyObject) {
        
        exp = "*"
        
        if RPN{
            
            screen.text = calc(nums, exp: exp)
            
        } else{
            
            screen.text = exp
            
        }
        
    }
    @IBAction func pushMod(sender: AnyObject) {
        
        exp = "mod"
        
        if RPN{
            
            screen.text = calc(nums, exp: exp)
            
        } else{
            
            screen.text = exp
            
        }
    }
    @IBAction func pushZero(sender: AnyObject) {
        
        if screen.text != exp {
        
        nums[nums.count-1] = nums[nums.count-1] + "0"
            
        } else {
            
            nums.append("0")
        }
        
        screen.text = nums[nums.count-1]
    }
    @IBAction func pushDot(sender: AnyObject) {
        
        if screen.text != exp {
            
            nums[nums.count-1] = nums[nums.count-1] + "."
            
        } else {
            
            nums.append(".")
        }
        
        screen.text = nums[nums.count-1]
        
    }
    @IBAction func pushOne(sender: AnyObject) {
        
        if screen.text != exp {
            
            nums[nums.count-1] = nums[nums.count-1] + "1"
            
        } else {
            
            nums.append("1")
        }
        
        screen.text = nums[nums.count-1]
        
    }
    @IBAction func pushTwo(sender: AnyObject) {
        
        if screen.text != exp {
            
            nums[nums.count-1] = nums[nums.count-1] + "2"
            
        } else {
            
            nums.append("2")
        }
        
        screen.text = nums[nums.count-1]
    }
    @IBAction func pushThree(sender: AnyObject) {
        
        if screen.text != exp {
            
            nums[nums.count-1] = nums[nums.count-1] + "3"
            
        } else {
            
            nums.append("3")
        }
        
        screen.text = nums[nums.count-1]
        
    }
    @IBAction func pushFour(sender: AnyObject) {
        
        if screen.text != exp {
            
            nums[nums.count-1] = nums[nums.count-1] + "4"
            
        } else {
            
            nums.append("4")
        }
        
        screen.text = nums[nums.count-1]
        
    }
    @IBAction func pushFive(sender: AnyObject) {
        
        if screen.text != exp {
            
            nums[nums.count-1] = nums[nums.count-1] + "5"
            
        } else {
            
            nums.append("5")
        }
        
        screen.text = nums[nums.count-1]
        
    }
    @IBAction func pushSix(sender: AnyObject) {
        
        if screen.text != exp {
            
            nums[nums.count-1] = nums[nums.count-1] + "6"
            
        } else {
            
            nums.append("6")
        }
        
        screen.text = nums[nums.count-1]
        
    }
    @IBAction func pushSeven(sender: AnyObject) {
        
        if screen.text != exp {
            
            nums[nums.count-1] = nums[nums.count-1] + "7"
            
        } else {
            
            nums.append("7")
        }
        
        screen.text = nums[nums.count-1]
        
    }
    @IBAction func pushEight(sender: AnyObject) {
        
        if screen.text != exp {
            
            nums[nums.count-1] = nums[nums.count-1] + "8"
            
        } else {
            
            nums.append("8")
        }
        
        screen.text = nums[nums.count-1]
    }
    @IBAction func pushNine(sender: AnyObject) {
        
        if screen.text != exp {
            
            nums[nums.count-1] = nums[nums.count-1] + "9"
            
        } else {
            
            nums.append("9")
        }
        
        screen.text = nums[nums.count-1]
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

