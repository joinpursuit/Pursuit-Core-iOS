# Tools and Installations

### Objective

* To install the tools (Xcode and Slack) used during the course
* To register and sign into accounts used during the course (Github and Slack)

### Readings
1. [Marty Aveton's (C4Q 3.2 graduate) Key Resources](https://medium.com/@MartianAviary/ten-key-resources-for-beginner-ios-devs-caba2b83f67c)
1. [Terminal](https://www.imore.com/how-use-terminal-mac-when-you-have-no-idea-where-start)
1. [UNIX Shell](https://en.wikipedia.org/wiki/Shell_(computing))

#### Resources

1. [Intro to App Development with Swift - Apple](https://itunes.apple.com/us/book/intro-to-app-development-with-swift/id1118575552?mt=11)
1. [Git configuration](https://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration)

#### Vocabulary

1. **operating system** - Software that is responsible for running programs and managing reources on a computer.
1. **shell** - A command line interface or window onto an operating system.
1. **text file** - A document without visual formatting. Swift files are text files.
1. **path** - The address of a file or folder on your computer such as `/Users/elmo/Desktop/Garden.png`.

---

### Xcode

1. From your Macbook, open the App Store.
2. Search for *Xcode*.
  	**Note:** Make sure you’re downloading Version 8. Do not download Xcode Beta 9 at this point. 
3. Press ‘Get’ and then ‘Install App’. 
4. You will now be prompted to provide your AppleID. If you do not have one, create one. Once you’ve provided a correct AppleID, click Buy.
	**Note:** Xcode is free. You do not have to make any purchases to download and use Xcode.
4. When download is complete, open *Xcode* from your Applications folder. 
5. The first time you open *Xcode* it’ll ask to install some additional components. Allow it to do so.
6. Once complete, you should see a “Welcome to Xcode” screen. 
7. Congratulations! You have successfully downloaded and installed Xcode.

#### Activity: 

Let's see what Xcode's Playgrounds are all about. 

1. Download the [Intro to App Development with Swift](https://itunes.apple.com/us/book/intro-to-app-development-with-swift/id1118575552?mt=11) book and open it in iBooks.
1. Read the short introductory material and on page 5 "Getting Started" download the project files that go with the course. I've linked them [here, too.](https://developer.apple.com/sample-code/swift/downloads/app-dev-curriculum.zip)
1. This will create a folder named _Intro to App Development Curriculum_ in your Downloads folder. (It's possible you'll get a zipped file instead, named _app-dev-curriculum.zip_. If so, double click it in the Finder.)
1. Make a folder in your home directory named _Projects_ and move the _Intro to App Development Curriculum_ there.
1. Open the 01_PlaygroundBasics.playground in Xcode.
1. Follow the lesson in the playground.
1. Return to the iBook and complete the Check Your Understanding and finish the chapter.

### Git

Git is a source control system that greatly facilitates collaboration on coding projects. We interact with it mainly in Terminal. Both Terminal and Git require some explicit attention to learn and should not be considered outside the scope of your work.

Git should already be installed on your machine but we should configure it. Run the following commands, one at a time and with correct information from the terminal, leaving out the dollar sign prompt.

```bash
$ git config --global user.name "John Doe"
$ git config --global user.email johndoe@example.com
```

### Sublime

Sublime Text is a text editor useful for editing files outside of Xcode, and without the word processing formatting overhead of applications like TextEdit, Word or Google Docs. Eventually you will need to make short edits to plain text files. We will also use sublime for handling interactive git message editing.

Dowload and install [Sublime Text](https://www.sublimetext.com/). Once it's up and running 

#### Sublime as git editor

https://gist.github.com/geekmanager/9939cf67598efd409bc7

```bash
ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/sublime
git config --global core.editor "sublime -n -w"
```

### Canvas

[Canvas](https://canvas.instructure.com/courses/1186749) is our key organizational tool. You'll find a schedule of lessons and assignments in it.

You should have received an email already from Canvas asking you to register before you can participate in the class.

If you haven't already please create a new account and make sure you set your Time Zone to "Eastern Time". You can then accept the invitation.

### Piazza

Piazza is our question and answer system.

Follow the link [here](piazza.com/access_code/fall2017/iosbridge) to create an account.  Enter the code "iosbridge".

### Slack

Slack is our less-formal, more immediate messaging/chat app. It should be used for quick short term communication and is not preferred for anything you would want to save long term.

1. To sign up for slack go to this [link](https://join.slack.com/t/c4qbridge-iosdays/shared_invite/MjI0MDgwMjY4NTE3LTE1MDIyMjU3NzQtZThhMjFkZTRlZQ). 
2. You will be prompted to enter your email address. Enter it and hit the green button.
3. Check your email for the confirmation and click "Confirm Email".
4. Enter your name and choose a user name.
5. Create a password.
6. You should be brought to the web app, ready to go!
7. Download and install desktop client from http://slack.com
8. Optionally install the mobile client.

### Github

Github is a hosted git repository. It serves as a centralized place to collaborate on and share code.

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



