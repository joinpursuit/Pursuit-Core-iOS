//
//  ViewController.swift
//  UDTest
//
//  Created by Cameron Flowers on 12/11/17.
//  Copyright © 2017 floreo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var testTextField: UITextField!

    @IBOutlet weak var returnLabel: UILabel!

    @IBOutlet weak var priceLabel: UILabel!

    @IBOutlet weak var priceSlider: UISlider!

    @IBOutlet weak var colorSwitch: UISwitch!


    let defaults = UserDefaults.standard
    let labelKey = "persistedLabel"
    let sliderValueKey = "sliderValueKey"
    let switchValueKey = "switchValueKey"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.



        let alert = UIAlertController(title: "My Alert", message: "This is an alert.", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
//            NSLog("The \"OK\" alert occured.")
//        }))
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)





        testTextField.delegate = self
        if let labelText = defaults.value(forKey: labelKey) as? String {
            returnLabel.text = labelText
        }

        if let switchStatus = defaults.value(forKey: switchValueKey) as? Bool{
            self.view.backgroundColor = switchStatus ? UIColor.orange : UIColor.white
            colorSwitch.isOn = switchStatus
        }

        if let savedPrice = defaults.value(forKey:sliderValueKey) as? Float {
            priceLabel.text = "$\(savedPrice)"
            priceSlider.value = savedPrice
        }

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        returnLabel.text = textField.text
        defaults.set(textField.text, forKey: labelKey)
        return true
    }


    @IBAction func sliderValueChanged(_ sender: UISlider) {
        priceLabel.text = "$\(sender.value)"
        defaults.set(sender.value, forKey: sliderValueKey)
    }

    @IBAction func switchValueChanged(_ sender: UISwitch) {

         self.view.backgroundColor = sender.isOn ? UIColor.orange : UIColor.white

        defaults.set(sender.isOn, forKey: switchValueKey)

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

