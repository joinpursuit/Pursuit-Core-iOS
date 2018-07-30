## FileManger - Saving Images to Documents Folder 

[In Class Demo Project - MovieSearch](https://github.com/C4Q/AC-iOS-MovieSearch-CollectionViews-FileManager)  

## Objectives
* What is the FileManager? 
* Get the Documents Directory Path 
* Create a path to save your image 
* Create a Data representation of the image using UIImagePNGRepresentation or UIImageJPEGRepresentation
* Save and Retrieve a stored Image 

## FileManager
A FileManager object lets you examine the contents of the file system and make changes to it. The FileManager class provides convenient access to a shared file manager object that is suitable for most types of file-related manipulations. A file manager object is typically your primary mode of interaction with the file system. You use it to locate, create, copy, and move files and directories. You also use it to get information about a file or directory or change some of its attributes.
[read more from the Apple Docs](https://developer.apple.com/documentation/foundation/filemanager)

Use UIImagePNGRepresentation to convert the file to data and write to the file path 
```swift
let imageData = UIImagePNGRepresentation(image)! // image is of type UIImage
let imageURL = PersistenceStoreManager.manager.dataFilePath(withPathName: filepath) // filepath to use
try! imageData.write(to: imageURL)
```

Read the file stored back to the app 
```swift 
let imageURL = PersistenceStoreManager.manager.dataFilePath(withPathName: filepath) // the name used when saving
let newImage = UIImage(contentsOfFile: imageURL.path)!
```

Replace a file in the documents folder 
```swift
let oldImageURL = PersistenceStoreManager.manager.dataFilePath(withPathName: artworkPath)
let newImageURL = PersistenceStoreManager.manager.dataFilePath(withPathName: bakingPath)
do {
    let _ = try FileManager.default.replaceItemAt(oldImageURL, withItemAt: newImageURL)
} catch {
    print("error removing: \(error.localizedDescription)")
}
```

Remove the file from the Documents directory 
```swift
let imageURL = PersistenceStoreManager.manager.dataFilePath(withPathName: artworkPath)
do {
    try FileManager.default.removeItem(at: imageURL)
} catch {
    print("error removing: \(error.localizedDescription)")
}
```

## Resources 
[JPG vs PNG](https://www.digitaltrends.com/photography/jpeg-vs-png-photo-format/)  
[UIImageJPEGRepresentation](https://developer.apple.com/documentation/uikit/1624115-uiimagejpegrepresentation)  
[UIImagePNGRepresentation](https://developer.apple.com/documentation/uikit/1624096-uiimagepngrepresentation)  
[FileManager](https://developer.apple.com/documentation/foundation/filemanager)
