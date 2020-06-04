---
title: devops
summary: devopsie shite!
---

# useful devops debug strategies 

### **One of my services i.e. a database doesn't work**

1. Do you have a clean install? Y/N.
Is there only one?
Is the install the most recent?
Check by find out versions being run etc.
useful commands
```
brew list mongodb
brew unstall mongodb 
brew unstall mongodb -f # uninstalls all versions install on system. 
```

2. Does the install run Y/N
shut down all other processes that might be running
restart the service. Is it now running? Y/N
Can you run it using brew / manually?
Does running it give any useful info?
```
ps -ef | grep mongo # processes running
tail -f <log file> # live debug of log files
```

3. Is it a dataissue Y/N
If things run manually but not using the service then suggests that this might be the issue
If you suspect Ydo the following.
- find db files (/usr/local/var/mongodb for mongo)
- remane the folder 
- create a new folder with the name of the old one.


4. Is there a config issue Y/N


# brew
- - - 
package manager, puts everything in
```bash
/usr/local/Cellar/<package>
```

## brew stuff
- - - 
#### **get brew to update its package list**
```bash
brew update
```

#### **update all packages installed**
```bash
brew upgrade
```

#### **switch to a different version of a keg**
```bash
brew switch <different keg>
```

#### **tidy up brew, generate free space**

```bash
brew clean up
```

#### **get details about brew package**
```bash
brew info <package>
```

#### ** start and stop specific services used with brew**
like postgres
```bash
brew services stop <service>
brew services start <service>

example
brew services stop mongodb
brew services start mongodb
```

#### **please use brew to update and upgrade your databases**

```

#### *:*link packages together**
```bash
brew link <blah>
```

#### **scratch**

```bash
brew update; brew upgrade; brew switch python 3.6.4_4; brew install python@2; brew unlink python; brew link python@2 --force; ln -s /usr/local/bin/python2 /usr/local/opt/python/bin/python2.7
```

## brew tools
- - - 
### **aws**
- - - 
do aws stuff from cmdline

#### **view sample of files**
can pipe stuff to stdout using -
```bash
aws s3 cp s3://tvsquared-userdata/3871/1/app-usersessions/1547468023214-combined_Q3_8_app_FR_1.csv.gz - | gzcat | head
```

#### **transfer from s3 to local**
```bash
aws s3 cp "s3://tvsquared-userdata/collector/282-1/2018.05/visits-282-1-2018.05.31.json.bz2" .
```

#### **transfering folders between buckets**
s3 has a flat folder structure so need to use the --recursive flag
```bash
aws s3 cp s3://tvsquared-userdata/collector/282-1/2018.01/ s3://tvsquared-userdata-preprod/collector/282-1/2018.01/ --recursive
```

#### **transfer folders from local to s3**
```bash
aws s3 cp --recursive . "s3://tvsquared-receivedata/tivo"
```

### **bash-completion**


### **fuzzy finder (fzf)**
[intro_docs](https://github.com/junegunn/fzf)
[basic use cases](https://sourabhbajaj.com/mac-setup/iTerm/fzf.html<Paste>)



### **jq**
- - - 

## xtract nested key from json

```
jq '.topkey.middlekey.bottomkey'
```

jq is a super useful tool for processing json from cmdline  
Can easily pipe results to other comdline tools.
[docs](https://stedolan.github.io/jq/manual/)  
[useful cheat sheet](https://lzone.de/cheat-sheet/jq)  

#### **pipecomplressed files to jq**
```bash
bzcat <filename>.json.bz2 | jq '.' - | sort | less
```

#### **pretty print json on cmdline**
```bash
jq '.' <filename>.json
```

#### **extract info from json**
```bash
jq'.['pizz', 'shiz']' <yout shitty filename>.json
# alternative 
jq '. | {url, k5}' actions-4834-1-2019.06.29.json
```

#### **selective extraction from json**
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

#### filter json by nested key value and get the count

```
bzcat actions-3390-1-2020.03.02.json.bz2 | jq -c 'select(.v5.medium == "app")' | wc -l
```

### **pyenv**

Have multiple python versions on your machine


#### **issues installing pyenv due to openssl**

```bash
brew uninstall --force --ignore-dependencies openssl@1.1
brew install -v 3.5.2
brew install openssl@1.1
```

#### **switch py3.5 to py3.7 and back**
```bash
pyenv global 3.5.0
or 
pyenv global system
```
You will need to install all the relevant pip packages into the correct python folder

#### **get what pyenv version is currently being used**
```
pyenv versions
```

# Virtual Machines

## setting up macos in a virtual box

for catalina. This was an absolute pain.
run on virtual box 6.2 on mac os with catalina. meta I know.

Steps
- create a catalina iso
    - download catalina installer from the apps store. you want to turn off all the autoinstalling stuff
    - run this script to generate the iso.
        ```bash
