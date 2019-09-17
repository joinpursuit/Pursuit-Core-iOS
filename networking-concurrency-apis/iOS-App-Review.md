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
