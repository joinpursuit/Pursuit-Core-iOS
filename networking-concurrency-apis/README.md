
# Unit 3:  Networking, Concurrency, APIs

## Contents

1. [Intro to the Internet and Networking](./intro-to-the-internet-and-networking/README.md)
1. [Parsing JSON](./parsing-json/README.md)
1. [DSA: Linked Lists](https://github.com/joinpursuit/DSA-Curriculum/blob/master/linked_lists/ios/README.md)
1. [Intro to Unit Testing](./introduction-to-unit-testing/README.md)
1. [URLSession](./urlsession/README.md)
1. [Concurrency](./concurrency/README.md)
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

public final class NetworkHelper {
  private init() {
    let cache = URLCache(memoryCapacity: 10 * 1024 * 1024, diskCapacity: 10 * 1024 * 1024, diskPath: nil)
    URLCache.shared = cache
  }
  public static let shared = NetworkHelper()

  public func performDataTask(endpointURLString: String,
                              httpMethod: String,
                              httpBody: Data?,
                              completionHandler: @escaping (AppError?, Data?, HTTPURLResponse?) ->Void) {
    guard let url = URL(string: endpointURLString) else {
      completionHandler(AppError.badURL("\(endpointURLString)"), nil, nil)
      return
    }
    var request = URLRequest(url: url)
    request.httpMethod = httpMethod
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      if let error = error {
        completionHandler(AppError.networkError(error), nil, response as? HTTPURLResponse)
        return
      } else if let data = data {
        completionHandler(nil, data, response as? HTTPURLResponse)
      }
    }
    task.resume()
  }

  public func performUploadTask(endpointURLString: String,
                                httpMethod: String,
                                httpBody: Data?,
                                completionHandler: @escaping (AppError?, Data?, HTTPURLResponse?) ->Void) {
    guard let url = URL(string: endpointURLString) else {
      completionHandler(AppError.badURL("\(endpointURLString)"), nil, nil)
      return
    }
    var request = URLRequest(url: url)
    request.httpMethod = httpMethod
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let task = URLSession.shared.uploadTask(with: request, from: httpBody) { (data, response, error) in
      if let error = error {
        completionHandler(AppError.networkError(error), nil, response as? HTTPURLResponse)
        return
      } else if let data = data {
        completionHandler(nil, data, response as? HTTPURLResponse)
      }
    }
    task.resume()
  }
}
```

</details>


<details>
	<summary>AppError - handles error throughout the app</summary>

```swift
import Foundation

public enum AppError: Error {
  case badURL(String)
  case networkError(Error)
  case noResponse
  case decodingError(Error)
  case badStatusCode(String)
  case badMimeType(String)

  public func errorMessage() -> String {
    switch self {
    case .badURL(let message):
      return "badURL: \(message)"
    case .networkError(let error):
      return error.localizedDescription
    case .noResponse:
      return "no network response"
    case .decodingError(let error):
      return "decoding error: \(error)"
    case .badStatusCode(let message):
      return "bad status code: \(message)"
    case .badMimeType(let mimeType):
      return "bad mime type: \(mimeType)"
    }
  }
}
```

</details>


<details>
	<summary>ImageHelper - wrapper for image processing including caching images in memory for optimization in performance</summary>

```swift
import UIKit

public final class ImageHelper {
  // Singleton instance to have only one instance in the app of the imageCache
  private init() {
    imageCache = NSCache<NSString, UIImage>()
    imageCache.countLimit = 100 // number of objects
    imageCache.totalCostLimit = 10 * 1024 * 1024 // max 10MB used
  }
  public static let shared = ImageHelper()

  private var imageCache: NSCache<NSString, UIImage>

  public func fetchImage(urlString: String, completionHandler: @escaping (AppError?, UIImage?) -> Void) {
    NetworkHelper.shared.performDataTask(endpointURLString: urlString, httpMethod: "GET", httpBody: nil) { (error, data, response) in
      if let error = error {
        completionHandler(error, nil)
        return
      }
      if let response = response {
        // response.allHeaderFields dictionary contains useful header information such as Content-Type, Content-Length
        // response also has the mimeType, such as image/jpeg, text/html, image/png
        let mimeType = response.mimeType ?? "no mimeType found"
        var isValidImage = false
        switch mimeType {
        case "image/jpeg":
          isValidImage = true
        case "image/png":
          isValidImage = true
        default:
          isValidImage = false
        }
        if !isValidImage {
          completionHandler(AppError.badMimeType(mimeType), nil)
          return
        } else if let data = data {
          let image = UIImage(data: data)
          DispatchQueue.main.async {
            if let image = image {
              ImageHelper.shared.imageCache.setObject(image, forKey: urlString as NSString)
            }
            completionHandler(nil, image)
          }
        }
      }
    }
  }

  public func image(forKey key: NSString) -> UIImage? {
    return imageCache.object(forKey: key)
  }
}
```

</details>
