# Standards

* Understand ```UICollectionView```

# Objectives

* Build and populate collection views
* Understand how flows work in collection views
* Size and layout items of a collection view dynamically

# Resources

* [Ray Wenderlich Tutorial](https://www.raywenderlich.com/136159/uicollectionview-tutorial-getting-started)
* [Collection View (Apple Docs)](https://developer.apple.com/reference/uikit/uicollectionview)
* [Collection View Layout(Apple Docs)](https://developer.apple.com/reference/uikit/uicollectionviewlayout)
* [UICollectionViewDelegateFlowLayout (Apple Docs)](https://developer.apple.com/reference/uikit/uicollectionviewdelegateflowlayout)
* [Alex Paul - Colleciton View Demo](https://github.com/joinpursuit/AC-iOS-CollectionView-In-Code)

## [Project Link](https://github.com/joinpursuit/Pursuit-Core-iOS-Collection-Views-Introduction)

# 1. Introduction

## Table View vs. Collection View

Collection views are very much like table views. The main difference is that collection views are far more flexible in how they can lay out their content.

While it's highly customizable via an overrideable class ```UICollectionViewLayout```, the default ```Flow``` layout is very powerful without any subclassing. The protocol ```UICollectionViewDelegateFlowLayout``` allows us to tap into this layout.  It inherits from UICollectionViewDelegate as shown below:

```swift
public protocol UICollectionViewDelegateFlowLayout : UICollectionViewDelegate
```

### DataSource

UICollectionView's data source is very much like UITableView's. The key methods work in the same way, but for some rewording.


```swift
override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
}


override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dataArray.count
}

override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    .
    .
    .
    }

    return cell
}
```

## No Default Cells

Collection Views require customization for their cells.  There is no "basic" or "subtitle" collection view cell, like you might find with a table view. We must always create a subclass and set its properties like we do for custom table view cells.

## Horizontal / Vertical scrolling

Collection Views can be configured to scroll both vertically and horizontally by setting the `scroll direction` property inside of the attributes inspector.

## Sizing Collection View Cells

We can set the size of a collection view cell by conforming to a special protocol named "UICollectionViewDelegateFlowLayout".  Then you are able to calll the appropriate method.

```swift
extension BestSellersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(YOURWIDTH, YOURHEIGHT)
    }
}
```

Let's create an app that loads data into a collection view instead of a table view.  Let's use the following endpoint: https://api.magicthegathering.io/v1/cards?name=bolt

# 2. Build the Model

## Networking

Let's start by adding in our networking layer:

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

<details>
<summary>ImageAPIClient</summary>

```swift
import Foundation
import UIKit

class ImageAPIClient {
    private init() {}
    static let manager = ImageAPIClient()
    func loadImage(from urlStr: String,
                   completionHandler: @escaping (Result<UIImage, AppError>) -> Void) {
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(.badURL))
            return
        }
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case let .success(data):
                guard let onlineImage = UIImage(data: data) else {
                    completionHandler(.failure(.notAnImage))
                    return
                }
                completionHandler(.success(onlineImage))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
}
```

</details>

## Model Object

Now we can build out our model.  Let's take a look at some sample `JSON`:

```js

{
  "cards": [
    {
      "name": "Lightning Bolt",
      "manaCost": "{R}",
      "cmc": 1.0,
      "colors": [
        "Red"
      ],
      "colorIdentity": [
        "R"
      ],
      "type": "Instant",
      "supertypes": [

      ],
      "types": [
        "Instant"
      ],
      "subtypes": [

      ],
      "rarity": "Common",
      "set": "2ED",
      "setName": "Unlimited Edition",
      "text": "Lightning Bolt deals 3 damage to any target.",
      "artist": "Christopher Rush",
      "number": "162",
      "layout": "normal",
      "multiverseid": 806,
      "imageUrl": "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=806&type=card",
      // More properties...
    }
  ]
}
```

We can use the following to model this object:

```swift
import Foundation

struct ResultsWrapper: Codable {
    let cards: [MagicCard]
}

struct MagicCard: Codable {
    let name: String
    let text: String?
    let imageUrl: String?
    static func getCards(from data: Data) -> [MagicCard] {
        do {
            let results = try JSONDecoder().decode(ResultsWrapper.self, from: data)
            return results.cards
        } catch {
            print("Decoding Error: ", error)
            fatalError()
        }
    }
}
```

And the following APIClient to get data:

```swift
import Foundation

struct MagicCardAPIClient {
    private init() {}
    static let manager = MagicCardAPIClient()

    private let urlStr = "https://api.magicthegathering.io/v1/cards?name="

    func getCards(matching searchTerm: String = "bolt",
                  completionHandler: @escaping (Result<[MagicCard], AppError>) -> Void) {
        guard let formattedSearchTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            completionHandler(.failure(.badURL))
            return
        }

        let fullUrlStr = urlStr + formattedSearchTerm

        guard let url = URL(string: fullUrlStr) else {
            completionHandler(.failure(.badURL))
            return
        }

        NetworkHelper.manager.performDataTask(withUrl: url,
                                              andMethod: .get) { (result) in
                                                switch result {
                                                case let .success(data):
                                                    let cards = MagicCard.getCards(from: data)
                                                    completionHandler(.success(cards))
                                                case let .failure(error):
                                                    completionHandler(.failure(error))
                                                }
        }
    }
}
```

Then, we can test our model to make sure it was build correctly:


Save the JSON from the link [here](https://api.magicthegathering.io/v1/cards?name=bolt) to your project's bundle:

Add the following test to make sure your app can parse the JSON correctly:

```swift
import XCTest
@testable import CollectionViewIntroduction

class CollectionViewIntroductionTests: XCTestCase {

    func testMagicCardGetCards() {

        // Arrange

        let jsonData = getTestMagicCardJSONData()

        // Act

        let cards = MagicCard.getCards(from: jsonData)

        // Assert

        XCTAssertEqual(cards.count, 75)
    }

    private func getTestMagicCardJSONData() -> Data {
        guard let pathToData = Bundle.main.path(forResource: "cards", ofType: "json") else {
            fatalError("cards.json file not found")
        }
        let internalUrl = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: internalUrl)
            return data
        }
        catch {
            fatalError("An error occurred: \(error)")
        }
    }
}
```

# 3. Build the UI

Let's start to put our Collection View together.  In Storyboard, drag a `UICollectionView` into your View Controller and pin it to the edges of the screen.

Click on the cell and give it a reuse identifier of `magicCardCell`

Build your cell's UI in storyboard by creating an Image View and pinning it to the edges of the cell.


Next, create a new file `MagicCardCollectionViewCell` that subclasses from `UICollectionViewCell`.

Create an outlet from the Storyboard file to your custom subclass:

```swift
import UIKit

class MagicCardCollectionViewCell: UICollectionViewCell {
    @IBOutlet var cardImageView: UIImageView!
}
```

Let's also grab a placeholder image if we can load the card image: https://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=442063&type=card.  Store this in your assets folder.

# 4. Build the View Controllers

Now we can build our VC to pull in data from online, and load it into our cells.  Start by dragging in an outlet to your CollectionView

```swift
import UIKit

class ViewController: UIViewController {

    @IBOutlet var cardsCollectionView: UICollectionView!

    var cards = [MagicCard]() {
        didSet {
            cardsCollectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        loadCards()
    }

    private func configureCollectionView() {
        cardsCollectionView.dataSource = self
        cardsCollectionView.delegate = self
    }

    private func loadCards() {
        MagicCardAPIClient.manager.getCards { [weak self] (result) in
            switch result {
            case let .success(cards):
                self?.cards = cards
            case let .failure(error):
                print("An error occurred: \(error)")
            }
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // https://stackoverflow.com/questions/37152071/landscape-orientation-for-collection-view-in-swift/37152739
        let orientation = UIApplication.shared.statusBarOrientation

        if (orientation == .landscapeLeft || orientation == .landscapeRight) {
            return CGSize(width: (collectionView.bounds.width - 10) / 2, height: collectionView.bounds.width / 2.2)
        }
        else {
            return CGSize(width: (collectionView.bounds.width - 5) / 2, height: (collectionView.bounds.width / 1.5))
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "magicCardCell", for: indexPath) as? MagicCardCollectionViewCell else {
            fatalError("Unknown reuse ID")
        }
        let magicCard = cards[indexPath.row]
        cell.cardImageView.image = nil

        let imageCompletionHandler: (Result<UIImage, AppError>) -> Void = { result in
            switch result {
            case let .success(image):
                cell.cardImageView.image = image
                cell.setNeedsLayout()
            case let .failure(error):
                print("An error occurred: ")
                print(error)
            }
        }

        if let cardImageUrl = magicCard.imageUrl {
            ImageAPIClient.manager.loadImage(from: cardImageUrl,
                                             completionHandler: imageCompletionHandler)
        } else {
            cell.cardImageView.image = UIImage(named: "totallyLostImage")
        }
        return cell
    }
}
```

We'll need to set up the info.plist to [allow arbitrary loads](https://stackoverflow.com/questions/31254725/transport-security-has-blocked-a-cleartext-http)
