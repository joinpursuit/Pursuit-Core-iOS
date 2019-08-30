import UIKit
import Foundation

var str = "Hello, playground"

struct PeopleWrapper: Codable {
    let people: [Person]
    
    static func getPerson(data: Data) -> PeopleWrapper? {
        do {
            let person = try JSONDecoder().decode(PeopleWrapper.self, from: data)
            return person
        } catch {//catching errors thrown -> "error"
            print("couldn't decode \(error)")
            return nil
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case people = "results"
    }
}
struct Person: Codable {
    let name: Name
    
    struct Name: Codable {
        let title: String
        let first: String
        let last: String
    }
}

//var personJSONData = """
//{ "name": {"first":"clark","last": "kent","title":"señor"},
//"stuff":"other stuff"
//}
//""".data(using: .utf8)!
//
//PeopleWrapper.getPerson(data: personJSONData)
let randomUserURLString = "https://randomuser.me/api/?results=5"

guard let url = URL(string: randomUserURLString) else {fatalError()}

struct PeopleAPIClient {
    static let shared = PeopleAPIClient()
    
    enum FetchUserErrors: Error {
        case remoteResponseError
        case noDataError
        case badDecodeError
    }
    
    func fetchUsers(completionHandler: @escaping (Result<PeopleWrapper,Error>) -> () ) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {completionHandler(.failure(FetchUserErrors.remoteResponseError))
                return
            }
            
            guard let data = data else {completionHandler(.failure(FetchUserErrors.noDataError))
                return
            }
            
            guard let people = PeopleWrapper.getPerson(data: data) else {completionHandler(.failure(FetchUserErrors.badDecodeError))
                return
            }
            
            completionHandler(.success(people))
            }.resume()
    }
}

var firstPerson = Person(name: Person.Name(title: "Mr", first: "David", last: "Rifkin"))

for _ in 1...6 {
    PeopleAPIClient.shared.fetchUsers { (result) in
        switch result {
        case .failure(let error):
            print(error)
        //i can use as an instance of Error
        case .success(let peopleWrapper):
            firstPerson = peopleWrapper.people.first!
        }
    }
}

print(firstPerson)
sleep(2)
print(firstPerson)


let array = [1,2,3,4,5,6,7,8,9]
array.reduce(0) { (a, b) in
    a + b
}
