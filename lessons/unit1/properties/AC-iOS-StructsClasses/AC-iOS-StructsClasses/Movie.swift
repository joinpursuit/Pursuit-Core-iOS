//
//  Movie.swift
//  AC-iOS-StructsClasses
//
//  Created by Erica Y Stevens on 7/10/17.
//  Copyright © 2017 Erica Y Stevens. All rights reserved.
//

import Foundation

struct Movie {
    var name: String
    var year: Int
    var genre: Genre
    var cast: [Actor]
    var description: String
    
    init(name: String, year: Int, genre: Genre, cast: [Actor], description: String) {
        self.name = name
        self.year = year
        self.genre = genre
        self.cast = cast
        self.description = description
    }
    
    init?(from dict: [String:Any]) {
        if let name = dict["name"] as? String,
            let genreString = dict["genre"] as? String,
            let year = dict["year"] as? Int,
            let description = dict["description"] as? String,
            let castStringArray = dict["cast"] as? [String] {
            
            let actors = Movie.getCastMembers(in: castStringArray)
            
            self.name = name
            self.genre = Movie.genreFrom(string: genreString)
            self.year = year
            self.description = description
            self.cast = actors
        } else {
            return nil
        }
    }
    
    static func genreFrom(string: String) -> Genre {
        switch string {
        case string where string == Genre.action.rawValue:
            return Genre.action
        case string where string == Genre.animation.rawValue:
            return Genre.animation
        default:
            return Genre.drama
        }
    }
    
    static func getCastMembers(in castArray: [String]) -> [Actor] {
        var actors: [Actor] = []
        for memberName in castArray {
            
            for actorInfoDict in actorData {
                if let actorDict = actorInfoDict[memberName] {
                    if let birthYear = actorDict["birth_year"] as? Int,
                        let breakoutYear = actorDict["breakout_year"] as? Int,
                        let breakoutRole = actorDict["breakout_role"] as? String {
                        
                        let deathYear = actorDict["death_year"] as? Int ?? nil
                        
                        let actor = Actor(breakoutYear: breakoutYear, breakoutRole: breakoutRole, name: memberName, birthYear: birthYear, deathYear: deathYear)
                        actors.append(actor)
                    }
                    break
                }
            }
        }
        return actors
    }
    
} // End of Movie Struct
// MARK: Actor Data
private var actorData: [[String:[String:Any?]]] = [
    [
        "Sandra Bullock" : [
            "birth_year" : 1964,
            "breakout_year" : 1987,
            "breakout_role" : "Hangmen",
            "death_year" : nil
        ]
    ],
    
    [
        "Jon Hamm": [
            "birth_year" : 1971 as AnyObject,
            "breakout_year" : 2000 as AnyObject,
            "breakout_role" : "Space Cowboys",
            "death_year" : nil
        ]
    ],
    
    [
        "Michael Keaton" : [
            "birth_year" : 1951,
            "breakout_year" : 1982,
            "breakout_role" : "Night Shift",
            "death_year" : nil
        ]
    ],
    
    [
        "Mike Myers" : [
            "birth_year" : 1963,
            "breakout_year" : 1987,
            "breakout_role" : "Wayne's World",
            "death_year" : nil
        ]
    ],
    
    [
        "Eddie Murphy" : [
            "birth_year" : 1961,
            "breakout_year" : 1980,
            "breakout_role" : "Saturday Night Live",
            "death_year" : nil
        ]
    ],
    
    [
        "Cameron Diaz" : [
            "birth_year" : 1972,
            "breakout_year" : 1994,
            "breakout_role" : "The Mask",
            "death_year" : nil
        ]
    ],
    
    [
        "Ginnifer Goodwin" : [
            "birth_year" : 1978,
            "breakout_year" : 2006,
            "breakout_role" : "Big Love",
            "death_year" : nil
        ]
    ],
    
    [
        "Jason Bateman" : [
            "birth_year" : 1969,
            "breakout_year" : 1980,
            "breakout_role" : "Little House on the Prairie",
            "death_year" : nil
        ]
    ],
    
    [
        "Idris Elba" : [
            "birth_year" : 1972,
            "breakout_year" : 2002,
            "breakout_role" : "The Wire",
            "death_year" : nil
        ]
    ],
    
    [
        "Sam Worthington" : [
            "birth_year" : 1976,
            "breakout_year" : 2004,
            "breakout_role" : "Somersault",
            "death_year" : nil
        ]
    ],
    
    [
        "Zoe Saldana" : [
            "birth_year" : 1978,
            "breakout_year" : 1999,
            "breakout_role" : "Law & Order",
            "death_year" : nil
        ]
    ],
    
    [
        "Sigourney Weaver" : [
            "birth_year" : 1949,
            "breakout_year" : 1977,
            "breakout_role" : "Annie Hall",
            "death_year" : nil
        ]
    ],
    
    [
        "Christian Bale" : [
            "birth_year" : 1974,
            "breakout_year" : 1987,
            "breakout_role" : "Empire of the Sun",
            "death_year" : nil
        ]
    ],
    
    [
        "Heath Ledger" : [
            "birth_year" : 1979,
            "breakout_year" : 1999,
            "breakout_role" : "10 Things I Hate About You",
            "death_year" : 2008
        ]
    ],
    
    [
        "Aaron Eckhart" : [
            "birth_year" : 1968,
            "breakout_year" : 2000,
            "breakout_role" : "Eric Brockovich",
            "death_year" : nil
        ]
    ],
    
    [
        "Shia LaBeouf" : [
            "birth_year" : 1986,
            "breakout_year" : 1998,
            "breakout_role" : "The Christmas Path",
            "death_year" : nil
        ]
    ],
    
    [
        "Megan Fox" : [
            "birth_year" : 1986,
            "breakout_year" : 2004,
            "breakout_role" : "Confessions of a Teenaeg Drama Queen",
            "death_year" : nil
        ]
    ],
    
    [
        "Josh Duhamel" : [
            "birth_year" : 1972,
            "breakout_year" : 1999,
            "breakout_role" : "All My Children",
            "death_year" : nil
        ]
    ],
    
    [
        "Leonardo DiCaprio" : [
            "birth_year" : 1974,
            "breakout_year" : 1991,
            "breakout_role" : "Critters 3",
            "death_year" : nil
        ]
    ],
    
    [
        "Kate Winslet" : [
            "birth_year" : 1975,
            "breakout_year" : 1994,
            "breakout_role" : "Heavenly Creatures",
            "death_year" : nil
        ]
    ],
    
    [
        "Billy Zane" : [
            "birth_year" : 1966,
            "breakout_year" : 1985,
            "breakout_role" : "Back to the Future",
            "death_year" : nil
        ]
    ],
    
    [
        "Jennifer Lawrence" : [
            "birth_year" : 1990,
            "breakout_year" : 2007,
            "breakout_role" : "The Bill Engvall Show",
            "death_year" : nil
        ]
    ],
    
    [
        "Josh Hutcherson" : [
            "birth_year" : 1992,
            "breakout_year" : 2002,
            "breakout_role" : "Houseblend",
            "death_year" : nil
        ]
    ],
    
    [
        "Liam Hemsworth" : [
            "birth_year" : 1990,
            "breakout_year" : 2010,
            "breakout_role" : "The Last Song",
            "death_year" : nil
        ]
    ],
    
    [
        "Bradley Cooper" : [
            "birth_year" : 1975,
            "breakout_year" : 2001,
            "breakout_role" : "Wet Hot American Summer",
            "death_year" : nil
        ]
    ],
    
    [
        "Sienna Miller" : [
            "birth_year" : 1981,
            "breakout_year" : 2004,
            "breakout_role" : "Layer Cake",
            "death_year" : nil
        ]
    ],
    
    [
        "Kyle Gallner" : [
            "birth_year" : 1986,
            "breakout_year" : 2001,
            "breakout_role" : "Wet Hot American Summer",
            "death_year" : nil
        ]
    ]
]
