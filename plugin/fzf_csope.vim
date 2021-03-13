""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CSCOPE settings for vim using popup and preview window
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" This file contains fzf shortcut for vim's cscope interface,
" with keyboard mappings.
" Prerequiites
" USAGE:
" -- vim 6:     Stick this file in your ~/.vim/plugin directory (or in a
"               'plugin' directory in some other directory that is in your
"               'runtimepath'.
"
" NOTE:
" These key maps use multiple keystrokes (2 or 3 keys).  If you find that vim
" keeps timing you out before you can complete them, try changing your timeout
" settings, as explained below.
"
" Happy cscoping,
"
" Nabendu Maiti       nbmaiti83@gmail.com     2021/3/14
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! Cscope(option, query, fullscreen)
    let color = '{ x = $1; $1 = ""; z = $3; $3 = ""; p = $2; $2 = "";  printf "\033[35m%s\033[0m:\033[32m%s\033[0m:\033[33;1m%s\033[0m:\033[34m%s\033[0m\n", x,z,p,$0;}'
    let command_fmt = "cscope -dL -%s %s %s %s '"

    let initial_command = printf(command_fmt, a:option, shellescape(a:query)," | awk '", color)
    let reload_command = printf(command_fmt, a:option, '{q}', " | awk '", color)
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 0, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

function! CscopeQuery(option)
    call inputsave()
    if a:option == '0'
        let query = input('C Symbol: ')
    elseif a:option == '1'
        let query = input('Definition: ')
    elseif a:option == '2'
        let query = input('Functions calling: ')
    elseif a:option == '3'
        let query = input('Functions called by: ')
    elseif a:option == '4'
        let query = input('Text: ')
    elseif a:option == '6'
        let query = input('Egrep: ')
    elseif a:option == '7'
        let query = input('File: ')
    elseif a:option == '8'
        let query = input('Files #including: ')
    elseif a:option == '9'
        let query = input('Assignments to: ')
    else
        echo "Invalid option!"
        return
    endif
    call inputrestore()
    if query != ""
        call Cscope(a:option, query , 0)
    else
        echom "Cancelled Search!"
    endif
endfunction

if mapcheck('<C-\>g') == ""
    "'s'   symbol: find all references to the token under cursor
    "'g'   global: find global definition(s) of the token under cursor
    "'c'   calls:  find all calls to the function name under cursor
    "'t'   text:   find all instances of the text under cursor
    "'e'   egrep:  egrep search for the word under cursor
    "'f'   file:   open the filename under cursor
    "'i'   includes: find files that include the filename under cursor
    "'d'   called: find functions that function under cursor calls
    "'a'   Assigned: Assigned to this symbol

    nnoremap <C-\>s :call Cscope('0', expand('<cword>'), 0)<CR>
    nnoremap <C-\>g :call Cscope('1', expand('<cword>'), 0)<CR>
    nnoremap <C-\>d :call Cscope('2', expand('<cword>'), 0)<CR>
    nnoremap <C-\>c :call Cscope('3', expand('<cword>'), 0)<CR>
    nnoremap <C-\>t :call Cscope('4', expand('<cword>'), 0)<CR>
    nnoremap <C-\>e :call Cscope('6', expand('<cword>'), 0)<CR>
    nnoremap <C-\>f :call Cscope('7', expand('<cfile>'), 0)<CR>
    nnoremap <C-\>i :call Cscope('8', expand('<cfile>'), 0)<CR>
    nnoremap <C-\>a :call Cscope('9', expand('<cword>'), 0)<CR>

    nnoremap <C-\><C-\>s :call CscopeQuery('0')<CR>
    nnoremap <C-\><C-\>g :call CscopeQuery('1')<CR>
    nnoremap <C-\><C-\>d :call CscopeQuery('2')<CR>
    nnoremap <C-\><C-\>c :call CscopeQuery('3')<CR>
    nnoremap <C-\><C-\>t :call CscopeQuery('4')<CR>
    nnoremap <C-\><C-\>e :call CscopeQuery('6')<CR>
    nnoremap <C-\><C-\>f :call CscopeQuery('7')<CR>
    nnoremap <C-\><C-\>i :call CscopeQuery('8')<CR>
    nnoremap <C-\><C-\>a :call CscopeQuery('9')<CR>
endif

" default and permanent key apping
nnoremap <silent> <Leader>ks :call Cscope('0', expand('<cword>'), 0)<CR>
nnoremap <silent> <Leader>kg :call Cscope('1', expand('<cword>'), 0)<CR>
nnoremap <silent> <Leader>kd :call Cscope('2', expand('<cword>'), 0)<CR>
nnoremap <silent> <Leader>kc :call Cscope('3', expand('<cword>'), 0)<CR>
nnoremap <silent> <Leader>kt :call Cscope('4', expand('<cword>'), 0)<CR>
nnoremap <silent> <Leader>ke :call Cscope('6', expand('<cword>'), 0)<CR>
nnoremap <silent> <Leader>kf :call Cscope('7', expand('<cword>'), 0)<CR>
nnoremap <silent> <Leader>ki :call Cscope('8', expand('<cword>'), 0)<CR>
nnoremap <silent> <Leader>ka :call Cscope('9', expand('<cword>'), 0)<CR>

nnoremap <silent> <Leader><Leader>ks :call CscopeQuery('0')<CR>
nnoremap <silent> <Leader><Leader>kg :call CscopeQuery('1')<CR>
nnoremap <silent> <Leader><Leader>kd :call CscopeQuery('2')<CR>
nnoremap <silent> <Leader><Leader>kc :call CscopeQuery('3')<CR>
nnoremap <silent> <Leader><Leader>kt :call CscopeQuery('4')<CR>
nnoremap <silent> <Leader><Leader>ke :call CscopeQuery('6')<CR>
nnoremap <silent> <Leader><Leader>kf :call CscopeQuery('7')<CR>
nnoremap <silent> <Leader><Leader>ki :call CscopeQuery('8')<CR>
nnoremap <silent> <Leader><Leader>ka :call CscopeQuery('9')<CR>


