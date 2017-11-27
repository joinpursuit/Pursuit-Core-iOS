# Getting Data from Online

# Resources

- [Singleton](https://developer.apple.com/library/content/documentation/Swift/Conceptual/BuildingCocoaApps/AdoptingCocoaDesignPatterns.html#//apple_ref/doc/uid/TP40014216-CH7-ID177)
- [Pros and cons of Singletons](https://cocoacasts.com/are-singletons-bad/)
- [Closures](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html)
- [Project Link from Jack](https://github.com/C4Q/AC-iOS-NewsAndWeather)

## Objectives

1. Understand the Singleton Design Pattern (and its limitations)
2. Create and use functions that have a closure as an argument
3. Load data from online into an app

# 1. Singleton Design Pattern

A *Singleton* is a design pattern used for ensuring that there is a single, globally shared instance of a custom class.  A Singleton is essentially just a global variable.  It can be useful if there is a global state that you might need to access or manipulate that everything in your app could want to access.

Here's an example of a Singleton for a Settings menu.

```swift
class Settings {
	var colorScheme: (Double, Double, Double) = (red: 0.5, green: 0.2, blue: 0.9)
	var fontSize: Int = 15
	static let shared = Settings()
	private init(){}
}
```

Let's unpack the class above.

There are two instance properties in Settings

1. colorScheme: (Double, Double, Double)
2. fontSize: Int

There is one type property

1. shared: Settings

This means that we can access the various settings by calling:

```swift
Settings.shared.fontSize
//or
Settings.shared.colorSheme.red
```

How can we ensure that there is only ever one active Settings?  In the class above, we mark the initializer as *private*.  That means that we can only create Settings instances inside of our class.

We now have a singleton that we can manipulate to change the various Settings of our app.  Because there is only one instance (named *shared*), we have a garuntee that anywhere in our app that reads from or writes to the settings is looking at the same place.

# 2. NetworkHelper

In past classes, we have converted JSON from our Application's Bundle into a custom object and loaded it into our application.  This is useful for getting and using data, but has its limitations.  We have to copy and paste the JSON and we have to manually paste over each request that we make.  We clearly need a better way to get this information.  But how can we create an app that communicates with the internet?  We will use the following class:

<details>
<summary>NetworkHelper</summary>

```swift
class NetworkHelper {
    private init() {}
    static let manager = NetworkHelper()
    let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    func performDataTask(with url: URL, completionHandler: @escaping ((Data) -> Void), errorHandler: @escaping ((Error) -> Void)) {
        self.urlSession.dataTask(with: url){(data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                guard let data = data else {
                    return
                }
                if let error = error {
                    errorHandler(error)
                }
                completionHandler(data)
            }
            }.resume()
    }
}
```

</details>


For now, we will just copy and paste this class into our project inside a "Models" folder and use it to make our network requests.  Over the course of this week, we will upack this class and understand its constituent parts.


# 3. performDataTask

So how can we use this class?  Let's take a look at its instance method's signature:

```swift
performDataTask(with url: URL, 
				completionHandler: @escaping ((Data) -> Void), 
				errorHandler: @escaping ((Error) -> Void))
```

This function takes 3 arguments:

1. A url: URL
2. Something to do when the network request is finished: (Data) -> Void
3. Something to do if an error is encountered: (Error) -> Void


### URL

We can give our method a url by converting a String to a URL using:

```swift
URL(string: "www.example.com")
```

### completionHandler

performDataTask with make a network request and when its finished, it will end up with data.  We need to tell it what to do when it gets data.  In our example here, we will tell it to turn the data into an array of our custom objects and pass it into another function.

### errorHandler

Something might go wrong when we try to get our data from online.  We need to know what to do with that information so we can inform the user.  For example, we can change the text of a label so that the user knows what error transpired.


Our **completionHandler** has to return Void and has Data as an arguement.  If we want to use an array of custom objects as an argument, we'll need another function that takes this array of custom objects and can display it to the user.



# 4. APIClient - Stock info

Let's make a new app using the [iex stock api](https://iextrading.com/developer/docs/) that we have used before on homework.

<details>
<summary>Stock struct</summary>

```swift
struct Stock: Codable {
    let companyName: String
    let exchange: String
    let industry: String
    let description: String
    let CEO: String
    static let defaultStock = Stock(companyName: "Default company", exchange: "Default exchange", industry: "Default industry", description: "Default description", CEO: "Default CEO")
}
```
</details>

<details>
<summary>Stock APIClient</summary>

```swift
struct StockAPIClient {
    private init() {}
    static let manager = StockAPIClient()
    func getStock(from urlStr: String, completionHandler: @escaping (Stock) -> Void, errorHandler: (Error) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let stock = try JSONDecoder().decode(Stock.self, from: data)
                completionHandler(stock)
            }
            catch {
                print(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion,
                                              errorHandler: {print($0)})
    }
}
```
</details>

# 5. Using our APIClient


<details>
<summary>Inside viewDidLoad</summary>

```swift
StockAPIClient.manager.getStock(from: endPoint,
                                completionHandler: {self.stock = $0},
                                errorHandler: {self.nameLabel.text = "Invalid Ticker: \($0)"})
```
</details>

# 6. Overview:

1. Use the NetworkHelper class to go to a URL and get Data
2. Convert the Data into a custom class using JSONDecoder() or JSONSerialization
3. Use the completion handler in the CustomClientAPIClient to display the object to the user
