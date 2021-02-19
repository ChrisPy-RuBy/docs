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
## loops

```c
const char *strings[] = {"one","two","three"};
int i; 
for(i=0; i<2; i++) {
	printf("%s", strings[i]);
}
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

## static variables

static variables allow the variable to be accessed outside 
its local scope

global variables are available outside of the file.
```c
#include<stdio.h>

int runner()
{
	int count = 0;
	count++;
	return count;
}

int static_runner()
{
    static int count = 0;
    count++;
    return count;
}

int main()
{
	printf("%d ", runner());    # print 1
	printf("%d ", runner());    # print 1
    printf("%d ", static_runner());  # print 1
    printf("%d ", static_runner());  # print 2
    return 0;
}
```
## pointers and addresses

```c
int a = 1;
# this is a pointer that points to the thing at the address of a
int * pointer_to_a = &a;

# we can interact directly with a by using the pointer
# this would increment both the value of a and 
# the value of pointer_to_a
*pointer_to_a += 1;
```

## datastructures

defining a structure
```c
struct point {
    int x;
    int y;
};

# can use typedefs to define custom points 
# like this.
typedef struct {
    int x;
    int y;
} point;

point p;
```

can also use pointers in structures

```c
typedef struct {
    char * brand;
    int model;
} vehicle;

vehicle mycar;
mycar.brand = "Ford";
mycar.model = 2007;
```

## **heap vs stack memory**

[see](https://www.geeksforgeeks.org/stack-vs-heap-memory-allocation/)

two different types of memory allocation in c

### **stack allocation**

size of memory required is known to the compiler
whenever a function is called, the memory for the variables is deallocated

```c
int main
	// all these variables get memory allocated on the stack
	int a;
	int b[10];
	int n = 20; 
	int c[n];
```

### **heap allocation**

a pile of memory space is available to allocate / deallocate

```c
int main()
{
	// this memory for 10 ints
	// is allocated on heap
	int *ptr = new int[10];
}
```
