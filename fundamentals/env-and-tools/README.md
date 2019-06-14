# Tools and Installations

### Objective

* To install the tools (Xcode and Slack) we use during the course
* To register and sign into accounts used during the course (Github and Slack)

### Readings
1. [Marty Aveton's (3.2 graduate) Key Resources](https://medium.com/@MartianAviary/ten-key-resources-for-beginner-ios-devs-caba2b83f67c)
1. [Terminal](https://github.com/joinpursuit/AC_4_Web/blob/master/units/fundamentals/lessons/terminal/cheat_sheet.md)
1. [UNIX Shell](https://en.wikipedia.org/wiki/Shell_(computing))

#### Resources

1. [The Swift Programming Language Guide](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html)
1. [Intro to App Development with Swift - Apple](https://itunes.apple.com/us/book/intro-to-app-development-with-swift/id1118575552?mt=11)
1. [Git configuration](https://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration)

#### Vocabulary

1. **operating system** - Software that is responsible for running programs and managing resources on a computer.
1. **shell** - A command line interface or window onto an operating system.
1. **text file** - A document without visual formatting. Swift files are text files.
1. **path** - The address of a file or folder on your computer such as `/Users/elmo/Desktop/Garden.png`.

---

## Laptop Account

If you are using a loaner laptop, we suggest you create your own user account.

Creating your own account on a Mac:

1. Choose Apple menu > System Preferences, then click Users & Groups.
1. Click the "lock" icon to unlock the users, then enter an administrator name and password.
1. Click the Add (+) button below the list of users.
1. In the pop-up, click the "New Account" menu, then choose an "Administrator" type of user.
1. Enter a full name for the new user, and a password that you will remember.

### Apple Developer Account

The "free tier" Apple developer account enables most of Apple's development features, except for a few (most notably, deploying applications to the App Store and configuring Remote Push Notifications). The cost of the Paid membership is $99 per year. Sign up and create a free developer account [here](https://developer.apple.com/programs/how-it-works/).

### Xcode

If you haven't installed *Xcode*, proceed to the installation instructions below:

1. From your Macbook, open the App Store.
1. Search for *Xcode*.
  	**Note:** Make sure you’re downloading Version 10. Do not download Xcode 11 Beta at this point in time.
1. Press ‘Get’ and then ‘Install App’.
1. You will now be prompted to provide your AppleID. If you do not have one, create one. Once you’ve provided a correct AppleID, click `Buy`.
	**Note:** Xcode is free. You do not have to make any purchases to download and use Xcode.
1. When download is complete, open *Xcode* from your Applications folder.
1. The first time you open *Xcode* it will ask to install some additional components. Allow it to do so.
1. Once complete, you should see a “Welcome to Xcode” screen.
1. Congratulations! You have successfully downloaded and installed Xcode.

#### Activity:

Let's see what Xcode's Playgrounds are all about.

1. Download the [Intro to App Development with Swift](https://itunes.apple.com/us/book/intro-to-app-development-with-swift/id1118575552?mt=11) book and open it in iBooks.
1. Read the short introductory material and on page 5 "Getting Started" download the project files that go with the course. I've linked them [here, too.](https://developer.apple.com/sample-code/swift/downloads/app-dev-curriculum.zip)
1. This will create a folder named _Intro to App Development Curriculum_ in your Downloads folder. (It's possible you'll get a zipped file instead, named _app-dev-curriculum.zip_. If so, double click it in the Finder.)
1. Make a folder in your home directory named _Projects_ and move the _Intro to App Development Curriculum_ there.
1. Open the 01_PlaygroundBasics.playground in Xcode.
1. Follow the lesson in the playground.
1. Return to the iBook and complete the Check Your Understanding and finish the chapter.

### Github

*Git* is a source control system that greatly facilitates collaboration on coding projects. *Github* is a hosted git repository. It serves as a centralized place to collaborate on and share code.

[Create a github account](http://github.com) if you don't already have one.

We interact with it mainly in Terminal. Both Terminal and Git require some explicit attention to learn and should not be considered outside the scope of your work.

Git should already be installed on your machine but we should configure it. Run the following commands, one at a time and with correct information from the terminal, leaving out the dollar sign prompt.

```bash
$ git config --global user.name "John Doe"
$ git config --global user.email johndoe@example.com
```

[Github Hello World project - an introduction to the Github platform](https://guides.github.com/activities/hello-world/#commit)

### Canvas

[Canvas](https://canvas.instructure.com/courses/1605734/assignments/syllabus) is our key organizational tool. In it, you'll find a schedule of lessons and assignments.

You should have already received an email from Canvas asking you to register. You will need to register before you can participate in the class.

If you haven't already, please create a new account and make sure you set your Time Zone to "Eastern Time". You can then accept the invitation.

### Slack

*Slack* is our less-formal, more immediate messaging/chat app. It should be used for quick, short-term communication and is **not preferred** for anything you would want to save long-term.

1. Join the `pursuit-core.slack.com` workspace [link](http://pursuit-core.slack.com).
2. You will be prompted to enter your email address. Enter it and hit the green button.
3. Check your email for the confirmation and click "Confirm Email".
4. Enter your name and choose a user name.
5. Create a password.
6. You should be brought to the web app, ready to go!
7. Download and install the desktop app from http://slack.com
8. Optionally, you can install the mobile client on your iPhone or Android phone.

### Terminal

*Terminal* is a program on your Mac that gives a text-based interface to your computer. This is sometimes called a *CLI*, which stands for "command line interface". Since the Mac's operating system (macOS) is a version of UNIX, much of what you discover about UNIX will be applicable to the Mac's command line.

Here is an example of a command typed into Terminal.

```bash
$ ls

Applications	Library		Projects
Desktop		Movies		Public		
Documents	Music		Sites		iPhone
Downloads	Pictures			

```

Explanation: `ls` is the command. In order to execute the command, we press the return/enter key. The four lines after are the output.

#### File System

Many of the Terminal commands are for navigating the file system. The file system is your files and folders. Everything you see and do in *Finder* (the graphical app used to navigate files) can be done in Terminal by entering commands.


##### File system commands

|Command |Description|Example|
|:------:|:---------:|:-----:|
| pwd    | "print working directory", tells you what directory (folder) you are in | pwd -> /Users/lara |
| ls     | lists all files and folders in the directory | ls |
| cd     | "change directory", moves to a directory | cd Desktop |
| rm     | "remove", deletes a file (careful! THERE IS NO UNDO) | rm README.md |
| mkdir  | Makes an empty folder in the current directory | mkdir SurveyInformation |


##### Special file names
|Name    |Description|Example|
|:------:|:---------:|:-----:|
| .      | The current directory | ls . |
| ..     | The parent directory | ls .. |
| ~      | Your _home_ directory | ls ~ |
| /      | The root directory | ls / |
| ../..  | Parent's parent's directory | ls ../.. |


##### Reading and writing files

|Command |Description|Example|
|:------:|:---------:|:-----:|
| cat  _file_ | Displays the text of a file in terminal | cat README.md |
| more _file_ | Displays the text of a file in terminal, with paging | more README.md |
| open _file_ | Opens a file using the associated program | open README.md |
| nano _file_ | Edit a file in the terminal | nano README.md |


The dollar sign is a _prompt_. Don't type the "$" character itself!

You type your command after the prompt and hit enter. Some commands "take" one or more arguments, which are inputs separated by a space. Some commands don't take any arguments.

Here is a command that is being given one argument:

```bash
$ git log
```

#### Helpful terminal commands

|Command |Description|Example|
|:------:|:---------:|:-----:|
| man    | "manual", prints comprehensive documentation to the window | man ls|
| pwd    | "print working directory", tells you your directory/folder | pwd -> /Users/lara |
| ls     | lists all files in the directory | ls |
| cd     | "change directory", moves to a directory | cd Desktop |
| rm     | "remove", deletes a file (careful! THERE IS NO UNDO) | rm README.md |
| mkdir  | Makes an empty folder in the current directory | mkdir SurveyInformation |
| cat    | Displays the text of a file in terminal | cat README.md |
| more   | Displays the text of a file in terminal, with paging | more README.md |
| open _file_     | Opens a file using the associated program | open README.md |
| git clone (URL) | makes a local copy of a git repo in the current directory | git clone website.git|

#### Standards

Engineering Foundations: EF.2, EF.3
