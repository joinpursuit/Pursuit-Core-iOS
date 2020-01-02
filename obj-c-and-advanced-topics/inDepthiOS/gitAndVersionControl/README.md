# Git and Version Control

## Resources

 - [Version Control](http://www.catb.org/~esr/writings/version-control/version-control.html)
 - [Git cheatsheet](http://ndpsoftware.com/git-cheatsheet.html)
 - [Try Git](http://try.github.io)
 - [Pro Git ebook](https://git-scm.com/book/en/v2)
 - [Learn Enough Git To Be Dangerous](https://www.learnenough.com/git-tutorial)
 - [Oh Shit, Git!](https://ohshitgit.com/)

## Objectives

- Understand the problem that version control solves
- Use common git commands to navigate through a file
- Use Git Flow to manage a project
- Use different strategies to resolve merge conflicts

# 1. Version Control

## Locking

In the early days of software development, version control was accomplished with *locks*.  All files are read-only, so no one can edit them.  If you want to edit a file, you tell the system what file you want to be editing, and it gives you write access.  It also puts a lock on it that prevents anyone else from requesting edit access for that file.  From [http://www.catb.org/~esr/writings/version-control/version-control.html](http://www.catb.org/~esr/writings/version-control/version-control.html):

"When a locking strategy is working well, workflow looks something like this:

1. Alice locks the file foo.c and begins to modify it.
1. Bob, attempting to modify foo.c, is notified that Alice has a lock on it and he cannot check it out.
1. Bob is blocked and cannot proceed. He wanders off to have a cup of coffee.
1. Alice finishes her changes and commits them, unlocking foo.c.
1. Bob finishes his coffee, returns, and checks out foo.c, locking it.


Unfortunately workflow too often looks more like this:

1. Alice locks the file foo.c and begins to modify it.
1. Bob, attempting to modify foo.c, is notified that Alice has a lock on it and he cannot check it out.
1. Alice gets a reminder that she is late for a meeting and rushes off to it, leaving foo.c locked.
1. Bob, attempting to modify foo.c, is notified that Alice has a lock on it and he cannot check it out.
1. Bob, having been thwarted twice and wasted a significant fraction of his day waiting on the lock, curses feelingly at Alice. He informs the VCS he wants to steal the lock.
1. Alice returns from the meeting to find mail or an instant message informing her that Bob has stolen her lock.
1. Changes in Alice's working copy are now in conflict with Rob's and will have to be merged later. Locking has proven useless.

That, unfortunately, is the least nasty failure case. If the VCS has no facility for stealing locks, change conflict is prevented but Bob may be blocked indefinitely by Alice's forgotten lock. If Alice is not reliably notified that her lock has been stolen, she may continue working on foo.c only to receive a rude surprise when she attempts to commit it.

Most importantly, in these failure cases locking only defers conflicts that must be resolved by merging divergent changes to foo.c after the fact — it does not prevent them. It scales poorly and tends to frustrate all parties."

To solve the problems seen here, developers created a more robust version control system.

## Commit before merge

Instead of only having one person able to edit a file at a time, any number of people can locally make changes to the file and commit them.  This has the advantage of allowing multiple people to work on the same codebase and files simultaneously.  For example, you can create a feature branch and change files that are also being changed in production.  This allows multiple versions of the codebase to exist in different forms, and be merged in at a later point.

# 2. Git

Git is the most widely used version control system.  Competitors include [Mercurial](https://www.mercurial-scm.org/) and [Subversion (SVN)](https://subversion.apache.org/).

![Git operations](https://en.wikipedia.org/wiki/Git#/media/File:Git_operations.svg)

## Common Git commands

| command | description |
| --- | --- |
| git pull | pull all new commits from upstream |
| git add -A | stage all changes |
| git add /path/to/file | stage all changes at a given filepath |
| git commit -m 'commit message' | commit all staged changes with a given message |
| git push origin HEAD | push all new commits upstream |
| git checkout -b 'new-branch' | create a new branch |
| git checkout 'existing-branch' | switch over to an existing branch |
| git checkout /path/to/file | permanently delete all unstaged changes at a given filepath |
| git branch | view the current branch |
| git remote add origin 'https://github.com/username/projectName.git' | Link a local project to an project in github |
| git push -u origin master | use the first time pushing changes to a new remote repo to configure tracking |

# 3. Git Flow

![git flow diagram](https://nvie.com/img/git-model@2x.png)

In Git Flow, there are two main branches:

- master
- developer

 And  three additional supporting kinds of branches:

- Feature branches
- Release branches
- Hotfix branches

When you want to add something to the codebase, branch off of develop.  Make the changes that you want, then merge it back into develop.  This is in effect a short lived feature branch.  If it needs to live longer, other people can collaborate in that feature branch until it is ready to be merged into develop.

To release something, branch off of develop into a release branch, then merge the release branch into master. Only branch off of master in emergency cases like creating hotfixes for serious bugs.

# 4. Resolving merge conflicts
