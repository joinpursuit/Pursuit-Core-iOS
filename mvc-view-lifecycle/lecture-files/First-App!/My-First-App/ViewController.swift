//
//  ViewController.swift
//  My-First-App
//
//  Created by David Rifkin on 7/29/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //add new button. when you connect that button to your view controller, the function should change the background of the OuterMost view to a different color than the function we defined below
    
    //set up an outlet from your label that changes its text in response to the buttons being pressed.
    
    @IBOutlet weak var labelWithText: UILabel!
    
    @IBOutlet weak var buttonOneOutlet: UIButton!
    
    @IBAction func button2Pressed(_ sender: UIButton) {
        self.view.backgroundColor = UIColor.red
        self.labelWithText.text = "This is red"
    }
    
    
    @IBAction func colorChangeButtonPressed(_ sender: UIButton) {
        
        self.view.backgroundColor = sender.currentTitleColor
        self.labelWithText.text = "This is orange-y"
        self.buttonOneOutlet.setImage(UIImage(named: "PomegranateImage"), for: UIControl.State.disabled)
    }
    override func viewDidLoad() {
        
       self.labelWithText.text = "We just loaded the view"
        self.view.backgroundColor = UIColor.red
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

