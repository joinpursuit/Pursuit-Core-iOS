//
//  Person.swift
//  AC-iOS-StructsClasses
//
//  Created by Erica Y Stevens on 7/11/17.
//  Copyright © 2017 Erica Y Stevens. All rights reserved.
//

import Foundation

class Person {
    var name: String
    var birthYear: Int
    var deathYear: Int?
    
    init(name: String, birthYear: Int, deathYear: Int?) {
        self.name = name
        self.birthYear = birthYear
        self.deathYear = deathYear
    }
}
