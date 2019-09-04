# Errors + Loading Images

## [Project Link](https://github.com/C4Q/AC-iOS-BooksFromOnlineWithImages)

## Resources
https://blog.bobthedeveloper.io/intro-to-error-handling-in-swift-3-edb2ce6a6668

https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/ErrorHandling.html
# 1. Error Handling

Some functions are more error-prone than others.  These functions are written with a special keyword *throws* to indicate that when something goes wrong, they pass an error outwards in scope.

<details>
<summary>Example</summary>

```
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

# 4. App Transport Security

Apple likes to be safe.  By default, Xcode will prevent you from accessing any urls with a scheme that is not HTTPS.  If you do want to access data from a HTTP scheme, we'll need to reconfigure our app to allow it.

[Stack Overflow](https://stackoverflow.com/questions/31254725/transport-security-has-blocked-a-cleartext-http)

# 5. Activity Indicator View

When we are loading data into our app, we often want to give the user an indication that they are waiting for something to load.  If the screen is just blank, they might not know that there is data coming in.  The native way of presenting this to a user is using a UIActivityIndicatorView.  
