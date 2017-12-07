# Unit 3 Quick Guide

### Key Lesson Links

- [Parsing JSON](https://github.com/C4Q/AC-iOS/tree/master/lessons/unit3/ParsingJSON/README.md)
- [Online web requests](https://github.com/C4Q/AC-iOS/blob/master/lessons/unit3/GettingDataFromOnline/README.md)
- [Images and Error Handling](https://github.com/C4Q/AC-iOS/blob/master/lessons/unit3/ErrorHandlingAndImages/README.md)
- [Concurrency](https://github.com/C4Q/AC-iOS/tree/master/lessons/unit3/Concurrency.README.md)
- [API Keys](https://github.com/C4Q/AC-iOS/tree/master/lessons/unit3/APIKeys%2BBasicAuthentication)
- [Auth and POST](https://github.com/C4Q/AC-iOS/tree/master/lessons/unit3/POSTRequests)


### Helpful Classes/Methods:

<details>
<summary>AppError enum</summary>

```swift
enum AppError: Error {
 case badURL
 case codingError(rawError: Error)
 //Add more as required
}
```

</details>


<details>
<summary>Network Helper</summary>

```swift
class NetworkHelper {
    //Make it so we can't make NetworkHelpers outside this class
    private init() {}
    
    //Create a class property that we will use to get to instance methods
    static let manager = NetworkHelper()
    
    //Create a default URLSession
    private let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    
    //Give the manager an instance method that takes a URL, completion handler and error handler.  After getting data from the URL, it runs the completion handler.
    func performDataTask(with request: URLRequest, completionHandler: @escaping (Data) -> Void, errorHandler: @escaping (Error) -> Void) {
        //Create a dataTask
        self.urlSession.dataTask(with: request){(data: Data?, response: URLResponse?, error: Error?) in
            guard let data = data else {return} //Ensure the data is valid
            
            //Handle any errors
            if let error = error {
                errorHandler(error)
            }
            
            //Input the data into the completion handler
            completionHandler(data)
            
            //resume() starts the data task.  Without out, our data task will not run.
            }.resume()
    }
}
```

</details>

<details>
<summary>ImageAPIClient</summary>


```swift 
import UIKit
class ImageAPIClient {
    private init() {}
    static let manager = ImageAPIClient()
    func loadImage(from urlStr: String,
                   completionHandler: @escaping (UIImage) -> Void,
                   errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        let completion = {(data: Data) in
            guard let onlineImage = UIImage(data: data) else {return}
            completionHandler(onlineImage)
        }
        NetworkHelper.manager.performDataTask(with: URLRequest(url: url),
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }
}
```

</details>

<details>
<summary>ThingAPIClient</summary>

```swift
struct ThingAPIClient {
    private init(){}
    static let shared = ThingAPIClient()
    func getThings(from urlStr: String,
                     completionHandler: @escaping ([Thing]) -> Void,
                     errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let things = try JSONDecoder().decode([Thing].self, from: data)
                completionHandler(things)
            }
            catch {
                print(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: URLRequest(url: url),
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }
}
```
</details>

<details>
<summary> POST Request </summary>

```
func post(thing: Thing, errorHandler: @escaping (Error) -> Void) {
    let urlStr = "https://api.fieldbook.com/v1/5a21d3ea92dfac03005db55a/orders"
    guard var authPostRequest = buildAuthRequest(from: urlStr, httpVerb: .POST) else {errorHandler(AppError.badURL); return }
    do {
        let encodedThing = try JSONEncoder().encode(thing)
        authPostRequest.httpBody = encodedThing
        NetworkHelper.manager.performDataTask(with: authPostRequest,
                                              completionHandler: {_ in print("Made a post request")},
                                              errorHandler: errorHandler)
    }
    catch {
        errorHandler(AppError.codingError(rawError: error))
    }
}
```
</details>

<details>
<summary>Basic Auth Helper functions</summary>

```swift
private func buildAuthRequest(from urlStr: String, httpVerb: HTTPVerb) -> URLRequest? {
    guard let url = URL(string: urlStr) else { return nil }
    var request = URLRequest(url: url)
    let userName = "key-1"
    let password = "p3Z-A83YixDsI-B4aRLm"
    let authStr = buildAuthStr(userName: userName, password: password)
    request.addValue(authStr, forHTTPHeaderField: "Authorization")
    if httpVerb == .POST {
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    return request
}
private func buildAuthStr(userName: String, password: String) -> String {
    let nameAndPassStr = "\(userName):\(password)"
    let nameAndPassData = nameAndPassStr.data(using: .utf8)!
    let authBase64Str = nameAndPassData.base64EncodedString()
    let authStr = "Basic \(authBase64Str)"
    return authStr
}
```
</details>


### Key Projects

| Name | Tags |
| --- | --- |
| [Downcasting Example](https://github.com/C4Q/AC-iOS-ParsingJSONExample) | JSON/TableView |
| [Codable Examples](https://github.com/C4Q/AC-iOS-CodableExample) | Parsing JSON/TableView |
| [Web Request - Stocks](https://github.com/C4Q/AC-iOS-StocksFromOnline) | NetworkHandler/JSON/APIClient/TableView |
| [Web Request - People](https://github.com/C4Q/AC-iOS-RandomUserAPIPractice) | NetworkHandler/JSON/APIClient/TableView/CodingKeys
| [Web Request - Currency Converter](https://github.com/C4Q/AC-iOS-CurrencyConverter) | PickerView/JSON |
| [Loading Online Images - Books](https://github.com/C4Q/BooksFromOnlineWithImages) | NetworkHandler/APIClient/ImageClient/TableView | 
| [Concurrency - NASA Image](https://github.com/C4Q/AC-iOS-ConcurrencyIntroduction) | Concurrency/DispatchQueue/Async
| [API Keys - Recipes](https://github.com/C4Q/AC-iOS-Recipes-APIKeys) |  APIKeys/GET |
|[POST - Fieldbook Demo](https://github.com/C4Q/AC-iOS-Post-BasicAuth) | Auth/Basic Auth/GET/POST
