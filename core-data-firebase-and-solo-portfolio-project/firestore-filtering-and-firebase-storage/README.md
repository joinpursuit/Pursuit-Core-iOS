# Advanced Firestore and Firebase Storage

## Objectives

- Understand how to manipulate and customize persisted Firestore documents.
- Understand how to store media files using Firebase Storage

# 1. Refresher on Firestore and  Document Stores

A **Document Store** is a way of organizing information for storage.  It is a kind of *key-value store*.  To use a document store, you create different *collections* for each of your model objects. Each document is essentially a dictionary, and should have keys named for the object's properties, which map to their values.

**Cloud Firestore** is Firebase's flagship database for mobile app development. Cloud Firestore features rich, fast queries and scales well. It is a `NoSQL` database, which means that the database doesn't have tables that relate data.  Instead, it acts as a big key-value store.

# 2. Getting Firestore Data

To this point, we have used Firestore to create entries in collections and read back entire collections. For example, in the previous lesson we created `post` objects in a Firestore collection, and fetched the entire collection of `posts` to use in our app.

<details>
<summary> Posts model and firestore methods </summary> 

```swift
import Foundation

struct Post {
    let title: String
    let body: String
    let uuid: UUID
    let userUID: String
    let commentCount: Int = 0

    init(title: String, body: String, userUID: String) {
        self.title = title
        self.body = body
        self.uuid = UUID()
        self.userUID = userUID
    }
    ...
}

//New File
import FirebaseFirestore

class FirestoreService {

    // MARK:- Static Properties

    static let manager = FirestoreService()

    // MARK:- Internal Properties

    func getPosts(onCompletion: @escaping (Result<[Post], Error>) -> Void) {
        db.collection("posts").getDocuments() { (querySnapshot, err) in
            if let err = err {
                onCompletion(.failure(err))
            } else {
                let posts = querySnapshot!.documents.compactMap { (snapShot) -> Post? in
                    guard let uuid = UUID(uuidString: snapShot.documentID) else { return nil }
                    return Post(from: snapShot.data(), andUUID: uuid)
                }
                onCompletion(.success(posts))
            }
        }
    }

    func create(_ user: PersistedUser, onCompletion: @escaping (Result<Void, Error>) -> Void) {
        db.collection("users").document(user.uid).setData(user.fieldsDict) { err in
            if let err = err {
                onCompletion(.failure(err))
            } else {
                onCompletion(.success(()))
            }
        }
    }

    func create(_ post: Post, onCompletion: @escaping (Result<Void, Error>) -> Void) {
        db.collection("posts").document(post.uuidStr).setData(post.fieldsDict) { err in
            if let err = err {
                onCompletion(.failure(err))
            } else {
                onCompletion(.success(()))
            }
        }
    }

    // MARK:- Private Properties

    private let db = Firestore.firestore()
}
```
</details>


Our `getPosts` function will return to us all the documents in a collection called "posts" that is stored in Firestore.  It calls the `getDocuments` function on a `FIRCollectionReference` (`db.collection("posts")`), which looks at the collection and returns a snapshot object that includes all the documents.


# 3. Specifying Firestore Requests


