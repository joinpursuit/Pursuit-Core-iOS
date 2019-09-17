# PodcastFavorites demo app

## Key classes 

- [URLSession](https://developer.apple.com/documentation/foundation/urlsession)  
- [URLRequest](https://developer.apple.com/documentation/foundation/urlrequest)  
- [JSONDecoder](https://developer.apple.com/documentation/foundation/jsondecoder)  
- [JSONEncoder](https://developer.apple.com/documentation/foundation/jsonencoder)  
- [Codable - Encoding and Decoding Custom Types](https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types)

## Helper Classes we wrote 

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

</br> 

# Review Project

**Create an app that searches for Podcasts and allows the user to favorite a podcast.**  

- create a tab bar controller
- the tab bar controller should have two view controllers 
- the first view controller should have a search bar that allows the user to search podcasts
- create a custom cell for the search results controller
- the podcast search results controller should be able to segue to show details of the podcast
- there should be a button in the detail view controller to allow the user to favorite a podcast by using the POST endpoint below
- the second tab should list only the user's favorited podcasts 
- selecting a podcast should segue to show the podcast details

**Podcast object in JSON**   
```json 
{
            "wrapperType": "track",
            "kind": "podcast",
            "collectionId": 1435076502,
            "trackId": 1435076502,
            "artistName": "Paul Hudson and Sean Allen",
            "collectionName": "Swift over Coffee",
            "trackName": "Swift over Coffee",
            "collectionCensoredName": "Swift over Coffee",
            "trackCensoredName": "Swift over Coffee",
            "collectionViewUrl": "https://itunes.apple.com/us/podcast/swift-over-coffee/id1435076502?mt=2&uo=4",
            "feedUrl": "https://anchor.fm/s/572fc68/podcast/rss",
            "trackViewUrl": "https://itunes.apple.com/us/podcast/swift-over-coffee/id1435076502?mt=2&uo=4",
            "artworkUrl30": "https://is2-ssl.mzstatic.com/image/thumb/Music124/v4/3e/dc/7a/3edc7a05-9398-a4a9-ba2b-21587d6a0017/source/30x30bb.jpg",
            "artworkUrl60": "https://is2-ssl.mzstatic.com/image/thumb/Music124/v4/3e/dc/7a/3edc7a05-9398-a4a9-ba2b-21587d6a0017/source/60x60bb.jpg",
            "artworkUrl100": "https://is2-ssl.mzstatic.com/image/thumb/Music124/v4/3e/dc/7a/3edc7a05-9398-a4a9-ba2b-21587d6a0017/source/100x100bb.jpg",
            "collectionPrice": 0,
            "trackPrice": 0,
            "trackRentalPrice": 0,
            "collectionHdPrice": 0,
            "trackHdPrice": 0,
            "trackHdRentalPrice": 0,
            "releaseDate": "2018-12-24T19:17:00Z",
            "collectionExplicitness": "cleaned",
            "trackExplicitness": "cleaned",
            "trackCount": 9,
            "country": "USA",
            "currency": "USD",
            "primaryGenreName": "Technology",
            "contentAdvisoryRating": "Clean",
            "artworkUrl600": "https://is2-ssl.mzstatic.com/image/thumb/Music124/v4/3e/dc/7a/3edc7a05-9398-a4a9-ba2b-21587d6a0017/source/600x600bb.jpg",
            "genreIds": [
                "1318",
                "26"
            ],
            "genres": [
                "Technology",
                "Podcasts"
            ]
}
```

**JSON payload for favoriting a Podcast**  
```json 
{
	"trackId" : 1435076502, 
	"favoritedBy": "Alex Paul", 
	"collectionName" : "Swift over Coffee",
	"artworkUrl600" : "https://is2-ssl.mzstatic.com/image/thumb/Music124/v4/3e/dc/7a/3edc7a05-9398-a4a9-ba2b-21587d6a0017/source/600x600bb.jpg"
}
```

## Endpoints 

**Search for Podcasts**  
```GET https://itunes.apple.com/search?media=podcast&limit=200&term=swift```

**Search Podcast by trackId**  
```GET https://itunes.apple.com/search?media=podcast&limit=200&term=1435076502```   

**Favorite a Podcast**  
```POST https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites```  

**Get favorites**   
```GET https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites```   
