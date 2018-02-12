# Reading and Writing to Firebase

## Readings
1. [Structuring Data on Firebase](https://firebase.google.com/docs/database/ios/structure-data)
https://www.simplifiedios.net/firebase-realtime-database-tutorial/
2. [Ray Wenderlich Tutorial](https://www.raywenderlich.com/139322/firebase-tutorial-getting-started-2)
3. [Good Practices in Structuring NoSQL databases](https://www.airpair.com/firebase/posts/structuring-your-firebase-data)
<!--https://learnappmaking.com/chat-app-ios-firebase-swift-xcode/-->
<!--https://www.youtube.com/watch?v=Ca9h_UUf-Hw-->
<!--https://stackoverflow.com/questions/38412337/how-to-add-model-data-objects-to-firebase-database-->
4. [Data Snapshot](https://medium.com/ncr-edinburgh/firebase-datasnapshot-to-swift-struct-3156402fc452)
<!--https://www.reddit.com/r/swift/comments/4lvbny/model_class_for_firebase/#bottom-comments-->
<!--https://www.ikiapps.com/tutorials/2017/03/01/model-objects-from-firebase-json-data-in-swift-->
<!--https://codelabs.developers.google.com/codelabs/firebase-ios-swift/#0-->


## Objectives

1. Understand how to structure data for Firebase Realtime Database
2. Understand how to write data to Firebase
3. Understand how to read data from Firebase

# 1. ¿How Do I Write to Firebase?

Firebase data is stored as JSON and synchronized in realtime to every connected client. Using the Realtime Database you can build cross-platform apps with their Android, iOS, and JavaScript SDKs where all of your clients share one database instance and automatically receive updates with the newest data.

## What is Firebase Realtime Database / Why Use It?

1. It is a NoSQL Database where data is stored in JSON Tree Structure.
2. Stored in Google’s cloud so it is available anywhere / with certain protections.
3. Updated in realtime across multiple platforms and multiple users.
4. Although the database uses a JSON tree, data stored in the database can be represented as certain native types that correspond to available JSON types to help you write more maintainable code.

Firebase takes some predetermined thinking as it relates to setting up a viable data architecture to save our pertinent information. This is a simple task for storing data that is simple but as we shall see it gets particular when you are mapping out more complex relationships and objects.

## Best Practices for Data Structure

1. Avoid Nesting Data

When you fetch data at a location in your database, you also retrieve all of its child nodes. In addition, when you grant someone read or write access at a node in your database, you also grant them access to all data under that node. Therefore, in practice, it's best to keep your data structure as flat as possible.

With data is nested, iterating through it becomes problematic and expensive.

2. Flatten Data Structures / Denormalize the Data

You want to aim for your data to be efficiently downloadable in separate calls on a needs-only basis. Instead of pulling the whole tree consider pulling only a specific node path.

3. Create Scalable Data

Start small, think large. Make data modeling decisions that support many users. Sometimes it is important to build relationships into your Firebase model that are two-way. Sometimes redundancy (perhaps in the form of storing a dictionary for all the groups a particular user is affiliated with while also storing a separate groups node containing a dictionary of its members) allows for easier access to children nodes when data scales to support more users.

# 2. Writing to Firebase

## Refresher from Yesterday

To begin, create a new XCode project.

Then, go to [https://firebase.google.com/](https://firebase.google.com/) and login.  You can login with any gmail account.  Once you are logged in, click on the button at the top labeled "Go To Console".  Click on the plus icon to create a new project.

You will be brought to a splash screen that has some guides for getting started.  Click on the iOS option and it will have you complete the four following steps:

1. Register your Bundle Identifier (in the General section under Identity when you select the topmost file).
2. Download the Google plist and drag it in directly below your Info.plist.  This contains settings that Firebase uses to set up your app.
3. Run pod init in your repo.  Open the podfile and add 'Firebase/Core' to your pods.  Run pod install, then open the xcworkspace file.
4. Navigate to your App Delegate, import Firebase, then under didFinishLaunching, add the line:

```swift
FirebaseApp.configure()
```

You are now set up to use Firebase!  We'll want a few extra Pods to make use of what Firebase has to offer, so go ahead and install:

```
pod 'Firebase/Database'
pod 'Firebase/Auth'
pod 'FirebaseStorage'
```

Let's extend what we learned yesterday to incorporate posting to our database from within the app. We are going to create a basic app that sends posts up to the Firebase cloud. This app will store a list of our favorite musical artists we felt like deserve the Grammy.

#### Building the UI

Let's create a ViewController to display all the artists that we add to our database. Drag in 2 TextFields for setting the Artist Name and the Album we're nominating. Drag a button to add the artist to the Firebase Database and a Label to display a Success message.

Next, drag a TableView into your Storyboard scene toward the bottom half. of your ViewController. Create a custom cell called GrammyArtistCell.

Connect all the Views in your ViewController.swift

(As a side note, these functions are a little repetitive.  We should probably refactor this later to be a single function.)

```swift
import UIKit

class GrammyNominationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


@IBOutlet weak var artistNameTextField: UITextField!
@IBOutlet weak var artistAlbumTextField: UITextField!
@IBOutlet weak var responseLabel: UILabel!


@IBOutlet weak var tableViewArtists: UITableView!



@IBAction func buttonAddArtist(_ sender: UIButton) {

}

override func viewDidLoad() {
super.viewDidLoad()
// Do any additional setup after loading the view, typically from a nib.
}

override func didReceiveMemoryWarning() {
super.didReceiveMemoryWarning()
// Dispose of any resources that can be recreated.
}


}
```

### Writing to Firebase Realtime Database
#### Point and Shoot
First we need to point ourselves at the location in our database at which we'd like to write. To do this we will get a reference to the artists node in our Firebase Database. If it doesn't already exist we can create a new node to add to Firebase so long as we get a reference to our database.

Add the following code to your ViewController.swift

```swift
Swift

//defining firebase reference var
var ref: DatabaseReference!


override func viewDidLoad() {
super.viewDidLoad()
// Do any additional setup after loading the view, typically from a nib.

// if we don't do this in the App Delegate we can do it here
FIRApp.configure()

//getting a reference to the Artists node in our database
ref = Database.database().reference();

}
```
Firebase data is written to a FIRDatabase reference and retrieved by attaching an asynchronous listener to the reference. The listener is triggered once for the initial state of the data and again anytime the data changes.

Let's create a function to attach to our button to actually add artists.

```swift
func addArtist(){
//generating a new key inside artists node
//and also getting the generated key
let key = ref.child("artists").childByAutoId().key

//creating artist with the given values
let artist = ["id":key,
"artistName": artistNameTextField.text! as String,
"artistAlbum": artistAlbumTextField.text! as String
]

//adding the artist inside the generated unique key
refArtists.child(key).setValue(artist)

//displaying message
labelMessage.text = "Artist Added"
}
```
`childByAutoId`  generates a unique key inside the specified reference. and `.key` returns the generated key.
For saving the value inside a specified reference node we use `setValue()` method.
Now we just need to call this function on button click.

Build and run and let's see what happens in Firebase.

We aren't able to write to our Database unless we change our rules, or else our situation with authentication.

Build out your TableView custom cells to have two labels inside that will display our Artist and Album. Drag an outlet from the labels in Storyboard to our CustomCellClass.swift

```swift
import UIKit

class GrammyNominationCell: UITableViewCell {

//labels connected
@IBOutlet weak var nameLabel: UILabel!
@IBOutlet weak var albumLabel: UILabel!

override func awakeFromNib() {
super.awakeFromNib()
// Initialization code
}

override func setSelected(_ selected: Bool, animated: Bool) {
super.setSelected(selected, animated: animated)

// Configure the view for the selected state
}

}
```
The next step would be to build a Model Object Class to reference our Artists in our TableView.

Create a class named GrammyNomination.swift and add:
```swift

class GrammyNomination {

var id: String?
var name: String?
var album: String?

init(id: String?, name: String?, album: String?){
self.id = id
self.name = name
self.album = album
}
}

```

In our ViewController.swift we will need an array to store the Artists we receive back from the Database.

Refactor your ViewController.swift to include the array and TableView logic

```swift

import UIKit

//importing firebase
import Firebase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

//defining firebase reference var
var refArtists: FIRDatabaseReference!

@IBOutlet weak var artistNameTextField: UITextField!
@IBOutlet weak var artistAlbumTextField: UITextField!
@IBOutlet weak var responseLabel: UILabel!


@IBOutlet weak var tableViewArtists: UITableView!

//list to store all the artist
var artistList = [ArtistModel]()

public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
return artistList.count
}


public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
//creating a cell using the custom class
let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GrammyNominationCell

//the artist object
let artist: GrammyNomination

//getting the artist of selected position
artist = artistList[indexPath.row]

//adding values to labels
cell.nameLabel.text = artist.name
cell.albumLabel.text = artist.album

//returning cell
return cell
}

@IBAction func buttonAddArtist(_ sender: UIButton) {
addArtist()
}

override func viewDidLoad() {
super.viewDidLoad()

FIRApp.configure()

refArtists = FIRDatabase.database().reference().child("artists");
}

func addArtist(){
//generating a new key inside artists node
//and also getting the generated key
let key = refArtists.childByAutoId().key

//creating artist with the given values
let artist = ["id":key,
"artistName": textFieldName.text! as String,
"artistGenre": textFieldGenre.text! as String
]

//adding the artist inside the generated unique key
refArtists.child(key).setValue(artist)

//displaying message
labelMessage.text = "Artist Added"
}

override func didReceiveMemoryWarning() {
super.didReceiveMemoryWarning()
// Dispose of any resources that can be recreated.
}


}
```

#### Reading Data from Firebase

Add the following to your ViewDidLoad

```swift
override func viewDidLoad() {
super.viewDidLoad()

FIRApp.configure()

refArtists = FIRDatabase.database().reference().child("artists");

//observing the data changes
refArtists.observe(FIRDataEventType.value, with: { (snapshot) in

//if the reference have some values
if snapshot.childrenCount > 0 {

//clearing the list
self.artistList.removeAll()

//iterating through all the values
for artists in snapshot.children.allObjects as! [FIRDataSnapshot] {
//getting values
let artistObject = artists.value as? [String: AnyObject]
let artistName  = artistObject?["artistName"]
let artistId  = artistObject?["id"]
let artistGenre = artistObject?["artistGenre"]

//creating artist object with model and fetched values
let artist = GrammyNomination(id: artistId as! String?, name: artistName as! String?, album: artistAlbum as! String?)

//appending it to list
self.artistList.append(artist)
}

//reloading the tableview
self.tableViewArtists.reloadData()
}
})

}
```

Because Database is different than Auth, we'll need to import Firebase/Database.  Then, we get a reference to the child node that we are interested in.

```swift
let ref = Database.database().reference().child("tasks")
```

BOOM!

---
title: "Uploading Photos to Firebase"
slug: uploading-photos-to-firebase
---

Up until now, we have interacted mainly with `FirebaseAuth` and the `Firebase Realtime Database`. Moving forward, we'll take our first look at `Firebase Storage` which is built on Google's cloud storage platform. Both _Snapchat_ and _Spotify_ are using the same _Google_ infrastructure in production. In this section you will learn how to store media, specifically photos, using Firebase. Later on, you'll also learn how to retrieve and download your media.

Let's start coding the functionality that uploads our photo to Firebase!

# Writing Media to Firebase

In most cases, writing media to Firebase includes three main steps, in addition to handling the result of the upload. Here's the simplest example from the *Firebase Storage* documentation:

```
// 1 Media Data in memory
let data = Data()

// 2 Create a reference to the file you want to upload
let riversRef = storageRef.child("images/rivers.jpg")

// 3 Upload the file to the path "images/rivers.jpg"
let uploadTask = riversRef.putData(data, metadata: nil) { (metadata, error) in
guard let metadata = metadata else {
// 4 Uh-oh, an error occurred!
return
}
// 5 Metadata contains file metadata such as size, content-type, and download URL.
let downloadURL = metadata.downloadURL
}
```

In the code above, we do the following:

1. First we need to convert our media to type `Data`
1. We need to create a relative path to the location at which we'll store our media and what we'll name the data. In this example, data is being stored in the `/images` location with a filename of `rivers.jpg`
1. With `Data` and a location to store the data, we can upload our `Data` to the location specified in the previous step
1. After the upload has completed, if there an error, we'll be able to handle it here
1. If there was no error, we'll be able to access a download URL for where our `Data` was stored

You can confirm that your data is stored in `Firebase Storage` by opening your Firebase dashboard in your browser and navigating to the `Storage` tab. Here, you'll be able to see an overview of all media files store in `Firebase Storage`. You can also view, delete and download files stored here:

![Firebase Storage Overview](assets/firebase_storage.png)

Right now your `Storage` tab should be empty because you haven't uploaded any media yet. Let's change that now!

# Adding the Upload Code

Our code will follow the same steps above to upload an image to Firebase, however, we'll add some more code to handle creating a `Post` object in our database after the upload is completed.

Our strategy for creating a new `Post` object in our database will be:

1. Upload the image to `Firebase Storage`
1. Write a new `Post` object in our database that stores the image URL returned in the previous step

You can see that our media data and database JSON object will be stored in separate Firebase services. We cannot store `Data` in the `Firebase Realtime Database`, just as we cannot store our accompanying `Post` JSON in `Firebase Storage`. Instead we'll use the `Firebase Storage` and `Firebase Realtime Database` together to build the functionality we want.

First, let's create a method that will help us upload an image to Firebase. We'll create a new service as an interface between our app and `Firebase Storage`.

> [action]
Create a new file called `StorageService.swift` in the `Services` directory:

```
import UIKit
import FirebaseStorage

struct StorageService {
// provide method for uploading images
}
```

Next we'll create a class method that will help us upload images to `Firebase Storage`. Add the following code in `StorageService.swift`:

```
static func uploadImage(_ image: UIImage, at reference: StorageReference, completion: @escaping (URL?) -> Void) {
// 1
guard let imageData = UIImageJPEGRepresentation(image, 0.1) else {
return completion(nil)
}

// 2
reference.putData(imageData, metadata: nil, completion: { (metadata, error) in
// 3
if let error = error {
assertionFailure(error.localizedDescription)
return completion(nil)
}

// 4
completion(metadata?.downloadURL())
})
}
```

Let's break down the code:

1. First we change the image from an `UIImage` to `Data` and reduce the quality of the image. It is important to reduce the quality of the image because otherwise the images will take a long time to upload and download from `Firebase Storage`. If we can't convert the image into `Data`, we return nil to the completion callback to signal something went wrong.
1. We upload our media data to the path provided as a parameter to the method.
1. After the upload completes, we check if there was an error. If there is an error, we return nil to our completion closure to signal there was an error. Our `assertFailure` will crash the app and print the error when we're running in debug mode.
1. If everything was successful, we return the download URL for the image.

## Creating a Post

Accompanying each image upload will be a new post. Let's create a new service for our `PostService`.

> [action]
Create a new `PostService.swift` source file:
>
```
import UIKit
import FirebaseStorage
import FirebaseDatabase
>
struct PostService {
>
}
```

Next let's create a static method within our new service for creating a `Post` from an image:

```
static func create(for image: UIImage) {
let imageRef = Storage.storage().reference().child("test_image.jpg")
StorageService.uploadImage(image, at: imageRef) { (downloadURL) in
guard let downloadURL = downloadURL else {
return
}

let urlString = downloadURL.absoluteString
print("image url: \(urlString)")
}
}
```

To tie things together, let's use our new service to upload a new image to `Firebase Storage`. Once the user selected an image from the `UIImagePickerController`, the `completionHandler` property of our `MGPhotoHelper` will be executed. Let's change the closure we pass to upload the image once it's selected. Open `MainTabBarController` and change the following in `viewDidLoad`:

```
photoHelper.completionHandler = { image in
PostService.create(for: image)
}
```

## Testing the Uploading Code

Now it's time to test our solution! Run the app and select an image from `UIImagePickerController`. After selecting an image, you should see the following in your debug console:

![Debug Output](assets/debug_output.png)

The first time you try to run your app, an error may cause your app to crash. If so, re-run your app and try again. If it keeps crashing, backpedal through the previous steps to make sure you're not missing any code.

To confirm our image upload worked, we can check our Firebase dashboard. Open your Firebase project overview in your browser and click the `Storage` tab. You should see `test_image.jpg` in the root directory of your `Firebase Storage`:

![Test Image](assets/stored_test_image.png)

If you select the checkbox, you can download the image and confirm that it is the same image you uploaded previously:

![Download Image](assets/download_image.png)

# Conclusion

**Congratulations!** This means you have successfully uploaded data to Firebase!

Right now we are only uploading the image file, however we'll also need to create a `Post` object in our database so we can store other related information such as which user owns the post.

In the next section we will move from this very simple upload code to a more mature solution for creating new posts.


