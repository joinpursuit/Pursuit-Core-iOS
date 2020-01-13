# Advanced Auto Layout

## Objectives

## Resources

- [The Algebra of UI Layout Constraints](http://croisant.net/blog/2016-02-24-ui-layout-constraints-part-1/)
- [AutoResizingMask](http://www.thecodedself.com/autoresizing-masks/)


# 1. Auto Layout Introduction

We've been using Auto Layout to build the UI for all of the apps we've created so far.  But what is it?  Auto Layout is an algorithm that takes in objects and constraints as input, and outputs the appropriate positions for each object.  The algorithm that does this uses the [Simplex Algorithm](http://fourier.eng.hmc.edu/e176/lectures/NM/node32.html) to identify the constraints.  There's a lot of very high level math in the link above, but the basic idea goes like [this](http://croisant.net/blog/2016-02-24-ui-layout-constraints-part-1/):

Imagine we have a view like below:

![https://croisant.net/assets/2016/02/example-ui-layout.png](https://croisant.net/assets/2016/02/example-ui-layout.png)

And the following constraints:

1. Both elements should be as wide as possible, but it is most important for B to be as wide as possible.
1. B must be at least 50 pixels wide.
1. T must be at least twice as wide as B.
1. Both elements side by side must fit in a 300 pixel wide area.

We can rewrite these mathematically:

1. Maximize 10b + t, subject to:
1. b ≥ 50
1. t ≥ 2b
1. b + t ≤ 300

For point (1), we state that we want to maximize the combined width (b+t).  We give `b` a coefficient of 10, because it's more important to maximize `b`.

We can then graph each of the inequalities:

![https://croisant.net/assets/2016/02/linear_prog.jpg](https://croisant.net/assets/2016/02/linear_prog.jpg)

The yellow area represents all values of `b` and `t` that satisfy the inequalities.  Our task is then to *maximize* the width.  We can see here that either of the top two corners is the highest possible value.

It's easy to visualize with only three constraints, but if we had dozens or hundreds of constraints, we'd be unable to see what the solution was from graphing it.  The Simplex Algorithm does this work for us, and is what Auto Layout is based on.

# 2. translatesAutoresizingMaskIntoConstraints

In the days before Auto Layout, iOS applications used a concept called an AutoResizingMask.  You've seen this before in the line:

```swift
myView.translatesAutoresizingMaskIntoConstraints = false
```

And in errors like:

```
2020-01-13 14:42:11.882184-0500 AutoLayoutIntDepth[11495:652214] [LayoutConstraints] Unable to simultaneously satisfy constraints.
	Probably at least one of the constraints in the following list is one you don't want.
	Try this:
		(1) look at each constraint and try to figure out which you don't expect;
		(2) find the code that added the unwanted constraint or constraints and fix it.
	(Note: If you're seeing NSAutoresizingMaskLayoutConstraints that you don't understand, refer to the documentation for the UIView property translatesAutoresizingMaskIntoConstraints)
(
    "<NSAutoresizingMaskLayoutConstraint:0x600001988b40 h=--& v=--& UITableView:0x7ff5b6819200.minY == 0   (active, names: '|':UIView:0x7ff5b5702ad0 )>",
    "<NSLayoutConstraint:0x600001981a40 UITableView:0x7ff5b6819200.top == UILayoutGuide:0x6000003a4380'UIViewSafeAreaLayoutGuide'.top   (active)>",
    "<NSLayoutConstraint:0x60000198b020 'UIViewSafeAreaLayoutGuide-top' V:|-(44)-[UILayoutGuide:0x6000003a4380'UIViewSafeAreaLayoutGuide']   (active, names: '|':UIView:0x7ff5b5702ad0 )>"
)
```

So what is it anyways and why does iOS default to it?

In the time before Auto Layout, iOS development used autoresizing masks, which use a simpler method to dictate how views should shrink and grow.  For every view, you can specify which aspects are flexible with the following properties:

- `UIViewAutoresizingNone`
- `UIViewAutoresizingFlexibleLeftMargin`
- `UIViewAutoresizingFlexibleWidth`
- `UIViewAutoresizingFlexibleRightMargin`
- `UIViewAutoresizingFlexibleTopMargin`
- `UIViewAutoresizingFlexibleHeight`
- `UIViewAutoresizingFlexibleBottomMargin`

Depending on the value of these properties, the view will grow and shrink differently as the view expands or contracts.  This is called a **struts** and **springs** system, where the struts are the distance to its container, and the springs are the height and width.

You can see the effect these have in Storyboard, by selecting the Size Inspector for any view:

![autoresizing](./assets/autoresizing.gif)

With the introduction of Auto Layout, Apple added a bridge where you could take an old application using autoresizing masks, and convert them to new constraints.  This is the `translatesAutoresizingMaskIntoConstraints` property.  You should almost always set this to false and use Auto Layout, but there are [occasional use cases](http://www.thomashanning.com/xcode-8-mixing-auto-autoresizing-masks/) for autoresizing masks.

# 3. Compression Resistance and Content Hugging

# 4. Animating Constraints

# 5. Size Classes

# 6. Visual Format Language
