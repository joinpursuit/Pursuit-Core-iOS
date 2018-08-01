# Core data - Intro

## [Repo](https://github.com/C4Q/AC-iOS-CoreDataIntroDemo)

## Readings

1. [cocoacasts - What is Core Data?](https://cocoacasts.com/what-is-core-data)
2. [cocoawithlove - Why is Core Data not a database?](https://www.cocoawithlove.com/2010/02/differences-between-core-data-and.html)
3. [rollout.io - iOS database options](https://rollout.io/blog/ios-databases-sqllite-core-data-realm/)

## Objectives

1. Articulate what Core Data is, and why it is useful
2. Build a Managed Object Context using both to-one and to-many relationships
3. Store and fetch entities


# 1. Why Core Data?

Core Data is another type of local persistence.  Similar to File Manager, we can use Core Data to store objects directly to the phone.  So what can Core Data do that saving arrays to File Manager can't?

The biggest difference is that Core Data can manage **relationships** between objects.  An example will help illustrate this.

Imagine that you are building an app that has Users and Posts.  Every User is associated with an array of Posts and every Post has a User that posted it.  How would we store this information using File Manager?

We could try something like this:


```
var users = [User]()
var posts = [Post]()

let userOne = User(name: "Ann")
let userTwo = User(name: "Bob")

let postOne = Post(text: "Text A", user: userOne)
let postTwo = Post(text: "Text B", user: userOne)
let postThree = Post(text: "Text C", user: userTwo)
let postFour = Post(text: "Text D", user: userTwo)
let postFive = Post(text; "Text E", user: userTwo)

users = [userOne, userTwo]
posts = [postOne, postTwo, postThree, postFour, postFive]

FileManagerHelper.save(users)
FileManagerHelper.manager.save(posts)
```


<details>
<summary>What is a drawback to this approach?</summary>

When we go to save these arrays, we do so by creating a plist file for each of them.  Each of the posts has a User, so we end up storing userTwo in the Users array, and then again in postThree, postFour and postFive.  The same information is replicated in 4 different places!

</details>

Core Data offers a solution to this problem.  Instead of storing redundant copies of information, Core Data knows how to store objects and the *relationships* that they have to each other.

Core Data is thus called an **object graph manager**.  **Objects** are each of the entities that you are storing.  The relationships between them is managed like a **graph** where each entity is a node that has edges connecting it to other entities.  Core Data **manages** this object graph.


# 2. How does Core Data work?

Core Data is technically **not** a database.  A database is a collection of tables that you can access through querries.  While Core Data is often backed by a database, it does not need to be.

The following image outlines how Core Data operates.


![link](https://www.objc.io/images/issue-4/stack-simple-9af1e89d.png)

**Source**: https://www.objc.io/images/issue-4/stack-simple-9af1e89d.png


The **NSManagedObjectContext** provides an area for your entities to be held.  While typically, you only have one context, you can create as many as you like.

The **NSPersistentStoreCoordinator** is responsible for keeping track of all the NSManagedObjectContexts and for telling the NSPersistentStore to load or save information.

The **NSPersistentStore** manages storing the information from a context given to it by the NSPersistentStoreCoordinator.  This could be to a database such as SQLite or to iCloud.

These three aspects combine to create a system that is very powerful and flexible.

While the picture above illustrates common utilization of Core Data, it allows for more complex configurations:


![complex Core Data](https://www.objc.io/images/issue-4/stack-complex-dc540ef4.png)

Source: https://www.objc.io/images/issue-4/stack-complex-dc540ef4.png



# 3. Core Data vs. SQLite

Core Data is not a database.  It is a larger system that can have a database as the means of storing persisting entities.  When deciding on the persistence model of your application, it may make sense to use a wrapper for a SQLite database (e.g [this pod](https://github.com/stephencelis/SQLite.swift)) and not use Core Data.

As a rough guide of the pros and cons, Core Data is fantastic for modeling relationships between objects, and is very fast at fetching results, but in order to operate it loads the entire database into memory.  Traditional databases don't model relationships as clearly and can take longer to fetch results, but don't need to load everything into memory to answer requests.


# 4. Building a simple Core Data app.

Today, we will build a simple app that is backed by Core Data.  Our app will allow you to create users and for a user to create a post.

### Configure Xcode

Open a new Xcode project.  This time, we'll need to check the box that says "include Core Data".  This will make some changes to our AppDelegate, and will give us a Data Model to use.

Let's call our app "NumberFacts".  Users will make posts about various facts about numbers.  All of the posts and users will be persisted to your phone.

### AppDelegate Changes

In the AppDelegate, we have a new instance variable and a new instance method.

**persistentContainer**

Remember the picture above with the NSManagedObectContext, the NSPersistentStoreCoordinator and the NSPersistentStore?  Here we see none of those and only one class called a NSPersistentContainer.  In iOS 10, Apple gave this convenience class which is a wrapper around the entire picture we saw above.  Practically, this means that we can let this wrapper class do the heavy lifting for us.  It builds the Core Data stack by itself, so we don't need to worry about it.  If you do need to deploy for iOS builds before iOS 10, then you'll need to look into building a Core Data stack yourself, but NSPersistentContainer will work for most purposes.

**saveContext()**

This method is responsible for saving a NSManagedObjectContext.  In ApplicationWillTerminate(_:), they have added a line that invokes this method.  This may or may not work on simulator, but either way it is good practice to save whenever you make changes to ensure the data is retained.

### Building the model

We want our application to have Users and Posts.  Each Post has one User, and a User may have any number of Posts.  When we use Core Data, instead of building the classes for our model ourselves, we use the xcdatamodeld file provided.  Select the file, and you'll see a new screen.

There are three main kinds of things in Core Data: *Entities*, *Attributes* and *Relationships*.  For all intents and purposes, think of entities as classes, and attributes as properties.  Relationships create additional properties, an instance or array of instances of the entity it is related to.

In our model, we want two attributes, a User and a Post.

Click on the button at the bottom right to change into the Graph View.  Then select the Post entity.

Our Post will have two attributes:

- number: Double
- title: String

Create this by clicking the add attribute button.  Then open the Utilities menu to change the names and types of the attributes.

Our User will have two attributes:

- name: String
- dob: Date

We now want to add the relationships between them.  Control drag from the User entity to the Post entity.

Name the relationship under the User to "posts" and change the Type from "To One" to "To Many".  Then name the relationship under the Post to "user".

Our model is now built.  We have two classes that functionally act as below:

```swift
class User {
	let name: String
	let dob: Date
	let posts: [Post]
	... (inits below)
}

class Post {
	let number: Double
	let title: String
	let user: User
	... (inits below)
}
```

### Build the UI

To get our demo up and running, we'll use a Storyboard based application.

Create a Tab Bar Controller with two tabs named "Posts" and "Users"

### Posts

Create a table view controller.  Embed it in a Navigation stack and set that navigation stack as one of the view controllers for your Tab Bar Controller.  Give your prototype cell a reuse ID of "postCell" and set the style to subtitle.

Add a bar button item in the "Add" style and create a segue from the button to another TableViewController.  Change the cells from Dynamic to Static.  

Create 4 cells, one to put the title, one to put the number, one to select the user and one with a button to submit.

### Users

Create a table view controller.  Embed it in a Navigation stack and set that navigation stack as one of the view controllers for your Tab Bar Controller. Give your prototype cell a reuse ID of "userCell".

Create a segue from the protoype cell to the PostsTableViewController.  That way, selecting a user will show all their posts.

Add a bar button item in the "Add" style and create a segue from the button to another TableViewController.  Change the cells from Dynamic to Static.  

Create 3 cells, one to put the name, one to put the date (with a date picker) and one with a button to submit.

### Build the controllers

We have four View Controllers in our app.

### CreateUserTableViewController

```swift
import UIKit

class CreateUserTableViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        //TO DO: Validate name
        let newUserName = nameTextField.text!
        let newUserDOB = datePicker.date
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newUser = User(context: managedObjectContext)
        newUser.name = newUserName
        newUser.dob = newUserDOB
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        let successAlert = UIAlertController(title: "Success", message: "New user added", preferredStyle: .alert)
        successAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(successAlert, animated: true, completion: nil)
    }
}
```

### UsersTableViewController

```swift
import UIKit

class UsersTableViewController: UITableViewController {
    
    var users = [User]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadUsers()
    }
    
    func loadUsers() {
        do {
            let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            users = try moc.fetch(User.fetchRequest())
        }
        catch {
            print(error)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PostsTableViewController {
            let selectedUser = users[tableView.indexPathForSelectedRow!.row]
            destination.user = selectedUser
        }
    }
}
```

### CreatePostTableViewController

```swift
import UIKit

class CreatePostTableViewController: UITableViewController {

    var users = [User]()
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var numberTextField: UITextField!
    
    @IBOutlet weak var usersPickerView: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usersPickerView.delegate = self
        usersPickerView.dataSource = self
        loadUsers()
    }
    
    func loadUsers() {
        do {
            let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            users = try managedObjectContext.fetch(User.fetchRequest())
        }
        catch {
            print(error)
        }
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        //TO DO: Validate input
        let postTitle = titleTextField.text!
        let postNum = Double(numberTextField.text!)!
        let postUser = users[usersPickerView.selectedRow(inComponent: 0)]
        
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newPost = Post(context: managedObjectContext)
        newPost.title = postTitle
        newPost.number = postNum
        newPost.user = postUser
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        let successAlert = UIAlertController(title: "Success", message: "New post added", preferredStyle: .alert)
        successAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(successAlert, animated: true, completion: nil)
    }
}

extension CreatePostTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return users.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return users[row].name
    }
}
```


### PostsTableViewController

```swift
import UIKit

class PostsTableViewController: UITableViewController {

    var posts = [Post]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPosts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPosts()
    }
    
    func loadPosts() {
        if let passedInUser = user {
            let userPosts = passedInUser.posts?.allObjects as! [Post]
            posts = userPosts
            return
        }
        do {
            let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            posts = try moc.fetch(Post.fetchRequest())
        }
        catch {
            print(error)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
        let post = posts[indexPath.row]
        cell.textLabel?.text = "\(post.user?.name ?? "Unknown") - \(post.title ?? "No title")"
        cell.detailTextLabel?.text = "\(post.number)"
        return cell
    }
}
```