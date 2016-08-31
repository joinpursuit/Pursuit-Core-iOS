//: [Previous](@previous)

import Foundation

//: [Next](@next)

func reportOnMovies(movies:[[String:Any]], inLanguage language: String = "en", sortedBy sorter:([String:Any], [String:Any]) -> Bool) -> String? {
    var wordForAnd = "and"
    
    switch language {
    case "en":
        wordForAnd = "and"
    case "sp":
        wordForAnd = "y"
    default:
        break
    }
    
    func buildCommaSeparatedList(words: [String]) -> String {
        var output = ""
        for (i, word) in words.enumerate() {
            if i == words.count - 1 {
                output += "\(wordForAnd) \(word)"
            }
            else {
                output += "\(word), "
            }
        }
        return output
    }
    
    // sort the outer array with the sort function/closure passed in
    let sortedMovies = movies.sort(sorter)
    
    var output: String?
    for movie in sortedMovies {
        if let name = movie["name"] as? String, year = movie["year"] as? Int,
            cast = movie["cast"] as? [String], locations = movie["locations"] as? [String] {
            if output == nil {
                output = ""
            }
            
            let castString = buildCommaSeparatedList(cast)
            
            output?.appendContentsOf("\(name) came out in \(year) starring \(castString).")
            output?.appendContentsOf("\nIt was shot in \(buildCommaSeparatedList(locations)).")
            if let president = presidentsByYear[year] {
                output?.appendContentsOf(" \(president) was president.\n")
            }
            output?.appendContentsOf("\n")
        }
    }
    return output
}

reportOnMovies(movies) { (a, b) -> Bool in
    if let a = a["year"] as? Int, b = b["year"] as? Int {
        return a < b
    }
    return false
}

reportOnMovies(movies) { (a, b) -> Bool in
    if let a = a["name"] as? String, b = b["name"] as? String {
        return a < b
    }
    return false
}


