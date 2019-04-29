# UIScrollView 

## Vocabulary 

- content view
- contentSize 
- zoomScale 
- minimumZoomScale 
- maximuZoomScale

## UIScrollView 

A view that allows the scrolling and zooming of its contained views.

**Overview**   
UIScrollView is the superclass of several UIKit classes including UITableView, UICollectionView and UITextView.

The central notion of a UIScrollView object (or, simply, a scroll view) is that it is a view whose origin is adjustable over the content view. It clips the content to its frame, which generally (but not necessarily) coincides with that of the application’s main window. A scroll view tracks the movements of fingers and adjusts the origin accordingly. The view that is showing its content “through” the scroll view draws that portion of itself based on the new origin, which is pinned to an offset in the content view. The scroll view itself does no drawing except for displaying vertical and horizontal scroll indicators. The scroll view must know the size of the content view so it knows when to stop scrolling; by default, it “bounces” back when scrolling exceeds the bounds of the content.

The UIScrollView class can have a delegate that must adopt the UIScrollViewDelegate protocol. For zooming and panning to work, the delegate must implement both viewForZooming(in:) and scrollViewDidEndZooming(_:with:atScale:); in addition, the maximum (maximumZoomScale) and minimum ( minimumZoomScale) zoom scale must be different.

## Objectives 

Add a UIScrollView to a scene's view in Storyboard. Add an ImageView to this Scroll View and implement the ability to zoom and pan the image. 


## Zooming an Image using a Scroll View

- set delegate for scrollview on view controller 
- return the image view from viewForZooming() scroll view delegate method
- set the min and max zoom scale 

## Reading 

[UIScrollView](https://developer.apple.com/documentation/uikit/uiscrollview)          
[UIScrollViewDelegate](https://developer.apple.com/documentation/uikit/uiscrollviewdelegate)   
