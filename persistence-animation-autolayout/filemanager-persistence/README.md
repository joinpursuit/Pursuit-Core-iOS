# Persisting Custom Objects to Documents Directory

## Objectives

- Understand how data is persisted to the documents directory
- Serialize data for storage
- Store data to the documents directory
- Read data from the documents directory


## Readings  

- [FileManager](https://developer.apple.com/documentation/foundation/filemanager)  
- [PropertyListEncoder](https://developer.apple.com/documentation/foundation/propertylistencoder)  
- [PropertyListDecoder](https://developer.apple.com/documentation/foundation/propertylistdecoder)  
- [PropertyList](https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/PropertyList.html)  
- [File System Basics](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html)  

# 1. Why UserDefaults isn't good enough

[UserDefaults](https://developer.apple.com/documentation/foundation/userdefaults) is a persistence mechanism for saving app data. However Apple strongly recommends that we only use it to store simple data e.g a background theme for an app, position on a slider, media playback speed, units of measurement. UserDefaults also works with primarily property list objects such as String, Data, Date, URL.

Storing too much data in UserDefaults can cause slowdown when launching your application and it can be more challenging to store custom objects and collections.

To solve these problems, we will instead persist these custom objects to disk using the `FileManager`.

# 2. The App Sandbox

When a user downloads your app onto their phone, it allocates extra storage space for you to save information.  Users can choose to set the amount of space that your phone can save data to.  This `sandbox` means that you have unrestricted access to a set aside block of memory on the phone, and cannot access other areas without special permissions.  This makes it much safer for the user, because they know that your app won't be able to access other apps (e.g contacts, mail) without permission.

![Apple Sandbox](https://developer.apple.com/library/archive/documentation/Security/Conceptual/AppSandboxDesignGuide/Art/about_sandboxing.png)

Just like you can access and save files on your laptop, you can access and save files onto the phone of users who have downloaded your app.

![Fire storage](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/art/ios_app_layout_2x.png)

# 3. Accessing the Documents Directory

We can access the documents directory to load and save data.  The `FileManager` class provides an interface for getting the URL to the documents directory.  The URL here is an offline one and refers to a location on the user's phone.

```swift
func documentsDirectory() -> URL {
  return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
}
```

```swift
func filePathFromDocumentsDirectory(filename: String) -> URL {
  return documentsDirectory().appendingPathComponent(filename)
}
```

Sample usage:

```swift
let usersURL = filePathFromDocumentsDirectory(filename: "users.json")
```

# 4. Serializing Data

Now that we can access the URL for the documents directory, we want to store data to it.  There are two aspects that we need to save data:

- Serialize the data
- Persist the data

*Serializing data* means putting it into a format that can be saved.  There are many different formats that can be used to serialize data including:

- Keyed Archive
- XML
- JSON
- plist

There are differences between each in terms of speed and performance, but it is most important that you can find one way to persist information.  We'll start by storing data in plist format using `PropertyListEncoder`

```swift
import Foundation

struct Person: Codable {
    let name: String
    let birthday: Date
}

func getDate(from str: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.date(from: str) ?? Date.distantPast
}

let applePeople = [
    Person(name: "Steve Jobs", birthday: getDate(from: "1955-02-24")),
    Person(name: "Steve Wozniak", birthday: getDate(from: "1950-08-11")),
    Person(name: "Tim Cook", birthday: getDate(from: "1960-11-01"))
]

do {
    let serializedApplePeople = try PropertyListEncoder().encode(applePeople)
} catch {
    print("Error serializing to property list: \(error)")
}
```

# 5. Storing Data

Now that we have serialized data, we can save it to the documents directory:

```swift
import Foundation

func documentsDirectory() -> URL {
  return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
}

func filePathFromDocumentsDirectory(filename: String) -> URL {
  return documentsDirectory().appendingPathComponent(filename)
}

struct Person: Codable {
    let name: String
    let birthday: Date
}

func getDate(from str: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.date(from: str) ?? Date.distantPast
}

let applePeople = [
    Person(name: "Steve Jobs", birthday: getDate(from: "1955-02-24")),
    Person(name: "Steve Wozniak", birthday: getDate(from: "1950-08-11")),
    Person(name: "Tim Cook", birthday: getDate(from: "1960-11-01"))
]

do {
    let serializedApplePeople = try PropertyListEncoder().encode(applePeople)
    let url = filePathFromDocumentsDirectory(filename: "applePeople.plist")
    try serializedApplePeople.write(to: url, options: Data.WritingOptions.atomic)
} catch {
    print("Error serializing to property list: \(error)")
}

```

# 6. Accessing stored stored data

To access stored data, we'll need to read the data from the saved URL, then decode it back into a Swift object:

```swift
import Foundation

func documentsDirectory() -> URL {
  return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
}

func filePathFromDocumentsDirectory(filename: String) -> URL {
  return documentsDirectory().appendingPathComponent(filename)
}

struct Person: Codable {
    let name: String
    let birthday: Date
}

func getDate(from str: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.date(from: str) ?? Date.distantPast
}

let applePeople = [
    Person(name: "Steve Jobs", birthday: getDate(from: "1955-02-24")),
    Person(name: "Steve Wozniak", birthday: getDate(from: "1950-08-11")),
    Person(name: "Tim Cook", birthday: getDate(from: "1960-11-01"))
]

do {
    let serializedApplePeople = try PropertyListEncoder().encode(applePeople)
    let url = filePathFromDocumentsDirectory(filename: "applePeople.plist")
    try serializedApplePeople.write(to: url, options: Data.WritingOptions.atomic)
} catch {
    print("Error serializing to property list: \(error)")
}

let url = filePathFromDocumentsDirectory(filename: "applePeople.plist")

if FileManager.default.fileExists(atPath: url.path) {
  do {
    if let data = FileManager.default.contents(atPath: url.path) {
      let people = try PropertyListDecoder().decode([Person].self, from: data)
      print(people)
    } else {
      print("No data saved")
    }
  }
  catch {
    print("Decoding error: \(error)")
  }
}
```

# 7. Building a wrapper:

Like with all of our services so far, it will save time to build a custom wrapper around FileManager.  This can help us avoid hardcoding the path name and make it easier for us to debug problems when they arise.

```swift
import Foundation

struct PersistenceHelper<T: Codable> {
    func getObjects() throws -> [T] {
        guard let data = FileManager.default.contents(atPath: url.path) else {
            return []
        }
        return try PropertyListDecoder().decode([T].self, from: data)
    }

    func save(newElement: T) throws {
        var elements = try getObjects()
        elements.append(newElement)
        let serializedData = try PropertyListEncoder().encode(elements)
        try serializedData.write(to: url, options: Data.WritingOptions.atomic)
    }

    init(fileName: String) {
        self.fileName = fileName
    }

    private let fileName: String

    private var url: URL {
        return filePathFromDocumentsDirectory(filename: fileName)
    }

    private func documentsDirectory() -> URL {
       return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
     }

     private func filePathFromDocumentsDirectory(filename: String) -> URL {
       return documentsDirectory().appendingPathComponent(filename)
     }
}

struct PersonPersistenceHelper {
    static let manager = PersonPersistenceHelper()

    func save(newPerson: Person) throws {
        try persistenceHelper.save(newElement: newPerson)
    }

    func getPeople() throws -> [Person] {
        return try persistenceHelper.getObjects()
    }

    private let persistenceHelper = PersistenceHelper<Person>(fileName: "people.plist")

    private init() {}
}


struct Person: Codable {
    let name: String
    let birthday: Date
}

func getDate(from str: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.date(from: str) ?? Date.distantPast
}

let applePeople = [
    Person(name: "Steve Jobs", birthday: getDate(from: "1955-02-24")),
    Person(name: "Steve Wozniak", birthday: getDate(from: "1950-08-11")),
    Person(name: "Tim Cook", birthday: getDate(from: "1960-11-01"))
]

do {
    for person in applePeople {
        try PersonPersistenceHelper.manager.save(newPerson: person)
    }
    print(try PersonPersistenceHelper.manager.getPeople() )
} catch {
    print(error)
}
```
