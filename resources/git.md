
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

5) Commit your changes.

6) Create a pull request in Github
![Pull Request Image]
(resources/PullRequestImage.png)

7) Make sure the left side is the original and the right side is your version
![Pull Request Comparison Check Image]
(resources/CompareCheck.png)

## Git commands
|Git command | description | example|
|---|---|---|
| git clone (URL) | makes a local copy of a git repo in the current directory | git clone https://github.com/C4Q/AC3.2.git |
| git add -A | Adds the changes you've made to the "index"| git add -A |
| git commit -m "commit message" | Commits your changes | git commit -m "updated the examples in the table"
| git pull   | Updates your local copy to match what it's cloned from | git pull origin master |
| git status | Shows you the current state of your "working tree" | git status |
| git diff   | Shows all the differences between your working tree and the previous 

# Git woes and their resolutions divers

### Set up branches

master->develop->(user branch)

1. Clone the repo locally.

2. Copy the master branch to develop.
	
	```
	git checkout -b develop
	```
	This only happens once per team.

3. Copy the develop branch to a user branch
	
	```
	git checkout -b sabrina
	```
	This happens for each member of the team. 

4. Push the develop branch back to the repo.
	
	```
	git push origin develop
	```

5. Remaining team members
	
	```
	git fetch origin develop:develop
	git checkout develop
	git checkout -b erica
	```

### Using github.com

1. Work on your branch. Commit early; commit often.
	
	```
	git commit -a -m "I love coding (and git). I really do."
	```

2. When you like what you have push your branch to the same named branch on the remote repo.
	
	```
	git push origin shashi
	```

3. Make a pull request between your branch and the ```develop``` branch on github.

4. Another member of your team reviews the PRs and merges with the big green button if there
   are no conflicts.

5. If there are conflicts, switch to the appropriate step of the "without github.com" section.

### Without github.com

This is a less communicative option, where you are making unilateral decisions 
about merging code. Best done as a team or at least in communication with the team.

1. Work on your branch. Commit early; commit often.
	
	```
	git commit -a -m "I love coding (and git). I really do."
	```

2. When you like what you have check out the develop branch and sync it up with the remote.
	
	```
	git checkout develop
	git pull origin develop
	```

3. Checkout your branch and merge develop into it. (May result in conflicts). Assuming
   my branch is ```sabrina```.

	```
	git checkout sabrina 
	git merge develop
	```

	It's after the merge command that you would see the conflicts. If there are conflicts
	resolve them and push.

4. Check out develop, merge yours back into it and push.
	```
	git checkout develop
	git merge sabrina // guaranteed to work because you just merged develop into it
	git push origin develop
	```

5. If there are conflicts, switch to the appropriate step of the "without github.com" section.

## Other people's branches

You **can** check out other people's branches, either to run or to merge as we did with develop.


## Useful commands

```
git status
```

Tells you what branch you are on and the state of your files.

```
git branch
```

Lists all branches with a star for the one you're on.

```
git fetch origin shashi:shashi
```

Gets the branch named shashi from the repo and creates a local
branch with the name shashi. (I could have chosen different names but why rename?). 
It doesn't put me on that branch. To do that you need to ```checkout```.

```
git checkout erica
```

Switch to branch erica

```
git checkout -b newbranch
```

This makes a copy of the current branch with the new name specified
by -b. And it puts you on that branch (the checkout part).

## Word of wisdom

You generally want to pull before pushing to a branch. This will happen for branches
like develop that change a lot. You probably don't need to pull from your named branch
because you're the only one likely to push to it.
