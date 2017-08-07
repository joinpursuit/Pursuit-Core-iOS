# Tools and Installations

### Objective

* To install the tools (XCode and Slack) used during the course
* To register and sign into accounts used during the course (Github and Slack)

### Readings
1. [Marty Aveton's (3.2 grad) Key Resources](https://medium.com/@MartianAviary/ten-key-resources-for-beginner-ios-devs-caba2b83f67c)
1. [Terminal](https://www.imore.com/how-use-terminal-mac-when-you-have-no-idea-where-start)
1. [UNIX Shell](https://en.wikipedia.org/wiki/Shell_(computing))

#### Resources

1. [Intro to App Development with Swift - Apple](https://itunes.apple.com/us/book/intro-to-app-development-with-swift/id1118575552?mt=11)


#### Vocabulary

1. **operating System** - Software that is responsible for running programs and managing reources on a computer.
1. **shell** - A command line interface or window onto an operating system.
1. **path** - The address of a file or folder on your computer such as /Users/elmo/Desktop/Garden.png.

---

### Xcode

1. From your Macbook, open the App Store.
2. Search for *Xcode*.
  * Note: Make sure you’re downloading Version 8. Do not download Xcode Beta 9 at this point. 
3. Press ‘Get’ and then ‘Install App’. 
4. You will now be prompted to provide your AppleID. If you do not have one, create one. Once you’ve provided a correct AppleID, click Buy.
  * Note: Xcode is free. You do not have to make any purchases to download and use Xcode.
4. When download is complete, open *Xcode* from your Applications folder. 
5. The first time you open *Xcode* it’ll ask to install some additional components. Allow it to do so.
6. Once complete, you should see a “Welcome to Xcode” screen. 
7. Congratulations! You have successfully downloaded and installed Xcode.

### Canvas

### Piazza

### Slack
1. Download and install desktop client from http://slack.com
2. Optionally install the mobile client.

### Github

## Create a github account

[Create a github account](http://github.com) if you don't already have one.

### Terminal

*Terminal* is a program on your Mac that gives a text based interface to your computer. This is sometimes called a CLI for command line interface. Since the Mac's operating system (OS) is a version of UNIX much of what you discover about UNIX will be applicable to the Mac's command line.

An example of a command typed into Terminal. 

```bash
$ ls

Applications	Library		Projects
Desktop		Movies		Public		
Documents	Music		Sites		iPhone
Downloads	Pictures			
					
```

Broken down, `ls`, followed by the return/enter key is the command. The four lines after are the output.

#### File System

Many of the basic commands are for navigating the file system. These are your files and folders. All you see and do in *Finder* (the graphical app used to navigate files) can be done in Terminal on the command line.


##### File system commands 

|Command |Description|Example|
|--------|-----------|-------|
| pwd    | "print working directory", it tells you your directory/folder | pwd -> /Users/lara |
| ls     | lists all files in the directory | ls |
| cd     | "change directory", this moves to a directory | cd Desktop |
| rm     | "remove", this deletes a file (careful! NO UNDO) | rm README.md |
| mkdir  | Makes an empty folder in the current directory | mkdir SurveyInformation 

##### Special file names
|Name    |Description|Example|
|--------|-----------|-------|
| .      | The current directory | ls . |
| ..     | The parent directory | ls .. |
| ~      | Your _home_ directory | ls ~ |
| /      | The root directory | ls / |
| ../..  | Parent's parent's directory | ls ../.. 


##### Reading and writing files

|Command |Description|Example|
|--------|-----------|-------|
| cat    | Displays the text of a file in terminal | cat README.md |
| more   | Displays the text of a file in terminal, with paging | more README.md |
| open _file_     | Opens a file using the associated program | open README.md |
| nano _file_     | Edit a file in the terminal | nano README.md |


The dollar sign is a _prompt_. You type your command after it and hit enter. Some commands take one or more arguments (inputs). Some don't. Don't type the "$" character itself.

A command that's being given one argument.

```bash
$ git log
```

#### Helpful terminal commands

|Command |Description|Example|
|--------|-----------|-------|
| man    | "manual", it prints comprehensive documentation to the window | man ls|
| pwd    | "print working directory", it tells you your directory/folder | pwd -> /Users/lara |
| ls     | lists all files in the directory | ls |
| cd     | "change directory", this moves to a directory | cd Desktop |
| rm     | "remove", this deletes a file (careful! NO UNDO) | rm README.md |
| mkdir  | Makes an empty folder in the current directory | mkdir SurveyInformation |
| cat    | Displays the text of a file in terminal | cat README.md |
| more   | Displays the text of a file in terminal, with paging | more README.md |
| open _file_     | Opens a file using the associated program | open README.md |
| git clone (URL) | makes a local copy of a git repo in the current directory | git 

#### Exercises


1. Research the `banner` command and print the following:
	1. "C4Q" name 80 characters wide
	1. "Swift Rules" 132 characters wide.

1. Research the `cal` command and print the following:
	1. This months calendar
	1. This year's calendar
	1. This February
	1. January 1892

1. Research the `ls` command and print the following:
	1. The contents of your home directory
	2. The contents of your Desktop, with timestamps and permissions


