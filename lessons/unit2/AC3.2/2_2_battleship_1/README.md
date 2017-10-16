# Standards

* Understand the basic elements of an iOS project
* Understand principles of class design and reuse
* Understand the view hierarchy
* Understand the workings of the MVC pattern

# Objectives

Students will be able to:

* Pin a view to its container

# Resources

[UITabBarController](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/ViewControllerCatalog/Chapters/TabBarControllers.html#//apple_ref/doc/uid/TP40011313-CH3-SW1)


## Homework Assignment

Before continuing on to today's assignment you must hand in your homework:

1. Commit your changes locally, either through XCode or 

```
git commit -a -m "Homework submission"
```

2. Make a pull request on my repo, the ```master``` branch (this is the default).

### Exercise: Computer-vs-human

For this exercise we're going to work off a ```branch``` of the repo.

1. If you haven't already, in your Battleship directory, add my repo as the upstream:

```
git remote add upstream https://github.com/jgresh/Battleship.git
```

2. Fetch my version of the completed homework on the branch computer-vs-human into
a branch of the same name:

```
git fetch upstream computer-vs-human:computer-vs-human
git checkout computer-vs-human
```

Compile and run the project. See how it works and understand it. You'll be extending 
from this version. Don't worry, your changes are still on the ```master``` branch. Ignore the
specific ```ship``` part of the enum for now. My code doesn't do anything with it.

3. Branch from computer-vs-human to human-vs-computer

```
git checkout -b human-vs-computer
```

This makes a copy of computer-vs-human on a branch where you can make independent changes. 

4. This time, build an interface for you to select the placement of ships. Then, in an **unintelligent**
loop over every value, have the computer "guess" at the squares. The first step of changing the 
context/mode of the app is the key element here and the computer guessing is just preparation
for the human-vs-human version. **Work in teams. Divide up work.**

5. (Later, probably tomorrow) Build a true human-vs-human version. This requires a lot of thinking
about interface. You will need to keep the state of two boards.


