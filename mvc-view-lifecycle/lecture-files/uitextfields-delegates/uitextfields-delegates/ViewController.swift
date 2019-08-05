//
//  ViewController.swift
//  uitextfields-delegates
//
//  Created by David Rifkin on 8/5/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var label: UILabel!

    @IBAction func buttonPressed(_ sender: UIButton) {
    }
    
    @IBAction func iTypedSomething(_ sender: UITextField) {
        if topTextField.text?.lowercased() == "david stop" {
            fatalError()
        }
    }
    @IBAction func hitReturnInTextView(_ sender: UITextField) {
        topTextField.text?.append("i hit return")
        label.text = sender.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextField.delegate = self
        bottomTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.backgroundColor  = UIColor(red: CGFloat.random(in: 0.0...1.0), green: CGFloat.random(in: 0.0...1.0), blue: CGFloat(integerLiteral: 3), alpha: 1.0)
        return true
    }
    
//add an action from your uitextfield that updates some other UI type (you know the one) in this controller with the text that is in the UITextField
    //hint - you can look up how to use the return key to trigger that action

}

