# fzf_cscope.vim

 CSCOPE settings for vim using popup and preview window
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

![image-20210314031215254](https://raw.githubusercontent.com/nmaiti/fzf_cscope.vim/master/screenshoot.png)





 This file contains settings for vim's cscope interface to fzf (can use vim* >8 advanced popup feature), " plus some keyboard mappings that I've found useful.

### Prerequisites  : 

1. cscope  -- install using 'sudo apt install cscope' on ubuntu
2. https://github.com/junegunn/fzf
3. https://github.com/junegunn/fzf.vim

### Installation:

Install fzf & fzf.vim before installing fzf_csope.vim and using it

`Using`  [pathogen.vim](https://github.com/tpope/vim-pathogen), and then simply copy and paste:

```sh
mkdir -p ~/.vim/bundle
cd ~/.vim/bundle
git clone https://github.com/nmaiti/fzf_cscope.vim.git
```

using [vim Plug](https://github.com/junegunn/vim-plug) add following in your ~/.vimrc

```sh
Plug 'nmaiti/fzf_cscope.vim'
```



### **key mappings**

Search options:
"'s'   symbol: find all references to the token under cursor
"'g'   global: find global definition(s) of the token under cursor
"'c'   calls:  find all calls to the function name under cursor
"'t'   text:   find all instances of the text under cursor
"'e'   egrep:  egrep search for the word under cursor
"'f'   file:   open the filename under cursor
"'i'   includes: find files that include the filename under cursor
"'d'   called: find functions that function under cursor calls
"'a'   Assigned: Assigned to this symbol

```shell
<Leader>k<search option key>  ------- search word/file under the current cursor
e.g.sc
<Leader>kc  -   find callers of current keyword/symbol
```

// Interactive cscope search

```sh
<Leader><Leader>k<search option key>  ------- search something
e.g.
<Leader><Leader>ks  -   find symbol
```

**NOTE**:

1. These key maps use multiple keystrokes (2 or 3 keys).  If you find that vim
   " keeps timing you out before you can complete them, try changing your timeout
   " settings, as explained below
2. cscope_map.vim can also be used independently with it's own key mappings. If not csope_maps.vim is not present fzf_cscope.vim can use csope_maps.vim's keyboard shortcuts for convenience of programmers.
      In that case instead of '<Leader>k', '<Ctrl - \>' can be used.
 
 **Self promotion**:
 
 Try [zsh_vim config](https://github.com/nmaiti/zsh-vim-config/tree/to_plug) to_plug branch for latest vim features and plugins

