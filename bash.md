Title: bash
summary: Notes on bash scripting
- - - 

[awesome general guide to multiple cmmdline tools](http://conqueringthecommandline.com/book/ps)

# bash
[amazing bash cheat sheet](https://devhints.io/bash)   
[v.good guide to bash](https://www.tldp.org/LDP/abs/html/)   
[process management](https://mywiki.wooledge.org/ProcessManagement)   
Important point! Syntax for running stuff from the command line is v. different to running in script  

## basics 

### shebang

```bash
#! /bin/bash
```

### comparison operators

#### basic string comparisons

```bash
if [[ $var == "test" ]]
not 
if [[ $var -eq "test"]]
```

#### basic numeric comaprisons

fill in

#### check for specific file extensions

```bash
if [[ $file =~ \.bz2$ ]]
```

#### check if <blah> exists
[check file exists](https://linuxize.com/post/bash-check-if-file-exists/)

##### files

```bash
if [[ -f "$FILE" ]]; then
    echo "$FILE exists."
fi
```

##### directory

```bash
if [[ -d "$DIRECTORY" ]]; then
    echo "$DIRECTORY exists."
fi
```

##### executable

```bash
if [[ -x "$FILE" ]]; then
    echo "$FILE exists  and is executable."
fi
```

##### good check to see if something is installed

```bash
if ! [ -x "$(command -v pyenv)" ];then
	echo "not installed"
fi
```

##### string empty / not empty

```bash
if [[ -z "$string"]]; then
	echo "empty"
fi
```

```bash
if [[ -n "$string"]]; then
	echo "not empty"
fi
```

#### negation

```bash
if ! [ -f $FILE ]; then
    echo "Not here"
fi
```


### variables / assignment

#### assign variables

```bash
Myvariable=Hello
Anothervar=Fred
echo $myvariable 
sample/etc
ls $sample
```

#### set defaults for variables

##### set a default value and continue
```bash
NAME=${1:-'default'}
```

##### raise an error and exit

```bash
NAME=${1?Error: no name given}
```

### assignment

### datatypes / structures

#### strings

#### regexes 	

```bash
pre_reg=$IN_FOLDER'\/(.*)\/yy=([0-9]+)\/mm=([0-9]+)\/dd=([0-9]+)\/(.*$)'
regex=$pre_reg 

FILE=$1
if [[ $FILE =~ $regex ]]; then
	subfolders=${BASH_REMATCH[1]}
	year=${BASH_REMATCH[2]}
	month=${BASH_REMATCH[3]}
	day=${BASH_REMATCH[4]}
	filename=${BASH_REMATCH[5]}
```


##### string cleaning

```
# would remove all non-alpha numberics and replace with space
${1//[^[:alpha:]]/ }
```

#### arrays

##### creation

```bash
names=("chris" "dan" "alex")
```

#### associative arrays

##### creation
```bash
declare -A b
b=([hello]=world ["a b"]="c d")
```

##### key access 

set key 
```bash
declare -A dict
dict[a]=3
```

access key
```bash
echo ${dict[a]}
```

#### **ways to increment variables**
[increment variables](https://askubuntu.com/questions/385528/how-to-increment-a-variable-in-bash)
```bash
var=$((var+1))
((var=var+1))
((var+=1))
((var++))
```

### control flow

#### **basic conditionals**

```bas
[[ x -le y ]]
[[ x -gt y ]]
&& and
|| or
```

#### case statement

```bash
case $thing in 
a )
	echo "a"
	;;
b )
	echo "b"
	;;
* )
	echo "catch at the end"
	exit 1
esac
```


#### if else statements
[guide](https://ryanstutorials.net/bash-scripting-tutorial/bash-if-statements.php
)
```bash
for tag in $(git tag); do
if [[ $tag == *'tvs'* ]]; then
echo $tag
§   elif [[ <do something else> ]]; then
echo do something else""
else
echo "Unknown parameter"
fi
done
```

#### **check for specific file extensions**

```bash
elif [[ $file =~ \.bz2$ ]]
```

#### **check if file exists**
[check file exists](https://linuxize.com/post/bash-check-if-file-exists/)

### loops

xarsg and parallel are alternatives to looping

#### run bash functions in parallel

need to export the bash function before you can use it.

```bash
export -f regex_match
aws s3 ls <somewthing> --recursive | awk '{print $4}' | xargs -P 4 -I {} bash -c 'regex_match {}  s3://tvsquared-athena-ds/ filtered_outcomes_crosswalk_test_2 renamed'
```

#### basic loop

basic loop
```bash
names=("chris" "dan" "alex")
for name in $names;do 
echo $name
done
```

#### c style

c style loop
```bash
for((i=0; i<${#thingtoloopover}; i++)); do
echo "do something"
echo "${thingtoloopover:$i:1}"
done 
```

#### while loop

basic while loop
```bash
counter=1
while [[ $counter -le 10 ]]; do 
echo $counter
((counter++))
done
```

#### until loop
basic until loop
```bash
counter=1 
until [[ $counter -gt 10 ]]; do 
echo $counter 
((counter++))
done
```

#### loop through folder

loop through all files in a folder
```bash
for file in ./*.log; do 
echo $file; <do something>; 
done
```


## command execution

###  on the command line**

```bash
test_func () {<do something> $1}
```

a useful example 

```bash
site_collector_copy () {aws s3 cp s3://<something> s3://<something> --recursive}
```

### running a python program from a bash script

super easy
```bash
python -m <script_name>
```

### run command and catch output to a variable

need to make sure that stdout and stderr go to the same place!

```bash
VAR=$(python --version 2>&1)
```

direct 2 i.e. stderr to the same place as 1 i.e. stdout


## data input

#### userinput

```bash
read -rp "Enter site ids you want to move . . .  " var1
read -rp "Enter list of env's to move data to, i.e. x, y: " var2
```

### getops

a way of dealing with commandline arguements 
still not that straight forward.
 [see here](https://sookocheff.com/post/bash/parsing-bash-script-arguments-with-shopts/)


#### basic getopts example

```
#! /usr/bin/env bash

while getopts ":hd:l:" opt; do
  case ${opt} in
    h )
      echo "Usage:"
      echo "    tool -h                      Display this help message."
      echo "    tool -d                      The d: means that this requires an argument."
      echo "    tool -l                      The l: means that this requires an argument."
      exit 0
      ;;
	d )
	  target=$OPTARG
	  echo $target
	  ;;
	l )
	  location=$OPTARG
	  echo $location
	  ;;
    \? )
      echo "Invalid Option: -$OPTARG" 1>&2
      exit 1
      ;;
	: ) 
	  echo "Invalid Option: -$OPTARG requires an argument" 1>&2
	  exit 1
	  ;;
  esac
done
shift $((OPTIND -1))

echo "$target $location"
```


### using read for fun and profit

read a csv 
```bash 
# on the cmdline
cat <your>.csv | bash <your script>.sh
```

in the script
```bash
while IFS=, read -r field1 field2
do
<do the thing>
done
```

IFS specifies the delimiter and parses it into the mulitple fiel 




# to learn

- better commandline shizzle ``to_learn
[guide](http://conqueringthecommandline.com/book/ps) ``to_learn
[learn x in y mins](https://learnxinyminutes.com/docs/erlang/) ``to_learn
- understand read command. ``to_learn
- learn parallel command ``to_learn
- make a date calculator. i.e what is this date +30 days etc ``to_learn


