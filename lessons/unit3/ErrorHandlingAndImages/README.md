# Errors + Loading Images + Wrappers

## [Project Link](https://github.com/joinpursuit/Pursuit-Core-iOS-BooksFromOnlineWithImages)

## Resources

- https://docs.swift.org/swift-book/LanguageGuide/ErrorHandling.html

# 1. Error Handling

Some functions are more error-prone than others.  These functions are written with a special keyword *throws* to indicate that when something goes wrong, they pass an error outwards in scope.

<details>
<summary>Example</summary>

```swift
var itemsDict = ["Chips": 4, "Soda": 2, "Pretzels": 9, "Gum": 14]
var money: Double = 3

enum PaymentError: Error {
    case insufficientFunds
    case itemSoldOut
    case itemNotAvailable
}

func buyItem(named str: String) throws {
    guard money >= 1 else {
        throw PaymentError.insufficientFunds
    }
    guard let remainingItems = itemsDict[str] else {
        throw PaymentError.itemNotAvailable
    }
    guard remainingItems > 0 else {
        throw PaymentError.itemSoldOut
    }
    itemsDict[str] = remainingItems - 1
    money -= 1
}
```
</details>

There are four ways to handle the errors that are thrown:

1. Write another function that throws it elsewhere
2. Use a do/catch pattern
3. Use try? to convert any returned objects to nil and ignore errors
4. Use try! to assert that no errors will occur and to crash if they do

### Common App Errors

```swift
enum AppError: Error {
    case unauthenticated
    case invalidJSONResponse
    case couldNotParseJSON
    case noInternetConnection
    case badURL
    case badStatusCode
    case noDataReceived
    case other(rawError: Error)
}
```

# 2. Google Books API

[Endpoint](https://www.googleapis.com/books/v1/volumes?q=Pratchett)

[Documentation](https://developers.google.com/books/docs/v1/using)

# 3. ImageClient

```swift
class ImageAPIClient {
    static let manager = ImageAPIClient()
    
    func getImage(from urlStr: String,
                  completionHanlder: @escaping (Result<UIImage, AppError>) -> Void) {
        
        guard let url = URL(string: urlStr) else {
            completionHanlder(.failure(.badURL))
            return
        }
        
        NetworkHelper.manager.getData(from: url) { (result) in
            switch result {
            case let .failure(error):
                completionHanlder(.failure(error))
            case let .success(data):
                guard let onlineImage = UIImage(data: data) else {
                    completionHanlder(.failure(.notAnImage))
                    return
                }
                completionHanlder(.success(onlineImage))                
            }
        }
    }
    
    private init() {}
}
```

# 4. Model Classes for Books Project

Book.swift
```swift
import Foundation

struct BookInfo: Codable {
    let totalItems: Int
    let items: [Book]
}

struct Book: Codable {
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Codable {
    let title: String
    let authors: [String]?
    let subtitle: String?
    let description: String?
    let imageLinks: ImageLinks?
}

struct ImageLinks: Codable {
    let smallThumbnail: String
    let thumbnail: String
}
```

BookAPIClient.swift
```swift
import Foundation

struct BookAPIClient {
    static let manager = BookAPIClient()
    
    func getBooks(from urlStr: String,
                  completionHandler: @escaping (Result<[Book], AppError>) -> Void) {
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(.badURL))
            return
        }

        NetworkHelper.manager.getData(from: url) { (result) in
            switch result {
            case let .failure(error):
                completionHandler(.failure(error))
                return
            case let .success(data):
                do {
                    let bookInfo = try JSONDecoder().decode(BookInfo.self, from: data)
                    let books = bookInfo.items
                    completionHandler(.success(books))
                }
                catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
    
    private init() {}
}
```

NetworkHelper.swift
```swift
class NetworkHelper {
    static let manager = NetworkHelper()
    
    func getData(from url: URL,
                 completionHandler: @escaping ((Result<Data, AppError>) -> Void)) {
        self.urlSession.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else {
                    completionHandler(.failure(.noDataReceived))
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
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
    
    private init() {}
    
    private let urlSession = URLSession(configuration: URLSessionConfiguration.default)
}
```

AppError.swift
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

# 5. VC Classes for Books Project

BooksVC
```swift
import UIKit

class BooksViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var books = [Book]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var searchTerm = "" {
        didSet {
            loadNewBooks()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
    }
    
    func loadNewBooks() {
        let urlStr = "https://www.googleapis.com/books/v1/volumes?q=\(searchTerm)&maxResults=40"

        BookAPIClient.manager.getBooks(from: urlStr) { (result) in
            switch result {
            case let .success(books):
                self.books = books
            case let .failure(error):
                switch error {
                //ToDo: - Add better error handling
                case .couldNotParseJSON(let error):
                    print("JSONError: \(error)")
                case .noInternetConnection:
                    print("No internet connection")
                default:
                    print("An error occurred: \(error)")
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BookDetailViewController {
            destination.book = books[self.tableView.indexPathForSelectedRow!.row]
        }
    }
}

extension BooksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Book Cell", for: indexPath)
        let book = books[indexPath.row]
        
        cell.textLabel?.text = book.volumeInfo.title
        cell.detailTextLabel?.text = book.volumeInfo.subtitle
        cell.imageView?.image = nil //Gets rid of flickering
        
        guard let imageUrlStr = book.volumeInfo.imageLinks?.smallThumbnail else {
            return cell
        }
        
        ImageAPIClient.manager.getImage(from: imageUrlStr) { (result) in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(image):
                cell.imageView?.image = image
                cell.setNeedsLayout() //Makes the image load as soon as it's ready
            }
        }
        
        return cell
    }
}

extension BooksViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchTerm = searchBar.text ?? ""
        searchBar.resignFirstResponder()
    }
}
```

BookDetailVC
```swift
import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var book: Book!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = book.volumeInfo.title
        subtitleLabel.text = book.volumeInfo.subtitle
        authorLabel.text = book.volumeInfo.authors?.joined(separator: ",")
        descriptionTextView.text = book.volumeInfo.description
        loadImage()
        
    }
    func loadImage() {
        guard let imageURLStr = book.volumeInfo.imageLinks?.thumbnail else {
            return
        }
        
        ImageAPIClient.manager.getImage(from: imageURLStr) { (result) in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(image):
                self.coverImageView.image = image
                self.coverImageView.setNeedsLayout()
            }
        }
    }
}
```

# 6. App Transport Security

Apple likes to be safe.  By default, Xcode will prevent you from accessing any urls with a scheme that is not HTTPS.  If you do want to access data from a HTTP scheme, we'll need to reconfigure our app to allow it.

[Stack Overflow](https://stackoverflow.com/questions/31254725/transport-security-has-blocked-a-cleartext-http)

# 7. Activity Indicator View

When we are loading data into our app, we often want to give the user an indication that they are waiting for something to load.  If the screen is just blank, they might not know that there is data coming in.  The native way of presenting this to a user is using a UIActivityIndicatorView.  
