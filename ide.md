---
Title: ides
summary: summary of useful stuff for writing code
---

## pycharm

## vim

#### **key configs*
Add these to  your `~/.vimrc file 
```
:nmap <silent> <leader>d <Plug>DashSearch
```
in normal mode after pressing <leader> (normally\) then d 
do DashSearch

### **yank to system clipboard please**

```bash
" select the thing you want.
<Visual line>
"+y
" yank to the clipboard
```


### **basic key mappings**
```bash
ctrl-w, ctrl-w -> switch screens
```

### **goto line**

```bash
<line number>G
i.e.
42G
```

### **config**

#### **map keys in vim**

```bash
:imap jk <esc> 
```
map jk to esc to stop pressing esc


#### **basic column editing**

```bash
crtl-v
```
select the lines that you want
enter writing mode
write the thing you want. Note nothing will appear on any other lines than the first
press esc



#### **diffing files**

https://lornajane.net/posts/2015/vimdiff-and-vim-to-compare-files
https://stackoverflow.com/questions/1265410/is-there-a-way-to-configure-vimdiff-to-ignore-all-whitespaces

```bash 
vimdiff <file 1> <file 2 >
```

#### **split screen vertical / horizontal**

```bash
:vsplit <filename>
" or
:vsp
```
or 
```bash
:hsplit <filename>
" or 
:sp
```

#### **tagging out multiple lines**

```bash
:<line number from>,<line number to>/^/# 
```

#### **set line numbers**
```bash
:set numbers
" or
:set nonumbers
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
or remove all backslashes

```bash
:%s/\///g
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
