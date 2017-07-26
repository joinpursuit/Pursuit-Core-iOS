//
//  main.swift
//  AC-iOS-StructsClasses
//
//  Created by Erica Y Stevens on 7/10/17.
//  Copyright © 2017 Erica Y Stevens. All rights reserved.
//

import Foundation

// MARK: - Movie Data

var movies: [[String:Any]] = [
    [
        "name": "Minions",
        "year": 2015,
        "genre": "animation",
        "cast": ["Sandra Bullock", "Jon Hamm", "Michael Keaton"],
        "description": "Evolving from single-celled yellow organisms at the dawn of time, Minions live to serve, but find themselves working for a continual series of unsuccessful masters, from T. Rex to Napoleon. Without a master to grovel for, the Minions fall into a deep depression. But one minion, Kevin, has a plan."
    ],
    [
        "name": "Shrek",
        "year": 2001,
        "genre": "animation",
        "cast": ["Mike Myers", "Eddie Murphy", "Cameron Diaz"],
        "description": "Once upon a time, in a far away swamp, there lived an ogre named Shrek whose precious solitude is suddenly shattered by an invasion of annoying fairy tale characters. They were all banished from their kingdom by the evil Lord Farquaad. Determined to save their home -- not to mention his -- Shrek cuts a deal with Farquaad and sets out to rescue Princess Fiona to be Farquaad\"s bride. Rescuing the Princess may be small compared to her deep, dark secret."
    ],
    [
        "name": "Zootopia",
        "year": 2016,
        "genre": "animation",
        "cast": ["Ginnifer Goodwin", "Jason Bateman", "Idris Elba"],
        "description": "From the largest elephant to the smallest shrew, the city of Zootopia is a mammal metropolis where various animals live and thrive. When Judy Hopps becomes the first rabbit to join the police force, she quickly learns how tough it is to enforce the law."
    ],
    [
        "name": "Avatar",
        "year": 2009,
        "genre": "action",
        "cast": ["Sam Worthington", "Zoe Saldana", "Sigourney Weaver"],
        "description": "On the lush alien world of Pandora live the Na\"vi, beings who appear primitive but are highly evolved. Because the planet\"s environment is poisonous, human/Na\"vi hybrids, called Avatars, must link to human minds to allow for free movement on Pandora. Jake Sully, a paralyzed former Marine, becomes mobile again through one such Avatar and falls in love with a Na\"vi woman. As a bond with her grows, he is drawn into a battle for the survival of her world."
    ],
    [
        "name": "The Dark Knight",
        "year": 2008,
        "genre": "action",
        "cast": ["Christian Bale", "Heath Ledger", "Aaron Eckhart"],
        "description": "With the help of allies Lt. Jim Gordon and DA Harvey Dent, Batman has been able to keep a tight lid on crime in Gotham City. But when a vile young criminal calling himself the Joker suddenly throws the town into chaos, the caped Crusader begins to tread a fine line between heroism and vigilantism."
    ],
    [
        "name": "Transformers",
        "year": 2007,
        "genre": "action",
        "cast": ["Shia LaBeouf", "Megan Fox", "Josh Duhamel"],
        "description": "The fate of humanity is at stake when two races of robots, the good Autobots and the villainous Decepticons, bring their war to Earth. The robots have the ability to change into different mechanical objects as they seek the key to ultimate power. Only a human youth, Sam Witwicky can save the world from total destruction."
    ],
    [
        "name": "Titanic",
        "year": 1997,
        "genre": "drama",
        "cast": ["Leonardo DiCaprio", "Kate Winslet", "Billy Zane"],
        "description": "The ill-fated maiden voyage of the R.M.S. Titanic; the pride and joy of the White Star Line and, at the time, the largest moving object ever built. She was the most luxurious liner of her era -- the \"ship of dreams\" -- which ultimately carried over 1,500 people to their death in the ice cold waters of the North Atlantic in the early hours of April 15, 1912."
    ],
    [
        "name": "The Hunger Games",
        "year": 2012,
        "genre": "drama",
        "cast": ["Jennifer Lawrence", "Josh Hutcherson", "Liam Hemsworth"],
        "description": "Katniss Everdeen voluntarily takes her younger sister\"s place in the Hunger Games, a televised competition in which two teenagers from each of the twelve Districts of Panem are chosen at random to fight to the death."
    ],
    [
        "name": "American Sniper",
        "year": 2014,
        "genre": "drama",
        "cast": ["Bradley Cooper", "Sienna Miller", "Kyle Gallner"],
        "description": "Navy S.E.A.L. sniper Chris Kyle\"s pinpoint accuracy saves countless lives on the battlefield and turns him into a legend. Back home to his wife and kids after four tours of duty, however, Chris finds that it is the war he can\"t leave behind."
    ]
]

// MARK: - PART 1

print("\nPART 1 *****************")

var swiftMovies: [Movie] = []

//For each movie in the Movie array, print the name of each movie and associated cast on a single line. Be sure not to print the array of cast members, only the string elements.
/*Expeted Output:
 Minions: Sandra Bullock, Jon Hamm, Michael Keaton
 Shrek: Mike Myers, Eddie Murphy, Cameron Diaz
 .
 .
 .
 */

//for movie in swiftMovies {
//    print("\(movie.name): \(movie.cast.joined(separator: ", "))")
//}

// Populate an array of Movie structs converted from the familiar array of dictionaries.
for movieDict in movies {
    if let movie = Movie(from: movieDict) {
        swiftMovies.append(movie)
    }
}

