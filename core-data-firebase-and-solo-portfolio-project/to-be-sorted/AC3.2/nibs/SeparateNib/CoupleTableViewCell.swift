//
//  CoupleTableViewCell.swift
//  SeparateNib
//
//  Created by Jason Gresh on 12/15/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class CoupleTableViewCell: UITableViewCell {

    @IBOutlet weak var personOneLabel: UILabel!
    @IBOutlet weak var personTwoLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
