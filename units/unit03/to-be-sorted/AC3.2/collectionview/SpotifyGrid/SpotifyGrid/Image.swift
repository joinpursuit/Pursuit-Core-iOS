//
//  Image.swift
//  SpotifyGrid
//
//  Created by Jason Gresh on 10/30/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

struct Image {
    let height: Int
    let width: Int
    let url: URL
    
    init?(from dictionary: [String:AnyObject]) {
        if let height = dictionary["height"] as? Int,
            let width = dictionary["width"] as? Int,
            let url = dictionary["url"] as? String,
            let validURL = URL(string: url) {
            self.height = height
            self.width = width
            self.url = validURL
        }
        else {
            return nil
        }
    }
}
