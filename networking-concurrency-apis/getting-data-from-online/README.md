# Getting Data from Online

[Project Link](https://github.com/joinpursuit/Pursuit-Core-iOS-Getting-Data-From-Online-Lesson-Project)

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

We now have a singleton that we can manipulate to change the various Settings of our app.  Because there is only one instance (named *shared*), we have a guarantee that anywhere in our app that reads from or writes to the settings is looking at the same place.

# 2. NetworkHelper

In past classes, we have converted JSON from our Application's Bundle into a custom object and loaded it into our application.  This is useful for getting and using data, but has its limitations.  We have to copy and paste the JSON and we have to manually paste over each request that we make.  We clearly need a better way to get this information.  But how can we create an app that communicates with the internet?  We will use the following class:

<details>
<summary>NetworkHelper</summary>

```swift
class NetworkHelper {

    // Mark: - Static Properties

    static let manager = NetworkHelper()

    // MARK: - Internal Methods

    func getData(from urlString: String, completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badURL))
            return
        }
        let dataTask = self.urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completionHandler(.failure(.responseError(error)))
                return
            }
            guard let urlResponse = response as? HTTPURLResponse else {
                completionHandler(.failure(.noURLResponse))
                return
            }
            guard let data = data else {
                completionHandler(.failure(.noData))
                return
            }
            switch urlResponse.statusCode {
            case 200...299: break
            default:
                completionHandler(.failure(.badURLResponse(urlResponse.statusCode)))
                return
            }

            completionHandler(.success(data))
        }
        dataTask.resume()
    }

    // MARK: - Private Properties and Initializers

    private let urlSession = URLSession(configuration: .default)

    private init() {}
}
```
</details>

<details>
<summary>NetworkError</summary>
enum NetworkError: Error, CustomStringConvertible {
    case badURL
    case responseError(Error)
    case noURLResponse
    case noData
    case badURLResponse(Int)
    var description: String {
        switch self {
        case .badURL: return "Invalid URL"
        case let .responseError(error): return "Response Error: \(error)"
        case .noURLResponse: return "No URL Response"
        case .noData: return "No Data"
        case let .badURLResponse(statusCode): return "Bad status code: \(statusCode)"
        }
    }
}
</details>



Let's unpack some of what these classes are doing:

### getData(from:completionHandler:)

We defined a method `getData(from:completionHandler:)` that takes in a `String` representing a URL as an argument, as well as a closure of type `(Result<Data, NetworkError>) -> Void`.

`Result` is a new enum introduced in Swift 5.  It has two cases `.success` and `.failure`.  `.success` wraps the first generic type as an associated value.  The second generic type must conform to the `Error` protocol.  The `.failure` case wraps that error.

In our method, we will hit the url given to us, then call the completion handler, passing in either data, or a network error.

### URLSession

A `URLSession` is a Swift class that enables us to create a connection to a URL.  Here, we use its `dataTask(with:completionHandler:)` method to open up a data task to a URL and specify what should happen when it completes the data task.  The completionHandler takes in a closure of type `(Data?, URLResponse?, Error?) -> Void)`.  Data represents the raw data we get back from the URL.  `URLResponse` is an `HTTPURLResponse` which tells us the `statusCode` of the request.  `Error` will be non-nil if anything went wrong during the data task.  

In our closure, we check to make sure that there are no errors, there is data, and that the `statusCode` is a success message.  If anything went wrong, we call the completionHandler passing in the error, then return out of the method.  If we get to the end without any errors, we will call the completionHandler passing in the data.

After we create our dataTask, we need to start it.  We actually make the call to get data from the URL by using the data task's `resume()` method.


### NetworkError

Our `NetworkError` enum conforms to the `Error` protocol (which doesn't actually require anything) and lists some potential things that can go wrong when getting data.

# 4. JokeFetchingService

Let's make a new app using [The Official Joke Api](https://official-joke-api.appspot.com/jokes/programming/ten).

<details>
<summary>Joke struct</summary>

```swift
struct Joke: Codable {
    let id: Int
    let type: String
    let setup: String
    let punchline: String
}
```
</details>


<details>
<summary>JokeError</summary>

```swift
enum JokeError: Error, CustomStringConvertible {
    case networkError(NetworkError)
    case jsonDecodingError(Error)
    var description: String {
        switch self {
        case let .networkError(networkError):
            return "Network error: \(networkError)"
        case let .jsonDecodingError(decodingError):
            return "Decoding error: \(decodingError)"
        }
    }
}
```
</details>


<details>
<summary>JokeFetchingService</summary>

```swift
import Foundation

class JokeFetchingService {

    // MARK: - Static Properties

    static let manager = JokeFetchingService()

    // MARK: - Internal Methods

    func getJokes(completionHandler: @escaping (Result<[Joke], JokeError>) -> Void) {
        NetworkHelper.manager.getData(from: jokesEndpoint) { (result) in
            switch result {
            case let .success(data):
                do {
                    let jokes = try JSONDecoder().decode([Joke].self, from: data)
                    completionHandler(.success(jokes))
                } catch {
                    completionHandler(.failure(.jsonDecodingError(error)))
                }
            case let .failure(networkError):
                completionHandler(.failure(.networkError(networkError)))
            }
        }
    }

    // MARK: - Private Properties and Initializers

    private let jokesEndpoint = "https://official-joke-api.appspot.com/jokes/programming/ten"

    private init() {}
}
```
</details>

# 5. Using our JokeFetchingService

Whenever we make a call to the internet, that call happens on a different `queue`.  We'll talk more about concurrency in future lessons.  For now, know that you need to add the line below to ensure that you are updating the UI at the right time:

```swift
DispatchQueue.main.async { }
```

<details>
<summary>JokesViewController</summary>

```swift
import UIKit

class JokesViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet var jokesTableView: UITableView!

    // MARK: - Internal Properties

    var jokes = [Joke]() {
        didSet {
            jokesTableView.reloadData()
        }
    }

    // MARK: - Lifecyle Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        configureJokesTableView()
        loadJokes()
    }

    // MARK: - Private methods

    func configureJokesTableView() {
        jokesTableView.delegate = self
        jokesTableView.dataSource = self
    }

    func loadJokes() {
        JokeFetchingService.manager.getJokes { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case let .success(fetchedJokes):
                    self.jokes = fetchedJokes
                case let .failure(error):
                    let alertVC = UIAlertController(title: "Error",
                                                    message: "An error fetching the jokes occurred: \(error.description)",
                                                    preferredStyle: .alert)
                    alertVC.addAction(UIAlertAction(title: "OK",
                                                    style: .default,
                                                    handler: nil))
                    self.present(alertVC, animated: true, completion: nil)
                }
            }
        }
    }
}

extension JokesViewController: UITableViewDelegate {}

extension JokesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = jokesTableView.dequeueReusableCell(withIdentifier: "jokeCell", for: indexPath)
        let joke = jokes[indexPath.row]
        cell.textLabel?.text = joke.setup
        cell.detailTextLabel?.text = joke.punchline
        return cell
    }
}
```
</details>
