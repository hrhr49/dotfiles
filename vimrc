set encoding=utf-8
scriptencoding utf-8
set shellslash

"以下のを入れると、プラグイン関連での補完関連でエラーが出ちゃう
"autocmd CompleteDone * pclose
filetype plugin indent on
syntax on

set mouse=a
" mapping
inoremap <C-r> <C-r><C-p>
inoremap <C-l> <C-x><C-l>
inoremap jj <ESC>
inoremap jk <C-n>
inoremap <C-k> <Esc>gg/aaa<CR>cgn
nnoremap <M-d> <C-d>
nnoremap <M-u> <C-u>
nnoremap n nzz
nnoremap N Nzz

" nnoremap vv <S-v>

" " mapping for left little finger
" let i=char2nr('!')
" while 1
"     let c=nr2char(i)
"     if c=='|'
"         let c='\\|'
"     endif
"     execute 'noremap <Space>' . c . ' <C-' . c . '>'
"     execute 'nmap <ESC>' . c . ' <M-' . c . '>'
"     execute 'noremap <M-' . c . '> <C-' . c . '>'
"     execute 'cnoremap <M-' . c . '> <C-' . c . '>'
"     execute 'inoremap <M-' . c . '> <C-' . c . '>'
"     if c=='~'
"         break
"     endif
"     let i=i+1
" endwhile

nnoremap <Space>j <C-f>
nnoremap <Space>k <C-b>
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap ss <C-w>s
nnoremap sv <C-w>v
nnoremap sq <C-w>q
nnoremap su <C-u>
nnoremap sd <C-d>
nnoremap s^ <C-^>
nnoremap st :tabnew<CR>
nnoremap sp gT
nnoremap sn gt

vnoremap ge :s/[^\x01-\x7E]/&薔/ge<CR> \| gv:!graph-easy<CR> \| :'[,']s/薔//ge<CR>
vnoremap gp :s/[^\x01-\x7E]/&薔/ge<CR> \| gv:!plantuml -txt -p<CR> \| :'[,']s/薔//ge<CR>

"nn <C-k> k:call search ("^". matchstr (getline (line (".")+ 1), '\(\s*\)') ."\\S", 'b')<CR>^
"nn <C-j> :call search ("^". matchstr (getline (line (".")), '\(\s*\)') ."\\S")<CR>^
let loaded_matchparen = 1
let g:netrw_keepdir = 0
"let g:markdown_folding=1
"set completeopt+=longest

" show foldings
"set foldcolumn=1

" remove tag comeletion from default
set complete-=t
set autochdir
set autoindent
set clipboard&
set clipboard^=unnamedplus
set expandtab

set ignorecase
set smartcase

set nobackup
set nohlsearch
set noswapfile
set noundofile
set number
set shiftwidth=4
set smartindent
set smarttab
set tabstop=4
set wildignorecase
set wildmenu
set wrapscan
set incsearch
"set cursorline

set tags+=tags;
set laststatus=2

augroup RunProgram
autocmd FileType python nnoremap <F5> :w\|!python %<CR>
autocmd FileType ruby nnoremap <F5> :w\|!ruby %<CR>
autocmd FileType perl nnoremap <F5> :w\|!perl %<CR>
autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType go nnoremap <F5> :w\|!go run %<CR>
autocmd FileType javascript nnoremap <F5> :w\|!node %<CR>
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab iskeyword+=-
autocmd FileType html nnoremap <F5> :w\|!google-chrome %<CR>
autocmd FileType markdown nnoremap <F5> :w\|!google-chrome %<CR>
autocmd FileType markdown nnoremap <F6> :w\|!pandoc -t html5 -s --mathjax 
            \ -f markdown+hard_line_breaks --highlight-style=pygments
            \ -c ~/memo/pandoc/github.css --filter ~/memo/pandoc/my_pandoc_filter.py -o %:r.html %<CR>
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd FileType typescript nnoremap <F5> :w \| !tsc % \| node %:r.js<CR>
autocmd BufRead,BufNewFile *.ts set filetype=typescript
autocmd BufRead,BufNewFile *.pu nnoremap <F5> :w \| !plantuml %<CR>
autocmd BufRead,BufNewFile *.dot nnoremap <F5> :w \| !dot % -O -Tpng<CR>
autocmd BufRead,BufNewFile *.adoc nnoremap <F5> :w \| !asciidoctor -r asciidoctor-diagram %<CR>
" autocmd FileType python call s:configure_lsp()
autocmd FileType vim nnoremap <F5> :w\|so %<CR>
augroup END
nnoremap <F6> :make<CR>

