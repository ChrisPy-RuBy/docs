title: GIT
summary: everything to do with git.
* * * * *

# useful resources
- - - - - - 
[oh shit git](https://ohshitgit.com/)

[git gix up](https://sethrobertson.github.io/GitFixUm/fixup.html#remove_deep)

[git basics](https://git-scm.com/book/en/v2/Git-Basics-Undoing-Things)

## **setup**
- - - - - 
#### **setuping up git hooks**

```bash 
mkdir -p ~/.git-templates/hooks
git config --global init.templatedir '~/.git-templates'
```

```bash
#!/bin/bash

current_branch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')

if [[ $current_branch == *"tvsrelease"* ]]  
then  
	echo "Trying to push to a protected branch, use a pull request instead"
    exit 1 # push will not execute
else  
    exit 0 # push will execute
fi
```

make sure the file is executable
```bash
chmod a+x ~/.git-templates/hooks/pre-push
```
Then go into all currently checked out repositories (backend, frontend, common, misc, anisble etc.) and do git init.
It should automatically run git init and insert the hook when you do git clone to get a new repository down so if you do this before fetching any of the repos you won't have to do "git init"

#### **add automatic linting / formating to pre-commit**

https://ljvmiranda921.github.io/notebook/2018/06/21/precommits-using-black-and-flake8/

## cherry-pick
- - - - - 

Useful alternative to merge or rebase. Used to pick individual commits to release branches in 
prod.

#### **Basic usage** 

```bash
git checkout master
git cherry-pick <commit hash>
```

#### **Update the release branch**

Procedure for pulling commits onto release branch
```bash
git checkout tvsdev.<release number>
git cherry-pick <commit hash>
```
 cherry picked commit will be reviewed in the the pull request.

## commit 
- - - - -
#### **Amend last commit message**

```bash
git commit --amend -m "ref T6251 - WIP"
```

#### **Commit without pre-commit hook**

```bash
git commit -m "I'm going to kill them all" --no-verify
```

## blame / log
- - - - -
```bash
git log -p -M --follow --stat -- <filename>
```

display a good commit graph on cmdline

```bash
glol
```


## branch
- - - - - 
#### **display all local branches**
```bash
git branch
```

#### **display all remote branches**
```bash
git branch -4
```

#### **delete local branch**

```bash
git branch -d <branch name>
```

## checkout
- - - - -
#### **change branch**

```bash
git checkout <other branch>
```

#### **drop all changes in a specfic file**
```bash
git checkout -- <specific file path>
```

#### **drop all unstaged changes**

```bash
git checkout .
```
## diff
- - - - 
#### **difference between two files**

```bash
git diff *
```

#### **differences between two branches**
```bash
git diff <branch_1> <branch_2>
```

## pull
- - - - -
#### **cleaner work history and no pointless merge commits** 

!!! note
    Only do this from remote into local. Never the other way round.

- - - 
```bash
git pull --rebase
```
can be shorted to 
```bash
git pull -r
```
## rebase
- - - - 
can be used to give a cleaner work history. can be used to squash commits into cleaner commits

```bash
git rebase -i
```
will rebase in inteactive mode with some instructures. I might want to investigate this a bit. 

## reset
- - - -
#### **unstage specific files** 
```bash
git reset HEAD <filename.py> 
```

#### **reset branch locally to head i.e. last commit** 
```bash
git reset --hard HEAD
``` 

alternativly

```bash
git reset --hard origin/master
```

#### **undo the last commit**
```bash
git reset --hard HEAD^
```

## stash
- - - - -
Stashing stores tracked and untracked changes for a later date so that you can apply them to somewhere else

https://git-scm.com/docs/git-stash

#### **stash all stages and unstaged changes**

Allows you to change branches and pull etc without merge issues
```bash
git stash
```
Results in a stash associated with a specific commit message

#### **bring back last stashed changes**

```bash 
git stash pop
```

#### **clear all stashes**

```bash
git stash clear
```

#### **list all stashes**
```bash
git stash list 
```

#### **show contents of specific stash**
```bash
git stash show -p stash@{1}
```

#### **drop a single stash**
```bash
git stash drop <stash hash or number>
```

#### **apply a specific stash**
not the same as pop but similar
```bash
git stash apply stash@{1}
```

## fetch
- - - - 
pull changes from remote to local but don't merge
```bash
git fetch master
```

## merge
- - - - -
combine two branches togeher
```bash
git merge master
```

## clone
- - - - -
clone a repo from somewhere

# External Tools
- - - 

## Gitlab
- - - - 
#### **deleting remote branches**
use the git lab gui
## Github
- - - -

## Source Tree
- - - 
