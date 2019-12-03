
# Unit 3:  Networking, Concurrency, APIs

## Contents

| Lesson | Exit Ticket | Lab |
| --- | --- | --- |
| 1. [Introduction to the Internet and Networking](https://github.com/joinpursuit/Pursuit-Core-iOS/blob/master/networking-concurrency-apis/intro-to-the-internet-and-networking/README.md) | [6.1](https://canvas.instructure.com/courses/1605734/assignments/12289325) / [6.3](https://canvas.instructure.com/courses/1705726/assignments/12465058) | [link](https://github.com/joinpursuit/Pursuit-Core-Introduction-To-Networking-and-APIs-Lab) |
| 2. [Parsing JSON](https://github.com/joinpursuit/Pursuit-Core-iOS/blob/master/networking-concurrency-apis/parsing-json/README.md) | [6.1](https://canvas.instructure.com/courses/1605734/assignments/12323266) / [6.3](https://canvas.instructure.com/courses/1705726/assignments/12465031) | [Weather / Color / Random User](https://github.com/joinpursuit/Pursuit-Core-iOS-Parsing-JSON-Lab) |
| 3. [Unit Testing](https://github.com/joinpursuit/Pursuit-Core-iOS/blob/master/networking-concurrency-apis/introduction-to-unit-testing/README.md) | [6.1](https://canvas.instructure.com/courses/1605734/assignments/12344585) / [6.3](https://canvas.instructure.com/courses/1705726/assignments/12465028) | [Jokes / Star Wars / Trivia](https://github.com/joinpursuit/Pursuit-Core-iOS-Introduction-to-Unit-Testing-Lab) |
| 4. [Getting Data from Online](https://github.com/joinpursuit/Pursuit-Core-iOS/blob/master/networking-concurrency-apis/getting-data-from-online/README.md) | [6.1](https://canvas.instructure.com/courses/1605734/assignments/12382891) / [6.3](https://canvas.instructure.com/courses/1705726/assignments/12465071) | n/a |
| 5. [Concurrency and Grand Central Dispatch](https://github.com/joinpursuit/Pursuit-Core-iOS/tree/master/networking-concurrency-apis/concurrency) | [6.1](https://canvas.instructure.com/courses/1605734/assignments/12394340) / [6.3](https://canvas.instructure.com/courses/1705726/assignments/12465060) | [Country List](https://github.com/joinpursuit/Pursuit-Core-iOS-Concurrency-Lab/blob/master/README.md) |
| 6. [Images and Error Handling](https://github.com/joinpursuit/Pursuit-Core-iOS/tree/4_3/lessons/unit3/ErrorHandlingAndImages) | [6.1](https://canvas.instructure.com/courses/1605734/assignments/12453542) / [6.3](https://canvas.instructure.com/courses/1705726/assignments/12465040) | [XCKD / Pokemon / Random User](https://github.com/joinpursuit/Pursuit-Core-iOS-Images-Lab/blob/master/README.md) |
| 7. [Retain Cycles](https://github.com/joinpursuit/Pursuit-Core-iOS/blob/master/networking-concurrency-apis/memory-management-and-arc/README.md) | [6.3](https://canvas.instructure.com/courses/1705726/assignments/12465030) | n/a |
| 8. [API Keys and Auth](https://github.com/joinpursuit/Pursuit-Core-iOS/blob/master/networking-concurrency-apis/api-keys-basic-authentication/README.md) | [6.1](https://canvas.instructure.com/courses/1605734/assignments/12480829) / [6.3](https://canvas.instructure.com/courses/1705726/quizzes/4493743) | [Musixmatch](https://github.com/joinpursuit/Pursuit-Core-iOS-API-Keys-Lab/blob/master/README.md) |
| 9. [Post Requests](https://github.com/joinpursuit/Pursuit-Core-iOS/blob/master/networking-concurrency-apis/post-requests/README.md) | [6.1](https://canvas.instructure.com/courses/1605734/assignments/12503024) | [Airtable Clients List](https://github.com/joinpursuit/Pursuit-Core-iOS-Post-Requests-with-Airtable) |


## Assignments

- [Stocks and Contacts](https://github.com/joinpursuit/Pursuit-Core-iOS-Unit3-Assignment1)
- [TV Shows](https://github.com/joinpursuit/AC-iOS-EpisodesFromOnline-HW/blob/master/README.md)
- Group Project

## Source Code and Lectures

[6.1 Unit 3 Lecture Code](./lecture-files)

[Lecture Videos](https://www.youtube.com/channel/UCDN46W3L67JMtrRb-u_cgCA)

[Github Cheat Sheet](https://github.com/davidlawrencer/github-cheat-sheet)


## Extra Content

1. [Singleton Pattern](./singleton-pattern/README.md)
1. [Working with Dates](./working-with-dates/README.md)
1. [App Transport Security](./app-transport-security/README.md)


## Helper Classes written in Unit 3 to handle Networking


<details>
	<summary>Network Helper - wrapper for URLSession</summary>

```swift
import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

class NetworkHelper {

    // MARK: - Static Properties

    static let manager = NetworkHelper()

    // MARK: - Internal Properties

    func performDataTask(withUrl url: URL,
                         andHTTPBody body: Data? = nil,
                         andMethod httpMethod: HTTPMethod,
                         completionHandler: @escaping ((Result<Data, AppError>) -> Void)) {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        urlSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else {
                    completionHandler(.failure(.noDataReceived))
                    return
                }

                guard let response = response as? HTTPURLResponse, (200...299) ~= response.statusCode else {
                    completionHandler(.failure(.badStatusCode))
                    return
                }

                if let error = error {
                    let error = error as NSError
                    if error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                        completionHandler(.failure(.noInternetConnection))
                        return
                    } else {
                        completionHandler(.failure(.other(rawError: error)))
                        return
                    }
                }
                completionHandler(.success(data))
            }
            }.resume()
    }

    // MARK: - Private Properties and Initializers

    private let urlSession = URLSession(configuration: URLSessionConfiguration.default)

    private init() {}
}
```

</details>


<details>
	<summary>AppError - handles error throughout the app</summary>

```swift
import Foundation

enum AppError: Error {
    case unauthenticated
    case invalidJSONResponse
    case couldNotParseJSON(rawError: Error)
    case noInternetConnection
    case badURL
    case badStatusCode
    case noDataReceived
    case notAnImage
    case other(rawError: Error)
}
```

</details>
