Title: vim
summary: summary of useful stuff for writing code in vim
- - - 
# to learn
- vim macros **to_learn

[guides](https://www.ubuntupit.com/100-useful-vim-commands-that-youll-need-every-day/)
[guides_2](https://hackernoon.com/useful-vim-tricks-for-2019-e7c1db7a18d6)

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

### **dealing with ranges**
(ranges)[https://vim.fandom.com/wiki/Ranges]

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

most useful for commenting 
```
crtl-v " select a bunch of rows
shift-I " enter insert mode
<enter the keys that we need> 
esc " will now generate that across the whole range
```



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

#### **wrap text or digits in quotes**

This is black magic
```bash
" 6091-1
:%s/\([0-9\-]*\)/"\1",/g
" "6091-1",

```

#### **strip leading whitespacee**

```
:%s/^[ \t]*//g
```





#### **delete blank lines**

```bash
:g/^$/d
```

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
# config backups
 
#### **nvim 2010-10**

```bash
set incsearch   " ingore case search
set hlsearch    " highlight search results
set ignorecase 
set spell       " turn spell check on/off
set cursorline  " cursorline
set number      " line numbere 
set showmatch   " highlight matching

syntax on       " syntax highlighting
colorscheme molokai   
filetype indent on " file specific indentin   
set wildmenu    " visual menu for looking at files

set tabstop=4   " tab vs spaces indentation
set softtabstop=4 
set expandtab
set bs=2 " add backspace matching

" key mappings
imap jk <esc>  " stop pressing esc all the time
imap kj <esc>  " stop pressing esc all the time
imap sd <esc>  " see above
imap ds <esc>  " see above

" sensible window switching
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp*,/private/tmp/*
set directory=/~/.vim-tmp,~/.tmp,~/tmp,var/tmp,tmp
set writebackup


" general key remaps 
noremap £ :norm i#<CR>

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Pathogen load
filetype off
" execute pathogen#infect()
" filetype plugin indent on


" COC comfig
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Dash shizzle
:nmap <silent> <leader>d <Plug>DashSearch
```



## sublime


