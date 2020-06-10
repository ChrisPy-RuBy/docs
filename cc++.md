Title: CC++
Summary: notes on c and c++
- - - 

# Basics

basic info to create a script.
compile with make
profile with valgrind
```c
#include <stdio.h>

// main function gets run when script runs
// main should return an int
// argc is the number of args
// argv is the args themselves where argv[0] is the prog name.
int main(int argc, char *argv[]) {

	//declare a variable
	int i = 0;

	// for loop in c
	for (i = 0; i < argc; i++) {
		printf("arg %d: %s\n", i, argv[i]);
	}
	return 0;
}
```

```bash
make myscript.c
valgrind ./myscript
```

## **defining variables**

variable in c must be defined before they are used.

```c
# numbers are relatively easy.
int number;
number = 8;

# strings are more complex as they are arrays of characters and 
# can be done in a variety of ways

# create an array with 100 spaces and fill in one by one.
char name[100];
name[0]="A";

# alternatively
char name[] = "John Smith";

# alternatively use a pointer
char * name = "John Smith";

# array of numbers
int array[5] = {1, 2, 3, 4, 5};

```

## **useful string functions**

```c
# get length of string
char * name = "John";
printf("%d\n", strlen(name))

# string comparison where 4 is the max string comparision length.
strncmp(name, "John", 4);
```


## **accessing data**

```c
->  # structure point access
.   # structure value access
[]  # array index
sizeof # size of a type or variable
&   # address of
*   # value of
```

## **boolean operators**

```c
!    # not
&&   # and
||   # or
?:   # ternary operators
```

## for loop

```c
for (i = 0; i < argc; i++) {
	printf("arg %d: %s\n", i, argv[i]);
}
```

## while loop

```c
while(i > 0) {
	i--
}
```

