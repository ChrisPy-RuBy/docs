Title: vim
summary: summary of useful stuff for writing code in vim
- - - 
# vim

## to learn
- vim macros **to_learn

[guides](https://www.ubuntupit.com/100-useful-vim-commands-that-youll-need-every-day/)
[guides_2](https://hackernoon.com/useful-vim-tricks-for-2019-e7c1db7a18d6)

## config

### understanding keymappings

[start_here](https://vim.fandom.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_1))

## plugins

### ctags

### setup
install ctags
make tag file 
```ctags -R .
```

### ale

#### check the status of a linter

type in the file you are interested in to get an overview of what is happening
```
:ALEInfo
```
need to have the configured linter install i.e.
sudp apt-get install shellcheck

## setup

## key mappings

### **map keys in vim**

```bash
:imap jk <esc> 
```
map jk to esc to stop pressing esc

### **basic key mappings**
```bash
ctrl-w, ctrl-w -> switch screens
```

### key configs

## tricks

### **Piping to external programs**

super useful

```bash
" this would select everything from the current line to 3 lines below, and pipe through to sort.
:.,+3!sort
```

autoformat your code with black.
This would format the whole doc
```bash
:0,$!black - -q
```

make a json file readable
```
:%!jq .
```

## visual model

### visual block mode
ctrl-v

#### insert something
select block
shift-I
esc esc

#### basic column editing

```bash
crtl-v
```
select the lines that you want
enter writing mode
write the thing you want. Note nothing will appear on any other lines than the first
press esc

most useful for commenting 
```
crtl-v " select a bunch of rows
shift-I " enter insert mode
<enter the keys that we need> 
esc " will now generate that across the whole range
```



## find and replace

### find and replace in block
select block
```
:s/\%V<old>/<new>g
```

### wrap text or digits in quotes

This is black magic
```bash
" 6091-1
:%s/\([0-9\-]*\)/"\1",/g
" "6091-1",

```

### strip leading whitespace

```
:%s/^[ \t]*//g
```



### delete blank lines

```bash
:g/^$/d
```



### **goto line**

```bash
<line number>G
i.e.
42G
```

### **dealing with ranges**
(ranges)[https://vim.fandom.com/wiki/Ranges]

### **config**





#### **diffing files**

https://lornajane.net/posts/2015/vimdiff-and-vim-to-compare-files
https://stackoverflow.com/questions/1265410/is-there-a-way-to-configure-vimdiff-to-ignore-all-whitespaces

```bash 
vimdiff <file 1> <file 2 >
```

#### **diff files open in split windows**

With the windows open.
Wtf is 'windo'
```
:windo diffthis
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
#### **process teamcity console output and make human readable**
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

#### **math and remove evrything to the end of line**

```bash
:s%/stringtomatch.*$//
```

### **copy and paste**

#### **delete line, copy and paste**
```bash
dd
p
```
 



