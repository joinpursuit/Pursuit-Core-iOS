//
//  ViewController.swift
//  flashlight-app
//
//  Created by David Rifkin on 7/30/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var counter = Counter()
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBAction func pressChangeBKGD(_ sender: UIButton) {
        changeBackgroundColor()
        increaseCount()
        updateCountLabel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func changeBackgroundColor() {
        if view.backgroundColor == UIColor.white {
            view.backgroundColor = UIColor.black
        } else if view.backgroundColor == UIColor.black {
            view.backgroundColor = UIColor.white
        }
    }
    
    private func increaseCount() {
        counter.increaseCount()
    }

    private func updateCountLabel() {
        countLabel.text = "The Count is \(counter.count)"
    }
}

