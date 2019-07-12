## ** "*args" and "**kwargs" **



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
    for y in range(100) if x - y !=0 
]```
## **recursion**
[stackover_flow link](https://stackoverflow.com/questions/30214531/basics-of-recursion-in-python

