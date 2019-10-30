Title: unixtools
Summary: Notes on Useful unix tools

# ag
v.fast alternative to grep

## basic use

```bash
ag <thing to find>
```


# awk
https://www.tutorialspoint.com/awk/awk_basic_examples.htm
(good 3 part tutorial to the basics)[https://blog.jpalardy.com/posts/why-learn-awk/]

## **cut sections from strings**
similar to cut at a basic level, but much more powerful and esoteric.
```bash
ls -l | awk '{print $5}'
```
would get all the files for the contents of the current folder


# aws

## **get sample of v.large files on s3**

the  - arg pipes the output to stdout 
```bash
s3://tvsquared-userdata/3871/1/app-usersessions/1547468023214-combined_Q3_8_app_FR_1.csv.gz - | gzcat | head
```


# bc
use bc for maths
```bash
echo "2+2" | bc
```



# chmod
change permissions of files or folders

| # | permission | rwx |
|---|---|---|
|7| read, write, exec | rwx|
|6|read, write|rw|
|5|read, exec|r-x|
|4|read|r--|
|3|write, exec|-wx|
|2|write|-w-|
|1|exec|--x|
|0|none|---| 

example 
```bash
chmod 0744
```
would grant the following permissions -rwxr—r—

# cmp
compare file to show they are the same.

```bash
cmp --silent '<filename_1>' '<filename_2>' && echo 'files are the same brah' || echo 'computer says no'
```

# cut


#### **get specific column from csv**

```bash
head <filename.csv> | cut -f 5 -d ,
```
will get the contents of the 5th column split on , 

# cron
https://opensource.com/article/17/11/how-use-cron-linux
#### **edit the crontab**
```bash
vim crontab -e
```

*****
min, hour, day of month, month, day_of_week

#### **add a new crontab**
```bash
crontab ~/.crontab.crontab
```

# curl

# date
tool for converting times etc

#### **convert timestamps**
```bash
date -r 1555718402
```
can provide timezone info
```bash
TZ=UTC date -r 1559780588
```
not 100 % trustworthy

#### **get current date in nice format**
```bash
date -v -1d +"%Y-%m-%d"
```
would return yesterday in nice format
```bash
date1=$(date +%Y-%m-%d)
```
would assign todays date in the format 2019-07-27 to date1

# diff

row by row check to determine differences between 2 files.

```bash
diff <(cat <file_1> ) <(cat /tmp/<file_2>)
```
 

# du

#### **get folder size**
```bash
du -sk ~/Downloads
```

# df

#### **get disk space**

```bash
df -H
```


# find

#### **find all existing repos** 
You can use the following to git init all your existing tvsquared local git repos:
```bash
find . -type d -name tvsquared-\* -exec git init \{\} \;
```

#### **all files of a certain type**
```bash
find ./*.csv > filestocopy.txt
```

# FZF

super good fuzzyfinder, on commandline and in vim

# grep

## basics

-n: get line number of match
-E: use egrep i.e. regex pattern matching
-A: displays lines surrounding 
-v: inverse match
 
#### Display all uses of specific command or line

```bash
cd to desired drive
grep –r request\.brand *    
this returns all instances of request.brand that occur in that folder.
```


#### get all rows with certain patterns and outputs to different file

This will match ‘2018-09-30’ in file and pipe to test.csv

```bash
grep 2018-09-30 appdl_UK-FR_Q3.csv > test.csv
```

#### used anywhere in a folder tree
```bash
grep –rl jqdb.channelmaps *
```
finds everywhere that this is used anywhere\


#### everything on or near a line 

-A 0 means just get that line
-A 10 will get the subsequent 10 lines

```bash
cat test.txt | grep –A 0 word
```

#### line numbers of matched
```bash
grep -n e combined_Q3_7_app_FR_1.csv
```

#### complex string matching

Get all lines that have any of certain specific characters
```bash
grep -E ‘a|e’ <filename.csv> <filenameto.csv>
```

Get all lines that 
Get all lines that contain a character not of a specified type

```bash
grep -nE '^V[[:alpha:]]' combined_Q3_7_app_FR_1.csv
```

# head/tail

#### **get subset of data from csv**
```bash
tail -10000 <filename.csv> | head
```


#### **strip header from csv** 

```bash
tail -n +2 <filename>.csv | head
```


# htop
https://peteris.rocks/blog/htop/
monitors system performance
```bash
htop
```

# kill
kill a job or process. Get the pid from htop or ps aux

```bash
kill -9 <PID>
```

# less
makes streamed output managable

```bash
 ps -ef | less
```
would give you all the processes running, one page at a time
# ls

#### **list all files of certain type in folder**
```bash
ls *.csv
```

# pbcopy / pbpaste

copies to and from the clipboard

# mail

email yourself from the cmdline
```bash
data | mail –s test <email address>
```

# sed
very powerful and fast test streaming and processing. v.esoteric
https://stackoverflow.com/questions/2112469/delete-specific-line-numbers-from-a-text-file-using-sed

useful flags
-i: edit in place, will over right current
-e:
-n: inverse, get everything that doesn't match.
-g: global, all instances of match in whole file.

#### **find and replace**
```bash
sed 's/<thing to find>/<thing to replace with>/g' <filelocation>.csv > <filedestination>.txt
```
example
```bash
sed 's/"/""/g' extra.holidays.2018.csv> whatnewcsv.txt
```

#### **find and delete**
https://stackoverflow.com/questions/5410757/delete-lines-in-a-text-file-that-contain-a-specific-string

```bash
sed  -i ‘/patterntomatch/d’ <filename.csv>
```
or 
```bash
sed  ‘/patterntomatch/d’ <filename.csv> <newfile>
```

#### **delete specific rows from file**
single line
```bash
sed -e ‘1000d’ <filename from> <filename to>
```
range of lines
```bash
sed -e ‘1000,10003d;56788d’ <filename from> <filename to>
```

#### **display specific rows**
told you it was esoteric!
```bash
sed -n '6643913,6643920p;6643921q' split_data.csv > dodgy.txt
```

# scp

#### **glomming / globbing scp**

```bash
scp 'backend@backend.preprod.tvsquared.private:/tmp/4008-1*' .
```


#### **transfer from local to remote**

```bash
scp /<filepath>/<filename> backend@backend.preprev.tvsquared.private:~/backend
```

#### **transfer from remote to local**

exammple
```bash
scp backend@backend.preprev.tvsquared.private:~/backend/tvsquared/tools/bespoke/alphonsoexpediadataimporter.py /Users/work/Desktop
```

# sftp

https://www.tecmint.com/sftp-command-examples/
#### **login to server**

```bash
sftp <serveraddress>
```

example
```bash
sftp groupon_test_1@upload-3840.tvsquared.com
```

# split

splits file into smaller chunks.

# ssh

#### **generate ssh key**
might want to check this
```bash
 echo '$(cat ~/.ssh/id_rsa.pub)'
```


#### **exit a session**
```bash
exit
```

# tar

```bash
tar -zcvf archive-name.tar.gz directory-name
```

# tee
splits output to both stdout and to file. Get to see what you are getting and output to file.

# tmux
[useful_guide](https://lukaszwrobel.pl/blog/tmux-tutorial-split-terminal-windows-easily/)
[cheatsheet](https://gist.github.com/MohamedAlaa/2961058)

#### **basic tmux**

from commandline
```bash
# list all active tmux sessions
tmux ls 
# append to most recent session
tmux a 
# append to specified session
tmux a -t <session_name>
# list all tmux commands
tmux lscm
```

from inside session
```bash
# kill window
crtl-b - x
# detach session
crtl-b - d
# split screen horizontal
crtl-b - "
# split screen vertical
crtl-b - %
# new window
crtl-b - c
# switch windows
crtl-b - n
```

# tr
used to trim data quickly

#### **remove characters from a csv v.quickly**
could also use sed here
This would remove all " from a file and write to a new file.
```bash
cat <filename>.csv | tr -d \" > new_filename.csv
```

# tree 
display file structure
```bash
tree -L 4
```
will display file structure down to level 4

# xargs

#### **loop through a list of files on s3 and grep them in parallel** 

Write a list of files 
Use Xargs. 
Xrags -I % takes the value form the previous things and assigns to %
-P 5 runs run parallel where 5 is the max number of processes.

cat filestocheck.txt | xargs -I % -P 5 aws s3 cp "s3://tvsquared-elblogs-collector-eu-west-1/collectorf-prod/AWSLogs/457063536638/elasticloadbalancing/eu-west-1/2019/04/20/%" - | grep collector-228 >> test.txt

```bash
xargs -I % -P 5
```

# wc

#### **number of files in folder**
```bash
ls -l | wc -l
```