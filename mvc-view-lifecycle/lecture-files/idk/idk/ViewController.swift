//
//  ViewController.swift
//  idk
//
//  Created by David Rifkin on 8/5/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var `switch`: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.purple
    }
    
    @IBAction func slideTheSlider(_ sender: UISlider) {
        self.view.backgroundColor = UIColor(red: 1, green: 0, blue: 1, alpha: CGFloat(sender.value))
    }
    
    @IBAction func toggleSwitch(_ sender: UISwitch) {
        if sender.isOn {
            slider.isHidden = false
        } else {
            slider.isHidden = true
        }
    }
    

}

