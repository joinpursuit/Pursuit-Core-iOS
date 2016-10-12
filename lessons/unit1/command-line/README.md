- title: Console apps in Swift - I/O with stdin an stdout
- tags: console, command line, operating system

# Objectives
* Understand what an operating system is
* Understand where a program one writes lives within the operating system
* Understand how to get data in and out of that program
* Return values to the OS


# Resources
[Operating Systems](https://en.wikipedia.org/wiki/Operating_system)

[Shells](https://en.wikipedia.org/wiki/Shell_(computing))

#Lecture

## Operating Systems
* What is an Operating System?
![Figure 1. - Operating System Layers](https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/Operating_system_placement.svg/330px-Operating_system_placement.svg.png)

* Examples of well known OS’s
	* Compare some
  	* Interface differences
  	* Multiuser differences
* Compare iOS with OSX
	  * Pretty similar
	  * Phone is every bit as much a computer as a laptop/desktop
* Name an app that is in both OSs
  	* Safari
    	 * Facebook
    	 * Twitter
    	 * Tumblr
	* Evernote
* Computer systems are highly layered
	* provide the minimum needed at each layer
	* simplicity
	* stability
	* security
* Shells
	* Graphical shells
	* Command Line shells
		* What Operating System runs "under" OSX
		* How do we "talk to UNIX"? The terminal
		* Run Terminal
			* pwd
			* ls
			* echo
			* date - note how it agrees with the clock in the menu
			* open .
	* Environment
	* Apart from layers shells also imply more than one way to do the same thing
		* Do you know what DOS in MS-DOS stands for?
		* Disk might not even be a disk anymore
* As programmers, much of the time we're thinking only about our code and how it runs and not the environment it runs in and this is good but some input from the user is needed to, at the very least, start our program and maybe interact further with it. Up until this point we've mostly hard coded values into our programs which, if you think of it, is a primitive way of interacting with the only user: you.

##Input and Output
* What is input? 
	* Think back to the apps we talked about. Where do they get their input?
* What is output? Where does it go to?
	* Think back to the apps we talked about. Where do they put their output?
* Input/output is a breakdown of the broader idea of interface

## Command Line Interface
This all sets us up for today's main topic which is how to interact with the user when writing a command line application. The good news is that we're going to be focusing mainly on building apps with beautiful graphical interfaces but text based interfaces have a very important place too.

* Why?
	* Actually very powerful - learning to use and write command driven applications has many uses and deepens your toolkit and professional worth
	* There is a rich history of it and some tools either don't exist graphically or are really much clunkier to work with.
	* git is a good example
	* Most SO solutions to git and other problems will assume command line proficiency 
	* Imperative for interview exercises

* Swift
	* [readLine](https://developer.apple.com/library/watchos/documentation/Swift/Reference/Swift_StandardLibrary_Functions/index.html#//apple_ref/swift/func/s:Fs8readLineFT12stripNewlineSb_GSqSS_)
	* [print](https://developer.apple.com/library/watchos/documentation/Swift/Reference/Swift_StandardLibrary_Functions/index.html#//apple_ref/swift/func/s:Fs5printFTGSaP__9separatorSS10terminatorSS_T_)
	* Can't use Playgrounds. Based on what we learned today and what you know of playgrounds, can you theorize why?
	* Must write Console App (Mac OSX)
	* print, we're already familiar with but has more features we should look at
* CR/LF
	* visualize a typewriter
	* another reminder of how literal computers are
	* comes into play with readLine and its agurment to strip the newline or not
	* comes into play with print's terminator parameter
* Exercises
	* create a Command Line Tool project
	* write "echo"
	* write "dfn" (days from now)
	* run inside Xcode
	* find in Finder
	* run from Terminal
	* read from file

# Code
## echo
```swift
print("Type something, please: ", terminator: "")
if let response = readLine(stripNewline: true) {
    print("You wrote this: \(response)")
}
else {
    print("You gotta enter something")
}
```

## dfn
```swift
print("How many days in the future: ", terminator: "")
if let response = readLine(stripNewline: true), days = Double(response) {
    let aDate = NSDate()
    let futureDate = aDate.dateByAddingTimeInterval(24*60*60*days)
    print("\(days) days in the future will fall on the date \(futureDate)")
}
else {
    print("Something went wrong with what you entered. Should be a number.")
}
```