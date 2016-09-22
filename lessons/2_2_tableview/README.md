# Standards

* Understand the basic elements of an iOS project
* Understand the view hierarchy
* Understand the workings of the MVC pattern
* Understand protocols and delegation
* Understand Table Views

# Objectives

Students will be able to:

* Build and populate TableViews 

# Resources

## Table View Documentation

These pages aren't very long, except for the last, so you should be able to read each
carefully. Don't confuse a ```UITableView``` (which is a descendent of ```UIView```) with a ```UITableViewController```,
which is a subclass of view controller.
We can, and often do, control a ```UITableView``` from other view controllers. But ```UITableViewController``` is
handy as a pre-baked ```UITableView``` ready view controller used for simple implementations of table views.

Pay special attention to the realationship between UITableView and its two protocols ```UITableViewDataSource```
and ```UITableViewDelegate```.

* https://developer.apple.com/reference/uikit/uitableview
* https://developer.apple.com/reference/uikit/uitableviewdatasource
* https://developer.apple.com/reference/uikit/uitableviewdelegate
* https://developer.apple.com/reference/uikit/uitableviewcontroller
* Although it's woefully outdated and in Objective-C the diagrammatic part of [this overview](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/TableView_iPhone/CreateConfigureTableView/CreateConfigureTableView.html) is useful.


# Lecture

Today's lesson will be to build [C4Q Movie Reel](https://github.com/C4Q/AC3.2-Tableviews_Part_1). Fork the 
project at that URL, and clone it to your laptop.

# Assessment Dry Run

1. Fork [this](https://github.com/C4Q/AC3.2Unit-Midunit-Mock) repo which has only a README.md and .gitignore.
2. Clone it locally.
3. Create a project into that cloned directory. Name it AC32UnitMidunitMock.
4. Code like the dickens. Or pretend to.
5. Upon completion/satisfaction/resignation, add the project files to the repo.
```
git add .
```
6. Commit them locally.
```
git commit -a -m "First, and in this case, final commit"
```
7. Push to your repo.
```
git push origin master
```
8. Go to github and make a pull request.
