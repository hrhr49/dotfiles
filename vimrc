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
set foldmethod=marker

" show foldings
"set foldcolumn=1

" remove tag comeletion from default
set complete-=t

" NERDTreeなどが動かなくなるので無効化
" set autochdir
set autoindent

set clipboard&

" プラットフォームによってクリップボード設定切り替え
if has('unix') || has('mac')
set clipboard^=unnamedplus
endif

if has('win32') || has('win64')
set clipboard^=unnamed
endif

set expandtab

set ignorecase
" 入力の小文字、大文字に合わせて補完
" set infercase
set smartcase

" 補完最中だけ大文字小文字区別
augroup ComplNotIgnore
autocmd!
au InsertEnter * set noignorecase
au InsertLeave * set ignorecase
augroup END

set nobackup
set nowritebackup
set nohlsearch
" 以下のマッピングをすると、vim8を起動したときに置換モードになってしまう
" nnoremap <Esc> :noh<CR>
set noswapfile
set noundofile
set number
set relativenumber
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

" バッファ保存せずに移動できるようにする
set hidden

" homebrewで入れたpython3の認識をさせる。
" なぜかpython3だけ明示的に指定しなければ認識してくれなかった。
if executable('/home/linuxbrew/.linuxbrew/bin/python3')
  let g:python3_host_prog='/home/linuxbrew/.linuxbrew/bin/python3'
endif

" }}}
" キーマッピング(一般){{{
inoremap <C-r> <C-r><C-p>
inoremap <C-l> <C-x><C-l>
inoremap <C-u> <C-g>u<C-u>
inoremap jj <ESC>
inoremap jk <C-n>
inoremap <C-k> <Esc>gg/aaa<CR>cgn
inoremap <C-;> <Esc>cgn
nnoremap <C-l> :noh<CR><C-l>
nnoremap <M-d> <C-d>
nnoremap <M-u> <C-u>
nnoremap n nzz
nnoremap N Nzz
nnoremap <C-k> :lvim <C-r><C-w> ##<CR>
nnoremap <Space>j <C-f>
nnoremap <Space>k <C-b>

nnoremap [window] <Nop>
nmap s [window]
nnoremap [window]H <C-w>H
nnoremap [window]J <C-w>J
nnoremap [window]K <C-w>K
nnoremap [window]L <C-w>L
nnoremap [window]T <C-w>T
nnoremap [window]^ <C-^>
nnoremap [window]d <C-d>
nnoremap [window]h <C-w>h
nnoremap [window]j <C-w>j
nnoremap [window]k <C-w>k
nnoremap [window]l <C-w>l
nnoremap [window]n gt
nnoremap [window]o <C-w>o
nnoremap [window]p gT
nnoremap [window]q <C-w>q
nnoremap [window]s <C-w>s
nnoremap [window]t :tabnew<CR>
nnoremap [window]u <C-u>
nnoremap [window]v <C-w>v

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

" 保存時にsudo権限で無理やり保存
cnoremap w!! w !sudo tee > /dev/null %<CR> :e!<CR>
"}}}
" ファイル別設定{{{
augroup RunProgram
autocmd!
autocmd FileType python nnoremap <buffer> <F5> :w\|!python %<CR>
autocmd FileType ruby nnoremap <buffer> <F5> :w\|!ruby %<CR>
autocmd FileType perl nnoremap <buffer> <F5> :w\|!perl %<CR>
autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType go nnoremap <buffer> <F5> :w\|!go run %<CR>
autocmd FileType javascript nnoremap <buffer> <F5> :w\|!node %<CR>
autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab iskeyword+=-
autocmd FileType html nnoremap <buffer> <F5> :w\|!google-chrome %<CR>
autocmd FileType markdown nnoremap <buffer> <F5> :w\|!google-chrome %<CR>
autocmd FileType markdown nnoremap <buffer> <F6> :w\|!pandoc -t html5 -s --mathjax 
            \ -f markdown+hard_line_breaks --highlight-style=pygments
            \ -c ~/memo/pandoc/github.css --filter ~/memo/pandoc/my_pandoc_filter.py -o %:r.html %<CR>
