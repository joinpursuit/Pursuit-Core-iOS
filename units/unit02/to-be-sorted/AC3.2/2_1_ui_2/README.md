# Standards

* Understand the basic elements of an iOS project
* Understand principles of class design and reuse
* Understand the view hierarchy
* Understand the case for Generics and how they're used in the library

# Objectives

Students will be able to:
* Iterate over subviews
* Create a Tab Controller based project
* Create a new ViewController


# Resources

[UITabBarController](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/ViewControllerCatalog/Chapters/TabBarControllers.html#//apple_ref/doc/uid/TP40011313-CH3-SW1)

Hacking With Swift: Chapter 22: Generics

### The View Hierarchy

#### Iterate over subviews

```swift
for v in view.subviews {
    if let button = v as? UIButton {
        button.backgroundColor = UIColor.lightGrayColor()
    }
}
```

Questions:
* What is the ```as?``` doing?
* Why do we need it in this case?

#### Debug the View Hierarchy

XCode has a feature/button that allows you to inspect the view hierarchy. It's the button in 
the Debug bar that looks a little like a cross or a band-aid. It's only present when the app is
running. It automatically pauses the app when you enable it.

### Exercise: Multiple Monty via Tabs

Let's unhack our XCode project and have multiple View Controllers living inside a Tab Bar Controller.

1. Create a new project in XCode, this time choosing "Tabbed Application".
1. Copy over the model.
1. Copy over/rework the storyboard based and programmatic view controllers.

## Generics

```swift
func myMap<T,U>(items: [T], f: (T) -> (U)) -> [U] {
	var result = [U]()
	for item in items {
		result.append(f(item))
	}
	return result
}
```

### Exercise

Write a generic myFilter using myMap as a model.



