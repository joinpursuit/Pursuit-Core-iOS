# Unit 3 Quick Guide

### Helpful Classes:

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
	func performDataTask(with url: URL, completionHandler: (Data) -> Void, errorHandler: (Error) -> Void) {
		//Create a dataTask
		self.urlSession.dataTask(with: url){(data: Data?, response: URLResponse?, error: Error?) in
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
        NetworkHelper.manager.performDataTask(with: url,
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
    static let shared = EpisodeAPIClient()
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
        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }
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
| [Loading online images](https://github.com/C4Q/BooksFromOnlineWithImages) | NetworkHandler/APIClient/ImageClient/TableView | 
| [Concurrency](https://github.com/C4Q/AC-iOS-ConcurrencyIntroduction) | Concurrency/DispatchQueue/Async




