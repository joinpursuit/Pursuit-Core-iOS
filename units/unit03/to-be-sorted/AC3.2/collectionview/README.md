# Standards

* Understand ```UICollectionView```

# Objectives

* Build and populate collection views 
* Understand how flows work in collection views
* Size and layout items of a collection view dynamically

# Resources

* [Ray Wenderlich Tutorial](https://www.raywenderlich.com/136159/uicollectionview-tutorial-getting-started)
* [Collection View (Apple Docs)](https://developer.apple.com/reference/uikit/uicollectionview)
* [Collection View Layout(Apple Docs)](https://developer.apple.com/reference/uikit/uicollectionviewlayout)
* [UICollectionViewDelegateFlowLayout (Apple Docs)](https://developer.apple.com/reference/uikit/uicollectionviewdelegateflowlayout)

# Lesson

## Table View vs. Collection View

Collection views are very much like table views. The main difference is that 
collection views are far more flexible in how they can lay out their content.
While it's highly customizable via an overrideable class ```UICollectionViewLayout```,
the default ```Flow``` layout is very powerful without any subclassing. The
protocol ```UICollectionViewDelegateFlowLayout```.


### DataSource Delegate

UICollectionView's data source delegate is very much like UITableView's. The key methods
are exactly the same, but for some rewording.


```swift
override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
}


override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dataArray.count
}

override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    .
    .
    .
    }

    return cell
}
```

### UIEdgeInsets

UIEdgeInsets are like margins. They can be applied to any UIView but are often
found  on ```UIScrollView``` and its subclasses.
In this project we'll use this struct directly and also use its properties directly for setting
other related dimensions. 

### Search

We're going to embed a ```UITextField``` 
in the [Navigation Item](https://developer.apple.com/reference/uikit/uinavigationitem) of the Navigation Bar
to allow the user to change the search term. The navigation item is an object the view controller 
uses to configure the navigation bar. 

1. Drag a Text Field into the navigation bar of the collection view controller.
2. Control drag from the Text Field to the View Controller to set the delegate property of the Text Field.
3. Declare the collection view controller as adopting the ```UITextFieldDelegate``` protocol.
4. Implement ```textFieldShouldReturn(_:)```

    ```swift
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        search(textField.text!)
        textField.text = nil
        textField.resignFirstResponder()
        return true
    }
    ```
    
### Full implementation

Here's a full implementation of the UICollectionViewController subclass. A whole [working project is here](SpotifyGrid).

```swift
import UIKit

fileprivate let reuseIdentifier = "AlbumCell"
fileprivate let itemsPerRow: CGFloat = 3

class AlbumCollectionViewController: UICollectionViewController, UITextFieldDelegate, UICollectionViewDelegateFlowLayout {
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    var albums: [Album] = []
    let searchTerm = "blue"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "No Search Yet"
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.albums.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        if let acvc = cell as? AlbumCollectionViewCell {
            let album = self.albums[indexPath.row]
            acvc.titleLabel.text = "\(indexPath.row + 1). \(album.name)"
            
            if album.images.count > 1 {
                APIRequestManager.manager.getData(endPoint: album.images[1].url.absoluteString) { (data: Data?) in
                    if let validData = data,
                        let image = UIImage(data: validData) {
                        DispatchQueue.main.async {
                            acvc.imageView.image = image
                            acvc.setNeedsLayout()
                        }
                    }
                }
            }
        }

        return cell
    }

    // MARK: - TextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        search(textField.text!)
        textField.text = nil
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Utility
    func search(_ term: String) {
        self.title = term
        let escapedString = term.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)

        APIRequestManager.manager.getData(endPoint: "https://api.spotify.com/v1/search?q=\(escapedString!)&type=album&limit=50") { (data: Data?) in
            if  let validData = data,
                let validAlbums = Album.albums(from: validData) {
                self.albums = validAlbums
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }
        }
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    // margin around the whole section
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // spacing between rows if vertical / columns if horizontal
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
```

## Exercise

[New York Times Movie Reviews](NYTMovieReviews.md)
