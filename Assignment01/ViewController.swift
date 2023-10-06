//
//  ViewController.swift
//  Assignment01
//
//  Created by Simon Fong on 2023-09-29.
//

import UIKit

class ViewController: UIViewController {
    
    /// a reference for the model
    var globalMathModel = (UIApplication.shared.delegate as! AppDelegate).mathModel
    
    /// A label for calculated result.
    @IBOutlet weak var display_lbl: UILabel!
    
    /// A label for possible error message.
    @IBOutlet weak var errorMsg_lbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    /// Call model's reset function and display information.
    @IBAction func reset(_ sender: UIButton) {
        display_lbl.text = globalMathModel.reset()
        errorMsg_lbl.text = ""
    }
    
    
    /// Call model's push function to stored input into expression and display the returned string in display label..
    @IBAction func inputExpression(_ sender: UIButton) {
        let input:String? = sender.titleLabel!.text
        display_lbl.text =  globalMathModel.push(char:input)
    }
    
    /// Call model's calculate function to calculate.
    @IBAction func calculate(_ sender: UIButton) {
        let result = globalMathModel.calculate()
        
        /// Display result string
        display_lbl.text = "\(result.0)"
        
        /// If the 2nd return value in the result is not nil, then display the error message.
        if let errorMsg = result.1 {
            errorMsg_lbl.text = errorMsg
        }
    }
}

