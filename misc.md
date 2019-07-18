## c

#### **hello world in c**
 

```c
#include <studio.h>

int main(void) {
    printf('hello world!\n');
    return 0;
}
```
to run
```bash
gcc -o helloworld helloworld.c
```

#### **malloc error**
https://www.tutorialspoint.com/c_standard_library/c_function_malloc.htm
Memory allocation and is part of the strandard c library

## docker

#### **run container**
```bash
docker run <container>
```

#### **run command in container**
```bash
docker run <container> echo “TestyMcTest”
```
#### **display processes running on container**
```bash
docker ps -a
```

#### **ssh into container**
```bash
docker run -it busybox sh
```

#### **delete unneeded container**
Where id is the container id. Can find this using docker ps -a
```bash
docker rm 305297d7a235
```
#### **delete all exited containers**
```bash
docker rm $(docker ps -a -q -f status=exited)
```



## java
#### **installed java version**
```bash
java -version
```
## javascript 

#### **map reduce**

```javascript
db.getCollection("brands").mapReduce(function () {
	if (this.viscodeSettings != null) {
	emit(this._id, Object.keys(this.viscodeSettings).length);
	}
},
function(k, v) {
	return v;
	},
	{out: {inline: 1}}
);
```

## perl 
- - - 

#### **filter non-ascii characters from file**
```perl
perl -ane '{ if(m/[[:^ascii:]]/) { print  } }' open.csv > test.csv
```
