# Standards

* Understand ```Animation```

# Objectives

* Learn about animation using UIView.animate
* Practice performing various kind of animations with different properties
* Understand in what spaces is using animation helpful

# Resources

* [UI Animations in Swift](https://medium.com/written-code/ui-animations-with-swift-2ebb5e6d2292)
* [Animating Constraints](https://medium.com/@sdrzn/animating-constraints-using-ios-10s-new-uiviewpropertyanimator-944bbb42347b)
* [Apple Developer Docs](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/ViewPG_iPhoneOS/AnimatingViews/AnimatingViews.html#//apple_ref/doc/uid/TP40009503-CH6-SW2)
* [Simple Animations in Swift](https://www.appcoda.com/view-animation-in-swift/)

# Lesson

## Animations

Animation is the visible change of an attribute over time. The properties we change are the ones marked Animatable: * center * alpha * frame * bounds * transform * backgroundColor * contentStretch etc. The changing attribute might be positional: something moves or changes size or a view’s background color or opacity might change.

<details>
<summary> Why might we use animations in our app?</summary>

- Set your app apart
- Improve user experience
- Convey important information to users

</details>


### UIView.animate

Animation in iOS is done by starting an animation block, then telling iOS what changes you want to make. Because the animation block is active, those changes won't happen straight away – instead, iOS will execute them smoothly over the time you specified, so you don't have to worry when it will finish or what all the intermediate states are. The simplest way to employ animations in code are with the animateWithDuration functions provided through UIView:


animateWithDuration:animations:

animateWithDuration:animations:completion:

animateWithDuration:delay:options:animations:completion:


### Example

Here is a simple example of changing a view's background color using AWD
<details>
```
UIView.animate(withDuration: 1, animations: {
    self.yourView.backgroundColor = .red
    
} , completion : nil )
```
</details>
## Exercises

- How would we animate a change in your view's size (frame.size)

<details>
```
UIView.animate(withDuration: 1, animations: {
    self.yourView.frame.size.width += 20
    self.yourView.frame.size.height += 20
} , completion : nil )
```
</details>


- How would we animate a change in your view's position (frame.origin)

<details>
```
UIView.animate(withDuration: 1, animations: {
    self.yourView.frame.origin.x -= 50
    self.yourView.frame.origin.y -= 50
} , completion : nil )
```
</details>

Why do we use the self dot in these functions?

### Animation Options

UIView's come with a number of Animation Options we can pass into our functions in order to change aspects of how our animation works: [AppleDocs](https://developer.apple.com/documentation/uikit/uiviewanimationoptions?language=objc)

For instance we can define our animation curve to be:

.easeInOut - An ease-in ease-out curve causes the animation to begin slowly, accelerate through the middle of its duration, and then slow again before completing.
.easeIn - An ease-in curve causes the animation to begin slowly, and then speed up as it progresses.
.easeOut - An ease-out curve causes the animation to begin quickly, and then slow down as it completes.
.linear - A linear animation curve causes an animation to occur evenly over its duration.
    