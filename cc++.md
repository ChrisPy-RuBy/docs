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
