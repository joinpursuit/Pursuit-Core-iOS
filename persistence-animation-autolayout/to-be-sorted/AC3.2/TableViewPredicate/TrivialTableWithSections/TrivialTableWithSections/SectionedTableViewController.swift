//
//  SectionedTableViewController.swift
//  TrivialTableWithSections
//
//  Created by Jason Gresh on 11/23/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class SectionedTableViewController: UITableViewController {
    var dataArray = [Int]()
    //    let denominator = 5
    let range = 5
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Numbers"

        for i in 0..<2000 {
            dataArray.append(i)
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.last!/range + 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionData = self.dataArray.filter {(n: Int) in
            return n/range == section
        }
        return sectionData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let sectionData = self.dataArray.filter {(n: Int) in
            return n/range == indexPath.section
        }
        
        cell.textLabel?.text = String(sectionData[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
        return "\(range*section) to \(range*section + (range-1))"
    }
}
