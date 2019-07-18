---
title: devops
summary: devopsie shite!
---

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

### **jq**
- - - 
parse json from the cmdline

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
