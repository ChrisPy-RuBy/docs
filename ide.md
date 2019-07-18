---
Title: ides
summary: summary of useful stuff for writing code
---

## pycharm

## vim

### **basic key mappings**
```bash
ctrl-w, ctrl-w -> switch screens
```

### **config**

#### **map keys in vim**

```bash
:imap jk <esc> 
```
map jk to esc to stop pressing esc

#### **diffing files**

https://lornajane.net/posts/2015/vimdiff-and-vim-to-compare-files
https://stackoverflow.com/questions/1265410/is-there-a-way-to-configure-vimdiff-to-ignore-all-whitespaces

```bash 
vimdiff <file 1> <file 2 >
```

#### **split screen vertical / horizontal**

```bash
:vsplit <filename>
```
or 
```bash
:hsplit <filename>
```

#### **tagging out multiple lines**

```bash
:<line number from>,<line number to>/^/# 
```

#### **set line numbers**
```bash
:setnumbers
```
### **find, search,  replace**
[link](https://www.linux.com/learn/vim-tips-basics-search-and-replace)

#### **turn case sensitivity on / off**
```bash
:set ignorecase
:set noignorecase
```
#### **process teamcity console outoput and make human readable**
this will generate human readable output from a console output.
```bash
:%s/\\n/\r/g
```
can also do use jq and visualline
```bash
# select relevant line in visual mode
```


#### **replace**
replace all instances in a line
```bash
>>>:s/old/new/g
``` 
replace all instances in whole file
```bash
%s/old/new/g
```

### **copy and paste**

#### **delete line, copy and paste**
```bash
dd
p
```
## sublime
