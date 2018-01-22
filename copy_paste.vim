" Nice C++ file settings which are useful during Competitive Programming
" Contests.
" Features: 
"   1) Auto indent lines when file is written. In case of a fuck up in
"      between. That way you can continue typing with out stopping to
"      adjust spaces.
"   2) Usual things such as main body, iostream and some macros will
"      be available as soon as you open the file
"   3) Most Useful: While programming, we always have a standard list
"      of algorithm templates and classes but we need to copy and paste
"      the source from elsewhere. Over here, you can mark the
"      algorithms/classes you wish to use and they will be loaded

" C++ File Settings----------------------{{{
function! Indent() abort
    let l:this_line = line(".")
    normal gg=G
    execute ":normal " . l:this_line . "G"
endfunction

function! Setup() abort
    execute "normal! i#include <iostream>\<C-m>"
    execute "normal! o#define for(i,n) for(int i = 0; i < n; i++)\<C-m>"
    execute "normal! ousing namespace std;\<C-m>"
    execute "normal! oint main(){\<C-m>"
    execute "normal! i\<C-V>\<Tab>\<esc>mqo}\<esc>`qa\<space>"
    normal a
endfunction

function! Header_list() abort
    let l:count = -1
    let l:line = ""
    let l:header_list = []
    while 1 
        let l:count = l:count + 1
        let l:line = getline(l:count)
        let l:space_index = stridx(l:line," ")
        if strlen(l:line) == 0
            continue
        elseif strpart(l:line, 0, 2) ==# "//"
            continue
        elseif l:line[0] ==# '#'
            if strpart(l:line,1,l:space_index-1) ==# "include"
                let l:header_list += [strpart(l:line,l:space_index+1)]
            else
                continue
            endif        
        else
           break 
        endif
    endwhile
    return l:header_list
endfunction

function! Expand() abort
    execute "normal! V?*{\rd"
    let l:required = @
    let l:header_list = Header_list()
python3 << EOF
import vim, os

headers = vim.eval("l:header_list")
to_be_added = set()
algo_names = vim.eval("l:required").split()[1:]
file_names = os.listdir(path='/home/sumit/.algorithms/')

def parse_file(name):
    global headers
    global to_be_added
    try:
        with open('/home/sumit/.algorithms/' + name) as f:
            for line in f:
                if "require" in line:
                    dep = line.split()
                    print(headers)
                    for i in range(3,len(dep)):
                        if not dep[i] in headers:
                            to_be_added = to_be_added | {dep[i]}
                else:
                    if (not "#" in line) and (not "using" in line):
                       vim.command('normal! i' + line)  
    except FileNotFoundError:
        pass  

for name in algo_names:
    for f_name in file_names:
        if f_name.startswith(name[:-1]):
            parse_file(f_name)

vim.command("normal! gg")
for library in to_be_added:
    vim.command("normal! O" + "#include " + library)

EOF
    normal gg=G
    return ""
endfunction

augroup cpp
    autocmd!
    autocmd FileType cpp nnoremap <buffer> <localleader>sc mqA;<esc>`q 
    autocmd BufWritePre *.cpp :execute "call Indent()"
    autocmd BufNewFile *.cpp :execute "call Setup()" 
    autocmd FileType cpp :inoremap }* <esc>:execute "call Expand()"<cr>
" }}}

