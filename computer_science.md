title: compsci
summary: useful concepts in compsci
- - - 

# comsci

## databases

### what is database normalisation

dunno read a book. I think it is the idea that data should always be stored at the finest possible granularity. 

## general concepts

### bits, bytes etc

a bit is a single 0/1
a bytes is a concatenation of 8 bits.
a bytes can represent a number that is 2^8 or less i.e 0-255

## binary

### bits and bytes

a bit is a single digit in base 2 number
i.e 0 or 1
in a number of 10001

a byte is a series of bits, 8 digits long

#### bitwise operators. 

operations that operator on the binary representation of a number. 
binary has a number of shortcuts for certain math operations that are useful.

##### and operator (&)

take two number and return a third that is where both numbers had a 1
i.e.
```
10010011
10101110
-------
10000010
```
this makes more sense when we think of the numbers as 
respresentions of booleans

This technique is most useful when determining whether a number is 
even or not.

##### or operator (|)

take two equal length numbers and return a third where either
number is a 1.

```
10010011
10101110
-------
10111101
```

##### not operator
##### xor operator

##### bitshift operator  <<
moves a binary number a specfied number of positions to the left.
i.e.
```
00001101 << 3 = 01101000
```
this is useful a each place is like multipling by 2 


## the internet

### urls

[article on what is a url](https://developer.mozilla:.org/en-US/docs/Learn/Common_questions/What_is_a_URL)


## cryptography

### pgp

### gpg

# to_learn
- guide to urls **to_learn
- guide to sockets and ports **to_learn
- guide to unix operating system **to_learn
- learn wherer evrything is and what everyThing does on a mac and raspberry pi. **to_learn