// For each movie in the Movie array, print the name of each movie and associated cast on a single line. Be sure not to print the array of cast members, only the string elements.

// MARK: - PART 2

print("\nPART 2 *****************")

print("********** A ***********", terminator: "\n")

// a. Print the name of the first movie.
print(swiftMovies[0].name)

print("\n********** B ***********", terminator: "\n")

// b. Print a list of all movie names, preferably on one line.
for movie in swiftMovies {
    print(movie.name)
}


print("\n********** C ***********", terminator: "\n")

//* c. Print a list of all movie years and names (each on a new line) as follows:
//```
//2015: Minions
//2001: Shrek
//.
//.
//.
//```

for movie in swiftMovies {
    print("\(movie.year): \(movie.name)")
}

print("\n********** D ***********")

//* d. Iterate over all movies. Inside the loop use switch on `genre`. Print each title and add an appropriate emoji to represent its genre.
let animationEmoji = "\u{1f430}"
let actionEmoji = "\u{1f4a5}"
let dramaEmoji = "\u{1f3ad}"

for movie in swiftMovies {
    switch movie.genre {
    case Genre.action:
        print(movie.name, actionEmoji)
    case Genre.animation:
        print(movie.name, animationEmoji)
    case Genre.drama:
        print(movie.name, dramaEmoji)
    }
}

print("\n********** E ***********", terminator: "\n")
//* e. In code, not by literal initialization, create a new dictionary called `moviesByName` of type [String:[String:Any]]. Copy the elements of movies, adding each to `moviesByName` with the name as key. Sort by name.
var moviesByName: [String:[String:Any]] = [:]

for movie in swiftMovies {
    moviesByName[movie.name] = [
        "year" : movie.year,
        "genre" : movie.genre,
        "cast" : movie.cast,
        "description" : movie.description
    ]
}

let alphabeticallySortedMovies = Array(moviesByName).sorted { ($0.0 < $1.0) }
print(alphabeticallySortedMovies)

print("\n********** F ***********", terminator: "\n")

//* f. Do the same thing as in (e) for year and genre, creating a new dictionary for each one. What happens, and why? How might you change your approach?
var moviesByYear: [Int:[String:Any]] = [:]
var moviesByGenre: [Genre:[String:Any]] = [:]

for movie in swiftMovies {
    moviesByYear[movie.year] = [
        "name" : movie.name,
        "genre" : movie.genre,
        "cast" : movie.cast,
        "description" : movie.description
    ]
    
    //Because the genres associated with each movie are not guaranteed to be unique, the value at the key gets replaced/overwritten each time a movie with the same genre is passed as a subscript. (The same could be true in the case of year. It just so happens that each movie in this data set has a unique year, but if there were multiple movies with the same year they would be overwritten as well.
    moviesByGenre[movie.genre] = [
        "name" : movie.name,
        "year" : movie.year,
        "cast" : movie.cast,
        "description" : movie.description
    ]
}

let chronologicallySortedMovies = Array(moviesByYear).sorted { ($0.0 < $1.0) }
let moviesSortedByGenre = Array(moviesByGenre).sorted { ($0.0.rawValue < $1.0.rawValue) }

for movie in chronologicallySortedMovies {
    print(movie)
}

print()

for movie in moviesSortedByGenre {
    print(movie)
}

// MARK: - PART 3

// MARK: - President Data

var presidentData: [[String:Any?]] = [
    [
        "name" : "Bill Clinton",
        "year_entered" : 1993,
        "year_left" : 2000,
        "birth_year" : 0,
        "death_year" : nil
    ],
    [
        "name" : "George W. Bush",
        "year_entered" : 2001,
        "year_left" : 2008,
        "birth_year" : 0,
        "death_year" : nil
    ],
    [
        "name" : "Barack Obama",
        "year_entered" : 2009,
        "year_left" : 2016,
        "birth_year" : 0,
        "death_year" : nil
    ]
]


print("\nPART 3 *****************")
// Build a presidents array of type [President] (from the presidentData array above)
var presidents: [President] = []

for presidentInfoDict in presidentData {
    if let president = President(with: presidentInfoDict) {
        presidents.append(president)
    }
}

// Using the presidents array, and the inOffice method, print a statement that indicates whether each president was in office or not for each year between 1992-2008.

//Expected Output:
/*
 1992 Bill Clinton - not in office, George W. Bush - not in office, Barack Obama - not in office
 1993 Bill Clinton - in office, George W. Bush - not in office, Barack Obama - not in office
 1994 Bill Clinton - in office, George W. Bush - not in office, Barack Obama - not in office
 .
 .
 */

var startYear = 1992
let endYear = 2008
var output = ""

while startYear <= endYear {
    for i in 0..<presidents.count {
        
        let president = presidents[i]
        let presidentName = president.name
        

        if president.inOffice(startYear) && i == 0 {
            output += "\(startYear) \(presidentName) - in office, "
        } else if president.inOffice(startYear) && i > 0 && i < presidents.count - 1 {
            output += "\(presidentName) - in office, "
        } else if president.inOffice(startYear) && i == presidents.count - 1 {
            output += "\(presidentName) - in office"
        } else if !president.inOffice(startYear) && i == 0 {
            output += "\(startYear) \(presidentName) - not in office, "
        } else if !president.inOffice(startYear) && i > 0 && i < presidents.count - 1 {
            output += "\(presidentName) - not in office, "
        } else if !president.inOffice(startYear) && i == presidents.count - 1 {
            output += "\(presidentName) - not in office"
        }
    }
    print(output)
    output = ""
    startYear += 1
}
