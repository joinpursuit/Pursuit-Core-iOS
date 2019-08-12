//
//  Counter.swift
//  flashlight-app
//
//  Created by David Rifkin on 7/30/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

//model file - where I define a thing that we will increment and get the count of.

struct Counter {
    var count = 0
    //mutating - this function is going to change some value/property in the struct
    mutating func increaseCount() {
        self.count += 1
    }
}