autocmd FileType vim setlocal ts=2 sts=2 sw=2
autocmd FileType qf noremap <buffer> p  <CR>zz<C-w>p
autocmd BufRead,BufNewFile *.md setlocal filetype=markdown
" autocmd BufRead,BufNewFile *.md setlocal filetype=ghmarkdown
autocmd FileType typescript nnoremap <buffer> <F5> :w \| !tsc % \| node %:r.js<CR>
autocmd BufRead,BufNewFile *.ts setlocal filetype=typescript
autocmd BufRead,BufNewFile *.pu nnoremap <buffer> <F5> :w \| !plantuml %<CR>
autocmd BufRead,BufNewFile *.dot nnoremap <buffer> <F5> :w \| !dot % -O -Tpng<CR>
autocmd BufRead,BufNewFile *.adoc nnoremap <buffer> <F5> :w \| !asciidoctor -r asciidoctor-diagram %<CR>
autocmd BufRead,BufNewFile *.sh nnoremap <buffer> <F5> :w \| !%:p<CR>
autocmd BufRead,BufNewFile *.c nnoremap <buffer> <F5> :w \| !gcc % && ./a.out<CR>
autocmd BufRead,BufNewFile *.tcl nnoremap <buffer> <F5> :w \| !wish %<CR>
autocmd BufRead,BufNewFile *.scm nnoremap <buffer> <F5> :w \| !gosh %<CR>
autocmd BufRead,BufNewFile *.rs nnoremap <buffer> <F5> :w \| !rustc % \| !%:r<CR>
autocmd BufRead,BufNewFile *.nim nnoremap <buffer> <F5> :w \| !nim c -r %<CR>
" autocmd FileType python call s:configure_lsp()
autocmd FileType vim nnoremap <buffer> <F5> :w\|so %<CR>
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


  Plug 'scrooloose/nerdtree'

  " fzfのインストールも同時にやりたい場合は以下のようにする
  " Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  " Plug 'junegunn/fzf.vim'
  " ファイルなどのあいまい検索
  if executable('fzf')
    " Plug '~/.fzf/'
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/fzf'
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
 
" プラットフォームによって走らせるスクリプト変更
" if has('unix') || has('mac')
"   Plug 'autozimu/LanguageClient-neovim', {
"       \ 'branch': 'next',
"       \ 'do': 'bash install.sh',
"       \ }
" endif
" if has('win32') || has('win64')
"   Plug 'autozimu/LanguageClient-neovim', {
"       \ 'branch': 'next',
"       \ 'do': 'powershell -executionpolicy bypass -File install.ps1',
"       \ }
" endif

"   if has('nvim')
"     Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"   else
"     Plug 'Shougo/deoplete.nvim'
"     Plug 'roxma/nvim-yarp'
"     Plug 'roxma/vim-hug-neovim-rpc'
"   endif

  " Use release branch
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
 
  " for markdown
  " Plug 'previm/previm'
  " Plug 'vim-scripts/DrawIt'
  " Initialize plugin system
  Plug 'mattn/emmet-vim'
  " Plug 'jtratner/vim-flavored-markdown'
 
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  Plug 'sjl/gundo.vim'
  Plug 'francoiscabrol/ranger.vim'
  Plug 'rbgrouleff/bclose.vim'
  Plug 'easymotion/vim-easymotion'
  " Plug 'junegunn/vim-easy-align'
  Plug 'LeafCage/yankround.vim'
  " Plug 'maxbrunsfeld/vim-yankstack'
  " Plug 'liuchengxu/vim-which-key'

  " スクロールのを入れたが、どうもタイムラグが気になってしまったので保留
  " Plug 'yuttie/comfortable-motion.vim'
  " Plug 'terryma/vim-smooth-scroll'
  Plug 'tpope/vim-surround'
  Plug 'h1mesuke/vim-alignta'
  " Plug 'junegunn/vim-easy-align'

  " vim-markdownにはtabularが必要っぽい
  " Plug 'godlygeek/tabular'
  " Plug 'plasticboy/vim-markdown'
  " Plug 'luochen1990/rainbow'
  Plug 'kien/rainbow_parentheses.vim'
  Plug 'ap/vim-css-color'
  call plug#end()
catch
  echo 'vim-plug is not found'
endtry

""}}}
" プラグイン設定{{{

" プラグイン存在確認関数
let s:plug = {
      \ "plugs": get(g:, 'plugs', {})
      \ }

function! s:plug.is_installed(name)
  return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
endfunction

if s:plug.is_installed("vim-myplugin")
  " setting
endif

" let g:deopelete#ignore_case = 0
" let g:deopelete#smart_case = 0
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
  nnoremap <Space>t :<C-u>BTags<CR>
  nnoremap <Space><S-t> :<C-u>Tags<CR>
  nnoremap <Space>p :<C-u>Files<CR>
  nnoremap <Space>g :<C-u>GFiles<CR>
  nnoremap <Space><S-g> :<C-u>Ggrep 
  " nnoremap <Space>r :<C-u>History<CR>
  " 履歴はソートせずにプレビューも表示
  " nnoremap <Space>r :<C-u>call fzf#vim#history(fzf#vim#with_preview({'options': '--no-sort'}))<CR>
  nnoremap <Space>r :<C-u>call fzf#vim#history({'options': '--no-sort'})<CR>
  nnoremap <Space>b :<C-u>Buffers<CR>
  nnoremap <Space>l :<C-u>BLines<CR>
  nnoremap <Space><S-l> :<C-u>Lines<CR>
  nnoremap <Space>c :<C-u>BCommits<CR>
  nnoremap <Space><S-c> :<C-u>Commits<CR>
  " nnoremap <Space>h :<C-u>History:<CR>
  " コマンド履歴をソートせずに表示
  nnoremap <Space>h :<C-u>call fzf#vim#command_history({'options': '--no-sort'})<CR>
  " nnoremap <Space>s :<C-u>History/<CR>
  nnoremap <Space>s :<C-u>call fzf#vim#search_history({'options': '--no-sort'})<CR>
  " nnoremap <Space>/ :<C-u>History/<CR>
  nnoremap <Space>/ :<C-u>call fzf#vim#search_history({'options': '--no-sort'})<CR>
  nnoremap <Space>m :<C-u>Files ~/memo/<CR>
  " nnoremap <Space>: :<C-u>History:<CR>
  nnoremap <Space>: :<C-u>call fzf#vim#command_history({'options': '--no-sort'})<CR>
  if executable('rg')
    nnoremap <Space>a :<C-u>Rg<CR>
  else
    nnoremap <Space>a :<C-u>Ag<CR>
  endif
  " 行補完
  imap <c-l> <plug>(fzf-complete-line)

  " レジスタ内容貼り付け
  function! s:get_registers() abort
    redir => l:regs
    silent registers
    redir END

    return split(l:regs, '\n')[1:]
  endfunction

  function! s:registers(...) abort
    let l:opts = {
          \ 'source': s:get_registers(),
          \ 'sink': {x -> feedkeys(matchstr(x, '\v^\S+\ze.*') . (a:1 ? 'P' : 'p'), 'x')},
          \ 'options': '--prompt="Reg> "'
          \ }
    call fzf#run(fzf#wrap(l:opts))
  endfunction

  command! -bang Registers call s:registers('<bang>' ==# '!')

  nnoremap <Space>y :<C-u>Registers<CR>
  nnoremap <Space>" :<C-u>Registers<CR>
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
nnoremap <Space>e :<C-u>NERDTreeToggle<CR>
nnoremap <Space>E :<C-u>NERDTree<CR>
let NERDTreeQuitOnOpen=1

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

if s:plug.is_installed("LanguageClient-neovim")
  " language server client
  let g:LanguageClient_serverCommands = {
      \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
      \ 'javascript': ['javascript-typescript-stdio'],
      \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
      \ 'python': ['pyls'],
      \ 'ruby': ['solargraph', 'stdio'],
      \ 'c': ['clangd-6.0'],
      \}
  " let g:LanguageClient_windowLogMessageLevel = 'Info'
  " let g:LanguageClient_diagnosticsEnable = 0
  " 横に表示される警告文などを出さない
  let g:LanguageClient_useVirtualText = 0


  "nnoremap <F5> :call LanguageClient_contextMenu()<CR>
  nnoremap <F2> :call LanguageClient_contextMenu()<CR>
  " Or map each action separately
  nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
  nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
  nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
  vnoremap <silent> gq :call LanguageClient#textDocument_formatting_sync()<CR>
  nnoremap <silent> <F3> :call LanguageClient#textDocument_rename()<CR>
endif

" gdb使用の設定
" packadd termdebug

" gdb使用の設定
" let g:termdebug_wide = 163

" Gundoの設定
nnoremap <F9> :<C-u>GundoToggle<CR>
nnoremap <Space>u :<C-u>GundoToggle<CR>

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

" Aligntaの設定
if s:plug.is_installed("vim-alignta")
  vnoremap gs :Alignta \s\+<CR>
endif


" nmap <Leader>L <Plug>(easymotion-overwin-line)
" yankroundの設定
if s:plug.is_installed("yankround.vim")
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
endif

" yankstackの設定
" nmap <leader>p <Plug>yankstack_substitute_older_paste
" nmap <leader>P <Plug>yankstack_substitute_newer_paste

" coc.nvimの設定
" 以下にインストールするパッケージ一覧を設定
let g:coc_global_extensions = [
      \ "coc-python",
      \ "coc-tsserver",
      \ "coc-json",
      \ "coc-html",
      \ "coc-css",
      \ "coc-vimlsp",
      \]

function! s:my_coc_nvim_config()
  " coc.nvimの設定
  setl updatetime=300
  setl shortmess+=c
  setl signcolumn=yes
  " Use `[c` and `]c` to navigate diagnostics
  " nmap <buffer> <silent> [c <Plug>(coc-diagnostic-prev)
  " nmap <buffer> <silent> ]c <Plug>(coc-diagnostic-next)

  " Rem<buffer> ap keys for gotos
  nmap <buffer> <silent> gd <Plug>(coc-definition)
  nmap <buffer> <silent> gy <Plug>(coc-type-definition)
  nmap <buffer> <silent> gi <Plug>(coc-implementation)
  nmap <buffer> <silent> gr <Plug>(coc-references)
  xmap <buffer> <silent> gq <Plug>(coc-format-selected)
  nmap <buffer> <silent> gq <Plug>(coc-format-selected)
  " Use K to show documentation in preview window
  nnoremap <buffer> <silent> K :call <SID>show_documentation()<CR>

  " Use `[g` and `]g` to navigate diagnostics
  nmap <buffer> <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <buffer> <silent> ]g <Plug>(coc-diagnostic-next)
  hi clear CocUnderLine 
endfunction

autocmd FileType python call s:my_coc_nvim_config()
autocmd FileType c call s:my_coc_nvim_config()
autocmd FileType cpp call s:my_coc_nvim_config()
autocmd FileType javascript call s:my_coc_nvim_config()
autocmd FileType go call s:my_coc_nvim_config()

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" lightline
function! GetCWD30()
  return getcwd()[-30:]
endfunction

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'workspace'] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'workspace': 'GetCWD30'
      \ },
      \ }

if s:plug.is_installed("plasticboy/vim-markdown")
  let g:vim_markdown_conceal_code_blocks = 0
  let g:vim_markdown_folding_disabled = 1
endif

" luochen1990/rainbow
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
let g:rainbow_conf = {
\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\	'guis': [''],
\	'cterms': [''],
\	'operators': '_,_',
\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\	'separately': {
\		'*': {},
\		'markdown': {
\			'parentheses_options': 'containedin=markdownCode contained', 
\		},
\		'lisp': {
\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'], 
\		},
\		'haskell': {
\			'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/\v\{\ze[^-]/ end=/}/ fold'], 
\		},
\		'vim': {
\			'parentheses_options': 'containedin=vimFuncBody', 
\		},
\		'perl': {
\			'syn_name_prefix': 'perlBlockFoldRainbow', 
\		},
\		'stylus': {
\			'parentheses': ['start=/{/ end=/}/ fold contains=@colorableGroup'], 
\		},
\		'css': 0, 
\	}
\}

