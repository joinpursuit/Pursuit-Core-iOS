## NSKeyedArchiver and Persistence 
## Objectives 
1. Persistence review 
2. Archive an Ojbect using NSKeyedArchiver
3. Unarchive an Object using NSKeyedUnarchiver 

## Why should we use a class like NSKeyedArchiver over UserDefaults for persistence? 
UserDefaults is ideal for storing settings relating to the user's prefernce. For example your app may want to change it's default font, background color, the view controller last visited. Those settings would be ideal to be stored in UserDefaults. Apple recommends that UserDefaults be used for such settings alone and not your apps core content. The content your users store from objects created in your app should be persisted to the file system using a different type of persistence. Such a persistence class would create a path to the documents folder in the apps sandbox. That brings us to NSKeyedArchiver. 

NSKeyedArchiver is a preferred choice for storing your apps content over UserDefaults as stated above. With NSKeyedArchiver you are able to create a path to the apps sandbox for storing and retrieving your apps data. NSKeyedArchiver packages your object for saving using the NSKeyedArchiver class. When you app is loaded and needs to reaccess that stored data this is done using NSKeyedUnarchiver. Again to reiterate UserDefaults should be used for simple data storage that's particular to the user. The limit for this storage is not available for the developer. However if you store large amounts of data in your app using UserDefaults it will slow the launch process.  

##
## Resources 
1. [File System Basics](https://developer.apple.com/library/content/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html)
2. [NSKeyedArchiver](https://developer.apple.com/documentation/foundation/nskeyedarchiver)
3. [Persist Data](https://developer.apple.com/library/content/referencelibrary/GettingStarted/DevelopiOSAppsSwift/PersistData.html)

<img src="https://developer.apple.com/library/content/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/art/ios_app_layout_2x.png" width="600" height="600"/>

## Further Reading 
1. [NSCoding/NSKeyedArchiver](http://nshipster.com/nscoding/)
2. [UserDefaults](https://developer.apple.com/documentation/foundation/userdefaults)

**To make your Model compliant for being used by NSKeyedArchiver, the class needs to subclass NSObject and NSCoding**
```swift
class DSA: NSObject, NSCoding {}
```

**Implementation of the encoder's init** 
```swift 
func encode(with aCoder: NSCoder) {
  aCoder.encode(title, forKey: DSAPropertyKey.title.rawValue)
  aCoder.encode(dsaDescription, forKey: DSAPropertyKey.description.rawValue)
}
```

**Implementation of the decoder's init**
Since our class is allowing subclassing the convenience initializer here must be marked required. If we were to mark the class ```swift final ``` then we would not have to mark the init required in that case . 
```swift 
required convenience init?(coder aDecoder: NSCoder) {
  guard let title = aDecoder.decodeObject(forKey: DSAPropertyKey.title.rawValue) as? String,
        let description = aDecoder.decodeObject(forKey: DSAPropertyKey.description.rawValue) as? String
        else { return nil }
  self.init(title: title, description: description)
}
```

**Designated Initializer** 
```swift 
init(title: String, description: String) {
  self.title = title
  self.dsaDescription = description
}
```

**We need to create a path to store our archived document**
```swift 
func dataFilePath(withPathName path: String) -> URL {
  return DataModel.shared.documentsDirectory().appendingPathComponent(path)
}
```

**Saving the DSA List to storage**
```swift 
func saveDSAList(lists: [DSA]) {
  let path = DataModel.shared.dataFilePath(withPathName: DataModel.kPathname).path
  NSKeyedArchiver.archiveRootObject(lists, toFile: path)
  print(documentsDirectory())
}
```

**Loading the DSA List from storage**
```swift 
func load() -> [DSA] {
  let path = DataModel.shared.dataFilePath(withPathName: DataModel.kPathname).path
  var dsaLists = [DSA]()
  if let lists = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? [DSA] {
      dsaLists = lists
  }
  return dsaLists
}
```

## Miscellaneous New Topics  
In the DSA app we can delete an item from our table view. First the item must be removed from our list array then update the table view. The following datasource method is used for this action: 
```swift 
func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
  dsaLists.remove(at: indexPath.row)
  tableView.deleteRows(at: [indexPath], with: .automatic)
}
```

So far we have seen segueing to a View Controller using a push segue. A next form of segue is the modal segue. The DSA app is using a modal segue to present the EditViewController. In order to gain access to a navigation bar in a model view controller. The modal view controller need to be embedded in a Navigation Controller.

Here we are dismissing the modal view controller that was presented using the Navigation Controller 
```swift 
navigationController?.dismiss(animated: true, completion: nil)
```

**Reading** 
[Initialization](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html)
[What are convenience required initializers](https://stackoverflow.com/questions/26922694/what-are-convenience-required-initializers-in-swift)
[Using Segues](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/UsingSegues.html)

## The New Hotness which is Codable in Swift 4
[Persistence using Codable](https://github.com/alexpaul/LessonDrafts/blob/master/CodablePersistence.md)

## Persistence using Codable

## Objectives 
1. Encoding an Object to the Persistence store 
2. Decoding an Object to Persistence

## Resources 
1. [Review on the Codable class introduced in Swift 4](https://developer.apple.com/documentation/swift/codable)

## Further Reading 
1. [Networking and Persistence with JSON in Swift 4 (Part 1)](https://medium.com/@sdrzn/networking-and-persistence-with-json-in-swift-4-c400ecab402d) 

_Making a class Codable for Encoding and Decoding from Persistence_
```swift 
class DSA: Codable {}
```

_Encoding an Ojbect and writing it to the Persistence store using **PropertyListEncoder()**_
```swift
func saveDSAList() {
    let encoder = PropertyListEncoder()
    do {
        let data = try encoder.encode(lists)
        try data.write(to: dataFilePath(withPathName: DataModel.kPathname), options: .atomic)
    } catch {
        print("error encoding items: \(error.localizedDescription)")
    }
}
```
_Decoding an Ojbect to use in our app using **PropertyListDecoder()**_
```swift 
func load() {
    let path = dataFilePath(withPathName: DataModel.kPathname)
    let decoder = PropertyListDecoder()
    do {
        let data = try Data.init(contentsOf: path)
        lists = try decoder.decode([DSA].self, from: data)
    } catch {
        print("error decoding items: \(error.localizedDescription)")
    }
}
```

##
## Exercises 

Use the Pixabay API to search for and favorite photos  
**Endpoint:** ```https://pixabay.com/api/?key={YOUR API KEY GOES HERE}&q=```
If you don't have a Pixabay API key, you can sign up here: https://pixabay.com/en/service/about/api/

* Create a Tab Bar View Based Application 
* In the first view controller there should be a search bar to search for photos
* Use a datail view controller to show more details about a selected photo
* Use a UIControl e.g UIButton to favorite a Photo
* This favorite Photo Object should be saved to the Documents folder using Codable, in which case the url would be a property
* Other useful properties of a Photo Object would be: tags, previewURL, webformatURL
* Photo Objects favorited should be able to persist through launches of the application 
* The user should be able to add and delete a favorite Photo

## Advanced
* Can share a favorite photo using a the built in iOS Share Sheet
[Using a UIActivityViewController](https://www.hackingwithswift.com/example-code/uikit/how-to-share-content-with-uiactivityviewcontroller)
