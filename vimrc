" vim:set foldmethod=marker foldlevel=0:
set encoding=utf-8
scriptencoding utf-8
set shellslash

" 一般{{{
"以下のを入れると、プラグイン関連での補完関連でエラーが出ちゃう
"autocmd CompleteDone * pclose
filetype plugin indent on
syntax on

" let loaded_matchparen = 1
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
"set nohlsearch
" 以下のマッピングをすると、vim8を起動したときに置換モードになってしまう
" nnoremap <Esc> :noh<CR>
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
set mouse=a
try
set path+=~/memo/**
catch
endtry
set tags+=tags;
set laststatus=2

" }}}
" キーマッピング(一般){{{
inoremap <C-r> <C-r><C-p>
inoremap <C-l> <C-x><C-l>
inoremap jj <ESC>
inoremap jk <C-n>
inoremap <C-k> <Esc>gg/aaa<CR>cgn
inoremap <C-;> <Esc>cgn
nnoremap <M-d> <C-d>
nnoremap <M-u> <C-u>
nnoremap n nzz
nnoremap N Nzz
nnoremap <C-k> :lvim <C-r><C-w> ##<CR>
nnoremap <Space>j <C-f>
nnoremap <Space>k <C-b>
nnoremap sH <C-w>H
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sT <C-w>T
nnoremap s^ <C-^>
nnoremap sd <C-d>
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sn gt
nnoremap so <C-w>o
nnoremap sp gT
nnoremap sq <C-w>q
nnoremap ss <C-w>s
nnoremap st :tabnew<CR>
nnoremap su <C-u>
nnoremap sv <C-w>v

nnoremap <F6> :make<CR>
nnoremap <C-S-e> :Ex<CR>
map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>
map <2-MiddleMouse> <Nop>
imap <2-MiddleMouse> <Nop>
map <3-MiddleMouse> <Nop>
imap <3-MiddleMouse> <Nop>
map <4-MiddleMouse> <Nop>
imap <4-MiddleMouse> <Nop>

" 選択中のテキストを*で検索
vnoremap * "zy:let @/ = @z<CR>n

" ペーストしたテキストをビジュアルモードで選択
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" 外部コマンドとの連携
vnoremap ge :s/[^\x01-\x7E]/&薔/ge<CR> \| gv:!graph-easy<CR> \| :'[,']s/薔//ge<CR>
vnoremap gp :s/[^\x01-\x7E]/&薔/ge<CR> \| gv:!plantuml -txt -p<CR> \| :'[,']s/薔//ge<CR>
"}}}
" ファイル別設定{{{
augroup RunProgram
autocmd!
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
autocmd FileType vim setlocal ts=2 sts=2 sw=2
autocmd BufRead,BufNewFile *.md setlocal filetype=markdown
" autocmd BufRead,BufNewFile *.md setlocal filetype=ghmarkdown
autocmd FileType typescript nnoremap <F5> :w \| !tsc % \| node %:r.js<CR>
autocmd BufRead,BufNewFile *.ts set filetype=typescript
autocmd BufRead,BufNewFile *.pu nnoremap <F5> :w \| !plantuml %<CR>
autocmd BufRead,BufNewFile *.dot nnoremap <F5> :w \| !dot % -O -Tpng<CR>
autocmd BufRead,BufNewFile *.adoc nnoremap <F5> :w \| !asciidoctor -r asciidoctor-diagram %<CR>
autocmd BufRead,BufNewFile *.sh nnoremap <F5> :w \| !%:p<CR>
autocmd BufRead,BufNewFile *.c nnoremap <F5> :w \| !gcc % && ./a.out<CR>
autocmd BufRead,BufNewFile *.tcl nnoremap <F5> :w \| !wish %<CR>
autocmd BufRead,BufNewFile *.scm nnoremap <F5> :w \| !gosh %<CR>
" autocmd FileType python call s:configure_lsp()
autocmd FileType vim nnoremap <F5> :w\|so %<CR>
augroup END"}}}
" プラグイン一覧{{{
try
  " Specify a directory for plugins
  " - For Neovim: ~/.local/share/nvim/plugged
  " - Avoid using standard Vim directory names like 'plugin'
  call plug#begin('~/.vim/plugged')
 
  " Make sure you use single quotes

  " 日本語のヘルプ
  Plug 'vim-jp/vimdoc-ja'


  " Plug 'scrooloose/nerdtree'

  " ファイルなどのあいまい検索
  if executable('fzf')
    Plug '~/.fzf/'
    Plug 'junegunn/fzf.vim'
  else
    Plug 'ctrlpvim/ctrlp.vim'
    " Plug 'ompugao/ctrlp-history'
  endif
 
  " Plug 'MattesGroeger/vim-bookmarks'
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
  " Plug 'ayu-theme/ayu-vim' " or other package manager
  "...
  " set termguicolors     " enable true colors support
  " let ayucolor="light"  " for light version of theme
  " let ayucolor="mirage" " for mirage version of theme
  " let ayucolor="dark"   " for dark version of theme
  " colorscheme ayu
 
  " Plug 'rakr/vim-one'
  " set background=dark
 
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
  " Plug 'previm/previm'
  " Plug 'vim-scripts/DrawIt'
  " Initialize plugin system
  Plug 'mattn/emmet-vim'
  " Plug 'jtratner/vim-flavored-markdown'
 
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  " Plug 'sjl/gundo.vim'
  " Plug 'francoiscabrol/ranger.vim'
  " Plug 'rbgrouleff/bclose.vim'
  Plug 'easymotion/vim-easymotion'
  " Plug 'junegunn/vim-easy-align'
  Plug 'LeafCage/yankround.vim'
  " Plug 'maxbrunsfeld/vim-yankstack'
  call plug#end()
catch
  echo 'vim-plug is not found'
endtry

""}}}
" プラグイン設定{{{
" deopeleteの自動スタートアップで1秒ぐらいかかるときがある!
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

" let g:ale_echo_cursor = 0


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

if executable('fzf')
    " fzf
    nnoremap <Space>t :<C-u>Tags<CR>
    nnoremap <Space>p :<C-u>Files<CR>
    nnoremap <Space>r :<C-u>History<CR>
    nnoremap <Space>b :<C-u>Buffers<CR>
    nnoremap <Space>l :<C-u>BLines<CR>
    nnoremap <Space>c :<C-u>Colors<CR>
    nnoremap <Space>h :<C-u>History:<CR>
    nnoremap <Space>s :<C-u>History/<CR>
    nnoremap <Space>/ :<C-u>History/<CR>
    nnoremap <Space>m :<C-u>Files ~/memo/<CR>
else
    " CtrlP
    " <Nop>という文字列になってしまうことがあった。
    " 空文字ならうまく行く？
    let g:ctrlp_map = ''
    " let g:ctrlp_cmd = 'CtrlPMixed'
    let g:ctrlp_match_window = 'max:20'
    nnoremap <Space>t :<C-u>CtrlPTag<CR>
    nnoremap <Space>p :<C-u>CtrlP<CR>
    " nnoremap <Space>m :<C-u>CtrlPMixed<CR>
    nnoremap <Space>m :<C-u>CtrlP ~/memo/<CR>
    nnoremap <Space>r :<C-u>CtrlPMRU<CR>
    nnoremap <Space>b :<C-u>CtrlPBuffer<CR>
    nnoremap <Space>l :<C-u>CtrlPLine<CR>
    nnoremap <Space>c :<C-u>CtrlP ~/memo/<CR>

    " CtrlP History
    nnoremap <Space>h :<C-u>CtrlPCmdHistory<CR>
    nnoremap <Space>s :<C-u>CtrlPSearchHistory<CR>
endif

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
" let g:asyncomplete_auto_popup = 1

" language server client
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['pyls'],
    \ 'c': ['clangd-6.0'],
    \}
" let g:LanguageClient_windowLogMessageLevel = 'Info'
" let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_useVirtualText = 0


"nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <F2> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
"nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
"nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" gdb使用の設定
" packadd termdebug

" gdb使用の設定
" let g:termdebug_wide = 163

" Gundoの設定
nnoremap <F9> :GundoToggle<CR>

" rangerの設定
if executable("ranger")
    nnoremap <Space>f :Ranger<CR>
endif

" EasyMotionの設定
" <Leader>f{char} to move to {char}
" map  <Leader>f <Plug>(easymotion-bd-f)
" nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap <Space>s <Plug>(easymotion-overwin-f2)

" Move to line
" map <Leader>L <Plug>(easymotion-bd-jk)
" nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Space>w <Plug>(easymotion-bd-w)
" map  <Space>w <Plug>(easymotion-bd-w)

" nmap <Leader>w <Plug>(easymotion-overwin-w)

" Easy Alignの設定
" vmap ga <Plug>(EasyAlign)

" nmap <Leader>L <Plug>(easymotion-overwin-line)
" yankroundの設定
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
let g:yankround_max_history = 50
" 下なんかうまく動かない
" nnoremap <silent>g<C-p> :<C-u>CtrlPYankRound<CR>

" yankstackの設定
" nmap <leader>p <Plug>yankstack_substitute_older_paste
" nmap <leader>P <Plug>yankstack_substitute_newer_paste

"}}}
" 表示{{{
try
colorscheme molokai
" colorscheme ayu
" colorscheme gruvbox
catch
endtry
try
set guioptions-=m
set guioptions-=T
set guifont=Monospace\ 14
catch
endtry

" hilight current line number
set cursorline
" hi clear CursorLine
"}}}
" スクリプト{{{

" 折りたたみ情報を保持する 参考: http://nametake-1009.hatenablog.com/entry/2016/10/02/212629
let tmp_viewdir=$HOME . '/.vim/view'
execute 'set viewdir=' . tmp_viewdir

augroup SaveFoldings
autocmd!
autocmd BufWritePost * if expand('%') != '' && &buftype !~ 'nofile' | mkview | endif
autocmd BufRead * if expand('%') != '' && &buftype !~ 'nofile' | try | silent loadview | catch | endtry | endif
augroup END
" Don't save options.
set viewoptions-=options

" rangerの設定
function RangerExplorer()
    exec "silent !ranger --choosefile=/tmp/vim_ranger_current_file " . expand("%:p:h")
    if filereadable('/tmp/vim_ranger_current_file')
        exec 'edit ' . system('cat /tmp/vim_ranger_current_file')
        call system('rm /tmp/vim_ranger_current_file')
    endif
    redraw!
endfun
" map <Leader>x :call RangerExplorer()<CR>
map <Space>x :call RangerExplorer()<CR>


function RandomColorScheme()
  let mycolors = split(globpath(&rtp,"**/colors/*.vim"),"\n") 
  exe 'so ' . mycolors[localtime() % len(mycolors)]
endfun
"}}}
" 過去の遺産{{{
" call RandomColorScheme()

" :command NewColor call RandomColorScheme()
"
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
" hi MatchParen ctermbg=1

" for completion==============================
"set completeopt=menuone
"for k in split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_",'\zs')
"  exec "imap " . k . " " . k . "<C-N><C-P>"
"endfor

"imap <expr> <TAB> pumvisible() ? "\<Down>" : "\<Tab>"
"imap <expr> . pumvisible() ? "\<C-Y>.\<C-X>\<C-O>\<C-P>" : ".\<C-X>\<C-O>\<C-P>"
"}}}
