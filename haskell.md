# basics

## open the interpreter

```haskell
gchi
```

# compile a program




```
ghc -o helloworld helloworld.hs
```
## load functions into interpretter

load functions or reload
```haskell
:l myfunctions
:r
:set prompt "ghci> "
```

## **key concepts**

- currying
- guarding

## **doing basics**

#### **calling a function**
```haskell
-- call a function. 
-- Important all functions in haskell only take 1 argument
succ 8
-> 9

-- A multiparameter function is actually a multi function function but with syntac sugar.
add a b c d = a + b + c + d

-- is actually
add a b c d = \a -> (\b -> (\c -> (\d -> a + b + c + d)))
```

#### **anomimous functions**

```haskell
add x y = \x -> (\y -> x + y)
--or
add5 = \x -> x +         5
```
#### **conditional flow**

if else 
```haskell 
message :: String -> String
message name = if name == "Dave"
then "I can't do that"
else "Hello."
main :: IO ()
main = putStrLn (message "Dave")
```
case statement
```
message :: String -> String
message name = 
case name of 
"Dave" -> "I can't do that."
"Sam" -> "Play it again."
_     -> "Hello."  
```
guard pattern
```
message :; String -> String
message name
    |   name == "Dave" = "I can't do that."
    |   name == "Sam" = "Play it again."
    |   otherwise   = "Hello."
```
arguement pattern match
```
message :: String -> String
message "Dave" = "I can't do that."
message "Sam" = "Play it again"
message _ = "Hello"
```
```haskell
-- Write a comment!

doubleMe x = x * x
doubleMe 3 
-> 6

# define a list
let lostNumberss = [1,2,3,4,5]

# append a list
a ++ b

# insert 4 in at the start
4:a

# pop something from list
a !! 3
```

## **voc**

definition: A function that doesn't take any arguements
IO functions: Special functions that are able to interact with the outside world.
Type Class: 
Currying: passing functions rather than values 
Guarding:





