# Unit 4 Quick Guide

### Key Lesson Links

- [UserDefaults](https://github.com/C4Q/AC-iOS/blob/master/lessons/unit4/UserDefaults/README.md)
- [Collection Views](https://github.com/C4Q/AC-iOS/blob/master/lessons/unit4/CollectionViews/README.md)
- [Persistence with NSKeyedArchiver / Codable](https://github.com/C4Q/AC-iOS/blob/master/lessons/unit4/Persistence-NSKeyedArchiver-Codable/README.md)
- [Custom Delegation / NSCache](https://github.com/C4Q/AC-iOS/blob/master/lessons/unit4/Protocols-Delegation-NSCache/README.md)


### Helpful Classes/Methods:

<details>
<summary>Get the URL to the Documents Directory</summary>

```swift 
// returns documents directory path for app sandbox
func documentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}
```

</details>

<details>
<summary>Returns the URL for a file path in the Documents Directory</summary>

```swift
// /documents/Favorites.plist
// returns the path for supplied name from the dcouments directory
func dataFilePath(withPathName path: String) -> URL {
    return PersistenceDatastore.manager.documentsDirectory().appendingPathComponent(path)
}
```

</details>


<details>
<summary>Save Object(s) using PropertyListEncoder</summary>

```swift 
// save to documents directory
// write to path: /Documents/
func saveToDisk() {
    let encoder = PropertyListEncoder()
    do {
        let data = try encoder.encode(favorites)
        // Does the writing to disk
        try data.write(to: dataFilePath(withPathName: PersistenceDatastore.filename), options: .atomic)
    } catch {
        print("encoding error: \(error.localizedDescription)")
    }
}
```

</details>

<details>
<summary>Load Object(s) from the Documents Directory using PropertyListDecoder</summary>

```swift 
// load from documents directory
func load() {
    // what's the path we are reading from? - PersistenceDatastore.filename
    let path = dataFilePath(withPathName: PersistenceDatastore.filename)
    let decoder = PropertyListDecoder()
    do {
        let data = try Data.init(contentsOf: path)
        favorites = try decoder.decode([Favorite].self, from: data)
    } catch {
        print("decoding error: \(error.localizedDescription)")
    }
}
```

</details>

<details>
<summary>ImageCache using NSCache</summary>

```swift
class ImageCache {
    private init(){}
    static let manager = ImageCache()
    
    private let sharedCached = NSCache<NSString, UIImage>()
    
    // get current cached image
    func cachedImage(url: URL) -> UIImage? {
        return sharedCached.object(forKey: url.absoluteString as NSString)
    }
    
    // process image and store in cache
    func processImageInBackground(imageURL: URL, completion: @escaping(Error?, UIImage?) -> Void) {
        DispatchQueue.global().async {
            do {
                let imageData = try Data.init(contentsOf: imageURL)
                let image  = UIImage.init(data: imageData)
                
                // store image in cache
                if let image = image {
                    self.sharedCached.setObject(image, forKey: imageURL.absoluteString as NSString)
                }
                
                completion(nil, image)
            } catch {
                print("image processing error: \(error.localizedDescription)")
                completion(error, nil)
            }
        }
    }
}
```

</details>


### Key Projects

| Name | Tags |
| --- | --- |
|[Persistence using Codable](https://github.com/C4Q/AC-iOS-Persistence-Codable)| Persitence/Codable/FileManager|
|[MovieSearch](https://github.com/C4Q/AC-iOS-MovieSearch-CollectionViews-FileManager)| Persistence/Codable/FileManager|
|[Custom Delegation and Image Caching](https://github.com/C4Q/AC-iOS-CatOrDog-Delegation) | Delegation/NSCache |

