# Multiple MVC

### [Project Repo](https://github.com/C4Q/AC-iOS-TableViewSegues)

### Readings

1. [General Reference on Xcode (very useful)](http://help.apple.com/xcode/mac/8.0)
2. [Configuring a Segue in Storyboard - Apple](http://help.apple.com/xcode/mac/8.0/#/deve5fc2eb19)
3. [Using Segues (lots of great info here)](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/UsingSegues.html)
4. [Navigation Controller Implementation - tuts+ (helpful reference and example)](https://code.tutsplus.com/tutorials/ios-from-scratch-with-swift-navigation-controllers-and-view-controller-hierarchies--cms-25462)

#### References

1. [Using Segues - Apple](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/UsingSegues.html)
2. [`prepare(for:sender:)` - Apple](https://developer.apple.com/reference/appkit/nssegueperforming/1409583-performsegue)

---
### Vocabulary

1. **MVP (Minimum Viable Product)** - rapidly building a minimum set of features that is enough to deploy a product and test key assumptions about customers’ interactions with the product. [Quora](https://www.quora.com/What-is-a-minimum-viable-product/answer/Suren-Samarchyan?srid=dpgi)
2. **Segue** - A segue defines a transition between two view controllers in your app’s storyboard file. [Apple](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/UsingSegues.html)

---
# 0. Objectives

1. Understand how to connect multiple MVCs
2. Understand segues in storyboard to transition between view controllers
3. Further our understanding of `UITableViewController` delegate functions
4. Create a new custom `UIViewController` to display a single `Movie` object's data


# 1. Multiple MVC

So far we have only worked with one ViewController at a time.  When we want to display information, we have only had one screen to work with.  This has served our needs for applications with a single purpose.  However, we often want to have multiple MVCs that are joined together.  

**Question: What are some examples of multiple MVC in apps?**


There are 3 main ways in which we can combine MVCs:

- TabBarController
- NavigationController
- SplitViewController (mainly for iPad)

SplitViewControllers are mainly useful for iPad and we will discuss those in later units.

# 2. TabBarController Introduction

A TabBarController is a simple way to combine multiple MVCs together.  It creates a bar at the bottom of the phone with buttons at the bottom that allow you to move from one View Controller to the other.  The state of each of those View Controllers is maintained.

**In Storyboard**

Create two View Controllers inside your Main.storyboard file.  Give one a label that reads "View Controller One" and a blue view.  Give the other a label that reads "View Controller Two" and a red view.

Go to the Object Library and select a Tab Bar Controller.  Drag it into your Interface Builder.  It will bring two View Controllers with it.  It's trying to be helpful, but we have our own View Controllers so delete the ones that the Tab Bar Controller brings.

We need to do two things to hook up our ViewControllers to each other

1. Control drag from the Tab Bar Controller to each ViewController and select "view controllers" under "Relationship Segue"
2. Move the Storyboard Entry point (the arrow) to the Tab Bar Controller

Build and run the app and observe how you can move from one View Controller to another.

# 3. Navigation Controller

One common thing we want to do when using an application is to click on something for more information.

[exOne](https://i.stack.imgur.com/1kb6d.png)
[exTwo](https://www.wikihow.com/images/thumb/c/c9/Use-the-Augmented-Reality-Monocle-on-the-Yelp-for-iPhone-App-Step-8.jpg/aid2295937-v4-900px-Use-the-Augmented-Reality-Monocle-on-the-Yelp-for-iPhone-App-Step-8.jpg)
[exThree](https://img.gadgethacks.com/img/original/93/41/63555444654612/0/635554446546129341.jpg)

Once we've tapped on a cell for more information, we see a new screen, and can tap a back button to return where we were before.

[backButton](https://public.steelkiwi.com/media/filer_public/a2/5f/a25f1feb-4d01-4723-a530-a6ee7d0fec28/key_differences_in_design_of_native_applications_image_12.png)

We can use a NavigationController to achieve this in applications that we write.  Below, we'll make an app that displays a list of movies, and allows the user to tap on a movie for more information.  

Download the starter project [here](https://github.com/joinpursuit/Pursuit-Core-Multiple-MVC-Starter-Project) to get the repository with the images.

# 4. Building the Views

To embed our VC in a NavigationController, click on "embed in Navigation Controller" in the toolbar at the bottom.

[image](https://github.com/joinpursuit/Pursuit-Core-iOS/blob/master/mvc-view-lifecycle/multiple-mvc/Images/EmbedinNavVC.png)

When we build and run our application, we see that there is now a grey bar at the top.  This is reserved for things like the back button that we'll need.

[image](https://github.com/joinpursuit/Pursuit-Core-iOS/blob/master/mvc-view-lifecycle/multiple-mvc/Images/greyBarOnTop.png)

Let's set up our ViewController to have a table view inside of it

[tableViewSetupImage](https://github.com/joinpursuit/Pursuit-Core-iOS/blob/master/mvc-view-lifecycle/multiple-mvc/Images/tableViewcontraint.png)

Then, let's give our tableView 1 prototype cell and set it up as a Subtitle cell with an ID of "movieCell"

[idOfCell](https://github.com/joinpursuit/Pursuit-Core-iOS/blob/master/mvc-view-lifecycle/multiple-mvc/Images/idOfCell.png)

Now, let's build another View Controller that will show more information about the movie when a user taps on a cell:

[detailVC](https://github.com/joinpursuit/Pursuit-Core-iOS/blob/master/mvc-view-lifecycle/multiple-mvc/Images/detailVC.png)

Finally, we need a way to connect them.  Hold down control, then drag from the tableViewCell to the View controller, then select "Show" for the segue option.  Then, click on your segue and name is "movieSegue"

[movieSegue](https://github.com/joinpursuit/Pursuit-Core-iOS/blob/master/mvc-view-lifecycle/multiple-mvc/Images/movieSegue.png)

That's our Storyboard!  Now we can build in the View Controllers

# 5. Building the MoviesViewController

Let's start by renaming our View controller.  Right click on the class "ViewController", then click "Refactor" and "Rename..." and change its name to "MoviesViewController"

[rename image](https://github.com/joinpursuit/Pursuit-Core-iOS/blob/master/mvc-view-lifecycle/multiple-mvc/Images/RefactorRename.png)

Create an outlet from the tableView to your viewController.

[outlet image](https://github.com/joinpursuit/Pursuit-Core-iOS/blob/master/mvc-view-lifecycle/multiple-mvc/Images/tableViewoutlet.png)

Now, let's add our implementation to show all of the data in the movies array:

```swift
import UIKit

class MoviesViewController: UIViewController {

  // MARK: - IBOutlets

  @IBOutlet var moviesTableView: UITableView!

  // MARK: - Private Properties

  private var movies = [Movie]() {
    didSet {
      moviesTableView.reloadData()
    }
  }

  // MARK: - Lifecycle Methods

  override func viewDidLoad() {
    super.viewDidLoad()
    configureTableView()
    loadData()
  }

  // MARK: - Private Methods

  private func configureTableView() {
    moviesTableView.dataSource = self
    moviesTableView.delegate = self
  }

  private func loadData() {
    movies = Movie.allMovies
  }
}

extension MoviesViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movies.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = moviesTableView.dequeueReusableCell(withIdentifier: "movieCell") else {
      fatalError("Unknown Cell Identifier")
    }
    let movie = movies[indexPath.row]
    cell.textLabel?.text = movie.name
    cell.detailTextLabel?.text = "\(movie.year)"
    return cell
  }
}

extension MoviesViewController: UITableViewDelegate {}
```

Now, let's build and run our app.  We should see the following:

[stepOneGif](https://github.com/joinpursuit/Pursuit-Core-iOS/blob/master/mvc-view-lifecycle/multiple-mvc/Images/NoSegueHookupGif.gif)

What's happening?  Our NavigationController and segues are working great!  We are moving to the new ViewController whenever we tap a cell.  But we haven't set up that ViewController yet to prepare it for a Movie.

# 6. Building the MovieDetailViewController

Make a new Swift class that inherits from UIViewController named "MovieDetailViewController"

```swift
import UIKit

class MovieDetailViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    }
}
```

Back in your Storyboard file, change the class of your detail View controller to "MovieDetailViewController"

[movieVCChangeName](https://github.com/joinpursuit/Pursuit-Core-iOS/blob/master/mvc-view-lifecycle/multiple-mvc/Images/movieVCchangeName.png)

Then drag in all of your outlets

Because this class is powered by a Movie object, let's give the MovieDetailVC a Movie property.  

When the view loads, have the VC populate all of its outlets:

```swift
import UIKit

class MovieDetailViewController: UIViewController {

  // MARK: - Internal Properties

  var movie: Movie!

  // MARK: - IBOutlets

  @IBOutlet var movieImageView: UIImageView!
  @IBOutlet var movieTitleLabel: UILabel!
  @IBOutlet var movieDescriptionTextView: UITextView!

  // MARK: - Lifecycle Methods

  override func viewDidLoad() {
    super.viewDidLoad()
    populateOutlets()
  }

  // MARK: Private methods

  func populateOutlets() {
    movieImageView.image = UIImage(named: movie.posterImageName)
    movieTitleLabel.text = movie.name
    movieDescriptionTextView.text = movie.description
  }
}
```

Now the only step missing is to have the MoviesViewController tell our new MovieDetailViewController which Movie it should be displaying

# 7. prepareForSegue

prepareForSegue is a UIViewController method that by default does nothing.  We'll override it to say that if we are about to segue to a MovieDetailViewController, find the movie that the user tapped on, then set the movie property of the MovieDetailVC.

```swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {  
  guard let segueIdentifier = segue.identifier else { fatalError("No identifier on segue") }
  switch segueIdentifier {
  case "movieSegue":
    guard let movieDetailVC = segue.destination as? MovieDetailViewController else {
      fatalError("Unexpected segue VC")
    }
    guard let selectedIndexPath = moviesTableView.indexPathForSelectedRow else {
      fatalError("No row was selected")
    }
    movieDetailVC.movie = movies[selectedIndexPath.row]
  default:
    fatalError("Unexpected segue identifier")
  }
}
```

[finalGif](https://github.com/joinpursuit/Pursuit-Core-iOS/blob/master/mvc-view-lifecycle/multiple-mvc/Images/finalGif.gif)
