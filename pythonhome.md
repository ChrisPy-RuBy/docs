## ** "*args" and "**kwargs" **


#### **zip star(*) idiom**



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
[stackover_flow link](https://stackoverflow.com/questions/30214531/basics-of-recursion-in-python

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

