# Core Data - NSPredicate and FetchedResultsController

## [Repo](https://github.com/C4Q/AC-iOS-CoreDataArticles)

## Readings

1. [Apple Docs - NSPredicate](https://developer.apple.com/documentation/foundation/nspredicate)
2. [NSHipster](http://nshipster.com/nspredicate/)
3. [Predicate Cheat Sheet](https://academy.realm.io/posts/nspredicate-cheatsheet/)
4. [Apple Docs - NSFetchedResultsController](https://developer.apple.com/documentation/coredata/nsfetchedresultscontroller)

## Objectives

1. Create fetch requests with NSPredicates
2. Create a NSFetchedResultsController to manage information
3. Build an app that saves favorites using the NYTimes API

# 1. NSPredicate

### Why do we want it?

When we make a fetch request, we might only want a subset of the data.  For example, in an app that stores posts and users, we might want to get all posts that have the string "Olympics" in their title.  Rather than loading in all of the posts and filtering it ourselves, we can tell Core Data to only give us back the posts that we are interested in.

### How do we use it?

NSPredicates can operate either on Objective C collections, or on NSFetchResults.

Either way, the syntax is a little different than we have seen before.  It uses a cross between regular expressions and SQL.

They are quite powerful, and by controlling the syntax appropriately, you can do things like find partial matches, allow wildcard characters and use regular expressions.

[NSHipster](http://nshipster.com/nspredicate/) gives an excellent walkthrough of the more involved syntax.  We'll stick with simple queries, but know that many versatile options are available.

#### Objective C Collections

```swift
let food = ["Apple", "Banana", "Carrot", "Date", "Egg"]
let carrotPredicate = NSPredicate(format: "SELF = %@", "Carrot")
let lessThanCPredicate = NSPredicate(format: "SELF < %@", "C")
let carrots = (food as NSArray).filtered(using: carrotPredicate)
let earlyAlphaFoods = (food as NSArray).filtered(using: lessThanCPredicate)

//Filtering an array of custom objects

class Post: NSObject {
    @objc let title: String
    @objc let favorites: Int
    init(title: String, favorites: Int) {
        self.title = title
        self.favorites = favorites
    }
}

let posts = [Post(title: "Apples are great for you", favorites: 40),
             Post(title: "Bananas are usually yellow", favorites: 103),
             Post(title: "Bananas are sometimes green", favorites: 160),
             Post(title: "Banana bread is delicious", favorites: 999),
             Post(title: "The iPhone X is the newest Apple phone", favorites: 500)
]
let applePredicate = NSPredicate(format: "title CONTAINS %@", "Apple")
let bananaPredicate = NSPredicate(format: "title CONTAINS %@", "Banana")
let wellLikedPredicate = NSPredicate(format: "favorites > 150")

(posts as NSArray).filtered(using: applePredicate)
(posts as NSArray).filtered(using: bananaPredicate)
(posts as NSArray).filtered(using: wellLikedPredicate)
```

#### NSFetchRequestet

```swift
//Assume that Post is part of an xcdatamodel

let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Post")
fetchRequest.predicate = bananaPredicate
```

We can use NSPredicate to create fetch requests that only grab certain information.

# 2. NSFetchedResultsController

A NSFetchedResultsController is a way of combining Core Data and a Table View Controller.  You set up a NSFetchedResultsController and assign its delegate to be a TableViewController.  Whenever the data that the NSFetchedResultsController is watching changes, it will inform the TableViewController which will insert, delete or edit its content appropriately.

To be properly initialized, a NSFetchedResultsController needs the following:

- NSFetchRequest (with a sort descriptor)
- NSManagedObjectContext
- (optional) the name of the property that delineates sections
- (optional) the name of the cache

In order to conform to the NSFetchedResultsControllerDelegate protocol, our TableViewController does not need to implement any methods, but the implementation below will sync up our fetch request and our table view controller:

```swift
func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.beginUpdates()
}
    
func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
    switch type {
    case .insert:
        tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
    case .delete:
        tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
    case .move:
        break
    case .update:
        break
    }
}
    
func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    switch type {
    case .insert:
        tableView.insertRows(at: [newIndexPath!], with: .fade)
    case .delete:
        if let ip = indexPath {
            tableView.deleteRows(at: [ip], with: .fade)
        }
    case .update:
        if let ip = indexPath, let cell = tableView.cellForRow(at: ip) as? ArticleTableViewCell {
            cell.article = fetchedResultsController.object(at: ip)
        }
    case .move:
        tableView.moveRow(at: indexPath!, to: newIndexPath!)
    }
}
    
func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.endUpdates()
}
```


# 3. Building NYTimes app

We will build a NYTimes app to show how NSPredicates and NSFetchedResultsController can be used to persist and manage data.

Our app will load all of the popular articles using the [Most Popular API](https://developer.nytimes.com/most_popular_api_v2.json).  If you have not already, create an API key at the link [here](https://developer.nytimes.com/signup).  Users will be able to choose the category that they want to view stories for and load the appropriate stories.  Users will then be able to favorite articles and save them to review later.

#### Building the Model

We will have two entities with the following attributes:

**Article**

- abstract: String
- id: String
- isFavorite: Bool
- title: String

**Category**

-name: String
-lastUpdated: Date

An Article has a to-one relationship with a Category
A Category has a to-many relatioinship with an Article

#### Article extention:

```swift
import UIKit
import CoreData

extension Article {
    func populateFrom(jsonDict: [String: Any], with category: Category) {
        if let articleTitle = jsonDict["title"] as? String {
            self.title = articleTitle
        }
        if let articleAbstract = jsonDict["abstract"] as? String {
            self.abstract = articleAbstract
        }
        if let url = jsonDict["url"] as? String {
            self.id = url
        }
        self.isFavorite = false
        self.category = category
    }
}
```

#### Category extension

```swift
extension Category {
    func populateFrom(jsonDict: [String: Any]) {
        self.name = jsonDict["section"] as? String
        guard let dateStr = jsonDict["last_updated"] as? String else { return }
        updateDateAccessed(with: dateStr)
    }
    func isRecentEnough() -> Bool {
        guard let date = self.lastUpdated else { return false }
        let acceptableNumberOfHours = 6.0
        let acceptableNumberOfHoursInSeconds = acceptableNumberOfHours * 60 * 60
        return abs(date.timeIntervalSinceNow) < acceptableNumberOfHoursInSeconds
    }
    func updateDateAccessed(with dateStr: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let date = formatter.date(from: dateStr)
        self.lastUpdated = date
    }
}
```


#### Services: NYTimes APIClient

```swift
class NYTAPIClient {
    static let manager = NYTAPIClient()
    private init() {}
    private let key = ".json?api-key=fe8c8520db7244e29c3a10521417768a"
    private let endpoint = "https://api.nytimes.com/svc/topstories/v2/"
    func loadArticles(with categoryStr: String, completionHandler: @escaping ([Article]) -> Void, errorHandler: @escaping (Error) -> Void) {
        if let savedCategory = CoreDataHelper.manager.getCategory(named: categoryStr),
            savedCategory.isRecentEnough(),
            let articles = savedCategory.articles?.allObjects as? [Article] {
            completionHandler(articles)
            return
        }
        let url = URL(string: endpoint + categoryStr + key)!
        let request = URLRequest(url: url)
        let completion: (Data) -> Void = {(data) in
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                guard let jsonDict = json as? [String: Any] else { return }
                
                let category: Category
                if let savedCategory = CoreDataHelper.manager.getCategory(named: categoryStr) {
                    category = savedCategory
                } else {
                    category = Category(context: CoreDataHelper.manager.managedObjectContext)
                }
                category.populateFrom(jsonDict: jsonDict)
                
                guard let articleDictArr = jsonDict["results"] as? [[String: Any]] else { return }
                var articles = [Article]()
                for articleDict in articleDictArr {
                    if let savedArticle = CoreDataHelper.manager.getArticle(from: articleDict) {
                        articles.append(savedArticle)
                    } else {
                        let newArticle = Article(context: CoreDataHelper.manager.managedObjectContext)
                        newArticle.populateFrom(jsonDict: articleDict, with: category)
                        articles.append(newArticle)
                    }
                }
                CoreDataHelper.manager.saveAllData()
                completionHandler(articles)
            }
            catch {
                print(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: request, completionHandler: completion, errorHandler: errorHandler)
    }
}
```

#### Services: Network Helper

```swift
import Foundation

enum AppError: Error {
    case noData
}

class NetworkHelper {
    private init() {}
    static let manager = NetworkHelper()
    private let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    func performDataTask(with request: URLRequest, completionHandler: @escaping (Data) -> Void, errorHandler: @escaping (Error) -> Void) {
        self.urlSession.dataTask(with: request){(data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                guard let data = data else {errorHandler(AppError.noData); return}
                
                if let error = error {
                    errorHandler(error)
                }
                completionHandler(data)
                
            }
            }.resume()
    }
}
```

#### Services: CoreDataHelper

```swift
import UIKit
import CoreData

enum ManagedObjectType: String {
    case article = "Article"
    case category = "Category"
}

class CoreDataHelper {
    private init() {}
    static let manager = CoreDataHelper()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func saveAllData() {
        do {
            try managedObjectContext.save()
        }
        catch {
            print(error)
        }
    }
    func getCategory(named str: String) -> Category? {
        do {
            let request = NSFetchRequest<Category>(entityName: ManagedObjectType.category.rawValue)
            let predicate = NSPredicate(format: "name = %@", str)
            request.predicate = predicate
            return try managedObjectContext.fetch(request).first
        }
        catch {
            print(error)
            return nil
        }
    }
    
    func getArticle(from jsonDict: [String: Any]) -> Article? {
        guard let urlStr = jsonDict["url"] as? String else { return nil }
        do {
            let request = NSFetchRequest<Article>(entityName: ManagedObjectType.article.rawValue)
            let predicate = NSPredicate(format: "id = %@", urlStr)
            request.predicate = predicate
            return try managedObjectContext.fetch(request).first
        }
        catch {
            print(error)
            return nil
        }
    }
    
    func deleteAll(managedObjectType: ManagedObjectType) {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: managedObjectType.rawValue)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try managedObjectContext.execute(deleteRequest)
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
}
```

#### Building the UI

#### Storyboard

Create a tab bar controller.

In one tab, create a View Controller that has a collection view at the top that scrolls horizontally.  We will store the categories here.  The rest of the view should be taken up by a tableView that will be where we display our articles.

For the other tab, create a TableViewController.

#### Nibs

#### CategoryCollectionViewCell.xib

Create a label and pin it to the edges.

#### CategoryCollectionViewCell.swift

Create an outlet to the label

#### ArticleTableViewCell.xib

Create a title label at the top, an abstract label below it, and a button at the right side.


#### ArticleTableViewCell.swift

```swift
class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    @IBOutlet weak var favoriteImageButton: UIButton!
    
    var article: Article! {
        didSet {
            titleLabel.text = article.title
            abstractLabel.text = article.abstract
            favoriteImageButton.setImage(article.isFavorite ? #imageLiteral(resourceName: "filledStar") : #imageLiteral(resourceName: "unfilledStar") , for: .normal)
        }
    }

    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        switch article.isFavorite {
        case true:
            favoriteImageButton.setImage(#imageLiteral(resourceName: "unfilledStar"), for: .normal)
            article.isFavorite = false
        case false:
            favoriteImageButton.setImage(#imageLiteral(resourceName: "filledStar"), for: .normal)
            article.isFavorite = true
        }
        CoreDataHelper.manager.saveAllData()
    }
}
```

#### Creating the ArticlesViewController

```swift
class ArticlesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureCollectionView()
        selectedCategoryName = categories[0]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData(with: selectedCategoryName)
    }
    
    func configureTableView() {
        let nib = UINib(nibName: "ArticleTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "articleCell")
        tableView.dataSource = self
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func configureCollectionView() {
        let collectionNib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        categoriesCollectionView.register(collectionNib, forCellWithReuseIdentifier: "categoryCell")
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        collectionViewLayout.estimatedItemSize = CGSize(width: 100, height: 50)
    }
    
    let categories = ["home", "opinion", "world", "national", "politics", "upshot", "nyregion", "business", "technology", "science", "health", "sports", "arts", "books", "movies", "theater", "sundayreview", "fashion", "tmagazine", "food", "travel", "magazine", "realestate", "automobiles", "obituaries", "insider" ]
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    
    var selectedCategoryName: String = "" {
        didSet {
            loadData(with: selectedCategoryName)
        }
    }
    
    var articles = [Article]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    func loadData(with category: String) {
        NYTAPIClient.manager.loadArticles(
            with: category,
            completionHandler: {self.articles = $0},
            errorHandler: {print($0)}
        )
    }
}

extension ArticlesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleTableViewCell
        let article = articles[indexPath.row]
        cell.article = article
        return cell
    }
}

extension ArticlesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
        let category = categories[indexPath.row]
        cell.categoryLabel.text = category
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategoryName = categories[indexPath.row]
    }
}
```


#### Creating the FavoritesTableViewController

```swift
import UIKit
import CoreData

class FavoriteArticlesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    lazy var fetchedResultsController: NSFetchedResultsController = {() -> NSFetchedResultsController<Article> in
        let request = NSFetchRequest<Article>(entityName: "Article")
        let predicate = NSPredicate(format: "isFavorite = true")
        let sort = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sort]
        request.predicate = predicate
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let rc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: "category.name", cacheName: nil)
        rc.delegate = self
        return rc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "ArticleTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "articleCell")
        do {
            try fetchedResultsController.performFetch()
        }
        catch {
            print(error)
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = fetchedResultsController.sections else { return 0 }
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionInfo = fetchedResultsController.sections?[section] else { return 0 }
        return sectionInfo.numberOfObjects
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleTableViewCell
        cell.article = fetchedResultsController.object(at: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionInfo = fetchedResultsController.sections?[section] else { return nil }
        return sectionInfo.name
    }
    
    // MARK: - FetchedResultsController methods
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            if let ip = indexPath {
                tableView.deleteRows(at: [ip], with: .fade)
            }
        case .update:
            if let ip = indexPath, let cell = tableView.cellForRow(at: ip) as? ArticleTableViewCell {
                cell.article = fetchedResultsController.object(at: ip)
            }
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
```