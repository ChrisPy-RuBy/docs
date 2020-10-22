Title: regex
Summary: Guide to regexes
- - - 

[link to regex 101](https://regex101.com/ see quick referenceA)

# basics 

```python
# match b not a
b
```

# useful escape characters
```python
\s # match whitespace
\S # Don't match whitespce 
\d # Digits 
\D # No digits
\w # word characters
\W # not word characters  
\t # tabs   
\r # return  
```

# magic characters

```python
^ # beginning of a newline
$ # end of line or string
\< # beginning of word
\> # end of word
\b # word boundary
\B # non word boundary
```

# basic mulitpliers

```python
* any number of time
+ more than once
? 0 or more
. means wildcard and is chainable
.. for example

```

# squared brackets


```python
b[e]
matches be

b[aei] 
would match a, e, or i in any combination
be, ba, bi

[1-9]
ranges of things. here 1 to 9. be careful as range can be weird
[1-57]
is not 1 to 57 but 1,2,3,4,5,7
```

negation

```python
[^ab]
means not the values in the bracket
```

# round brackets
mean capture everything. Order specfic

```python
(cat)
matches cat but not tac
```

can add conditionals to it

```python
(cat|tac)
would make cat and tac but not act
```
 can use with other regex

(c|b)at
would match cat or bat for example


# curly brackets
multipliers

```python
\d{5}
```
means match a numnber 5 times
so would match 54321
1{5}
would only match 11111

#### **matching ranges**

```python
{3, 7}
matches between 3  to 7 times
```

#### **open ended ranges**

```python 
\d{2,}
```
would match any digit that was present more than once.

# Useful regexes

#### **match whole line or row containing ...**

```python
^.*(this|that).*$
```
would return all rows that contain this or that

#### **match all word beginning with specific letter**

```python
\bt\w+\b
```
would return all words that begin with t

#### **matching all numbers of a specifc length**

```python
\d{9}
```

#### **matching ip addresses**
```bash
\b([0-9]{1,3}\.){3}[0-9]{1,3}\b
```

#### **find and replace only selected parts of a string**

```
match this ->
request.jqdb.clients.update({'tomfoolery': 'bawlbaggery'})
not this ->
x.update({}})

in pycharm
(equest.*)(update?)(\(\{.*\}\))
$1$2_one$3 gives
request.jqdb.clients.update_one({'tomfoolery': 'bawlbaggery'})

# in vim
%s/\(equest.*\)\(update\)\((.*\)/\1\2_one\3/g
```



