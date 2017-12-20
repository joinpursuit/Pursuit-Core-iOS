## CollectionView Continued 

## Review
**UICollectionView:** An object that manages an ordered collection of data items and presents them using customizable layouts.

**UICollectionViewFlowLayout:** A concrete layout object **that organizes items into a grid** with optional header and footer views for each section.A flow layout works with the collection view’s delegate object to determine the size of items, headers, and footers in each section and grid. That delegate object must conform to the UICollectionViewDelegateFlowLayout protocol. Use of the delegate allows you to adjust layout information dynamically. For example, you would need to use a delegate object to specify different sizes for items in the grid. If you do not provide a delegate, the flow layout uses the default values you set using the properties of this class.

**UICollectionViewDelegateFlowLayout:** The UICollectionViewDelegateFlowLayout protocol defines methods that let you coordinate with a UICollectionViewFlowLayout object to implement a grid-based layout. The methods of this protocol define the size of items and the spacing between items in the grid.

## The classes and protocols for implementing collection views
Top-level containment and management: 
* UICollectionView
* UICollectionViewController

Content management: 
* UICollectionViewDataSource 
* UICollectionViewDelegate 

Presentation: 
* [UICollectionReusableView](https://developer.apple.com/documentation/uikit/uicollectionreusableview)
* UICollectionViewCell

Layout: 
* [UICollectionViewLayout](https://developer.apple.com/documentation/uikit/uicollectionviewlayout):  location, size, and visual attributes of the cells and reusable views inside a collection view
* UICollectionViewLayoutAttributes
* UICollectionViewUpdateItem

Flow layout: 
* [UICollectionViewFlowLayout](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout): allows you to customize the layout information dynamically
* UICollectionViewDelegateFlowLayout protocol

You can configure the flow layout either programmatically or using Interface Builder in Xcode. The steps for configuring the flow layout are as follows:
1. Create a flow layout object and assign it to your collection view.
2. Configure the width and height of cells.
3. Set the spacing options (as needed) for the lines and items.
4. If you want section headers or section footers, specify their size.
5. Set the scroll direction for the layout.  

## Objectives 
* reviewing collection views
* customizing cells sizes, insets, minimumLineSpacing and minimumInteritemSpacing
* knowing when to customize view layout 
* previewing supplementary views and it's existence for customization 

_Laying out sections and cells using the flow layout_

<img src="https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Art/flow_horiz_headers_2x.png" widht="600" height="400" />

## Subclassing UICollectionViewFlowLayout and Knowing When to subclass
* You want to add new supplementary or decoration views to your layout
* You want to tweak the layout attributes being returned by the flow layout
* You want to add new layout attributes for your cells and views
* You want to specify initial or final locations for items being inserted or deleted

[Read More...](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/UsingtheFlowLayout/UsingtheFlowLayout.html)  

## Subclassing UICollectionViewLayout
For custom layouts, you want to subclass UICollectionViewLayout, which provides you with a fresh starting point for your design. Only a handful of methods provide the core behavior for your layout object and are required in your implementation. The rest of the methods are there for you to override as needed to tweak the layout behavior. The core methods handle the following crucial tasks:
* Specify the size of the scrollable content area.
* Provide attribute objects for the cells and views that make up your layout so that the collection view can position each cell and view.  

[Read More...](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/CreatingCustomLayouts/CreatingCustomLayouts.html)  


## Changing the Section Spacing 
Asks the delegate for the margins to apply to content in the specified section.
```swift 
optional func collectionView(_ collectionView: UICollectionView, 
                      layout collectionViewLayout: UICollectionViewLayout, 
           insetForSectionAt section: Int) -> UIEdgeInsets
```

Asks the delegate for the spacing between successive rows or columns of a section.
```swift 
optional func collectionView(_ collectionView: UICollectionView, 
                      layout collectionViewLayout: UICollectionViewLayout, 
minimumLineSpacingForSectionAt section: Int) -> CGFloat
```

Asks the delegate for the spacing between successive items in the rows or columns of a section.
```swift 
optional func collectionView(_ collectionView: UICollectionView, 
                      layout collectionViewLayout: UICollectionViewLayout, 
minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
```


## Resources 
[UICollectionView](https://developer.apple.com/documentation/uikit/uicollectionview)  
[About iOS Collection Views](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Introduction/Introduction.html)  
[Using the Flow Layout](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/UsingtheFlowLayout/UsingtheFlowLayout.html)  
[UICollectionViewFlowLayout](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout)  
[UICollectionViewDelegateFlowLayout](https://developer.apple.com/documentation/uikit/uicollectionviewdelegateflowlayout)  
[Creating Custom Layouts](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/CreatingCustomLayouts/CreatingCustomLayouts.html#//apple_ref/doc/uid/TP40012334-CH5-SW1)  
