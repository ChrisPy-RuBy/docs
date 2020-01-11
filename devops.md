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
### **pyenv**
Have multiple python versions on your machine

#### **switch py3.5 to py3.7 and back**
```bash
pyenv global 3.5.0
or 
pyenv global system
```
You will need to install all the relevant pip packages into the correct python folder






### **parquet-tools** 
- - - 
parse parquet from cmdline




# Macs

#### **encrypt machine**
[guide to encrypting mac](https://www.mactrast.com/2013/07/how-to-public-how-to-encrypt-time-machine-backups-with-os-x)




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
