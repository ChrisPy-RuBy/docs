Title: bash
summary: Notes on bash scripting

[awesome general guide to multiple cmmdline tools](http://conqueringthecommandline.com/book/ps)

# bash
[amazing bash cheat sheet](https://devhints.io/bash)   
[v.good guide to bash](https://www.tldp.org/LDP/abs/html/)   
[process management](https://mywiki.wooledge.org/ProcessManagement)   
Important point! Syntax for running stuff from the command line is v. different to running in script  

## basics 

#### **string comparisions**

```bash
if [[ $var == "test" ]]

not 
if [[ $var -eq "test"]]
```

#### **define a functin on the command line**

```bash
test_func () {<do something> $1}
```

a useful example 

```bash
site_collector_copy () {aws s3 cp s3://tvsquared-userdata/collector/$1/2019.08/ s3://tvsquared-userdata-preprod/collector/$1/2019.08/ --recursive}
```

## data input

#### using read for fun and profit

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



#### **running a python program from a bash script**

super easy
```bash
python -m <script_name>
```


#### **assign variables**

```bash
Myvariable=Hello
Anothervar=Fred
echo $myvariable 
sample/etc
ls $sample
```

#### **basic data types/structures**

```bash
names=("chris" "dan" "alex")
```

```bash
declare -A b
b=([hello]=world ["a b"]="c d")
```

#### **accessing key values in associative array**

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

#### **basic conditionals**

```bash
[[ x -le y ]]
[[ x -gt y ]]
&& and
|| or
```

#### **basic if else statements**
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

#### **loops**

xarsg and parallel are alternatives to looping

basic loop
```bash
names=("chris" "dan" "alex")
for name in $names;do 
echo $name
done
```

c style loop
```bash
for((i=0; i<${#thingtoloopover}; i++)); do
echo "do something"
echo "${thingtoloopover:$i:1}"
done 
```

basic while loop
```bash
counter=1
while [[ $counter -le 10 ]]; do 
echo $counter
((counter++))
done
```

basic until loop
```bash
counter=1 
until [[ $counter -gt 10 ]]; do 
echo $counter 
((counter++))
done
```


loop through all files in a folder
```bash
for file in ./*.log; do 
echo $file; <do something>; 
done
```

copy all files in a file list

```bash
for file in $(cat filestocopy.txt); 
do cp ${file} ~/dev/tvsquared-backend/data/testdata/assist/; 
done
```

#### **string cleaning**

```
# would remove all non-alpha numberics and replace with space
${1//[^[:alpha:]]/ }
```

#### getops

a way of dealing with commandline arguements 
still not that straight forward.
 [see here](https://sookocheff.com/post/bash/parsing-bash-script-arguments-with-shopts/)

# to learn

- better commandline shizzle ``to_learn
[guide](http://conqueringthecommandline.com/book/ps) ``to_learn
[learn x in y mins](https://learnxinyminutes.com/docs/erlang/) ``to_learn
- understand read command. ``to_learn
- learn parallel command ``to_learn
- make a date calculator. i.e what is this date +30 days etc ``to_learn


