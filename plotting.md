Title: Plotting
Summary: plotting 
- - - 

# plotting

## plot types

### scatter plot

### bar chart

### venn diagram

### histogram

for viewing distributions of data. Count the frequency of a specific value and plot. 
Binning is important as both too large bins or too small can hide the underlying behaviour.


#### basic histogram

#### cumulative histogram

```python
data.hist(bins=60, cumulative=True, histtype='step')
```
![image](./img/cum_histo.png)
###

## matplotlib


### plot customisation

#### ticks

##### customise ticks

pyplot ticks are [matplot.text](https://matplotlib.org/stable/api/text_api.html#matplotlib.text.Text)
and so can be changed using the underlying attributes

```python
plt.xticks(rotation=45)
plt.xticks(fontsize=8)
# or
ax = plt.axes()
for tick in ax.get_xticklabels():
    tick.set_rotation(45)
    tick.set_fontsize(8)
```

##### vary number of ticks

```python
ax = plt.axes()
ax.xaxis.set_major_locator(plt.MaxNLocator(3))
ax.yaxis.set_major_formatter(plt.MaxNLocator(3))
```

##### hide ticks

```python
ax = plt.axes()
ax.yaxis.set_major_locator(plt.NullLocator()) # hides everything, tick and labels
ax.xaxis.set_major_formatter(plt.NullFormatter()) # hides labels, keeps ticks 
```


#### legend

#### axis labels 

```python
plt.ylable("y_label")
plt.xlable("x_label")

ax = plt.axes()
ax.set_xlabel("x_label")
ax.set_ylabel("y_label")
```

# or the underlying axes

```

#### data points

#### error bars

### plot layouts

#### 1to1 plot

empty 
![image](./img/1to1_empty.png)

```python
fig, ax = plt.subplots(figsize=[10, 4])
ax1 = plt.subplot(121)
ax2 = plt.subplot(122)
plt.tight_layout()
```

#### 1to2 plot

empty 
![image](./img/1-2_plot_empty.png)
```python
ax1 = plt.subplot(121)
ax2 = plt.subplot(222)
ax2 = plt.subplot(224)
plt.tight_layout()
```


```python
ax1 = plt.subplot(121)
ax1.plot(df['dwell_minutes'], df['number_of_visits'])
ax1 = plt.subplot(121)
ax1.set_ylabel("frequency")


ax2 = plt.subplot(222)
ax2.scatter(df['dwell_minutes'], df['number_of_visits'], )
ax2.set_xlabel("visit duration")

ax2.set_xlim(0, 60)
for tick in ax2.get_yticklabels():
    tick.set_rotation(45)
    tick.set_fontsize(8) 
plt.tight_layout()
```
![image](./img/plot_1.png)

#### inset plots

![image](./img/insert_plot_empty.png)
```python
fig, ax = plt.subplots(figsize=[5, 4])
axins = ax.inset_axes([0.5, 0.5, 0.47, 0.47])
```

with some data

![image](./img/insert_plot.png)
```python
fig, ax = plt.subplots(figsize=[5, 4])
ax.hist(<histo_df>, bins=60)
axins = ax.inset_axes([0.5, 0.5, 0.47, 0.47])
axins.hist(<histo_df>, bins=60, cumulative=True, histtype='step')
```

#### shared axis

plot two sets of data with different y axes on the same x.

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
```
