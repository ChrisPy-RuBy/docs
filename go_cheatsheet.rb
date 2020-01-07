cheatsheet do
  title 'Go'                 # Will be displayed by Dash in the docset list
  docset_file_name 'Go'    # Used for the filename of the docset
  keyword 'Go'             # Used as the initial search keyword (listed in Preferences > Docsets)
  # resources 'resources_dir'  # An optional resources folder which can contain images or anything else
  
  introduction 'shamelessly stolen from devhints.io'  # Optional, can contain Markdown or HTML

  # A cheat sheet must consist of categories
  category do
	id 'Basics'
    entry do
	name 'Example'
	notes <<-'END'
```go
package main

import "fmt"

func main() {
  message := greetMe("world")
  fmt.Println(message)
}

func greetMe(name string) string {
  return "Hello, " + name + "!"
}
```
	END
    end
    entry do
	name 'Comments'
	notes <<-'END'
```go
// single line comment
/*
multiline comments
*/
```
	END
    end
    entry do
	name 'Variables'
	notes <<-'END'
```go
var msg string
msg = "Hello"

// Shortcut of above (Infers type)
msg := "Hello"

// Constants
const Phi = 1.618
```
	END
    end
  end
  category do
	id 'Types'
    entry do
	name 'Strings'
	notes <<-'END'
```go
str := "Hello"

str := `Multiline
string`
```
	END
    end
    entry do
	name 'Numbers'
	notes <<-'END'
```go
num := 3          // int
num := 3.         // float64
num := 3 + 4i     // complex128
num := byte('a')  // byte (alias for uint8)

Other types

var u uint = 7        // uint (unsigned)
var p float32 = 22.7  // 32-bit float
```
	END
 end
    entry do
	name 'Arrays'
	notes <<-'END'
```go
// Arrays have a fixed size.
// var numbers [5]int
numbers := [...]int{0, 0, 0, 0, 0}
```
	END
 end
entry do
	name 'Slices'
	notes <<-'END'
```go
// Slices have a dynamic size, unlike arrays.
slice := []int{2, 3, 4}
slice := []byte("Hello")
```
	END
 end
entry do
	name 'Type conversion'
	notes <<-'END'
```go
i := 2
f := float64(i)
u := uint(i)
```
	END
 end
entry do
	name 'Pointers'
	notes <<-'END'
```go
func main () {
  b := *getPointer()
  fmt.Println("Value is", b)
}
 
func getPointer () (myPointer *int) {
  a := 234
  return &a
}
Pointers point to a memory location of a variable. Go is fully garbage-collected.
```
	END
 end
end
category do
	id 'Control flow'
    entry do
      name 'if else'
	  notes <<-'END'
```go
if day == "sunday" || day == "saturday" {
  rest()
} else if day == "monday" && isTired() {
  groan()
} else {
  work()
}
```
	END
 end
    entry do
	name 'statements in ifs'
	notes <<-'END'
```go
// a condition in an if statement can be preceded with a statement before a.
if _, err := getResult(); err != nil {
  fmt.Println("Uh oh")
}
```
	END
 end
entry do
	name 'Switch'
	notes <<-'END'
```go
switch day {
  case "sunday":
    // cases don't "fall through" by default!
    fallthrough

  case "saturday":
    rest()

  default:
    work()
}
```
	END
 end
entry do
	name 'For loop'
	notes <<-'END'
```go
for count := 0; count <= 10; count++ {
  fmt.Println("My counter is at", count)
}
```
	END
 end
entry do
	name 'For Range loop'
	notes <<-'END'
```go
entry := []string{"Jack","John","Jones"}
for i, val := range entry {
  fmt.Printf("At position %d, the character %s is present\n", i, val)
}
```
	END
 end
end
category do
	id 'Functions'
	entry do
	name 'Lambdas'
	notes <<-'END'
```go
// Functions are first class objects.

myfunc := func() bool {
  return x > 10000
}
```
	END
 end
    entry do
	name 'Multiple Return Types'
	notes <<-'END'
```go
a, b := getMessage()

func getMessage() (a string, b string) {
  return "Hello", "World"
}
```
	END
 end
    entry do
	name 'Named Return values'
	notes <<-'END'
```go
// By defining the return value names in the signature, a return (no args) will return variables with those names

func split(sum int) (x, y int) {
  x = sum * 4 / 9
  y = sum - x
  return
}
```
	END
 end
