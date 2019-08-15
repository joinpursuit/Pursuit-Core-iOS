# Multiple MVC Day Two

# Objectives

- Review NavigationControllers
- Create ViewControllers with new Storyboard files
- Use dependency injection to create ViewControllers
- Push ViewControllers onto a NavigationController
- Use unwind segues to "go back" on the navigation stack

# 1. Introduction

In this lesson, we're going to review another way to transition from one ViewController to another.  One of the problems with the approach that we saw before, was that it required you to remember that you needed to set the `movie` property of the destination ViewController.


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

In order to know what property we need to set, we have to look over at the other class we wrote.  As our applications get larger, we want to be able know right away what properties we need to set.  The best way is to build in the requirements into the initializer, so that it's immediately clear what we need to give to the ViewController.  This process is called *dependency injection*.

We'll be rebuilding the app from yesterday using this approach.  The link to the starter repo can be found [here](https://github.com/joinpursuit/Pursuit-Core-Multiple-MVC-Starter-Project)

## 2. Building the MoviesViewController (review)

Start off and create a ViewController with a TableView and embed the VC inside of a NavigationController

![tableView](https://github.com/joinpursuit/Pursuit-Core-iOS/raw/master/mvc-view-lifecycle/multiple-mvc/Images/tableViewcontraint.png)

Then, let's give our tableView 1 prototype cell and set it up as a Subtitle cell with an ID of "movieCell"
![prototypeCell](https://github.com/joinpursuit/Pursuit-Core-iOS/blob/master/mvc-view-lifecycle/multiple-mvc/Images/idOfCell.png)

Rename your ViewController:

![rename](https://github.com/joinpursuit/Pursuit-Core-iOS/blob/master/mvc-view-lifecycle/multiple-mvc/Images/RefactorRename.png)

Then create an outlet to your VC

![outlet](https://github.com/joinpursuit/Pursuit-Core-iOS/raw/master/mvc-view-lifecycle/multiple-mvc/Images/tableViewoutlet.png)

Add your implementation below:

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

## 3. Building the MovieDetailViewController

Now we need to build the detail View Controller.  Create a new file

![new file](https://github.com/joinpursuit/Pursuit-Core-iOS/blob/master/mvc-view-lifecycle/multiple-mvc-day-two/images/newFile.png)

and make it a subclass of UIViewController.

![cocoatouchclass](https://github.com/joinpursuit/Pursuit-Core-iOS/blob/master/mvc-view-lifecycle/multiple-mvc-day-two/images/cocoatouchclass.png)

We're going to make a separate Storyboard file for our new MovieDetailViewController.  This Storyboard isn't for creating segues, but just for helping us keep our different ViewControllers separated.

![createNewStoryboard](https://github.com/joinpursuit/Pursuit-Core-iOS/blob/master/mvc-view-lifecycle/multiple-mvc-day-two/images/createNewStoryboard.png)

Set the classname and Storyboard ID.  This will let us find the ViewController later to create an instance of it through code.

![storyboardID](https://github.com/joinpursuit/Pursuit-Core-iOS/blob/master/mvc-view-lifecycle/multiple-mvc-day-two/images/classNameAndStoryboardID.png)

With our new Storyboard file built, we can now add outlets just like we did from the main.storyboard file.

```swift
import UIKit

class MovieDetailViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var movieDescriptionTextView: UITextView!

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
```

This ViewController needs a `Movie` object in order to render itself.  This time we're making it private.  This is because we going to set the movie right when the ViewController is created, and we don't want other classes to be able to access it and change it afterwards.

```swift
import UIKit

class MovieDetailViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var movieDescriptionTextView: UITextView!

    // MARK: - Private Properties

    private var movie: Movie!

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
```

Now we need to build in a way to crate this ViewController, since we don't have  segue that will build it for us:

```
static func fromStoryboard(usingMovie movie: Movie) -> MovieDetailViewController {
    let storyboard = UIStoryboard.init(name: "MovieDetailViewController", bundle: nil)
    guard let movieDetailVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else {
        fatalError("Unexpected class type")
    }
    movieDetailVC.movie = movie
    return movieDetailVC
}
```

This is a static method that takes in a `Movie` object, and returns an instance of a `MovieDetailViewController` with its movie set to the appropriate movie.  Other classes don't need to remember to set it themselves, instead this method forces them to give the appropriate instance of a `Movie` to build the MovieDetailViewController.

Now, we can complete our MovieDetailViewController implementation:

```swift
import UIKit

class MovieDetailViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var movieDescriptionTextView: UITextView!

    // MARK: - Private Properties

    private var movie: Movie!

    // MARK: - Initializers

    static func fromStoryboard(usingMovie movie: Movie) -> MovieDetailViewController {
        let storyboard = UIStoryboard.init(name: "MovieDetailViewController", bundle: nil)
        guard let movieDetailVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else {
            fatalError("Unexpected class type")
        }
        movieDetailVC.movie = movie
        return movieDetailVC
    }

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        populateViews()
    }

    // MARK - Private Methods

    private func populateViews() {
        movieImageView.image = UIImage(named: movie.posterImageName)
        movieTitleLabel.text = movie.name
        movieDescriptionTextView.text = movie.description
    }
}
```

## Building the transition

Now we have both of ViewControllers built.  Previously, we hooked them up by creating a Storyboard segue.  Here, we'll do it programmatically, without using a segue.

When the user taps on a cell, we want to make our MovieDetailViewController and present it to the user.  UITableViewDelegate has an optional method that we can tap into to get that information:

```swift
extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
```

Inside of this delegate method, we then can use our new static method to build the ViewController that we want:

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

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = movies[indexPath.row]
        let detailMovieVC = MovieDetailViewController.fromStoryboard(usingMovie: selectedMovie)        
        navigationController?.pushViewController(detailMovieVC, animated: true)
    }
}
```

We use our new static function to build the MovieDetailViewController, passing in the movie that we want to have set up.

Every ViewController has an optional `navigationController` property that is either `nil`, or the instance of the NavigationController that the ViewController is inside.  By using its `pushViewController(:animated)` method, we can transition to our MovieDetailViewController just like we did previously with segues.

## Unwind Segue 

Unwind segues are used to "go back" on the navigation stack. You can unwind push, modal, popover, and other segues, in order to go back one or more steps in your navigation hierarchy. Unlike a normal segue, which will create a new instance of the destination view controller and then transition to it, an unwind segue transitions to an existing view controller in your navigation hierarchy. Callbacks are provided to both the source and destination view controller before the transition begins. You can use these callbacks to pass data between the view controllers.

When you create an unwind segue in Interface Builder, you do not specify a destination view controller. The unwind segue determines which view controller in your navigation hierarchy to unwind to when it is triggered at runtime. This process is customizable and additional points of customization are provided for container view controllers to participate in the unwind process. 

## Readings 
[Apple Technical Note - Using Unwind Segues](https://developer.apple.com/library/archive/technotes/tn2298/_index.html)  

## Steps involved in creating an Unwind Segue 

Example Scenario: You have 2 view controllers, you want to pass data from the second view contorller to the first view controller. In the link demo, we are passing the user's full name from the EditFullnameController to the MainViewController. 

1. Create an @IBAction in the view controller you are interested in unwinding to, in our case the MainViewController. 

MainViewController.swift
```swift 
// unwind segue step 1:
@IBAction func unwindFromEditFullname(segue: UIStoryboardSegue) {
  let editFullnameVC = segue.source as! EditFullnameController
  fullnameLabel.text = editFullnameVC.fullnameTextField.text
}
```

2. Implement the performForSegue() function in the second view controller, in our case the EditFullnameController. 

EditFullnameController.swift
```swift
@IBAction func submit(_ sender: UIBarButtonItem) {
  // step 2: implement perform segue
  /* step 3: control-drag from the this view controller's (EditFullnameController) "yellow icon" in (storyboard) over to the "exit icon" and select the unwind segue you're interested in e.g "Unwind From Edit Fullname"
  */
  // step 4: name the unwind segue identifier in attributes inspector
  performSegue(withIdentifier: "Unwind From Edit Fullname", sender: self)
}
```

3. In the storyboard that is being used (in our case, Main.storyboard), select the `EditFullnameController`, control-drag from the view controller icon to the exit icon in the header view on the view controller scene. At this point the unwind @IBAction you created in the MainViewController will pop up, select the unwind segue. 
4. Finally select in unwind segue in the document outline and navigate to the attribues inspector and name the segue identifier. 

Creating a programmatically initiated unwind segue.
![connecting unwind segue in storyboard](https://developer.apple.com/library/archive/technotes/tn2298/Art/tn2298_SceneToExitIcon.png)
