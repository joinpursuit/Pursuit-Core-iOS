# Unit 4 Quick Guide

### Key Lesson Links

- [UserDefaults](https://github.com/C4Q/AC-iOS/blob/master/lessons/unit4/UserDefaults/README.md)
- [Collection Views](https://github.com/C4Q/AC-iOS/blob/master/lessons/unit4/CollectionViews/README.md)
- [Persistence with NSKeyedArchiver / Codable](https://github.com/C4Q/AC-iOS/blob/master/lessons/unit4/Persistence-NSKeyedArchiver-Codable/README.md)
- [Custom Delegation / NSCache](https://github.com/C4Q/AC-iOS/blob/master/lessons/unit4/Protocols-Delegation-NSCache/README.md)
- [UIImagePickerController](https://github.com/C4Q/AC-iOS/blob/master/lessons/unit4/ImagePicker/README.mdown)
- [Subclassing UIViews and Nibs (Xibs)](https://github.com/C4Q/AC-iOS/blob/master/lessons/unit4/SubclassingUIViewsAndNibs(Xibs)/README.md)  
- [Intro to Programmatic View Layout](https://github.com/C4Q/AC-iOS/tree/master/lessons/unit4/IntroductionToProgrammaticUI)  
- [Programmable View Management Continued](https://github.com/C4Q/AC-iOS/tree/master/lessons/unit4/Programmatic-View-Management)  
- [UIKit Animation](https://github.com/C4Q/AC-iOS/tree/master/lessons/unit4/Animations)  
- [Core Animation](https://github.com/C4Q/AC-iOS/blob/master/lessons/unit4/Animations/CoreAnimation.md)  
- [Debugging Workshop](https://github.com/C4Q/AC-iOS/blob/master/lessons/unit4/Debugging%20Workshop.md)  


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
<summary>Save Object(s) using <a href="https://developer.apple.com/documentation/foundation/propertylistencoder">PropertyListEncoder</a></summary>

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
<summary>Load Object(s) from the Documents Directory using <a href="https://developer.apple.com/documentation/foundation/propertylistencoder">PropertyListEncoder</a>PropertyListDecoder</summary>

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
    <summary>ImageCache using <a href="https://developer.apple.com/documentation/foundation/nscache">NSCache</a></summary>

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

<details>
<summary>Using <a href="">https://developer.apple.com/documentation/quartzcore/caanimationgroup</a> to animate the shadowOpacity and shadowOffset of a layer</summary>

```swift 
func animateShadow() {
    // animate shadowOpacity
    // default opacity is 0
    let opacityAnimation = CABasicAnimation(keyPath: "shadowOpacity")
    opacityAnimation.fromValue = 0 // minimum value
    opacityAnimation.toValue = 1 // maximum value

    // final value is not on by default
    // you have to explicity set the final value if you need it to stick
    imageView.layer.shadowOpacity = 1


    // animate the shadow offset
    // default is CGSize.zero
    let offsetAnimation = CABasicAnimation(keyPath: "shadowOffset")
    offsetAnimation.fromValue = CGSize.zero
    offsetAnimation.toValue = CGSize(width: 5.0, height: 5.0)
    imageView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)

    // create group animation for shadow animation
    let groupAnimation = CAAnimationGroup()
    groupAnimation.animations = [opacityAnimation, offsetAnimation]
    groupAnimation.duration = 1.0 
    imageView.layer.add(groupAnimation, forKey: nil)
}
```

</details>

<details>
<summary>Using <a href="https://developer.apple.com/documentation/quartzcore/cabasicanimation">CABasicAnimation</a> to animate a rotation in the 3D plane</summary>

```swift 
func animateRotationX() {
    let animation = CABasicAnimation(keyPath: "transform.rotation.x")
    let angleRadian = CGFloat(2.0 * .pi) // 360
    animation.fromValue = 0 // degrees
    animation.byValue = angleRadian
    animation.duration = 5.0 // seconds
    animation.repeatCount = Float.infinity
    imageView.layer.add(animation, forKey: nil)
}
```

</details>

<details>
<summary>3D Translation using <a href="">CAKeyframeAnimation</a></summary>

```swift 
// 3D Translation using CAKeyframeAnimation
func animateTranslation() {
    let toTopLeft = CATransform3DMakeTranslation(-view.layer.position.x, -view.layer.position.y, 0)     // top left
    let toBottomRight = CATransform3DMakeTranslation(view.layer.position.x, view.layer.position.y, 0)   // bottom right
    let toTopRight = CATransform3DMakeTranslation(view.layer.position.x, -view.layer.position.y, 0)     // top right
    let toBottomLeft = CATransform3DMakeTranslation(-view.layer.position.x, view.layer.position.y, 0)   // bottom left
    let keyframeAnimation = CAKeyframeAnimation(keyPath: "transform")
    keyframeAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    keyframeAnimation.values = [CATransform3DIdentity,
                                toTopLeft,
                                CATransform3DIdentity,
                                toTopRight,
                                CATransform3DIdentity,
                                toBottomLeft,
                                CATransform3DIdentity,
                                toBottomRight,
                                CATransform3DIdentity]
    keyframeAnimation.duration = 4.0
    keyframeAnimation.repeatCount = Float.infinity
    imageView.layer.add(keyframeAnimation, forKey: nil)
}
```

</details>


### Key Projects

| Name | Tags |
| --- | --- |
|[Persistence using Codable](https://github.com/C4Q/AC-iOS-Persistence-Codable)| Persitence/Codable/FileManager|
|[MovieSearch](https://github.com/C4Q/AC-iOS-MovieSearch-CollectionViews-FileManager)| Persistence/Codable/FileManager|
|[Custom Delegation and Image Caching](https://github.com/C4Q/AC-iOS-CatOrDog-Delegation) | Delegation/NSCache |
|[Nib Demo](https://github.com/C4Q/AC-iOS-NibDemo)|Custom Nibs|
|[Fellows](https://github.com/C4Q/AC-iOS-Fellows)|Programmable View Management|  
|[Collection View Introduction Project with MTG Cards](https://github.com/C4Q/AC-iOS-CollectionViews-Introduction)|Collection Views|
|[Core Animation Demo App](https://github.com/C4Q/AC-iOS-CoreAnimationApp)| CoreAnimation|