end
category do
	id 'Packages'
    entry do
	name 'Imports'
	notes <<-'END'
```go
import "fmt"
import "math/rand"

import (
  "fmt"        // gives fmt.Println
  "math/rand"  // gives rand.Intn
)
```
	END
 end
    entry do
	name 'Aliases'
	notes <<-'END'
```go
import r "math/rand"
 
r.Intn()
```
	END
 end
    entry do
	name 'Packages'
	notes <<-'END'
```go
package hello
```
	END
 end
    entry do
	name 'Exporting Names'
	notes <<-'END'
```go
// Exported names begin with capital letters.
func Hello () {
  <do something>
}
```
    END
 end
end
category do
	id 'Concurrency'
	entry do
	name 'Goroutines'
	notes <<-'END'
```go
func main() {
  // A "channel"
  ch := make(chan string)

  // Start concurrent routines
  go push("Moe", ch)
  go push("Larry", ch)
  go push("Curly", ch)

  // Read 3 results
  // (Since our goroutines are concurrent,
  // the order isn't guaranteed!)
  fmt.Println(<-ch, <-ch, <-ch)
}
 
func push(name string, ch chan string) {
  msg := "Hey, " + name
  ch <- msg
}
 
// Channels are concurrency-safe communication objects, used in goroutines.
```
	END
 end
    entry do
	name 'Buffered channels'
	notes <<-'END'
```go
ch := make(chan int, 2)
ch <- 1
ch <- 2
ch <- 3
// fatal error:
// all goroutines are asleep - deadlock!
// Buffered channels limit the amount of messages it can keep.
```
	END
 end
    entry do
	name 'Closing channels'
	notes <<-'END'
```go
ch <- 1
ch <- 2
ch <- 3
close(ch)

Iterates across a channel until its closed

for i := range ch {
  ···
}

Closed if ok == false

v, ok := <- ch
```
	END
 end
end

category do
	id 'Error Handling'
	entry do
	name 'Defering'
	notes <<-'END'
```go
func main() {
  defer fmt.Println("Done")
  fmt.Println("Working...")
}
```
	END
 end
    entry do
	name 'Defering functions'
	notes <<-'END'
```go
func main() {
  defer func() {
    fmt.Println("Done")
  }()
  fmt.Println("Working...")
}

// Lambdas are better suited for defer blocks.

func main() {
  var d = int64(0)
  defer func(d *int64) {
    fmt.Printf("& %v Unix Sec\n", *d)
  }(&d)
  fmt.Print("Done ")
  d = time.Now().Unix()
}
 
// The defer func uses current value of d, unless we use a pointer to get final value at end of main.

```
	END
 end
end
category do
	id 'Struct'
	entry do
	name 'Defining'
	notes <<-'END'
```go
type Vertex struct {
  X int
  Y int
}
 
func main() {
  v := Vertex{1, 2}
  v.X = 4
  fmt.Println(v.X, v.Y)
}
```
	END
 end
    entry do
	name 'Literals'
	notes <<-'END'
```go
v := Vertex{X: 1, Y: 2}

// Field names can be omitted
v := Vertex{1, 2}

// Y is implicit
v := Vertex{X: 1}

You can also put field names.
```
	END
 end
    entry do
	name 'Pointers to structs'
	notes <<-'END'
```go
// Doing v.X is the same as doing (*v).X, when v is a pointer.

v := &Vertex{1, 2}
v.X = 2
```
	END
 end
end
category do
	id 'Methods'
	entry do
	name 'Receivers'
	notes <<-'END'
```go
// There are no classes, but you can define functions with receivers.
type Vertex struct {
  X, Y float64
}

func (v Vertex) Abs() float64 {
  return math.Sqrt(v.X * v.X + v.Y * v.Y)
}
 
v: = Vertex{1, 2}
v.Abs()
```
	END
 end
    entry do
	name 'Mutation'
	notes <<-'END'
```go
// By defining your receiver as a pointer (*Vertex), you can do mutations.
func (v *Vertex) Scale(f float64) {
  v.X = v.X * f
  v.Y = v.Y * f
}
 
v := Vertex{6, 12}
v.Scale(0.5)
// `v` is updated
```
	END
  end
end
end
