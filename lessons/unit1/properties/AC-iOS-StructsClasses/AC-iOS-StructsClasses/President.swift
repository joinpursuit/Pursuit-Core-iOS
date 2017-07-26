//
//  President.swift
//  AC-iOS-StructsClasses
//
//  Created by Erica Y Stevens on 7/11/17.
//  Copyright © 2017 Erica Y Stevens. All rights reserved.
//

import Foundation

class President: Person {
    var yearEnteredOffice: Int
    var yearLeftOffice: Int
    
    init(name: String, yearEntered: Int, yearLeft: Int, birthYear: Int, deathYear: Int?) {
        self.yearLeftOffice = yearLeft
        self.yearEnteredOffice = yearEntered
        super.init(name: name, birthYear: birthYear, deathYear: deathYear)
    }
    
    func inOffice(_ year: Int) -> Bool {
        if year >= yearEnteredOffice && year <= yearLeftOffice {
            return true
        } else {
            return false
        }
    }
    
    convenience init?(with dict: [String:Any?]) {
        if let name = dict["name"] as? String,
            let yearEntered = dict["year_entered"] as? Int,
            let yearLeft = dict["year_left"] as? Int,
            let birthYear = dict["birth_year"] as? Int {
            
            let deathYear = dict["death_year"] as? Int ?? nil
            
            self.init(name: name, yearEntered: yearEntered, yearLeft: yearLeft, birthYear: birthYear, deathYear: deathYear)
        }
        else {
            return nil
        }
    }
}

