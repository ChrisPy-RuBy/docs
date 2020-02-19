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
pyplot plots can be thought of a axes and figures

[find the chart you want here](https://matplotlib.org/gallery/)
```python
fig = plt.figure()
ax = plt.axes()
```

## customisation

```python
import numpy as np
plt.plot(x, np.sin(x - 0), color='blue', linestyle='dashed')
plt.plot(x, np.sin(x -3), color='#FFDD44', linestyle='dashdot')
plt.plot(x, np.sin(x -1), color='g', linestyle='dotted')
```

## multiplots

using the pyplot api we can plot multiple graphs on a single plot

```python
import numpy as np
plt.plot(x, np.sin(x - 0), color='blue')
plt.plot(x, np.sin(x -3), color='#FFDD44')
plt.plot(x, np.sin(x -1), color='g')
```

## plot types

### Basic scatter plot

Generate x and y as two lists. 
```python
plt.plot(x, y) # for quick plots. All points are treated the same
plt.scatter(x, y) # for more detailed plots. Much slower for plots with large number of datapoints as each plot treated unique. 
plt.show()
```

### Basic histograms

```python
data = np.random.randn(1000)
plt.hist(data)
# alter the binning
plt.hist(data, bins=100)
# normalise the data to 1 
plt.hist(data, normed=True)
```

### Mulithistos

```
x1 = np.random.normal(0, 0.8, 1000),
x2 = np.random.normal(-2, 1, 1000),
kwargs = dict(histtype=stepfilled, alpha=0.3, normed=True, bins=40)",
plt.hist(x1, **kwargs),
plt.hist(x2, **kwargs),
plt.show()
```

## legends

Can pass in a legend param into the plt.plot 

```python
plt.plot(x, np.sin(x), color='green', label='sin(x)')
plt.plot(x, np.cos(x), color='red', label='cos(x)')
plt.axis('tight')
plt.legend()
```

## axes

[tick details](https://jakevdp.github.io/PythonDataScienceHandbook/04.10-customizing-ticks.html)
some axes stuff can be done directly to the plt object whereas
other things must be done to the underlying ax object

```python
ax = plt.axes()
```

### Set length

set axes length or limits
```python
plt.xlim(-1, 11)
plt.ylim(-1.5, 1.5)
```

alternatively 

```
# can just feed all the params straight in.
plt.axis([-1, 11, -1.5, 1.5])
# alternatively just set to tight
plt.axis('tight')
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

## Error bars

```python
x = np.linspace(0, 10, 50)
dy = 0.8
y = np.sin(x) + dy * np.random.rand(50)

plt.errorbar(x, y, yerr=dy, fmt='.k')
```

## Continuous Errors

[see here](https://jakevdp.github.io/PythonDataScienceHandbook/04.10-customizing-ticks.html)

## Annotations




## For fun

### xkcd plot 

wrap in 

```
with plt.xkcd():
    <make plot>

plt.show()
```

## two x one y plot


```python
def doubleYSingleXPlot(x, y1, y2, xlabel, y1label, y2label):

    fig, ax1 = plt.subplots()
    color = 'tab:red'
    ax1.set_xlabel(xlabel)
    ax1.set_ylabel(y1label, color=color)
    ax1.plot(t, y1, color=color)
    ax1.tick_params(axis='y', labelcolor=color)

    ax2 = ax1.twinx()

    color= 'tab:blue'
    ax2.set_ylabel(y2label, color=color)
    ax2.plot(t, y2, color=color)
    ax2.tick_params(axis='y', labelcolor=color)

    fig.tight_layout()
    plt.show()

doubleYSingleXPlot(t, y1, y2, 'x', 'a', 'b')
```
## multiplots shared x axis, stacked y

```python
def doubleYPlotsSingleX(x, y1, y2):

    fig = plt.figure()
    ax1 = fig.add_axes([0.1, 0.5, 0.8, 0.4],
                       xticklabels=[], ylim=(-1.2, 10000), xlim=(0, 1000))
    ax2 = fig.add_axes([0.1, 0.1, 0.8, 0.4],
                       ylim=(-1.2, 1.2), xlim=(0, 1000))
    ax1.plot(y1)
    ax2.plot(y2)
    plt.show()

doubleYPlotsSingleX(t, y1, y2)
```




Basic

To fill in here.
- basic scatter plot
- basic histogram
- basic line chart

- dealing with datetimes

- basic linear regression plot

