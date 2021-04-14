Title: datascience
Summary: Notes on useful datascience libs
- - - 

# datascience notes

[machine learning](https://ml-cheatsheet.readthedocs.io/en/latest/)

## machine learning

### cross-entropy

```python
def cross_entropy(Y, P):
    Y = np.float_(Y)
    P = np.float_(P)
    return -np.sum(Y * np.log(P) + (1 - Y) * np.log(1 - P))
```

### basic linear regression

```python
import pandas as pd
from sklearn.linear_model import LinearRegression

# Assign the dataframe to this variable.
# TODO: Load the data
bmi_life_data = pd.read_csv('./bmi_and_life_expectancy.csv')

# Make and fit the linear regression model
#TODO: Fit the model and Assign it to bmi_life_model
model = LinearRegression()
bmi_life_model = model.fit(bmi_life_data[['BMI']], bmi_life_data[['Life expectancy']])

# Make a prediction using the model
# TODO: Predict life expectancy for a BMI value of 21.07931
laos_life_exp = model.predict([ [21.07931]])
```

### multiple linear regression

```python
from sklearn.linear_model import LinearRegression
from sklearn.datasets import load_boston

# Load the data from the boston house-prices dataset 
boston_data = load_boston()
x = boston_data['data']
y = boston_data['target']

# Make and fit the linear regression model
# TODO: Fit the model and assign it to the model variable
model = LinearRegression()
test = model.fit(x, y)

# Make a prediction using the model
sample_house = [[2.29690000e-01, 0.00000000e+00, 1.05900000e+01, 0.00000000e+00, 4.89000000e-01,
                6.32600000e+00, 5.25000000e+01, 4.35490000e+00, 4.00000000e+00, 2.77000000e+02,
                1.86000000e+01, 3.94870000e+02, 1.09700000e+01]]
# TODO: Predict housing price for the sample_house
prediction = test.predict(sample_house)
```

## jupyter notebooks


### create a notebook template

```bash
pip install jupyterlab_templates
jupyter labextension install jupyterlab_templates
jupyter serverextension enable --py jupyterlab_templates
jupyter notebook --generate-config
```

add the following to the 
```python
c.JupyterLabTemplates.template_dirs = ['$HOME/<some directory']
c.JupyterLabTemplates.include_default = True
c.JupyterLabTemplates.include_core_paths = True
```
in the $HOME/.jupyter/jupyter_notebook_config.py file

now make a sub folder in the directory and put a template in it!
jesus that was hard work

### scrollable dataframes

### script magic commands

```python
get_ipython().magic('matplotlib inline')
```

### using venvs with notebooks

### useful magics

time the function call
```python
%timeit func()
```

plot chart inline
```python
%matplotlib inline
```

### convert notebooks into different formats

```python
jupyter nbconvert --to FORMAT mynotebook.ipynb
```

### dealing with issues

#### more debug from notebook server

```bash
 jupyter notebook --allow-root --debug
 # or
jupyter lab --log-level=debug
```

## pandas

### conditionally generate a columns values 

if you want to dynamically generate the values for a column based on 
the rest of the row.

```
       a     b      c     d     z
0   10.0  14.0  145.0   NaN   NaN
1  654.0  99.0    NaN  13.0   NaN
2    NaN  12.0    NaN  14.0   NaN
3    NaN   NaN    NaN   NaN  10.0

def filterfun(row):
    if row['a'] == 10.0:
        return "x"
    else:
        return "y"

df['new_col'] = df.apply(lambda row: filterfun(row), axis=1)
```
 

## numpy

### **generate large arrays**

```python
np.arange(10000)
```

## matplotlib

[cheat sheet](https://www.cheatography.com/gabriellerab/cheat-sheets/matplotlib-pyplot/)

There are two main apis for matplotlib. The following info is for the pyplot api.
pyplot plots can be thought of a axes and figures

[find the chart you want here](https://matplotlib.org/gallery/)
```python
fig = plt.figure()
ax = plt.axes()
```

### customisation

```python
import numpy as np
plt.plot(x, np.sin(x - 0), color='blue', linestyle='dashed')
plt.plot(x, np.sin(x -3), color='#FFDD44', linestyle='dashdot')
plt.plot(x, np.sin(x -1), color='g', linestyle='dotted')
```

### multiplots

using the pyplot api we can plot multiple graphs on a single plot

```python
import numpy as np
plt.plot(x, np.sin(x - 0), color='blue')
plt.plot(x, np.sin(x -3), color='#FFDD44')
plt.plot(x, np.sin(x -1), color='g')
```

### plot types

#### Basic scatter plot

Generate x and y as two lists. 
```python
plt.plot(x, y) # for quick plots. All points are treated the same
plt.scatter(x, y) # for more detailed plots. Much slower for plots with large number of datapoints as each plot treated unique. 
plt.show()
```

#### classification scatter plot

```python
def load_pts(csv_name):
    data = np.asarray(pd.read_csv(csv_name, header=None))
    X = data[:,0:2]
    y = data[:,2]

    plt.scatter(X[np.argwhere(y==0).flatten(),0], X[np.argwhere(y==0).flatten(),1],s = 50, color = 'blue', edgecolor = 'k')
    plt.scatter(X[np.argwhere(y==1).flatten(),0], X[np.argwhere(y==1).flatten(),1],s = 50, color = 'red', edgecolor = 'k')
    
    plt.xlim(-2.05,2.05)
    plt.ylim(-2.05,2.05)
    plt.grid(False)
    plt.tick_params(
        axis='x',
        which='both',
        bottom='off',
        top='off')

    return X,y

X, y = load_pts('data.csv')
plt.show()
```

#### colored classification plot

```python
def plot_model(X, y, clf):
    plt.scatter(X[np.argwhere(y==0).flatten(),0],X[np.argwhere(y==0).flatten(),1],s = 50, color = 'blue', edgecolor = 'k')
    plt.scatter(X[np.argwhere(y==1).flatten(),0],X[np.argwhere(y==1).flatten(),1],s = 50, color = 'red', edgecolor = 'k')

    plt.xlim(-2.05,2.05)
    plt.ylim(-2.05,2.05)
    plt.grid(False)
    plt.tick_params(
        axis='x',
        which='both',
        bottom='off',
        top='off')

    r = np.linspace(-2.1,2.1,300)
    s,t = np.meshgrid(r,r)
    s = np.reshape(s,(np.size(s),1))
    t = np.reshape(t,(np.size(t),1))
    h = np.concatenate((s,t),1)

    z = clf.predict(h)

    s = s.reshape((np.size(r),np.size(r)))
    t = t.reshape((np.size(r),np.size(r)))
    z = z.reshape((np.size(r),np.size(r)))

    plt.contourf(s,t,z,colors = ['blue','red'],alpha = 0.2,levels = range(-1,2))
    if len(np.unique(z)) > 1:
        plt.contour(s,t,z,colors = 'k', linewidths = 2)
    plt.show()
```


#### Basic histograms

```python
data = np.random.randn(1000)
plt.hist(data)
# alter the binning
plt.hist(data, bins=100)
# normalise the data to 1 
plt.hist(data, normed=True)
```

#### Mulithistos

```
x1 = np.random.normal(0, 0.8, 1000),
x2 = np.random.normal(-2, 1, 1000),
kwargs = dict(histtype=stepfilled, alpha=0.3, normed=True, bins=40)",
plt.hist(x1, **kwargs),
plt.hist(x2, **kwargs),
plt.show()
```

### legends

Can pass in a legend param into the plt.plot 

```python
plt.plot(x, np.sin(x), color='green', label='sin(x)')
plt.plot(x, np.cos(x), color='red', label='cos(x)')
plt.axis('tight')
plt.legend()
```

alternatively
```python
 def plotter(x, y, name):
     plt.ylim(0, 60)
     plt.xlim(0, 60)
     plt.plot(x, y, label=name)
     plt.legend() 

```


### axes

[tick details](https://jakevdp.github.io/PythonDataScienceHandbook/04.10-customizing-ticks.html)
some axes stuff can be done directly to the plt object whereas
other things must be done to the underlying ax object

```python
ax = plt.axes()
```

#### Set length

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

#### Ticks

### Error bars

```python
x = np.linspace(0, 10, 50)
dy = 0.8
y = np.sin(x) + dy * np.random.rand(50)

plt.errorbar(x, y, yerr=dy, fmt='.k')
```

#### Continuous Errors

[see here](https://jakevdp.github.io/PythonDataScienceHandbook/04.10-customizing-ticks.html)

### Annotations




### For fun

#### xkcd plot 

wrap in 

```
with plt.xkcd():
    <make plot>

plt.show()
```

#### multiplots shared x axis, stacked y

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

