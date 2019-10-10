---
title: Python 
summary: Python notes.
---


## Pythonic Python

#### ** shortcircuiting functions**

[examples of shortcircuiting](https://www.geeksforgeeks.org/short-circuiting-techniques-python/)

you can do this ....
```python
somefunction(row.get('value') or '')
```
if you want to guard against absent or invalid values going into a 
function. if either the 'value' is none or absent, it will be 
replaced with ''

## **"*args" and "**kwargs"**



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




#### **extensible functions**

```python
def hyper_volumne(length, *lengths):
    V = length
    for length in lengths:
        V *= lengths
    return V 
```


## **comprehensions**

#### **nested comprehensions**


```python
vals = [[y*3 for y in range(x)] for x in range(10)]

# is equivalent to 
outer = []
for x in range(10):
    inner = []
    for y in range(x):
        inner.append(y*3)
    outer.append(inner)
```
#### **nested if statements**

```python
values = [
    x/ (x-y)
    for x in range(100) if x > 50
    for y in range(100)
    ]
```


## **recursion**
[stackover_flow link](https://stackoverflow.com/questions/30214531/basics-of-recursion-in-python)

## **testing**

[mocking and testing spark](https://towardsdatascience.com/stop-mocking-me-unit-tests-in-pyspark-using-pythons-mock-library-a4b5cd019d7e)

## **mocking**

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








# TODO insert basic example of mocking an object here.


specific methods can be mocked out also if that is easier.



# TODO give example of mocking a method


patch as a content manager. 

### **mocking side effects**

# TODO give example of patch as a context manager.
### **mock specifications**
Because mock is v.lazy, it means that you can easily mock the wrong thing.
A spec makes this harder to do. As you limit what can exist on your mock
object.
# TODO  what is a mock spec and how to use it.

# boto3
- - - 

# builtins
- - - - 

## **--file--**
where the module or whatever was imported from
```python
>>>import pandas
>>>pandas.__file__
'<some path to where it came from>some path to where it came from>.__init__.py'
```

## **--dict--**
changes everything on a module into dict

#### **display all functions etc on a module**

```python 
import datetime 
datetime.__dict__.keys()
```


## **--import--**
import something that isn't a module. Can use to avoid naming collisions

## **--main--**
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

## **vars**

not quite sure what this does.

# bson
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

# bytes / strings
- - - - 

#### **join() vs +=**

join is perferred as it is much faster

#### **convert bytes to strings vice versa**


```python
# generate string
byte.decode('utf-8')
# generate bytes
string.decode()
```

#### **intermediate use  of format**

###convert between binary / hex and dec
```python
# hex 
“{0:x}”.format(17)
# bin
“{0:b}”.format(17)
```

#### **split string on symbol**
```python
>>>”1234-1”.partition(“-”)
[“1234”, “-”, “1”]
```


# csv

# dateutils
- - -

#### **parse stupid timestamps**

```python
import dateutil.parser
dateutil.parser.parse("2015-10-19T00:00:00.000+0000")
```


# datetime
- - - 

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

# dictionary
- - - 

#### **set default**
```python
bigDict = {}
for liverampID, details in default_rollup.items():
    test = bigDict.setdefault(details.get('segmentGroup'), [])
    test.append(details.get('epsilonValueName').split('=')[0])

for segmentGroup, epsilonValueList in bigDict.items():
    new = setDict.setdefault(segmentGroup, set(epsilonValueList)) 
```
Sorting the output to want you want
```python
for k, v in sorted(setDict.iteritems(), key=lambda (k,v): len(v)):
     print("{}: {}").format(k, len(v))
```
[link](https://www.saltycrane.com/blog/2007/09/how-to-sort-python-dictionary-by-keys/)

#### **sorting dict by values**

```python
# generate a list of sorted keys
sorted_keys = sorted(dict_to_sort, key=lambda k: dict_to_sort[key], reverse=True)
# regenerate the dict or list using the sorted keys
[(key, dict_to_sort[key]) for key in sorted_keys]
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
# exceptions
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

# fabric
- - -

results = defaultdict(list)
data = [{'letter': 'a', 'value': 123}, {'letter': 'a', 'value': 789}, {'letter': 'b', 'value': 123}]
reduce(data, reducer, results)

```

## itertools

#### **groupby**

can do similar things to reduce. Need to work these examples out as they don't quite work at the moment
```python
data = [{'letter': 'a', 'value': 123}, {'letter': 'a', 'value': 789}, {'letter': 'b', 'value': 123}]

{item[0]: list(item[1]) for item in itertools.groupby(data)}
```

# ipython
- - -

#### **enable autoreload**
snip: `autoreload 
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


# lambdas
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

# list
- - - 

#### ** pythonic indexing,  enumerate** 

```python
for i, v in enumerate(range(10)):
    print(i, v)
```

#### **fastest way to copy a list**
```python
new_list = old_list[:]
```


# json

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

## object oriented programing
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

## optimising python code for speed

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

## pip

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

## pdb / ipdb
- - - 

[link](https://medium.com/instamojo-matters/become-a-pdb-power-user-e3fc4e2774b2)
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
#### **compile a regex for use**
```python
regex_pattern_date = r'yy=\d{4}/mm=\d{2}/dd=\d{2}/hh=\d{2}'
compiled = re.compile(regex_pattern_date)
```

#### **serach for on compiled regex**

```python
re.search(<compiled_regex>, <string>)
```
will return aregex object of the matches

#### **use matched regex**

```python
match_date.group()
```
will return the matching string
 

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

snip:`unittestclass
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
````bash
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
