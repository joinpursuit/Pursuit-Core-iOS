# Standards

* Understand Core Data's purpose and implementation.

# Objectives

* Build a Table View driven by Core Data.
* Populate a Core Data database via API calls.

# Resources

1. [Apple's Core Data Guide](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/CoreData/index.html#//apple_ref/doc/uid/TP40001075-CH2-SW1)

## Overview

Core Data is a way of putting a database on your phone. There are tools for defining
the structure of the database. XCode automatically builds a class based on the objects
you define in this tool. (Didn't use to be that way.)

The documentation is poor and confusing. It's even out of date for Swift 3. Further,
the Core Data checkbox available during app creation drops in code that goes against 
the recommendations in Apple's own guide.

## Terms

Persistence, context, thread/queue.

## Why?

The motivations for using Core Data include:

* To store some significant amount of data on the device that will be used later. 
* _Significant_ could in fact be very large. 
* If you expect to search or filter that data extensively.
* If you want the user to have offline access to the data.
* If you want the user to edit the data, particularly in a "transactional" manner.

## Context

The ```NSManagedObjectContext``` object represents a kind of session or interface
to the underlying "persistence layer". A "scratch pad" analogy is sometimes used.
There can be a hierarchy -- we'll just use two levels here -- of contexts. A main
thread one for the UI and a private one for making background updates. This is 
very much like sessions in a transactional database where a number of changes can be made
and later be committed or rolled back.

### ```perform()``` and ```performAndWait()```

Used to put operations on the correct thread for that context.

```swift
moc.performAndWait { ... }
```

## DataManager

This class implementation is based on Apple's guide. Theirs has no privateContext computed property.

Implementation

```swift
import UIKit
import CoreData

class DataController: NSObject {
    var managedObjectContext: NSManagedObjectContext
    
    override init() {
        // This resource is the same name as your xcdatamodeld contained in your project.
        guard let modelURL = Bundle.main.url(forResource: "Model", withExtension: "momd") else {
            fatalError("Error loading model from bundle")
        }
        // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = psc
        self.managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

        DispatchQueue.main.async {
            let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let docURL = urls.last!
            /* The directory the application uses to store the Core Data store file.
             This code uses a file named "DataModel.sqlite" in the application's documents directory.
             */
            let storeURL = docURL.appendingPathComponent("Model.sql")
            do {
                try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
            } catch {
                fatalError("Error migrating store: \(error)")
            }
        }
    }
    
    // should be called from the thread using the private context
    var privateContext: NSManagedObjectContext {
        get {
            let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            privateContext.parent = managedObjectContext
            return privateContext
        }
    }
}
```

Create and keep reference in AppDelegate as recommended by Apple.

```swift
func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
    self.dataController = DataController()
    
    return true
}
```

## Inserting data

Since Core Data creates our class for us, we need to extend it to add functionality to it.
Here, let's add our familiar field extraction method taking a JSON-derived dictionary
and mapping its key/values into our custom object. Note that we don't initialize the object

```swift
extension Article {
    func populate(from dict: [String:Any]) {
        if let title = dict["title"] as? String,
            let abstract = dict["abstract"] as? String {
            self.title = title
            self.abstract = abstract
        }
    }
}
```

Our data fetching and populating method is similar but not the same.

```swift
func getData() {
    APIRequestManager.manager.getData(endPoint: "https://api.nytimes.com/svc/topstories/v2/sports.json?api-key=f41c1b23419a4f55b613d0a243ed3243")  { (data: Data?) in
        if let validData = data {
            if let jsonData = try? JSONSerialization.jsonObject(with: validData, options:[]) {
                if let wholeDict = jsonData as? [String:Any],
                    let records = wholeDict["results"] as? [[String:Any]] {
                    
                    // used to be our way of adding a record
                    // self.allArticles.append(contentsOf:Article.parseArticles(from: records))

                    // create the private context on the thread that needs it
                    let moc = (UIApplication.shared.delegate as! AppDelegate).dataController.privateContext

                    moc.performAndWait {
                        for record in records {
                            // now it goes in the database
                            let article = NSEntityDescription.insertNewObject(forEntityName: "Article", into: moc) as! Article
                            article.populate(from: record)
                        }
                    
                        do {
                            try moc.save()
                            
                            moc.parent?.performAndWait {
                                do {
                                    try moc.parent?.save()
                                }
                                catch {
                                    fatalError("Failure to save context: \(error)")
                                }
                            }
                        }
                        catch {
                            fatalError("Failure to save context: \(error)")
                        }
                        
                    }
                    // start off with everything
                    //self.articles = self.allArticles
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}
```
## Displaying data: Fetched Results Controller

The ```NSFetchedResultsController``` object is tied to generating table views. It's built
with on a generic paradigm and we declare it with our custom object.

```swift
var fetchedResultsController: NSFetchedResultsController<Article>!
```

### Initializing the fetchedResultsController

```swift
    func initializeFetchedResultsController() {
        let moc = (UIApplication.shared.delegate as! AppDelegate).dataController.managedObjectContext

        let request = NSFetchRequest<Article>(entityName: "Article")
        let sort = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sort]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
```

### Using fetchedResultsController in Data Source Delegate methods

```swift
// get count of sections
fetchedResultsController.sections!.count

// get count in section
guard let sections = fetchedResultsController.sections else {
    fatalError("No sections in fetchedResultsController")
}
let sectionInfo = sections[section]
return sectionInfo.numberOfObjects

// get an object
fetchedResultsController.object(at: indexPath)
```

Why have configureCell? Because we might want to redraw/reconfigure an existing
row in the table. By factoring out the configuration/population of the cell
from its creation we can re-use it if the cell needs to be remade.

```swift
    func configureCell(_ cell: UITableViewCell, indexPath: IndexPath) {
```

### NSFetchedResultsControllerDelegate 

These delegate methods observe changes to the context associated with the fetched results
controller.

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
        if let ip = indexPath,
            let cell = tableView.cellForRow(at: ip) {
            configureCell(cell, indexPath: ip)
        }
    case .move:
        tableView.moveRow(at: indexPath!, to: newIndexPath!)
    }
}

func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.endUpdates()
}
```