hdiutil create -o /tmp/Catalina.cdr -size 5200m -layout SPUD -fs HFS+J
hdiutil attach /tmp/Catalina.cdr.dmg -noverify -mountpoint /Volumes/install_build
sudo /Applications/Install\ macOS\ Catalina.app/Contents/Resources/createinstallmedia --volume /Volumes/install_build
mv /tmp/Catalina.cdr.dmg ~/Desktop/InstallSystem.dmg
hdiutil detach /Volumes/Install\ macOS\ Catalina
hdiutil convert ~/Desktop/InstallSystem.dmg -format UDTO -o ~/Desktop/Catalina.iso
        ```
    - if the iso fails to create with a error(22, 0) message. close everything try again. still issue then restart.

- install virtual box and extensions
    - some problems getting it the correct access on mac that I haven't managed to resolve on ubuntu

- create the box
    - make sure you have enough space on the machine (catalina requires at least 25 GB!)
    - follow the setup steps from other articles
    if you get stuff at a weird shell
        - re-create the iso
    if the install sticks while loading at the 14 min mark
        - set system processors to more than 1.
    if the keyboard doesn't recognise
        - pause and un-pause the machine

## setting up an SD card as VM disk

format SD card. for mac make sure it is Mac OS extended Journal, with GUID partitioning. 
Need to format before you start from the ROOT in diskultily

```
# find disk name
diskutil list
# unmount disk
diskutil unmountDisk /dev/disk2
# grant access
sudo chown $USER /dev/disk2*
# create link.vmdk
VBoxManage internalcommands createrawvmdk -filename /Users/chriswoodall/VirtualBox\ VMs/link.vmdk -rawdisk /dev/disk2
# create disk in VB using gui and .vmdk 
open -a VirtualBox
# might need to unmount again to get it to work
diskutil unmountDisk /dev/disk2
# on restart will need to grant access to disk again
sudo chown $USER /dev/disk2*
```
### **parquet-tools** 
- - - 
parse parquet from cmdline




# Macs

#### **encrypt machine**
[guide to encrypting mac](https://www.mactrast.com/2013/07/how-to-public-how-to-encrypt-time-machine-backups-with-os-x)

#### **machine keeps rename itself**
[this is annoying](https://apple.stackexchange.com/questions/55416/my-mac-minis-computer-name-keeps-changing-when-it-resumes-from-sleep)
```bash
sudo scutil --set HostName <new_hostname>
sudo scutil --set LocalHostName <new_hostname>
sudo scutil --set ComputerName <new_hostname>
```

##  Too large for the volume's format?

re-format the drive
[here](https://discussions.apple.com/thread/4263857)


# teamcity

Go to [teamcity](http://teamcity.tvsquared.private:8111/) and run whatever you need to

#### **deploy**
 
Deploys code to remote environment. Blats everything there
This restarts the whole environment so if new code has been incorportated then. I don’t know if it will update the psql databases.
Press the run button
Edit parameters and change branch to whatever branch you are interested in.
START / STOP 
Temporarily starts or stops the environment, required for access to psql + mongos
	DELPLOY CLONE CLIENT DATA TO REMOTE ENVIRONMENT
TVSquared CORE -> DATA -> Deploy One Test Client Data
Set parameters clientid, servername, new Client Id, new client name  
NOTE: new client name shouldn’t have any spaces


- - -
## anisble
- - - 