In a real-world application, we want our server to be able to provide us with precise and specific information from our collections. Let's say we went to a given user's profile, and wanted to see only their posts. We could add a [whereField filter](https://firebase.google.com/docs/firestore/query-data/queries#simple_queries) to the collection in order to look only for posts were created by one specific user. This query is akin to a Swift `filter(by:)` array function. To whit: 

```swift
func getPosts(for userID: String, completion: @escaping (Result<[Post], Error>) -> ()) {
    db.collection("posts").whereField("userUID", isEqualTo: userID).getDocuments { (snapshot, error) in
        if let error = error {
            completion(.failure(error))
        } else {
            let posts = snapshot?.documents.compactMap({ (snapshot) -> Post? in
                let postID = snapshot.documentID
                let post = Post(from: snapshot.data(), id: postID)
                return post
            })
            completion(.success(posts ?? []))
        }
    }
}
```

This new `getPosts(for userID)` function returns all "posts" created by one specific user. This function also calls a `getDocuments` Firestore function that we saw before. However, this time `getDocuments` is being called on a `FIRQuery` object, which is the result of chaining a query on a document collection. 

We can filter information on multiple criteria using [compound queries](https://firebase.google.com/docs/firestore/query-data/queries#compound_queries) that are chained together. The resultant object is still a `FIRQuery`, so we can call `getDocuments` on it and end up using the same completion handler. 

We can also order our data chaining an [`order(by:)`](https://firebase.google.com/docs/firestore/query-data/order-limit-data) function on a collection. This is similar to a Swift `sorted(by:)` array function! Let's say we wanted to sort posts from most-commented to least-commented:

```swift
func getMostPopularPosts(completion: @escaping (Result<[Post], Error>) -> ()) {
db.collection("posts").order(by: "commentCount", descending: true).getDocuments { (snapshot, error) in
        if let error = error {
            completion(.failure(error))
        } else {
            let posts = snapshot?.documents.compactMap({ (snapshot) -> Post? in
                let postID = snapshot.documentID
                let post = Post(from: snapshot.data(), id: postID)
                return post
            })
            completion(.success(posts ?? []))
        }
    }
}
```

The `order(by:)` method provides us with an `FIRQuery`, so again we can use the same completion handler to parse out posts. The documents in our snapshot will be ordered from highest comment count to lowest, and so the completion block returns an array of posts that is sorted!


# 4. Firebase Storage

Firestore can be used to store much of the information that we'll need in our apps. It supports [many data types](https://firebase.google.com/docs/firestore/manage-data/data-types). However, like most servers, it is not set up to hold and make available large files. This is where Firebase Storage comes in.

On server applications, storage like Firebase Storage or Amazon S3 is used for large files that do not fit the native types that would be used on a client app. These include media such as .mp4 and .png files, as well as .csv and other file types. When we need an actual file, as opposed to a value such as a string or a number, we will put that into Firebase Storage.

# 5. Writing to Firebase Storage

We can import Firebase Storage installing the pod `Firebase/Storage` and then importing `FirebaseStorage` in the file we are creating our Storage functions in.

Much like with Firestore, we want to know where we'll be writing our files to. Luckily, after importing the framework, we can make use of the simplicity of Firebase's storage types

```swift

class FirebaseStorageService {
    static var manager = FirebaseStorageService()
    
    private let storage: Storage!
    private let storageReference: StorageReference
    private let imagesFolderReference: StorageReference
    
    private init() {
        storage = Storage.storage()
        storageReference = storage.reference()
        imagesFolderReference = storageReference.child("images")
    }
    [...]
```

As with Firestore and Firebase Auth, Firebase Storage will read where it should store files based on our `GoogleService-Info.plist` file, and so the only configuration we need to do will be to get a reference to that specific location. Once we have that reference, we can specify that we want to save images in a child called "images." Think of this child as a subfolder - /SomeImaginaryPathToStorage/images that will be a nice, organized place to hold images.

To actually store the image, we must first convert it to a `Data` type using the `UIImage.jpegData()` function. We can then add that object to storage by first giving it a unique location, and then adding our `Data` object to that location.

```swift
    [...]
    func storeImage(image: Data,  completion: @escaping (Result<URL,Error>) -> ()) {
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        let uuid = UUID()
        let imageLocation = imagesFolderReference.child(uuid.description)
        imageLocation.putData(image, metadata: metadata) { (responseMetadata, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                //Try to get the actual URL for our image
                imageLocation.downloadURL { (url, error) in
                    guard error == nil else {completion(.failure(error!));return}
                    //MARK: TODO - set up custom app errors
                    guard let url = url else {completion(.failure(error!));return}
                    completion(.success(url))
                }
            }
        }
    }
}
```

