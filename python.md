title: python 
summary: Python notes.
- - - 
# Python 

## Pythonic Python

Things to anki
- sorted() functions 
- various lambdas
- string formating


### Do's and Don'ts 

#### **header in file aka shebangline**
```
#!/usr/bin/env python3  or
#!/usr/bin/python3
```

#### **Write functions that do one thing**

#### **Maintain variable types**
do not mix types under the same variable

#### **Define Exceptions correctly**

``` python
try:
    do somting
except ValueError as e:
    log e
except Exceptions as e
```

### Syntax

#### **single line if else statements**

``` python
y = 1
x = 10 if y > 10 else None
```

#### **!= vs is not**

similar to = and is 
=  is used to check if something is the same object
is is used to check if something is the same type


#### ** shortcircuiting functions**

[examples of shortcircuiting](https://www.geeksforgeeks.org/short-circuiting-techniques-python/)

you can do this ....
```python
somefunction(row.get('value') or '')
```
if you want to guard against absent or invalid values going into a 
function. if either the 'value' is none or absent, it will be 
replaced with ''

### *args" and "**kwargs"

#### **zip star(*) idioms**

transpose wide lists together into thin ones

```python
x = [1,2,3,4,5]
y = ['a', 'b', 'c', 'd', 'e']
z = [1, 0 , 1, 0, 0]
all_ = [x, y, z]
for value in zip(*all_): print(value)

#or if you want it all at once
list(zip(*all_))
```

try this one on for size
zip a list into pairs!

```python
test_list = ['a', 1, 'b', 2, 'c', 3, 'd', 4]
pair_up = list(zip(*[iter(test_list)] * 2)
```

#### **split list of tups into two lists**

v.useful for plotting data as most graphs preferx, y

```python
data = [(1,2), (2,3), (3, 4)]
x, y = zip(*data)
# x is now [1,2,3]
# y is now [2, 3, 4]
```



#### **extensible functions**

```python
def hyper_volumne(length, *lengths):
    V = length
    for length in lengths:
        V *= lengths
    return V 
```

## Asserts

Can use asserts for security. But don't really on them.
```python
Assert(x > 0 ) "This is the assert message"
```

Warning do not do this

```python
assert(x > 0, "This is dumb and always true")
```

## Builtins
- - - - 

### **--file--**
where the module or whatever was imported from
```python
import pandas
pandas.__file__
'<some path to where it came from>some path to where it came from>.__init__.py'
```

### **--dict--**
changes everything on a module into dict

#### **display all functions etc on a module**

```python 
import datetime 
datetime.__dict__.keys()
```


### **--import--**
import something that isn't a module. Can use to avoid naming collisions

### **--main--**
read first when a module is imported or run from the command line
basic setup for tvs.
```python
if __name__ == "__main__":
    setup().process(process)
```
but can have any function in here. typically would be main or process etc

```python
target = __import__("my_script.py")
sum = target.sum
```

### **--repr-- vs --str--** 

__repr__ used to give dev representation of object
__str__ used for general use

### **vars**

not quite sure what this does.

## Bytes / Strings / Format
- - - - 

#### Bytes verses strings

what is a string... human readable tests.  
underneath a sequence of unicode code points.
i.e. "Hello" -> 0x48, 0x65, 0x6c, 0x6c, 0x6f  
strings in python are all unicode.
so can add either the unicode symbol or the hex encoding 
```
print(å) == print(\xe5)
```

What is a byte....Not human readable number from 0-255
must be translated to be read.
can't display unicode characters.

#### converting bytes and strings

interesting string 
```python
# this obviously contains a lot of unicode specific characters
norsk = "Jeg begynte å fortære en sandwich mens jeg kjørte taxi på vei til quiz"
norsk.encode("uft-8")
print(norsk)
```
results in. you can see that the unicode characters are now converted to their hex version. 
```python
b'Jeg begynte \xc3\xa5 fort\xc3\xa6re en sandwich mens jeg kj\xc3\xb8rte taxi p\xc3\xa5 v\ ei til quiz'
```

#### string literal encodings

```python
0b11  # binary literal
0o11  # octal literal 
0x11  # hex literal
```


#### python 2 vs python 3 reminder

python 2
str and unicode

python3 
bytes and str

str became bytes
unicode became str

#### useful types

```
r'raw' # means raw. No sequence escaping is used
b'bytes' # means the string is bytes
u''  # not sure. Think means unicode
```

####   what is this character
```
x = '\xc1'
print(x)
```
x here is printed as unicode. 

#### **join() vs +=**

join is perferred as it is much faster

#### **convert bytes to strings vice versa**


```python
# generate string
byte.decode('utf-8')
# generate bytes
string.decode()
```

a better example

```python
s = "résumé"
s.encode("utf-8")
# encode converts the unicode to bytes using utf-8 
# b'r\xc3\xa9sum\xc3\xa9'

b = b'r\xc3\xa9sum\xc3\xa9'
b.decode("utf-8")
# decode converts the bytes string to a unicode string with utf-8
# "résumé"
```




###convert between binary / hex and dec
```python
# hex 
“{0:x}”.format(17)
# bin
“{0:b}”.format(17)
```
###  **useful string formating**
[useful article](https://mkaz.blog/code/python-string-format-cookbook/)
```python
for 3.1415926
{:.2f} -> 3.14 2 dp
{:+.2f} -> +3.14 
{:.0f} -> 3 no dp
{:0>2d} -> 03.

# useful 
{d.hour:02}.format(d=datetme) -> 00, 01, 02 based on date etc
```


#### **split string on symbol**
```python
>>>”1234-1”.partition(“-”)
[“1234”, “-”, “1”]
```


## **Comprehensions**

#### **Generating random data**

```python
flarp  = ["a", "b", "c", "d" ]
darp = ["test", "dest"]
test_dict = {k: { y: random.randint(0,100) for y in darp  } for k in flarp}
```

another
```python
x = {k: random.randint(1, 1000) for k in range(1,100) }
```

#### **dict comprehension**

```python
{k:v for k, v in dict.items()}
```


#### **conditional comprehensions**

```python
results = {k: dict() if x % 2 == 0 else 0.0 
           for k in catergoies}
```


#### **nested comprehensions**


```python
vals = [[y*3 for y in range(x)] for x in range(10)]

# is equivalent to 
outer = []
for x in range(10):
    inner = []
    for y in range(x):
        inner.append(y*3)
    outer.apped(inner)
```
#### **Flatten nest datastrunctures**

nice if you know the depth

```python
[[[[for d in layer_4]
    for c in layer_3]
    for b in layer_2]
    for a in layer_one]
```
```
#### **nested if statements**

```python
values = [
    x/ (x-y)
    for x in range(100) if x > 50
    for y in range(100)
    ]
```


## Concurrency

#### **multithread**
for I/O bound

```python
import concurrent.futures
with concurrent.futures.ThreadPoolExecutor(max_workers=5) as executor:
    # where ready func is the function to map over your datasets. Must be iterable!. 
    batch = executor.map(ready_func, site_ids)
    for b in batch:
        results.append(b)
    return results
```


#### **multiprocess**
for CPU bound

## Dictionary
- - - 

### **default dict**

import collections.defaultdict

similar to setdefault
sets a default value for when a key in not present

#### **use default dict for counting values**

```python
results = defaultdict(int)  # default here for int is 0
for x, v in somedata:
	results[x] += v
```

#### **use default dict for grouping values by key**

```python
results = defaultdict(list)
for x, v in somedata:
	results[x].append(v)
```

### **set default**

IMPORTANT: SETDEFAULT does just what it says. 
for a dictionary if a key is present fine, but if not provide the value to use as default.


```python
bigDict = {}
for liverampID, details in default_rollup.items():
    test = bigDict.setdefault(details.get('segmentGroup'), [])
    test.append(details.get('epsilonValueName').split('=')[0])

for segmentGroup, epsilonValueList in bigDict.items():
    new = setDict.setdefault(segmentGroup, set(epsilonValueList)) 
```

#### **set default accumulating nested dicts**

```
for clientbrand, details in value2.items():
    for actionname, timestamp in details.items():
        try:
            value1[clientbrand][actionname] = min(value1[clientbrand][actionname], timestamp)
        except Exception:
            value1.setdefault(clientbrand, {}).setdefault(actionname, timestamp)
return value1
```

Sorting the output to want you want
```python
for k, v in sorted(setDict.iteritems(), key=lambda (k,v): len(v)):
     print("{}: {}").format(k, len(v))
```

[link](https://www.saltycrane.com/blog/2007/09/how-to-sort-python-dictionary-by-keys/)

### **sorted**

#### **sorting dict by values**

the sorted fuction returns a list of tuples. so you need to work out the function from there.
A good tip is not to use lambas and write the function 

an example
```python 
# some data
data = {'1': {'b': 1, 'c': 2}, '2': {'b': 2, 'c': 1}, '3': {'b': 100, 'c': 100}}
sorted(data) # this returns a sorted list of the keys for the top level dict
sorted(data.items())   # this returns a list of tuples sorted by keys

[('1', {'b': 1, 'c': 2}), ('2', {'b': 2, 'c': 1}), ('3', {'b': 100, 'c': 100})]

# if you want to sort by a value for a sub key. Then you need to pass in a function to do so
sorted(data, key=lambda x: x)   # would do the same as above

def sorter(x):
	return x[1]['b']
sorted(data.items(), key=sorter)   # would sort the list by the value in the subdict of 'b'

 
```


```python
# generate a list of sorted keys
sorted_keys = sorted(dict_to_sort, key=lambda k: dict_to_sort[key], reverse=True)
# regenerate the dict or list using the sorted keys
[(key, dict_to_sort[key]) for key in sorted_keys]
```


#### **Sort dict by highest key int**

```python
sorted(test_dict.items(), key=lambda k, v: v['dest'])
```

#### **merging dicts**
[link](https://treyhunner.com/2016/02/how-to-merge-dictionaries-in-python/)

#### **iterate a dict**

```python
for k, v in dict.items(): print(k, v)
```

#### **counters**

```python
from collections import Counter
counter = Counter()
for x, y in tiny_dict.items():
    counter[y] += 1

```

## Exceptions
[link](https://stackoverflow.com/questions/5191830/how-do-i-log-a-python-error-with-debug-information)

#### **useful stacktraces as exceptons messages**

```python
import logging
def get_number():
    return int('foo')
try:
    x = get_number()
except Exception as ex:
    logging.exception('Caught an error')
```


## Generators
- - - 
#### **basic generator**

```python
gen1 = (x for x in [1, 2, 3])

def gen():
    for x in [1,2, 3]
        yield x
gen2 = gen()

next(gen1)
next(gen2)
```

Nice to use "any" instead of looping over the whole lot.

```python
return any('action' in visit for visit in self.visits)
```


## Lambdas
- - - 

[link](https://www.bogotobogo.com/python/python_functions_lambda.php)
[link](http://p-nand-q.com/python/lambda.html)
[link](https://pythonconquerstheuniverse.wordpress.com/2011/08/29/lambda_tutorial/)
[link](Conditional Statements in lambdas)

#### **conditional lambdas**
```python
test = lambda x, y: x if x > y else y
test(9, 2)
```

#### **basic lambda**

```python
x = lamba x: x + 2
x(2)
4
```

#### **lambda maps**
In general just use a list compreshension instead
```python
values = [1,2,3,4]
x = list(map(lambda x: x+2, values))
[3,4,5,6]
```

#### **lambda reduce**
Again use list comprehension instead

```python
values = [1,2,3,4]
x = list(reduce)
10
```



## List
- - -

#### **for else loops**

This is useful if you want to do something when you make it all the way to the end of 
an iterable

```python
# a stupid example
data = [1,2,3,4, 5]

results = []
for x in date:
    print(x)
else: 
    results = data
# results is now data

for x in data:
    if x == 4:
        break
else:
    results = data
# results is still []
```



#### ** pythonic indexing,  enumerate** 



```python
for i, v in enumerate(range(10)):
    print(i, v)
```

#### **fastest way to copy a list**
```python
new_list = old_list[:]
```


## OOP
- - -

### **naming conventions**
```python
__<name>__ : reserved for builtins
_<private>: private attribure for python, not really private
__<name>: also kind of private but not quite used to avoid naming conflicts
```

#### **set attributes on a class**

```python
for k, v in dict.items():
    setattr(self, k, v)
```
would bolt on all the attributes from the dictionary

### **properties**
    good way of setting more complicated attribute on class 

### **static methods**
used to distinguish methods that don't require any knowledge of the state of the class.
It is more of a housekeeping thing than anything else
[link](https://stackoverflow.com/questions/15017734/using-static-methods-in-python-best-practice)
```python
@staticmethof
def you_shit_function():
    return "shit"
```

### **class methods**
similar to static methods but definately relavant to class but still don't require state of 
the instance of the class

```python
class Pizza:
    def __init__(self, ingredients):
        self.ingredients = ingredients

    def __repr__(self):
        return f'Pizza({self.ingredients!r})'

    @classmethod
    def margherita(cls):
        return cls(['mozzarella', 'tomatoes'])

    @classmethod
    def prosciutto(cls):
        return cls(['mozzarella', 'tomatoes', 'ham'])


>>>Pizza.margherita()
Pizza(['mozzarella', 'tomatoes'])
```



## Optimisation

#### tip blah: natively compiled libs
these can be much faster
```python
import ujson as json
import re2 as re
```

#### tip 1, membership testing

```python 
good: will look up directly 
for x in set([1,2,3,4,5])

bad: will loop through, with every loop
for x in list([1,2,3,4,5])
```

#### tip 2, string concat
```python
good: 
"".join(["a", "b", "c"])
bad:
strng += "a"
strng += "b"
strng += "c"
```

#### tip 3:
this one is interesting

```python
def func_1():
    anotherlist = []
    for x in somelist:
        antherlist.append(x.upper())
    return anotherlist

the above function in slower than

def func_2():
    anotherlist = []
    todo = x.upper
    otherthingtotodo = anotherlist.append
    for x in somelist:
        otherthingtodo(todo())

which is slower than 

def func_3():
    anotherlist = [x.upper() for x in somelist]

which is slow than

def func_4():
    todo = x.upper
    anotherlist = [todo() for x in somelist]
```




## **Recursion**
[stackover_flow link](https://stackoverflow.com/questions/30214531/basics-of-recursion-in-python)

#### **general recursion over a dict**

```python
if type(d) is dict:
    for k, v in d.items():
        d[k] = 
```

## **Testing**

[mocking and testing spark](https://towardsdatascience.com/stop-mocking-me-unit-tests-in-pyspark-using-pythons-mock-library-a4b5cd019d7e)

## **Mocking**

#### **basic example of mocking using mock**

```python
import datetime
from unittest.mock import Mock

testdate = datetime.datetime(2019, 7, 1, 1, 1)
# here is where the magic happens. datetime below is
# now a mock object not datetime.
datetime = Mock()
# we can then specify what we want it to return when 
# a specific func is called
datetime.datetime.today.return_value = testdate
datetime.datetime.today() 
# will return the value for testdate here not now()
```

#### **mocking side effects**
you might want to do this if you want to confirm that logging is 
working correctly.

This isn't that straight forward and it seems to need to be done with the
context of a unit test. Still working on this!

### **patching**

patching can be used to replace whole objects with mock ones. This can be done with the
@patch decorator or .patch()

##### TODO insert basic example of mocking an object here.


specific methods can be mocked out also if that is easier.



##### TODO give example of mocking a method


patch as a content manager. 

### **mocking side effects**

##### TODO give example of patch as a context manager.
### **mock specifications**
Because mock is v.lazy, it means that you can easily mock the wrong thing.
A spec makes this harder to do. As you limit what can exist on your mock
object.
##### TODO  what is a mock spec and how to use it.

## Libraries
- - -


### functools
- - - 

#### partial functinos 
useful when doing stuff on parallel or in spark.
Can create a partial complete function before handing it to the thing that will parallelise it

```python
from functools import partial

def my_fuction(param1, param2, data)
    print(param1, param2)
    yield data

part_func = partial(my_function, param1, param2)
executor.map(part_func, [<data>])
```

another alternative to this is to use a lambda
```python
def test_func(iterable, constant):
   for value in iterable:
       yield "{}{}".format(value, constant)

f = lambda x: test_func(x, 'constant')
```



### boto3
- - - 

### bson
--- 
stuff that is bz2 or from mongo is closer to bson than json
 

#### **parse things out of mongo i.e. piwik** 
```python
from bson import json_utils
```
this will deal with alot of the nonsense with time stamps etc

#### **dealing with objectids**
this is a mongo / bson thing
```python
from bson import ObjectId
```

#### **pretty print json as bson**
```python
from bson import json_util
json.dump(client_metadata,open(json_filename,'w'),
          indent=4, sort_keys=True, separators=(',', ': '),
          default=json_util.default)
```


### csv
- - -

### dateutils
- - -

#### **parse stupid timestamps**

```python
import dateutil.parser
dateutil.parser.parse("2015-10-19T00:00:00.000+0000")
```


### datetime
- - - 

#### **generate a max and min datetime from a date**

```python
datetime.combine(date(date.today().year, date.today().month, 1), datetime.min.time())
```

#### **genwerate all the times between two dates**     

```python
def date_range_generator(now, then, delta):
    time_range = y - x
    for value in range(time_range.seconds):
        yield y + datetime.timedelta(seconds=value)
```



#### **current datetime**

```python
now = datetime.datetime.now()
```

#### **convert datatime dates to datetime datetimes**
```python
datehourfrom = datetime.datetime.combine(day, datetime.time.min)
```

#### **convert timestamp to datetime**  

```python
datetime.fromtimestamp(1506729546)
datetime.datetime(2017, 9, 30, 0, 59, 6)
```
time zone info is optional

```python
datetime.fromtimestamp(<int>, datetime.timezone.utc)
```

### fabric
- - -

### **iter protocal**

requires a __iter__ and a next
```
class IterPrimes(object):
    def __init__(self,n=1):
        self.n=n

    def __iter__(self):
        return self

    def next(self):
        n = self.n
        while not test_prime(n):
            n += 1
        self.n = n+1
        return n
```


### ** itertools **

[Removing duplicates from a list of lists](https://stackoverflow.com/questions/2213923/removing-duplicates-from-a-list-of-lists)
[good intro](https://pymotw.com/3/itertools/index.html)

#### **chain**
link several iterables together without having to make one giant fisrt

#### **tee**

returns several independant iteratoor from original instead of 1

```python
test = list(range(10000))
y = tee(test, 10)
# y is now a list of 10 iterators from the split test data. 
# note that this doesn't split the original data, only duplicates it.
```

#### **starmap**

splits up input data into individual bits

```python
values = [(1, 2), (3, 4), (5, 6)]
for i in starmap(lambda x, y: (x, y, x*y), values):
    print("{} x {} = {}".formt(*i))
```

#### **count**

counts incrementally indefinately, in a step size defined by you.

#### **cycle**

create an iterable that is looped through indefinatly

#### **repeat**

create a iterable that repeats the same single value again and again until death.

#### **accumulates**

accumulate products of functions as iterated across and out puts that instead. can be though of as a 
cumulative sum.

```python 
list(accumulate(range(5)))
# [0, 1, 3, 6, 10]
```

can accumulate using other functions also

#### **permutations / products**

good for determining all the possible outcomes i.e. bruteforce approach to various problems.

```python
x = ['a', 'b', 'c']
y = [1, 2, 3]

# get all the possible orders of x
[a for a in permutations(x)]

# get all the possible combinations of x and y
[a for a in product(x, y)]
```

#### **reduce**

```python
results = defaultdict(list)
data = [{'letter': 'a', 'value': 123}, {'letter': 'a', 'value': 789}, {'letter': 'b', 'value': 123}]
reduce(data, reducer, results)
```

reduce two dicts and sum values

```python
def reducer(acc, elem):
    for k, v in elem.items():
        acc[k] = acc.get(k, 0) + v
    return acc

reduce(reducer, [{'a':2, "b":3, "s":10},{"a":2}], dict())

```

#### **groupby**

can do similar things to reduce. Need to work these examples out as they don't quite work at the moment
```python
data = [{'letter': 'a', 'value': 123}, {'letter': 'a', 'value': 789}, {'letter': 'b', 'value': 123}]

{item[0]: list(item[1]) for item in itertools.groupby(data)}
```

### ipython
- - -

#### **enable autoreload**
```python
%load_ext autoreload
%autoreload 2
```

#### **run scripts in ipython**
```python
%run <script.py>
```

#### **get history for ipython session**
```python
%history
``` 
#### **time a function**

```python
%timeit -n 10000 <your_crappy_function(stupid_params)>
```



### json

#### **dealing with mongo queries as json**

Export your query as standard json (not the fancy Mongo Shiz). Either write to file or
to clipboard.

Read from clipboard

```python
import pyperclip
import json
data = pyperclip.paste()
datalist = data.split['\n']
# parse data
parseddata = [json.loads(row) for row in datalist] 
# you now have the data as a list of dicts
```

Read from file

```python
with open(<path>, 'r') as f:
     list_of_rows = f.readlines()

parserows = [json.loads(row) for row in list_of_rows]
```

Pipe in from stdin

```python
import sys
import json

parsed_rows = []
for row in sys.stdin:
    try:
        parsed_rows.append(json.loads(row))
    except:
        pass
```


#### **parse a string to a dict**
[link](https://stackoverflow.com/questions/988228/convert-a-string-representation-of-a-dictionary-to-a-dictionary)
```python
>>> x = '{"x": 1, "a": 3}'
>>> json.loads(x)
{"x": 1, "a": 3}
```

#### **parsing large files of json i.e. firehose data**
not really josn as no wrapping []
[link](https://stackoverflow.com/questions/12451431/loading-and-parsing-a-json-file-with-multiple-json-objects-in-python)

## os
- - - 

#### **check for directory**
```python
os.path.isdir("/home/el"))
```

#### **check file exists**

```python
os.path.exists()
```

#### **list all files in directory**
```python
os.listdir(path)
```

#### **recursively make directory structure*
```python
os.makedirs(<path>)
```

## pandas
- - - - 

## performance / profiling
- - - - 
https://www.stefaanlippens.net/python_profiling_with_pstats_interactive_modeA
https://docs.python.org/3/library/profile.html#instant-user-s-manual

#### **generate some profiling stats**
```bash
python3 -m cProfile -o /tmp/profile.stats tvsquared/jobqueue/importer/collectortng.py 1366 1 2019-06-06T00 2019-06-06T00
```
It dumps some stats into the specified field directory.
We can then analyse using pstats. ncalss and cumtime are perceived as the most

```bash 
python3 -m pstats profile.stats
```

#### **profiling in code**

```python
import cProfile
cProfile.run('sum([i * 2 for i in range(10000)])')
cProfile.run('sum((i * 2 for i in range(10000)))')
```

#### **useful profiling tricks**

Use profile hooks to work out what individual functions are doing

```python
# a decorator that works out how long a function takes.
from profilehooks import timecall, profile

@timecall
def my_test_func():
    return "derp"

# a decorator that profiles the function
@profile
def my_other_test_func():
    return "herp"

```

## tempfile

keep only writing blank files
need to flush
```python
with temp.NamedTempFile(mode='w') as f:
        f.write(data)
        f.flush()
```

## pip

#### **When checking for packages check casse insensitive**

often the package that you are looking 

```
pip3 freeze | grep -i django 
```

#### **set up a package mirror**

Go to
```bash 
~/.pip/pip.conf
```
Tag out 
```bash
index-url = http://packagemirror.tvsquared.private/pip/simple/
trusted-host = packagemirror.tvsquared.private
```

#### **installing non-binary packages** 
Sometimes binary versions are incompatible with one another
When people say install from source they mean this
```bash
pip install --no-binary :all: scipy
```

#### **show current package info i.e version, location**
```bash
pip show <package>
```

#### **unfuck a pip package**

```bash
pip install --upgrade --force-reinstall pymongo
```

#### **show all packages**

```bash
pip freeze
```
or 
```bash
piplist
```

#### **installing / uninstalling**
```bash
pip install <package>==<specific version>
pip uninstall <package>
```
## pipdeptree

tool for show what uses what
```bash
pipdeptree -r -p more-itertools 
```

## pymongo

## psycopg2

basic db setup
[tutorial](http://www.postgresqltutorial.com/postgresql-python/create-tables/)
```python
import psycopg2
conn = psycopg2.connect("dbname=test1 user=postgres password=postgres")
cur = conn.cursor()
cur.execute("CREATE TABLE boo (test VARCHAR, best INT)")
cur.close()
conn.commit()
```

## pdb / ipdb
- - - 



[link](https://medium.com/instamojo-matters/become-a-pdb-power-user-e3fc4e2774b2)
#### Useful debug:



#### **basic debugger in code

```python
import ipbd; ipdb.set_trace()
```
now
```python
breakpoint()
```

#### **pdb out the code**

```bash
python -m pdb <scriptname>.py
```

#### **open nested python console within a pdb sesisons**


```python
!import code; code.interact(local=vars())
```

##### **display all local or global variables in debugger**
```python
local()
global()
```
## pytest 
more functionality that unittest
needs tests to be called test_<blah>
but doesn't require class

#### **get unit test coverage**
```bash
python -m pytest --cov
```
can get carried away with what it is checking

#### **better fixtures**
can make writing tests quicker

## numpy
- - -  

## matplotlib
- - -
 
## mock
- - -


## re
- - -
Two main use types. Match and Search.
Search finds the regex within the string
Match matches from the start.

#### **find version number in string**

```python
string = "pg_restore (PostgreSQL) 12.1"
regex = re.compile(r'\d+\.\d+')
matches = regex.search(string)
# if the match is not None
version = matches.group()
```

#### **compile a regex for use**
```python
regex_pattern_date = r'yy=\d{4}/mm=\d{2}/dd=\d{2}/hh=\d{2}'
compiled = re.compile(regex_pattern_date)
```

#### **search for on compiled regex**


```python
re.search(<compiled_regex>, <string>)
```
will return aregex object of the matches

#### **use matched regex**

```python
match_date.group()
```
will return the matching string

## re
- - - 

#### **pattern matching and grouping with ?P**

```bash
r'.+/group=(?P<yyyy>\d{4})_(?P<mm>\d{2})_(?P<dd>\d{2})_(?P<hh>\d{2})/(?P<file>.+parquet)'
```

lots going on here
r' means that it is raw string so no escaping etc
the regex is to match certain files names and ?P means that the 
matches are assigned to the specfied group names
i.e ?P<yyyy>\d{4}
matches 4 digits and assigns them to the group yyyy


 

## sys
- - - 

#### **determine the size of an object**

[link](https://stackoverflow.com/questions/449560/how-do-i-determine-the-size-of-an-object-in-python)

```python
sys.getsizeof(<thin you want size of>)
```

#### **parse data from stout**

```python
import sys
for row in sys.stdin:
print (row[0])
```
from cmdline
```bash
cat blrap.txt | python parse.py > text.txt
```
## timeit

useful lib for timing small pieces of code 

```python
import timeit
def my_function():
    y = 3.145
    for x in range(100):
        y = y ** 0.7
    return y

print(timeit.timeit(my_function, number=100000))i
```
Note: %timeit function in ipython is much easier to use
:



## unittest

#### **basic boiler plate to get up and running**

create a file named test_<thing to be tested>.py

```python
import unittest

class Test<class to be tested>(unittest.TestCase):

    def setUp(self):
        pass

    def tearDown(self):
        pass

    def test_example_test(self):
        pass

if __name__ == '__main__':
    unittest.main()    
```

run unittests from comdline

```bash
python -m  unittest test_<thing to be tested>.py
``` 

## venv

#### **create a virtual environment**
```bash
python3 -mvenv testproject_env
```
#### **Activate venv**
```bash
source testproject_env/bin/activate
```

#### **Deactivate venv**
```bash
deactivate
```

#### **requirements files**
Use a requirements file to install all the packages that are present in this file
```bash
pip install -r requirements.txt
```
An example requirements file can be found here.
It is basically a list of all pip packages that should be installed.

```bash
bandit>=1.5.1
mock>=2.0.0
py>=1.7.0
pylint>=2.2.2
pyspark==2.3.1
pytest>=4.0.1
pytest-cov>=2.6.0
moto>=1.3.7
moto[server]
selenium
termcolor
```

# to learn

- make notes on the main function ``to_learn
- make a pip package ``to_learn
- query google calender api with python ``to_learn
- [cpython source code tut](https://realpython.com/cpython-source-code-guide/) ``to_learn
- [gil tut](https://realpython.com/python-gil/) ``to_learn
- [memory-management](https://realpython.com/python-memory-management/) ``to_learn
- [buidling c-module](Building a Python C Extension Module) ``to_learn
- [standard-lib itertools](https://realpython.com/python-itertools/) ``to_learn
- advanced pandas ``to_learn
[idiomatic pandas](https://realpython.com/courses/idiomatic-pandas-tricks-features-you-may-not-know/) ``to_learn