try
colorscheme molokai
"colorscheme gruvbox
set guioptions-=m
set guioptions-=T
set guifont=Monospace\ 14
catch
endtry

try
set path+=~/memo/**
catch
endtry

" hi MatchParen ctermbg=1

" for completion==============================
"set completeopt=menuone
"for k in split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_",'\zs')
"  exec "imap " . k . " " . k . "<C-N><C-P>"
"endfor

"imap <expr> <TAB> pumvisible() ? "\<Down>" : "\<Tab>"
"imap <expr> . pumvisible() ? "\<C-Y>.\<C-X>\<C-O>\<C-P>" : ".\<C-X>\<C-O>\<C-P>"

" ============================================
" Plugins
" ============================================
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'michaeljsmith/vim-indent-object'
"Plug 'w0rp/ale'
Plug 'majutsushi/tagbar'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-commentary'
" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp'
" Plug 'prabirshrestha/asyncomplete.vim'
" Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'flazz/vim-colorschemes'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" for markdown
Plug 'previm/previm'
Plug 'vim-scripts/DrawIt'
" Initialize plugin system
Plug 'mattn/emmet-vim'
call plug#end()

let g:deoplete#enable_at_startup = 1

""let g:jedi#use_tabs_not_buffers = 1 "補完で次の候補に進むときにtabを使えるという設定にしたつもりですができませんでした。
"let g:jedi#popup_select_first = 0 "1個目の候補が入力されるっていう設定を解除
"let g:jedi#popup_on_dot = 0 " .を入力すると補完が始まるという設定を解除
"
""let g:jedi#goto_command = "<leader>d"
""let g:jedi#goto_assignments_command = "<leader>g"
""let g:jedi#goto_definitions_command = ""
""let g:jedi#documentation_command = "K"
""let g:jedi#usages_command = "<leader>n"
""let g:jedi#rename_command = "<leader>R" "quick-runと競合しないように大文字Rに変更. READMEだと<leader>r
"let g:jedi#smart_auto_mappings = 0 "勝手にimportを入力されるのがうざかったので
"let g:jedi#show_call_signatures = 0 "関数の引数を表示しない(numpyやpandasだとうざかったので)
autocmd FileType python setlocal completeopt-=preview "ポップアップを表示しない

let g:ale_echo_cursor = 0


"map [- <Plug>(IndentWisePreviousLesserIndent)
"map [= <Plug>(IndentWisePreviousEqualIndent)
"map [+ <Plug>(IndentWisePreviousGreaterIndent)
"map ]- <Plug>(IndentWiseNextLesserIndent)
"map ]= <Plug>(IndentWiseNextEqualIndent)
"map ]+ <Plug>(IndentWiseNextGreaterIndent)
"map [_ <Plug>(IndentWisePreviousAbsoluteIndent)
"map ]_ <Plug>(IndentWiseNextAbsoluteIndent)
"map [% <Plug>(IndentWiseBlockScopeBoundaryBegin)
"map ]% <Plug>(IndentWiseBlockScopeBoundaryEnd)

" CtrlP
let g:ctrlp_map = '<C-p>'
" let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_match_window = 'max:20'
nnoremap <Space>t :<C-u>CtrlPTag<CR>
nnoremap <Space>p :<C-u>CtrlP<CR>
nnoremap <Space>m :<C-u>CtrlPMixed<CR>
nnoremap <Space>r :<C-u>CtrlPMRU<CR>
nnoremap <Space>b :<C-u>CtrlPBuffer<CR>
nnoremap <Space>l :<C-u>CtrlPLine<CR>
nnoremap <Space>c :<C-u>CtrlP ~/memo/<CR>

" Tagbar

nnoremap <F8> :TagbarToggle<CR>
nnoremap <Space>o :TagbarToggle<CR>

" NERDTree
"nnoremap <Space>e :<C-u>NERDTreeToggle<CR>
"nnoremap <Space>E :<C-u>NERDTree<CR>
"let NERDTreeQuitOnOpen=1

" " vim-lsp
" if executable('pyls')
" " pip install python-language-server
" au User lsp_setup call lsp#register_server({
"     \ 'name': 'pyls',
"     \ 'cmd': {server_info->['pyls']},
"     \ 'whitelist': ['python'],
"     \ })
" endif

" function! s:configure_lsp() abort
"   setlocal omnifunc=lsp#complete   " オムニ補完を有効化
"   " LSP用にマッピング
"   nnoremap <buffer> <C-]> :<C-u>LspDefinition<CR>
"   nnoremap <buffer> gd :<C-u>LspDefinition<CR>
"   nnoremap <buffer> gD :<C-u>LspReferences<CR>
"   nnoremap <buffer> gs :<C-u>LspDocumentSymbol<CR>
"   nnoremap <buffer> gS :<C-u>LspWorkspaceSymbol<CR>
"   nnoremap <buffer> gQ :<C-u>LspDocumentFormat<CR>
"   vnoremap <buffer> gQ :LspDocumentRangeFormat<CR>
"   nnoremap <buffer> K :<C-u>LspHover<CR>
"   nnoremap <buffer> <F1> :<C-u>LspImplementation<CR>
"   nnoremap <buffer> <F2> :<C-u>LspRename<CR>
" endfunction

" asynccomplete
" let g:asyncomplete_smart_completion = 1
let g:asyncomplete_auto_popup = 1

" language server client
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['pyls'],
    \ }
"'c': ['clangd-6.0'],
" let g:LanguageClient_windowLogMessageLevel = 'Info'
" let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_useVirtualText = 0


"nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <F2> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
"nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
"nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>


nnoremap <Space>q <C-w>q

" Easy-Motion
" map s <Plug>(easymotion-prefix)
try
"colorscheme gruvbox
catch
endtry
hi clear SpellCap
hi clear SpellLocal
hi clear SpellRare
hi clear SpellBad

" for previm
let g:previm_open_cmd = "google-chrome"

"function! s:get_syn_id(transparent)
"  let synid = synID(line("."), col("."), 1)
"  if a:transparent
"    return synIDtrans(synid)
"  else
"    return synid
"  endif
"endfunction
"function! s:get_syn_attr(synid)
"  let name = synIDattr(a:synid, "name")
"  let ctermfg = synIDattr(a:synid, "fg", "cterm")
"  let ctermbg = synIDattr(a:synid, "bg", "cterm")
"  let guifg = synIDattr(a:synid, "fg", "gui")
"  let guibg = synIDattr(a:synid, "bg", "gui")
"  return {
"        \ "name": name,
"        \ "ctermfg": ctermfg,
"        \ "ctermbg": ctermbg,
"        \ "guifg": guifg,
"        \ "guibg": guibg}
"endfunction
"function! s:get_syn_info()
"  let baseSyn = s:get_syn_attr(s:get_syn_id(0))
"  echo "name: " . baseSyn.name .
"        \ " ctermfg: " . baseSyn.ctermfg .
"        \ " ctermbg: " . baseSyn.ctermbg .
"        \ " guifg: " . baseSyn.guifg .
"        \ " guibg: " . baseSyn.guibg
"  let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
"  echo "link to"
"  echo "name: " . linkedSyn.name .
"        \ " ctermfg: " . linkedSyn.ctermfg .
"        \ " ctermbg: " . linkedSyn.ctermbg .
"        \ " guifg: " . linkedSyn.guifg .
"        \ " guibg: " . linkedSyn.guibg
"endfunction
"command! SyntaxInfo call s:get_syn_info()

"inoremap <expr> ;  <SID>sticky_func()
"cnoremap <expr> ;  <SID>sticky_func()
"snoremap <expr> ;  <SID>sticky_func()
"
"function! s:sticky_func()
"    let l:sticky_table = {
"                \',' : '<', '.' : '>', '/' : '?',
"                \'1' : '!', '2' : '@', '3' : '#', '4' : '$', '5' : '%',
"                \'6' : '&', '7' : "'", '8' : '(', '9' : ')', '0' : ')', '-' : '=', '^' : '~',
"                \';' : '+', '[' : '{', ']' : '}', '@' : '`', ":" : "*", '\' : '|'
"                \}
"    " let l:sticky_table = {
"    "             \',' : '<', '.' : '>', '/' : '?',
"    "             \'1' : '!', '2' : '@', '3' : '#', '4' : '$', '5' : '%',
"    "             \'6' : '^', '7' : '&', '8' : '*', '9' : '(', '0' : ')', '-' : '_', '=' : '+',
"    "             \';' : ':', '[' : '{', ']' : '}', '`' : '~', "'" : "\"", '\' : '|',
"    "             \}
"    let l:special_table = {
"                \"\<ESC>" : "\<ESC>", "\<Space>" : ';', "\<CR>" : ";\<CR>"
"                \}
"
"    let l:key = getchar()
"    if nr2char(l:key) =~ '\l'
"        return toupper(nr2char(l:key))
"    elseif has_key(l:sticky_table, nr2char(l:key))
"        return l:sticky_table[nr2char(l:key)]
"    elseif has_key(l:special_table, nr2char(l:key))
"        return l:special_table[nr2char(l:key)]
"    else
"        return ''
"    endif
"endfunction
