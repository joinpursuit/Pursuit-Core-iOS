## Persisting Custom Objects to Documents Directory

[UserDefaults](https://developer.apple.com/documentation/foundation/userdefaults) is a persistence mechanism for saving app data. However Apple strongly recommends that we only use it to store simple data e.g a background theme for an app, position on a slider, media playback speed, units of measurement. UserDefaults also works with primarily property list objects such as String, Data, Date, URL. Custom objects e.g a Person object are best persisted to disk using the FileManager or Core Data along with some other utility classes. 

## Vocabulary 

- [FileManager](https://developer.apple.com/documentation/foundation/filemanager)  
- [PropertyListEncoder](https://developer.apple.com/documentation/foundation/propertylistencoder)  
- [PropertyListDecoder](https://developer.apple.com/documentation/foundation/propertylistdecoder)  
- [PropertyList](https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/PropertyList.html)  

## Readings 

[File System Basics](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html)  

- Documents/ Use this directory to store user-generated content
- Library/ Your app should not use these directories for user data files
- tmp/ Use this directory to write temporary files that do not need to persist between launches of your app

## Helper class that encapsulates FileManager access to the app sandbox 

```swift 
final class DataPersistenceManager {
  static func documentsDirectory() -> URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
  }
  
  static func cachesDirectory() -> URL {
    return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
  }
  
  static func filePathFromDocumentsDirectory(filename: String) -> URL {
    return documentsDirectory().appendingPathComponent(filename)
  }
  
  static func filePathFromCachesDirectory(filename: String) -> URL {
    return cachesDirectory().appendingPathComponent(filename)
  }
}
```

## Helper method to get the path of the Documents directory 

```swift 
static func documentsDirectory() -> URL {
  return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
}
```

## Helper method to get the path of a file in the Documents directory

```swift 
static func filePathFromDocumentsDirectory(filename: String) -> URL {
  return documentsDirectory().appendingPathComponent(filename)
}
```

## Custom Object 

- custom object needs to conform to Codable to work with PropertyListEncoder and PropertyListDecoder respectively

```swift 
struct User: Codable {
  let name: String
  let theme: String
  let githubImageURL: String
}
```

## Save to the Documents directory

**Filename**   

```let propertyListFilename = "File.plist"```

- Using FileManager to write to a path in the documents directory 
- Using PropertyListEncode to convert our custom object to data for saving in the documents directory

```swift 
let user = User.init(name: "Alex Paul",
                     theme: "darkMode",
                     githubImageURL: "https://avatars2.githubusercontent.com/u/1819208?s=460&v=4")
do {
  let data = try PropertyListEncoder().encode(user)
  let url = DataPersistenceManager.filePathFromDocumentsDirectory(filename: propertyListFilename)
  try data.write(to: url, options: Data.WritingOptions.atomic)
} catch {
  print("writing error: \(error)")
}
```

## Read file from the Documents Directory 

- Using FileManager to access the file path
- Using PropertyListDecoder to decode the data from the file to our custom object 

```swift 
if FileManager.default.fileExists(atPath: path) {
  do {
    if let data = FileManager.default.contents(atPath: path) {
      let user = try PropertyListDecoder().decode(User.self, from: data)
      print("user github is \(user.githubImageURL)")
    } else {
      // data is nil
    }
  } catch {
    print("reading error: \(error)")
  }
}
```
