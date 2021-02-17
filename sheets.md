---
title: sheets
summary: Stuff for excel type shenaningans!
---

# General


## Useful shortcuts

Useful shortcuts

```
cmd-up/down - first / last row
cmd-left/right - first / last column

cmd-shift-up/down - highlight first / last row
cmd-shift-left/right - highlight first / last column

cmd-pgup / pgdown - flip worksheets # excel;
alt-up/down - flip worksheets # google
```


## excel

### **Useful resources**
[good basic introductions to various topics](https://chandoo.org/wp/welcome/)
[nice general tools](https://edu.gcfglobal.org/en/excel2016/)

### how tos

#### **add double quotes to a complete column**

got this -> purplegobbleer
need this -> "purplegobbleer"
[go here](https://lenashore.com/2012/04/how-to-add-quotes-to-your-cells-in-excel-automatically/)


#### check if one cell exists in another

[guide](https://www.got-it.ai/solutions/excel-chat/excel-tutorial/match/check-if-one-value-exists-in-a-column)
use match or vlookup

#### vlookup

fill in the values in row bases on values of another row.
NOTE: Make sure that the data you are looking up from is sorted by the column you are interested in.

```
Example
VLOOKUP(10003, A2:B26, 2, FALSE)

About
Vertical lookup. Searches down the first column of a range for a key and returns the value of a specified cell in the row found.
search_key
The value to search for. For example, '42', 'Cats' or 'I24'.
range
The range to consider for the search. The first column in the range is searched for the key specified in 'search_key'.
index
The column index of the value to be returned, where the first column in 'range' is numbered 1.
is_sorted - [optional]
Indicates whether the column to be searched (the first column of the specified range) is sorted, in which case the closest match for 'search_key' will be returned.
```

so for the top example
- 10003 would be the value that you are looking to find 
- A2:B26 would be the range of data that you are looking to investigate. Column A in this case is the data that you are looking up from. It is where you are expecting to find 10003
- 2 is the index of the value you wish to return
- False is whether the data you are looking at is sorted or not. in this case it is whether column A is sorted or not.

#### Match

If you want to show everything for one cell that appears in a column

#### count

count the number of times som

#### Index/Match

alternative to vlookup. It is a combination of the index and match command. 
It is for solving the problem where you want to add a value to a column based on the value in a different 
column. you need a lookup table somewhere.

Example. I have a list of collector siteids and the colletor cluster that they are on (My lookup).
I have a list of clientids with the collector_siteid that they are on. I want to know what collector cluster 
each clientid is on. I can do this by using a index, match

not 100 % sure on what the truthy values are doing at the end.
```
=index(<lookup value>, match(<datavalue to check>, <lookup key>, 0), 1)
# specific example
=index(L:L, match(D3, K:K, 0), 1)
would use the lookup table L:K and return a value based on D3
```

#### conditionals 
[derp](https://stackoverflow.com/questions/11399111/how-to-replace-text-of-a-cell-based-on-condition-in-excel
=IF(L27=TRUE, 1,0)
)
```
=IF(L27=TRUE, 1,0)
```


### Plotting 

#### Plotting multi cluster scatter plots

v.annoying

combine the data for the x axis into one column.
seperate the data for the y axis into two seperate column

| x | y1 | y2 |
| - | - | - |
| 1 | null | 2 | 
| 2 | 4 | null | 

## google docs

filters are like tables in excel. 
Create a filter as soon as the spreadsheet is ready.

### extrapolating formulas to large data ranges

use paste formula if the little square button is not available.

### generating templates
https://docs.google.com/spreadsheets/d/<spreadsheetID>/template/preview


### conditional formatting

#### using conditional formating to mathc values against a couple of note

[example](https://docs.google.com/spreadsheets/d/1SmRcdcRtEWB5ENYfD1upo-8cUWK92LssVB9od0jcKpg/edit?usp=sharing)

```
# conditional one, colour contents of D2 if it is present in B$
=MATCH(D2, B$2:B$10, 0)
# done the oppsite
=ISNA(MATCH(D2, B$2:B$10, 0))
```

### pivots

[good guide](https://www.benlcollins.com/spreadsheets/pivot-tables-google-sheets/)

#### count number in column 

rows:set to thing you are interested in 
values: set to same thing as the rows, then summarize with a COUNTA

sort using the rows, asc, desc

### functions

#### random selection from a specific column

```
=INDEX(A2:A, RANDBETWEEN(1, COUNTA(A2:A)))
```
