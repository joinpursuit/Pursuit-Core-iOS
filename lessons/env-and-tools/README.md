# Install Xcode

1. From your Macbook, open the App Store.
2. Search for *Xcode*.
  * Note: Make sure you’re downloading Version 7.3.1. Do not download Xcode Beta 8 at this point. 
3. Press ‘Get’ and then ‘Install App’. 
4. You will now be prompted to provide your AppleID. If you do not have one, create one. Once you’ve provided a correct AppleID, click Buy.
  * Note: Xcode is free. You do not have to make any purchases to download and use Xcode.
4. When download is complete, open *Xcode* from your Applications folder. 
5. The first time you open *Xcode* it’ll ask to install some additional components, allow it.
6. Once complete, you should see a “Welcome to Xcode” screen. 
7. Congratulations! You have successfully downloaded Xcode. Now you’re able to do the pre-work assignment in directory: /lessons/prework 

# Install Slack
1. Download and install desktop client from http://slack.com
2. Optionally install the mobile client.

# Setup github
## Create a github account

[Create a github account](http://github.com) if you don't already have one.

#Terminal commands
Note: Commands will look like 

```shell
$ git add -A
```
The dollar sign just indicates that it's a terminal command.  Don't type the "$" character.

##Helpful terminal commands

|Command |Description|Example|
|--------|-----------|-------|
| pwd    | "print working directory", it tells you your directory/folder | pwd -> /Users/lara |
| cd     | "change directory", this moves to a directory | cd Desktop |
| ls     | lists all files in the directory | ls |
| rm     | "remove", this deletes a file (careful! NO UNDO) | rm README.md |
| mkdir  | Makes an empty folder in the current directory | mkdir SurveyInformation |
| cat    | Displays the text of a file in terminal | cat README.md |
| more   | Displays the text of a file in terminal, with paging | more README.md |
| open _file_     | Opens a file using the associated program | open README.md |
| git clone (URL) | makes a local copy of a git repo in the current directory | git clone https://github.com/C4Q/AC3.2.git |
| git add -A | Adds the changes you've made to the "index"| git add -A |
| git commit -m "commit message" | Commits your changes | git commit -m "updated the examples in the table"
| git pull   | Updates your local copy to match what it's cloned from | git pull origin master |
| git status | Shows you the current state of your "working tree" | git status |
| git diff   | Shows all the differences between your working tree and the previous version | git diff |

* Google for "unix commands"
* Google for "git cheatsheet"

## Creating Pull Requests

1) Fork the repo
![Fork Image]
(resources/ForkButton.png)

2) A popup will come up asking what repo you want to fork it to. Select your profile.

3) You should now be on your own profile viewing the forked repo

4) Make some changes to the project:
* Click on the README.md file.  
![README image]
(resources/ReadmeButton.png)

* Then click on the edit button.
![edit image]
(resources/EditButton.png)

*Add a line with your name and a custom message.

5) Commit your changes in terminal

6) Create a pull request in Github
![Pull Request Image]
(resources/PullRequestImage.png)

7) Make sure the left side is the original and the right side is your version
![Pull Request Comparison Check Image]
(resources/CompareCheck.png)
