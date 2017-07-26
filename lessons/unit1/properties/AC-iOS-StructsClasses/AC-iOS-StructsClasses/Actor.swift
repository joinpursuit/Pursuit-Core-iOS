//
//  Actor.swift
//  AC-iOS-StructsClasses
//
//  Created by Erica Y Stevens on 7/11/17.
//  Copyright © 2017 Erica Y Stevens. All rights reserved.
//

import Foundation

class Actor: Person {
    var breakoutYear: Int
    var breakoutRole: String
    
    init(breakoutYear: Int, breakoutRole: String, name: String, birthYear: Int, deathYear: Int?) {
        self.breakoutYear = breakoutYear
        self.breakoutRole = breakoutRole
        super.init(name: name, birthYear: birthYear, deathYear: deathYear ?? nil)
    }
}
