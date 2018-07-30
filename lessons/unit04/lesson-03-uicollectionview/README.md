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


### DataSource

UICollectionView's data source is very much like UITableView's. The key methods
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

## No default cells

Collection Views require customization for their cells.  Their is no "basic" or "subtitle" collection view cell. We must always create a subclass and set its properties like we do for table views.

## Horizontal / Vertical scrolling

Collection views can be configured to scroll both vertically and horizontally simply by setting that property inside the attributes inspector.

## Sizing Collection View Cells

We can set the size of a collection view cell by conforming to a special protocol named "UICollectionViewDelegateFlowLayout".  Flow Layout is the standard setup for collection views.  We will see how to customize this in later lessons.

```
extension BestSellersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(YOURWIDTH, YOURHEIGHT)
    }
}
```

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
    
    
## Building a collection view application

Endpoint for instruction: "https://api.magicthegathering.io/v1/cards?name=\(searchName)"