Title: datascience
Summary: Notes on useful datascience libs

# Useful datascience notes

[machine learning](https://ml-cheatsheet.readthedocs.io/en/latest/)
 

# numpy

#### **generate large arrays**

```python
np.arange(10000)
```

# matplotlib

[cheat sheet](https://www.cheatography.com/gabriellerab/cheat-sheets/matplotlib-pyplot/)

There are two main apis for matplotlib. The following info is for the pyplot api.

## plot types

### Basic scatter plot

Generate x and y as two lists. 
```python
plt.plot(x, y) # for quick plots. All points are treated the same
plt.scatter(x, y) # for more detailed plots. Much slower for plots with large number of datapoints as each plot treated unique. 
plt.show()
```

## axes

[tick details](https://jakevdp.github.io/PythonDataScienceHandbook/04.10-customizing-ticks.html)
some axes stuff can be done directly to the plt object whereas
other things must be done to the underlying ax object

```python
ax = plt.axes()
```

### Add labels

Basics
```python
# self explanatroy
plt.ylabel('total seconds')
plt.xlabel('Date')
```

### Ticks

Basics
```python
# rotate ticks
plt.xticks(rotation=45)
```

#### Hide ticks
```python
ax = plt.axes()
ax.yaxis.set_major_locator(plt.NullLocator()) # hides everything, tick and labels
ax.xaxis.set_major_formatter(plt.NullFormatter()) # hides labels, keeps ticks 
```

#### Varying number of ticks

```python
ax = plt.axes()
ax.xaxis.set_major_locator(plt.MaxNLocator(3))
ax.yaxis.set_major_formatter(plt.MaxNLocator(3))
```




Basic

To fill in here.
- basic scatter plot
- basic histogram
- basic line chart

- dealing with datetimes

- basic linear regression plot