if s:plug.is_installed('rainbow_parentheses.vim')
  let g:rbpt_colorpairs = [
        \ ['brown',       'RoyalBlue3'],
        \ ['Darkblue',    'SeaGreen3'],
        \ ['darkgray',    'DarkOrchid3'],
        \ ['darkgreen',   'firebrick3'],
        \ ['darkcyan',    'RoyalBlue3'],
        \ ['darkred',     'SeaGreen3'],
        \ ['darkmagenta', 'DarkOrchid3'],
        \ ['brown',       'firebrick3'],
        \ ['gray',        'RoyalBlue3'],
        \ ['black',       'SeaGreen3'],
        \ ['darkmagenta', 'DarkOrchid3'],
        \ ['Darkblue',    'firebrick3'],
        \ ['darkgreen',   'RoyalBlue3'],
        \ ['darkcyan',    'SeaGreen3'],
        \ ['darkred',     'DarkOrchid3'],
        \ ['red',         'firebrick3'],
        \ ]
  let g:rbpt_max = 16
  let g:rbpt_loadcmd_toggle = 0
  au VimEnter * RainbowParenthesesToggle
  au Syntax * RainbowParenthesesLoadRound
  au Syntax * RainbowParenthesesLoadSquare
  au Syntax * RainbowParenthesesLoadBraces
endif

" emmet
" HTML5のスニペット変更(参考: https://laboradian.com/change-html-of-emmet-vim/)
let g:user_emmet_settings = {
\  'variables' : {
\    'lang' : "ja"
\  },
\  'html' : {
\    'indentation' : '  ',
\    'snippets' : {
\      'html:5': "<!DOCTYPE html>\n"
\        ."<html lang=\"${lang}\">\n"
\        ."<head>\n"
\        ."\t<meta charset=\"${charset}\">\n"
\        ."\t<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n"
\        ."\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n"
\        ."\t<title></title>\n"
\        ."</head>\n"
\        ."<body>\n\t${child}|\n</body>\n"
\        ."</html>",
\    }
\  }
\}
"}}}
" 表示{{{
try
" colorscheme molokai
colorscheme Monokai
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

" 対応カッコの色設定を変更(そのままだとわかりづらいときあった)
" 参考: https://stackoverflow.com/questions/10746750/set-vim-bracket-highlighting-colors
" hi MatchParen cterm=bold ctermbg=none ctermfg=magenta

" hilight current line number
set cursorline
" hi clear CursorLine

set conceallevel=0
" 80列目の色を変える
set colorcolumn=80

" 200桁以上の行はシンタックスハイライトしない
set synmaxcol=250

if has('nvim')
  if has('+pumblend')
    " ポップアップメニューを半透明にする
    set pumblend=10
  endif
endif

if has('+termguicolors')
" GUIカラーを使う
  set termguicolors
endif

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

" CDコマンドでディレクトリ移動
command! -nargs=? -complete=dir -bang CD  call s:ChangeCurrentDir('<args>', '<bang>')
function! s:ChangeCurrentDir(directory, bang)
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang == ''
        pwd
    endif
endfunction

" Change current directory.
" nnoremap <silent> <Space>cd :<C-u>CD<CR>

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
" map <Space>x :call RangerExplorer()<CR>


" function RandomColorScheme()
"   let mycolors = split(globpath(&rtp,"**/colors/*.vim"),"\n") 
"   exe 'so ' . mycolors[localtime() % len(mycolors)]
" endfun

" ~/.local/.vimrcが存在すればそれを読み込む
if filereadable(expand($HOME.'/.local/.vimrc'))
  source $HOME/.local/.vimrc
endif

"}}}
" 過去の遺産{{{
"}}}
