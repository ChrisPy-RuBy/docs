# UNIX

## awk
https://www.tutorialspoint.com/awk/awk_basic_examples.htm

#### **cut sections from strings**
similar to cut at a basic level, but much more powerful and esoteric.
```bash
ls -l | awk '{print $5}'
```
would get all the files for the contents of the current folder

## chmod
change permissions of files or folders

## cut

#### **get specific column from csv**

```bash
head <filename.csv> | cut -f 5 -d ,
```
will get the contents of the 5th column split on , 

## cron
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

## curl

## date
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
## find

#### **find all existing repos** 
You can use the following to git init all your existing tvsquared local git repos:
```bash
find . -type d -name tvsquared-\* -exec git init \{\} \;
```

## head

#### **get subset of data from csv**
```bash
tail -10000 <filename.csv> | head
```


#### **strip header from csv** 

```bash
tail -n +2 <filename>.csv | head
```


## htop
https://peteris.rocks/blog/htop/
monitors system performance
```bash
htop
```

## kill
kill a job or process. Get the pid from htop or ps aux

```bash
kill -9 <PID>
```

## less
makes streamed output managable

```bash
 ps -ef | less
```
would give you all the processes running, one page at a time
## ls

#### **list all files of certain type in folder**
```bash
ls *.csv
```

## pbcopy / pbpaste

copies to and from the clipboard

## mail

email yourself from the cmdline
```bash
data | mail –s test <email address>
```

## sed
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

## scp

#### **transfer from local to remote**

```bash
scp /<filepath>/<filename> backend@backend.preprev.tvsquared.private:~/backend
```

#### **transfer from remote to local**

exammple
```bash
scp backend@backend.preprev.tvsquared.private:~/backend/tvsquared/tools/bespoke/alphonsoexpediadataimporter.py /Users/work/Desktop
```

### sftp

https://www.tecmint.com/sftp-command-examples/
#### **login to server**

```bash
sftp <serveraddress>
```

example
```bash
sftp groupon_test_1@upload-3840.tvsquared.com
```

## split

splits file into smaller chunks.

## ssh

#### **generate ssh key**
might want to check this
```bash
 echo '$(cat ~/.ssh/id_rsa.pub)'
```


#### **exit a session**
```bash
exit
```
## tee
splits output to both stdout and to file. Get to see what you are getting and output to file.

## tmux

## tr
used to trim data quickly

## tree 
display file structure
```bash
tree -L 4
```
will display file structure down to level 4

## xargs

#### **loop through a list of files on s3 and grep them in parallel** 
```bash
xargs -I % -P 5
```

## wc

#### **number of files in folder**
```bash
ls -l | wc -l
```
