Title: unixtools
summary: Notes on Useful unix tools
- - - 

# unixtools

## pipe and re-directs
```
cat <testfile>
and
cat < <testfile>
```
do the same thing. 
but for different reasons
one provides the file as an argument to cat
the other directly the file as stdin to cat.

## ag

v.fast alternative to grep

### find file with filename

```bash
ag -g part-00001-b3570e2d-1639-495a-bcb1-b3931164b25d-c000.snappy.parquet
```

### v.fast labbook search

```bash
ag --nobreak --nonumbers --noheading . | fzf
```

### basic use

```bash
ag <thing to find>
```
## awk

a useful mini language for processing text on the commandline.
https://www.tutorialspoint.com/awk/awk_basic_examples.htm
(good 3 part tutorial to the basics)[https://blog.jpalardy.com/posts/why-learn-awk/]
### incorporating awk into bash example

```bash
#!/bin/bash

cat "$@" | awk -F'[,-]' '

{volume[$1] += $8}

END {
  for(year in volume) {
    print year, volume[year]
  }
}

'
```
### useful cmdline options

```bash
awk -F , 'do something' # specify file seperator
awk -v var=1 'do something' # set variables from outside the script
```

### basics of awk
an awk command is understandable as follows.
It works with rows and columns.
$0 refers to the whole row
$1 refers to a specfic column.


```bash
some-condition {one or more statements}
\# i.e if (something then) {}
\# example, can be understood as if value in column 1 is greater than value in column 2 then 
\# then print column 3
awk '$1>$2 {print $3}'
\# whereas, would print the whole row where the condition was met.
awk '$1>$2'
\# and, would just print then specified column.
awk '{print $1}'
```
### dealing with different seperated files

awk defaults to tabs and spaces
can specify differnt types with the -F flag
```bash
awk -F , '{print}'
```

### basic operators, comparision and logic

```bash
$2 == 124.47   # equality
$2 != 124.47   # inequality
$2 > 124.47    # greater than
$2 >= 124.47   # greater than or equal
$2 < 124.47    # smaller than
$2 <= 124.47   # smaller than or equal
$2 ~ /^10.$/   # regex match
$2 !~ /^10.$/  # regex negated match  -- this one might be new
#and logical operators:
$1 ~ /^2015/ && $6 > 20000000  # and -- high volume in 2015
$6 < 1000000 || $6 > 20000000  # or  -- low or high volume
! /^2015/                      # not -- not in 2015
```

### nice formatting of output

This can be achieved with the printf command.
```bash
# would nicely format the output and re-arrange the colume order.
awk '{printf "%s %15s %.1f\n", $1, $6, $5}
```


### conditional table processing

```bash
# would print all rows  where column 1 is greater than 100
awk '$1 < 100 {print $0}'
# can also generate variables. Would print the row but also add the colume diff to the end.
awk 'diff=$1-$2 {print $0, diff}'
```

### regex matching on specific columns

```bash
# would match all the rows where column one matches that regex 
awk '$1 ~ /-01$/'
# would do the same but only return column 1 and 3
awk '$1 ~ /-01$/ {print $1, $3}'
```

### apply a regex to contents of a folder

```bash 
awk '/l.c/{print}' /etc/hosts 
```

### cut sections from strings
similar to cut at a basic level, but much more powerful and esoteric.
```bash
ls -l | awk '{print $5}'
```
would get all the files for the contents of the current folder

alternatively

```bash
echo  "This is a text file with some boring text in it. Blrap." | awk '{print $1, $2, $3}' -
```

another way is 

```bash
awk -v col=5 '{print $col}'
```

### sum all the values in a column

```bash
ls -l | awk '{sum += $5} END {print sum}'
```

### built-in variables
[summary of builtins](https://www.math.utah.edu/docs/info/gawk_11.html)

```bash
NR: the number of records (lines) processed since AWK started
NF: the number of fields (columns) on the current line
FNR: like NR, but resets to 1 when it begins processing a new file
FILENAME: the name of the file being currently processed
```
an example.
```bash
# print a total row count for a file. 
cat somefile.file | awk 'END {print NR}'
```
### Using BEGIN and END

BEGIN: things here get executed before the first row is processed. Use to set things up.
END: thing here get executed after the rows have been executed. Used to generate nice reports after processing.

### multiple conditions

chain multiple conditions but be careful as will match more than once.
```bash
awk '/^2016-03-24/ {print; next} $4 == 97.07 {print}'
```

### useful awk
```bash
# generate an average for all values in col 1 that match regex
cat ~/Downloads/netflix.tsv | awk '$1 ~ /^2016-03/ {sum_close += $5; count++} END {print sum_close/count}'
```

### arrays
```
awk -F'[,-]' '{volume[$1] += $8} END { for(year in volume) print year, volume[year]}'
```


## aws

### get sample of v.large files on s3

the  - arg pipes the output to stdout 
```bash
s3://<bucketname>/3871/1/app-usersessions/1547468023214-combined_Q3_8_app_FR_1.csv.gz - | gzcat | head
```

## bc

use bc for maths
```bash
echo "2+2" | bc
```

## chmod
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

can do this instead

```bash
# grant exe permissions to file
chmod +x  <yourfile>
```

## cmp
compare file to show they are the same.

```bash
cmp --silent '<filename_1>' '<filename_2>' && echo 'files are the same brah' || echo 'computer says no'
```

## cut


### get specific column from csv

```bash
head <filename.csv> | cut -f 5 -d ,
```
will get the contents of the 5th column split on , 

## cron
https://opensource.com/article/17/11/how-use-cron-linux

### run something in a cron every blah minutes

```bash
*/5 * * * * <do something>
# alternative that would run between 0 and 30 mins every 5 mins
0,5,10,15,20,25,30 * * * *  <do something>

```

### edit the crontab

```bash
vim crontab -e
```

*****
min, hour, day of month, month, day_of_week

#####

```bash
SHELL=/bin/sh

# Useful debugging the crontab. i.e. delet the file and when it is back you know it ran.
#* * * * * cd /Users/chriswoodall/dev/tvsquared-backend; touch crontest.txt

* 13 * * 1 date | mail –s monday chris.woodall@tvsquared.com

# how to run a bash script and pipe the output to cron.log
#* * * * * cd ~/ && ./test.sh >> ~/cron.log 2>&1
```
### Running bash scripts with other commandline tools.

```
# cron
1 * * * * /Users/chriswoodall/speedtest.sh >> cron.log 2>&1 

# in script
#!/bin/bash
PATH="/usr/local/bin:/usr/bin:/bin" 
$(speedtest --csv >> ~/Scratch/network_speed.csv)
```

## calc

Better calculator than bc

## curl

## csvtools / csvkit

nice tool package for dealing with csv files

### csvsql

#### query a csv file from the commandline

```bash
csvsql xaa.csv --query "SELECT * FROM xaa LIMIT 10;" -d "|"  | csvlook -d ","
```

#### load from csv into table

```bash
csvsql '/tmp/<filename>' --db 'postgresql://postgres:postgres@localhost/testing' -y 1000 --overwrite --insert
```

### in2csv

#### dealing with excel files from cmdline
```bash 
# get the sheet names
in2csv -n sheetname.xlsx 
# load specific sheet
in2csv --sheet <sheetname> <spreadsheet>.xlsx
```

## date
important: If you want to do anything remotely useful using bash and dates
the get gdate bu brew installing coreutils
It is compatible with Linux shizzle.

tool for converting times etc

```bash
start_date=$(date --date "4 day ago" '+%Y%m%d')
end_date=$(date +%m-%d-%Y -d "$start_date + 130 day")

```

```bash
get_date () {
date +%Y-%m-%d --date "$1"
}
then=$(get_date "4 days ago")
now=$(get_date "today")

while [[ $then != $now ]]; do
then=$(get_date "$then + 1 day")
echo "$then"
done
```

### issues with padding 

```+%-m```
drops the leading 0
so 2020-01-01
becomes 2020-1-01

### convert timestamps
```bash
date -r 1555718402
```
can provide timezone info
```bash
TZ=UTC date -r 1559780588
```
not 100 % trustworthy

### get current date in nice format
```bash
date -v -1d +"%Y-%m-%d"
```
would return yesterday in nice format
```bash
date1=$(date +%Y-%m-%d)
```
would assign todays date in the format 2019-07-27 to date1

## diff

row by row check to determine differences between 2 files.

```bash
diff <(cat <file_1> ) <(cat /tmp/<file_2>)
```

## du

#### get folder size
```bash
du -sk ~/Downloads
```

## df

### get disk space

```bash
```

## dstats

good tool for monitoring database servers

## file

tell you what a file contains and or how its compressed

## find

### parallel processing with find

```bash
find . -name "*.mpeg" | xargs -P 4 -I {} ffmpeg -i {} -o {}.mp4
```


### flatten a file structure recursively into a new folder

```bash
mkdir flat;
find . -type f -name \*.parquet -print -exec cp {} ./flat/ \
```

### find a file with specific name

where . is the directory to search.
```bash
find . -name <filename>.<file ending> -print
# can also use regex
find . -name '[a-zA-Z]*.sh' -print
```

### find file and open in vim

```bash
find . -name yarn-site.xml -type f -exec nvim \{\} \;
```

### find specific file types

use types.

```bash
# get all the directories
find . -types d -print
# get all the symlinks
find . -types l -print
# get only files
find . -types f -print
```

### find specific  files in specific paths

```bash
# will return everything that has /session/ in the path
find . -path \*session\*
```


### find all existing repos
You can use the following to git init all your existing tvsquared local git repos:
```bash
find . -type d -name tvsquared-\* -exec git init \{\} \;
```

### **all files of a certain type**
```bash
find ./*.csv > filestocopy.txt
```

## FZF
[intro_docs](https://github.com/junegunn/fzf)
[basic use cases](https://sourabhbajaj.com/mac-setup/iTerm/fzf.html<Paste>)

a

super good fuzzyfinder, on commandline and in vim

## tig

commandline git repo browsing tool

## grep

### basics

-r: recursive folder search
-n: get line number of match
-E: use egrep i.e. regex pattern matching
-A: displays lines surrounding 
-v: inverse match
-o: match only
*: search all files

### **useful combinations **
-oE: only return things that match the regex


### Recursively search a folder for something

```bash
cd to desired drive
grep –r request\.brand *    
this returns all instances of request.brand that occur in that folder.
```


### get all rows with certain patterns and outputs to different file

This will match ‘2018-09-30’ in file and pipe to test.csv

```bash
grep 2018-09-30 appdl_UK-FR_Q3.csv > test.csv
```

### used anywhere in a folder tree
```bash
grep –rl jqdb.channelmaps *
```
finds everywhere that this is used anywhere\


### everything on or near a line 

-A 0 means just get that line
-A 10 will get the subsequent 10 lines

```bash
cat test.txt | grep –A 0 word
```

### line numbers of matched
```bash
grep -n e combined_Q3_7_app_FR_1.csv
```

### complex string matching

Get all lines that have any of certain specific characters
```bash
grep -E ‘a|e’ <filename.csv> <filenameto.csv>
```

Get all lines that 
Get all lines that contain a character not of a specified type

```bash
grep -nE '^V[[:alpha:]]' combined_Q3_7_app_FR_1.csv
```

### check a bunch of files to see if they contain something or not.

check all files leading with crontab to see if they contain python

```bash
grep python crontab*
```

## graphviz

plot graphs as in graphs 

### from dot file to png

```
dot.file | dot -Tpng -x > dot.png
```

## head/tail

### **subsection of file**

```bash
head -n 1000 file.csv | tail -n 500 > data
```

### **get subset of data from csv**
```bash
tail -10000 <filename.csv> | head
```

### **cut top 5 rows form file**
```bash
tail -n +5 filename.csv
```


### **strip header from csv** 

```bash
tail -n +2 <filename>.csv | head
```

### **stream a logfile**

```bash
tail -f /usr/local/var/log/postgres.log
```


## htop
https://peteris.rocks/blog/htop/
monitors system performance
```bash
htop
```



### **fuzzy finder (fzf)**
[intro_docs](https://github.com/junegunn/fzf)
[basic use cases](https://sourabhbajaj.com/mac-setup/iTerm/fzf.html<Paste>)



## jq
- - - 

Tools for doing stuff with json.
jq is a super useful tool for processing json from cmdline  
Can easily pipe results to other cmdline tools.
[docs](https://stedolan.github.io/jq/manual/)  
[useful cheat sheet](https://lzone.e/cheat-sheet/jq)  


### compare two json files


This compares two sorted json files with whitespare stripped. It provides a yes / no to whether they
are the same.
```bash
cmp <(jq -cS . A.json) <(jq -cS . B.json)
```


### diff two json files

alternative [here](http://play.jd-tool.io/)
Similar to above but human readable diff 
```bash
vimdiff <(jq -S . A.json) <(jq -S . B.json)
```



### extract nested key from json

```
jq '.topkey.middlekey.bottomkey'
```

jq is a super useful tool for processing json from cmdline  
Can easily pipe results to other comdline tools.
[docs](https://stedolan.github.io/jq/manual/)  
[useful cheat sheet](https://lzone.de/cheat-sheet/jq)  

### pipecomplressed files to jq
```bash
bzcat <filename>.json.bz2 | jq '.' - | sort | less
```

### **pretty print json on cmdline**
```bash
jq '.' <filename>.json
```

### **extract info from json**
```bash
jq'.['pizz', 'shiz']' <yout shitty filename>.json
# alternative 
jq '. | {url, k5}' actions-4834-1-2019.06.29.json
```

### **selective extraction from json**
```bash
jq '. | select(.k5 == "viewnewvehiclepage") | {url}' actions-4834-1-2019.06.29.json 
```

can also do this
```bash
bzcat actions-4837-1-2019.06.22.json.bz2 | jq '. | select(.k5 | contains("viewusedvehiclepage")) | {url}' | wc -l
```
using regex here.
Can pip has many filters together as you want as long as it stays within the ''


where . is
```bash
{
  "cfgid": {
    "$oid": "0000000042903b7c3e"
  },
  "v5": null,
  "time": {
    "$date": "2019-06-29T16:14:46+00:00"
  },
  "visit": {
    "$oid": "5d178dd5394058b467f"
  },
  "visitor": {
    "$oid": "0000000080b2e7c8db"
  },
  "url": "https://www.<derp>.com/all-inventory/index.htm?compositeType=new&make=Ford&model=Mustang",
  "k5": "tngviewnewvehiclepage"
}
```

### filter json by nested key value and get the count

```
bzcat actions-3390-1-2020.03.02.json.bz2 | jq -c 'select(.v5.medium == "app")' | wc -l
```


```bash
# find everything where visit_vars is not null and pipe through
jq 'select(.visit_vars != null) | .visit_vars'
```

### extract nested key from json

```
jq '.topkey.middlekey.bottomkey'
```

an alternative is. Note the ['$oid'] notation
```bash
bzcat visits-4648-1-2020.06.19.json.bz2 | jq '.visitor['$oid']' | sort | uniq -c
```

### **pipe compressed files to jq**
```bash
bzcat <filename>.json.bz2 | jq '.' - | sort | less
```

### **pretty print json on cmdline**
```bash
jq '.' <filename>.json
```

### **extract info from json**
```bash
jq'.['pizz', 'shiz']' <yout shitty filename>.json
# alternative 
jq '. | {url, k5}' actions-4834-1-2019.06.29.json
```

### **selective extraction from json**
```bash
jq '. | select(.k5 == "viewnewvehiclepage") | {url}' actions-4834-1-2019.06.29.json 
```

can also do this
```bash
bzcat actions-4837-1-2019.06.22.json.bz2 | jq '. | select(.k5 | contains("viewusedvehiclepage")) | {url}' | wc -l
```
using regex here.
Can pip has many filters together as you want as long as it stays within the ''


where . is
```bash
{
  "cfgid": {
    "$oid": "0000000042903b7c3e"
  },
  "v5": null,
  "time": {
    "$date": "2019-06-29T16:14:46+00:00"
  },
  "visit": {
    "$oid": "5d178dd5394058b467f"
  },
  "visitor": {
    "$oid": "0000000080b2e7c8db"
  },
  "url": "https://www.<derp>.com/all-inventory/index.htm?compositeType=new&make=Ford&model=Mustang",
  "k5": "tngviewnewvehiclepage"
}
```

### filter json by nested key value and get the count

```
bzcat actions-3390-1-2020.03.02.json.bz2 | jq -c 'select(.v5.medium == "app")' | wc -l
```



## kill
kill a job or process. Get the pid from htop or ps aux

```bash
kill -9 <PID>
```

### send a specific signal to a process
```
kill -s USR1 3699
# sends signal user1 to pid 3699
```

## less
makes streamed output managable

```bash
ps -ef | less
```
would give you all the processes running, one page at a time

## ls

### **list all files of certain type in folder**
```bash
ls *.csv
```

### Useful display everything command

```bash
ls -larth
```

gives you permissions, something, owner, something, size, date and name 

### **List all files ordered by size**
```bash
ls -S 
```

## pgrep

get the PID for a process
super useful

## ps 

details about processes

```
ps -ef | grep python
# get all processes that are python
ps -ax --forest
# displays the tree for the process
```


## pobbler
[useful](https://support.foxtrotalliance.com/hc/en-us/articles/360025802252-How-To-Work-With-Poppler-Utility-Library-PDF-Tool-)
a pdf processing tool on the commandline

### convert pdf to text
generates a txt file of data

```bash
pdftotext <filetoscrap> 
```

## pbcopy / pbpaste

copies to and from the clipboard

## mail

email yourself from the cmdline
```bash
data | mail –s test <email address>
```
## nslookup

can use this tool to check waht collector a site is on
```bash
nslookup collector-<siteid>.tvsquared.com
```

## sed
very powerful and fast test streaming and processing. v.esoteric
https://stackoverflow.com/questions/2112469/delete-specific-line-numbers-from-a-text-file-using-sed

useful flags
-i: edit in place, will over right current
-e:
-n: inverse, get everything that doesn't match.
-g: global, all instances of match in whole file.

### find and replace
```bash
sed 's/<thing to find>/<thing to replace with>/g' <filelocation>.csv > <filedestination>.txt
```
example
```bash
sed 's/"/""/g' extra.holidays.2018.csv> whatnewcsv.txt
```

### append to a row 

```bash
# append ,<stuff>
sed 's/$/,stuffuwantattheendoftheline/' readfrom.csv | tee output.csv
```

### find and delete
https://stackoverflow.com/questions/5410757/delete-lines-in-a-text-file-that-contain-a-specific-string

```bash
sed  -i ‘/patterntomatch/d’ <filename.csv>
```
or 
```bash
sed  ‘/patterntomatch/d’ <filename.csv> <newfile>
```

### **delete specific rows from file**
single line
```bash
sed -i '3d' <filename> # delete a single line from a file.

sed -i '3,4d' <filename> # delete a range of lines

sed -e ‘1000d’ <filename from> <filename to>
```
range of lines
```bash
sed -e ‘1000,10003d;56788d’ <filename from> <filename to>
```

### **display specific rows**w
told you it was esoteric!
```bash
sed -n "7p" test.csv # would print only line 7
sed -n "7,10p" test.csv # would print range 7-10

sed -n '6643913,6643920p;6643921q' split_data.csv > dodgy.txt
```

### **delete header from file**

```bash
sed -e '1d' <from> <to>
```

## scutil

useful hostname shite
```bash
scutil --get HostName
scutil --get LocalHostName
scutil --set HostName "YOUR LOCAL HOST NAME"
```

## scp

### **glomming / globbing scp**

```bash
scp 'backend@backend.preprod.tvsquared.private:/tmp/4008-1*' .
```


### **transfer from local to remote**

```bash
scp /<filepath>/<filename> backend@backend.preprev.tvsquared.private:~/backend
```

### **transfer from remote to local**

exammple
```bash
scp backend@backend.preprev.tvsquared.private:~/backend/tvsquared/tools/bespoke/alphonsoexpediadataimporter.py /Users/work/Desktop
```

## sftp

https://www.tecmint.com/sftp-command-examples/
### **login to server**

```bash
sftp <serveraddress>
```

example
```bash
sftp groupon_test_1@upload-3840.tvsquared.com
```

## seq

generate sequences of things

### **0 padded numbers**

```
(seq -f "%04g" 0 9999)
```

## split

splits file into smaller chunks.

## sort 

v.useful

### **sort a dict scrapped from a terminal**

```bash
" example data
"2011":1234
"1001":4321

Here the -t is the delimiter, -k means 2nd column, -n means numeric
| sort -t : -k2n 
```

## ssh

### **what profile gets loaded on login**

/etc/profile then /.bash_profile

can run another profile within this profile by adding 
```bash
. $HOME/.bashrc
```

### **login into server using private key**

```
ssh -i <private_key> hostname
```

### **run commands on remote server without shell**

```
ssh hostname 'ls etc'
```

### **attach a tty shell and run vim**

```
ssh -t -i bandit26.sshkey bandit26@localhost -t vim
```

### **view all failed login attempts**

```
grep "Failed password" /var/log/auth.log
```

### **generate ssh key**
might want to check this
```bash
echo '$(cat ~/.ssh/id_rsa.pub)'
```

### **copy key to remote server so you don't have to keep ligging on**
```
ssh-copy-id remote_username@server_ip_address
```

### add new user to reomte machine 

login and copy the key from ~/.ssh/authorized_keys add to the machine that you want.

### **exit a session**
```bash
exit
```
## time

useful for benchmarking code in unix
```
time -f "Memory used (kB): %M\nUser time (seconds): %U" python3 naive.py
```

## tar

```bash
tar -zcvf archive-name.tar.gz directory-name
```

## tee
splits output to both stdout and to file. Get to see what you are getting and output to file.

## tmux
[useful_guide](https://lukaszwrobel.pl/blog/tmux-tutorial-split-terminal-windows-easily/)
[cheatsheet](https://gist.github.com/MohamedAlaa/2961058)

### **basic tmux**

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

### **get terminal output from a tmux**

- enter tmux section
- press space to enter highlight mode
- crtl-b [
- scoll the text you want
- press enter to copy to buffer
- open vim and save it

### **pipe terminal output to a log file**

```
tmux new -d \; pipe-pane 'cat > /tmp/log'
```

### **send commands to tmux session**
```
tmux send-keys 'UoMYTrfrBFHyQXmg6gzctqAwOmw1IohZ 0000' Enter
```


## tr
used to trim data quickly

### **remove characters from a csv v.quickly**
could also use sed here
This would remove all " from a file and write to a new file.
```bash
cat <filename>.csv | tr -d \" > new_filename.csv
```

## tree 
display file structure
```bash
tree -L 4
```
will display file structure down to level 4

## trace

bunch of programmes for investigating how your program interacts with the operating system and infrastructure

```
# system calls
strace -p <pid>
# library calls
ltrace -p <pid>
```

## vimpager

good alternative to less

## xargs

### **loop through a list of files on s3 and grep them in parallel** 

Write a list of files 
Use Xargs. 
Xrags -I % takes the value form the previous things and assigns to %
-P 5 runs run parallel where 5 is the max number of processes.

cat filestocheck.txt | xargs -I % -P 5 aws s3 cp "s3://tvsquared-elblogs-collector-eu-west-1/collectorf-prod/AWSLogs/457063536638/elasticloadbalancing/eu-west-1/2019/04/20/%" - | grep collector-228 >> test.txt

```bash
xargs -I % -P 5
```

## wc

#### **number of files in folder**
```bash
ls -l | wc -l
```
