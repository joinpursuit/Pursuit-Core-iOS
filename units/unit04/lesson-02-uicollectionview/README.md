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

We can set the size of a collection view cell by conforming to a special protocol named "UICollectionViewDelegateFlowLayout".  Then you are able to calll the appropriate method.

```
extension BestSellersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(YOURWIDTH, YOURHEIGHT)
    }
}
```

    
    
## Building a collection view application

Endpoint for app: "https://dog.ceo/api/breeds/image/random/10"
