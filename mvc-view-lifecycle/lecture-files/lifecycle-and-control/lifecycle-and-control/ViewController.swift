//
//  ViewController.swift
//  lifecycle-and-control
//
//  Created by David Rifkin on 8/2/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentStepperValue = 0.0 {
        didSet {
            theValueOfMyStepper.text = "The current value is \(currentStepperValue)"
        }
    }
    
    var currentSliderValue: Float = 0.0 {
        didSet {
            theValueOfMyStepper.text = "The current value is \(currentSliderValue)"
        }
    }
    
    @IBOutlet weak var theValueOfMyStepper: UILabel!
    @IBOutlet weak var myStepper: UIStepper!
    
    
    @IBAction func wentSlippinNSliding(_ sender: UISlider) {
        currentSliderValue = sender.value
    }
    
    @IBAction func stepperValueChange(_ sender: UIStepper) {
        self.currentStepperValue = sender.value
    }
    @IBAction func theSwitch(_ sender: UISwitch) {
    
        let letsFlipTheBool = !sender.isOn
        sender.setOn(letsFlipTheBool, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        currentStepperValue = myStepper.value
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear!!!")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear!!!")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
    }
    //available in class inferface
//    func doSomething() {
//
//    }
    //is not available in class interface
//    private func doThisOnlyInHere() {
//
//    }

}

