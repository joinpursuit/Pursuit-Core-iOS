## Brief Introduction to Github and Terminal

## Objective 

To be able to use Terminal on your mac, git commands and [Github.com](https://github.com). 

## What is Github 

GitHub is a code hosting platform for version control and collaboration. It lets you and others work together on projects from anywhere.

## What is a repository 

A repository is usually used to organize a single project. Repositories can contain folders and files, images, videos, spreadsheets, and data sets – anything your project needs.

## What is Git 

Open source version control system developed by Linus Torvalds in 2005. This is the version control system that Github uses for it's platform.

## What is Terminal

Terminal comes shipped with the macOS operating system. It provides text-based or command-line-interface access to the operating system.

## Terminal Commands 

| Command | Summary |
|:----:|:-----:|
| cd ~/Documents | navigate to the documents directory of your mac |
| pwd | show current directory |
| ls | list contents of current directory |
| mkdir GitIntro | create a folder named GitIntro |
| cd GitIntro | navigate to the newly created GitIntro folder |
| echo "Github Introduction" >> README.md | create a markdown file called README.md |
| touch testFile.txt | also creates a file with a given extension - however won't populate it with text as above |
| open README.md | open the README.md file for editing |

## Git Commands  

| Command | Summary |
|:----:|:-----:|
| git init | initializes (creates) a git repository in the current directory |
| ls -a | list hidden files |
| git status | show status of your local repository |
| git add README.md | add the untrack file to be committed |
| git commit -m "initial commit" | commit and include a message about your commit |
| git remote add origin `<repo url>` | configure the remote repository |
| git push --set-upstream origin master (done on initial setup) | push your changes to the remote repository |
| git push | pushing changes after initial configuration |
| git pull | to pull remote changes if available |
| clone | clone a repository into a newly created directory |
| fork | a copy of a repository. Forking a repository allows you to freely experiment with changes without affecting the original project |

## Github.com 

1. Navigate to [Github](https://github.com)
1. Click on New repository

## Other Resources 

| Resource | Summary |
|:----:|:-----:|
| [Git](https://en.wikipedia.org/wiki/Git) | Wikipedia - Git |
| [Github](https://en.wikipedia.org/wiki/GitHub) | Wikipedia - Github |
| [Github Hello World](https://guides.github.com/activities/hello-world/) | Hello World Tutorial Guide |
| [Terminal User Guide](https://support.apple.com/en-md/guide/terminal/welcome/mac) | Apple - Terminal User Guide |
| [git commands reference](https://git-scm.com/docs) | git commands reference |
| [Fork a repo](https://help.github.com/articles/fork-a-repo/) | Fork a repo |
