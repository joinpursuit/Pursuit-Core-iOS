
# Unit 3:  Networking, Concurrency, APIs

## Contents

1. [Intro to the Internet and Networking](./intro-to-the-internet-and-networking/README.md)
1. [Parsing JSON](./parsing-json/README.md)
1. [DSA: Linked Lists](https://github.com/joinpursuit/DSA-Curriculum/blob/master/linked_lists/ios/README.md)
1. [Intro to Unit Testing](./introduction-to-unit-testing/README.md)
1. [Getting Data From Online](./getting-data-from-online/README.md)
1. [URLSession](./urlsession/README.md)
1. [Concurrency](./concurrency/README.md)
1. [Retain Cycles](./memory-management-and-arc/README.md)
1. [API Keys and Basic Auth](./api-keys-basic-authentication/README.md)
1. [DSA: Queues](https://github.com/joinpursuit/DSA-Curriculum/blob/master/Queues/ios/README.md)
1. [DSA: Stacks](https://github.com/joinpursuit/DSA-Curriculum/blob/master/Stacks/ios/README.md)
1. [Post Requests](./post-requests/README.md)
1. [Singleton Pattern](./singleton-pattern/README.md)
1. [Working with Dates](./working-with-dates/README.md)
1. [UIPageViewController](./uipageviewcontroller/README.md)
1. [DSA: Review](https://github.com/joinpursuit/DSA-Curriculum)
1. [DSA: Hash Tables](https://github.com/joinpursuit/DSA-Curriculum/blob/master/hash_tables/ios/README.md)
1. [App Transport Security](./app-transport-security/README.md)
1. [Uploading JSON Data](./uploading-json-data/README.md)

## Source Code and Lectures

[6.1 Unit 3 Lecture Code](./lecture-files)

[Lecture Videos](https://www.youtube.com/channel/UCDN46W3L67JMtrRb-u_cgCA)


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
