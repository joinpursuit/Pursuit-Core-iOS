
# Canonical API implementation

> Note: This is using GETs only. 

The ["canonical" branch](https://github.com/C4Q/AC3.2-Unit3MidunitAssessment/tree/canonical) 
of the Unit 3 Midunit Assessment is our exemplar API project. It is our model because it
has the following components:

## Overview

* a UITableView
	* which seque's from the table's *cell*
	* which uses ```prepare(for:sender:)``` and not the other unnamed method
* aAPIRequestManager with one ```getData``` method for JSON and images
* a Model class
	* that maps de-serialized JSON within the init.
	* that has a class method to generate an array of the object 
* Error handling with Enum of errors and throws (optional)

## Code


### Segue

Inside ```prepare(for:sender:)``` we cast sender to a cell and 
 ask the tableView for the index path of that cell.

```swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let avc = segue.destination as? AlbumViewController,
        let cell = sender as? UITableViewCell,
        let indexPath = tableView.indexPath(for: cell) {
        avc.album = albums[indexPath.row]
    }
}
```

### APIRequestManager

```swift
import Foundation

class APIRequestManager {
    
    static let manager = APIRequestManager()
    private init() {}
    
    func getData(endPoint: String, callback: @escaping (Data?) -> Void) {
        guard let myURL = URL(string: endPoint) else { return }
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: myURL) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Error durring session: \(error)")
            }
            guard let validData = data else { return }
            callback(validData)
            }.resume()
    }
}
```

#### Calls to getData

The ```getData(endPoint:callback:)``` function is called in ```viewDidLoad```:

```swift
APIRequestManager.manager.getData(endPoint: "https://api.spotify.com/v1/search?q=\(escapedString!)&type=album&limit=50") { (data: Data?) in
    if  let validData = data,
        let validAlbums = Album.albums(from: validData) {
        self.albums = validAlbums
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
}
```

The same ```getData(endPoint:callback:)``` function is called in ```tableView(_:cellForRowAt:)```:

```swift
APIRequestManager.manager.getData(endPoint: album.images[2].url.absoluteString ) { (data: Data?) in
    if  let validData = data,
        let validImage = UIImage(data: validData) {
        DispatchQueue.main.async {
            cell.imageView?.image = validImage
            cell.setNeedsLayout()
        }
    }
}
```

Note, ```setNeedsLayout``` is only needed on the built-in cell types because the image was originally
collapsed when there was no image pre-data call. It would also be unneeded if a placeholder image 
was added before the data call. It's pretty harmless to call it anyway and it will not be held against
you for calling it unnecessisarily.

Model that maps de-serialized JSON within the init.

### The Model

#### init

```swift
convenience init?(from dictionary: [String:AnyObject]) throws {
    if let name = dictionary["name"] as? String,
        let images = dictionary["images"] as? [[String:AnyObject]] {
        var imageArr = [Image]()
        for im in images {
            if let imageObj = Image(from: im) {
                imageArr.append(imageObj)
            }
            else {
                throw AlbumModelParseError.image(image: im)
            }
        }
        self.init(name: name, images: imageArr)
    }
    else {
        return nil
    }
}
```

#### Factory method 

Model class method (using the Factory pattern) to generate an array of the object. 

```swift
static func albums(from data: Data) -> [Album]? {
    var albumsToReturn: [Album]? = []
    
    do {
        let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
        
        guard let response: [String : AnyObject] = jsonData as? [String : AnyObject],
            let albums = response["albums"] as? [String: AnyObject],
            let items = albums["items"] as? [[String: AnyObject]] else {
                throw AlbumModelParseError.results(json: jsonData)
        }
        
        for albumDict in items {
            if let album = try Album(from: albumDict) {
                albumsToReturn?.append(album)
            }
        }
    }
    catch let AlbumModelParseError.results(json: json)  {
        print("Error encountered with parsing 'album' or 'items' key for object: \(json)")
    }
    catch let AlbumModelParseError.image(image: im)  {
        print("Error encountered with parsing 'image': \(im)")
    }
    catch {
        print("Unknown parsing error")
    }
    
    return albumsToReturn
}
```