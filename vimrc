" vim:set foldmethod=marker foldlevel=0:
set encoding=utf-8
scriptencoding utf-8
set shellslash

" 一般{{{
"以下のを入れると、プラグイン関連での補完関連でエラーが出ちゃう
"autocmd CompleteDone * pclose
filetype plugin indent on
syntax on

" バックスペースで字下げや行末を消去できるようにする。
set backspace=2

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
" if executable('/home/linuxbrew/.linuxbrew/bin/python3') > 0
"   let g:python3_host_prog='/home/linuxbrew/.linuxbrew/bin/python3'
" endif
if executable($HOME . '/anaconda3/bin/python') > 0
  let g:python3_host_prog=$HOME . '/anaconda3/bin/python'
endif

" }}}
" キーマッピング(一般){{{
inoremap <C-r> <C-r><C-p>
inoremap <C-l> <C-x><C-l>
inoremap <C-u> <C-g>u<C-u>
inoremap jj <ESC>
" inoremap jk <ESC>
" inoremap <C-k> <Esc>gg/aaa<CR>cgn
" inoremap <C-;> <Esc>cgn
" 以下のマッピングはうまく動かない
" inoremap <C-CR> <End><CR>
" inoremap <C-S-CR> <Up><End><CR>

nnoremap <C-l> :noh<CR><C-l>
nnoremap <M-d> <C-d>
nnoremap <M-u> <C-u>
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <C-k> :lvim <C-r><C-w> ##<CR>
nnoremap <Space>j <C-f>
nnoremap <Space>k <C-b>

" Emacsライクなマッピング
inoremap <C-a> <Home>
inoremap <C-e> <End>

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
nnoremap [window]1 1gt
nnoremap [window]2 2gt
nnoremap [window]3 3gt
nnoremap [window]4 4gt
nnoremap [window]5 5gt
nnoremap [window]6 6gt
nnoremap [window]7 7gt
nnoremap [window]8 8gt
nnoremap [window]9 9gt

nnoremap [tab] <Nop>
nmap t [tab]
nnoremap [tab]1 0gt
nnoremap [tab]2 1gt
nnoremap [tab]3 2gt
nnoremap [tab]4 3gt
nnoremap [tab]5 4gt
nnoremap [tab]6 5gt
nnoremap [tab]7 6gt
nnoremap [tab]8 7gt
nnoremap [tab]9 8gt
nnoremap [tab]n :tabm+<CR>
nnoremap [tab]p :tabm-<CR>
nnoremap [tab]o :tabonly<CR>
nnoremap [tab]q :tabclose<CR>

" nnoremap ]t vat<Esc>
" nnoremap [t vato<Esc>

nnoremap <F6> :make<CR>
" nnoremap <C-S-e> :Ex<CR>
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

" ターミナルモード
tnoremap <silent> jj <C-\><C-n>

" tmuxがないときはvimのターミナルで代用する
if !executable('tmux')
  " nnoremap [tmux] <Nop>
  " nmap <C-s> [tmux]
  " nmap <C-b> [tmux]
  " nmap t [tmux]

  " tnoremap [tmux]h <C-\><C-n><C-w>h
  " tnoremap [tmux]j <C-\><C-n><C-w>j
  " tnoremap [tmux]k <C-\><C-n><C-w>k
  " tnoremap [tmux]l <C-\><C-n><C-w>l
  " nnoremap [tmux]s <C-u>:split\|:terminal<CR>
  " nnoremap [tmux]v <C-u>:vsplit\|:terminal<CR>
endif

"}}}
" ファイル別設定{{{
augroup RunProgram
autocmd!
autocmd FileType python nnoremap <buffer> <F5> :w\|!python %<CR>
autocmd FileType ruby nnoremap <buffer> <F5> :w\|!ruby %<CR>
autocmd FileType perl nnoremap <buffer> <F5> :w\|!perl %<CR>
autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType json setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType go nnoremap <buffer> <F5> :w\|!go run %<CR>
autocmd FileType javascript nnoremap <buffer> <F5> :w\|!node %<CR>
autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType typescript setlocal ts=2 sts=2 sw=2 expandtab
"autocmd FileType typescript.tsx setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab iskeyword+=-
autocmd FileType nim setlocal ts=2 sts=2 sw=2 expandtab
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
" autocmd BufNewFile,BufRead *.tsx setlocal filetype=typescriptreact
"autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx
"autocmd BufNewFile,BufRead *.tsx,*.jsx setlocal ts=2 sts=2 sw=2 expandtab
autocmd BufRead,BufNewFile *.pu nnoremap <buffer> <F5> :w \| !plantuml %<CR>
autocmd BufRead,BufNewFile *.dot nnoremap <buffer> <F5> :w \| !dot % -O -Tpng<CR>
autocmd BufRead,BufNewFile *.adoc nnoremap <buffer> <F5> :w \| !asciidoctor -r asciidoctor-diagram %<CR>
autocmd BufRead,BufNewFile *.sh nnoremap <buffer> <F5> :w \| !%:p<CR>
autocmd BufRead,BufNewFile *.c nnoremap <buffer> <F5> :w \| !gcc % && ./a.out<CR>
autocmd BufRead,BufNewFile *.tcl nnoremap <buffer> <F5> :w \| !wish %<CR>
autocmd BufRead,BufNewFile *.scm nnoremap <buffer> <F5> :w \| !gosh %<CR>
autocmd BufRead,BufNewFile *.rs nnoremap <buffer> <F5> :w \| !rustc % \| !%:r<CR>
autocmd BufRead,BufNewFile *.nim nnoremap <buffer> <F5> :w \| !nim c -r %<CR>
autocmd BufRead,BufNewFile *.tsx setlocal ts=2 sts=2 sw=2 expandtab
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
  " NERDTreeでdeviconsを表示
  Plug 'ryanoasis/vim-devicons'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

  if executable('git') > 0
    Plug 'Xuyuanp/nerdtree-git-plugin'
  endif

  " fzfのインストールも同時にやりたい場合は以下のようにする
  " Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  " Plug 'junegunn/fzf.vim'
  " ファイルなどのあいまい検索
  if executable('fzf') > 0
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/fzf'
  else
    Plug 'ctrlpvim/ctrlp.vim'
    " Plug 'ompugao/ctrlp-history'
  endif
 
  " text object関連
  Plug 'kana/vim-textobj-user'
  Plug 'glts/vim-textobj-comment'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'mattn/vim-textobj-url'
  " Plug 'kana/vim-textobj-jabraces'

  Plug 'majutsushi/tagbar'

  " Plug 'itchyny/lightline.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  Plug 'tpope/vim-commentary'
  Plug 'flazz/vim-colorschemes'

  " Use release branch
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
 
  Plug 'mattn/emmet-vim'
 
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  Plug 'sjl/gundo.vim'

  if executable('ranger')
    Plug 'francoiscabrol/ranger.vim'
    Plug 'rbgrouleff/bclose.vim'
  endif

  Plug 'easymotion/vim-easymotion'
  Plug 'LeafCage/yankround.vim'

  Plug 'tpope/vim-surround'
  Plug 'h1mesuke/vim-alignta'

  " markdown-previewのほうがkatexやplantuml対応でいい感じ(node + yarnありが望ましい)
  if executable('node') > 0 && executable('yarn') > 0
    " If you have nodejs and yarn
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
  else
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
  endif

  Plug 'luochen1990/rainbow'
  Plug 'ap/vim-css-color'

  " snippets
  " Track the engine.
  " Plug 'SirVer/ultisnips'

  " Snippets are separated from the engine. Add this if you want them:
  " Plug 'honza/vim-snippets'

  " ターミナルデバッガ
  " Plug 'epheien/termdbg'

  " 様々な言語のパック。
  " Markdownのときに勝手に箇条書きの点などついて面倒なので一時保留
  " Plug 'sheerun/vim-polyglot'

  " typescript, jsxなど
  Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'

  " ヤンクした場所をわかりやすくする。
  Plug 'machakann/vim-highlightedyank'

  " Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-repeat'
  Plug 'mattn/disableitalic-vim'

  call plug#end()
catch
  echo 'vim-plug is not found'
  echo v:exception
  echo v:throwpoint
endtry

"}}}
" プラグイン設定{{{

" プラグイン存在確認関数{{{
let s:plug = {
      \ "plugs": get(g:, 'plugs', {})
      \ }

function! s:plug.is_installed(name)
  return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
endfunction

if s:plug.is_installed("vim-myplugin")
  " setting
endif
"}}}
" fzf{{{
if executable('fzf') > 0
  " fzf
  " <C-i>で全選択するように修正
  let $FZF_DEFAULT_OPTS = '--bind ctrl-o:select-all,ctrl-d:deselect-all'

  " プレビューをする
  " Filesコマンドにもプレビューを出す(参考 https://qiita.com/kompiro/items/a09c0b44e7c741724c80)
  if executable('bat')
    command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
    command! -bang -nargs=? -complete=dir GFiles
      \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)
    " ripgrepで検索中、?を押すとプレビュー:
    command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)
  endif

  nnoremap <Space>t :<C-u>BTags<CR>
  nnoremap <Space><S-t> :<C-u>Tags<CR>
  nnoremap <Space>p :<C-u>Files<CR>
  nnoremap <Space>g :<C-u>GFiles<CR>
  nnoremap <Space><S-g> :<C-u>Ggrep 
  " nnoremap <Space>r :<C-u>History<CR>
  " 履歴はソートせずにプレビューも表示
  if executable('bat')
    nnoremap <Space>r :<C-u>call fzf#vim#history(fzf#vim#with_preview({'options': '--no-sort'}))<CR>
  else
    nnoremap <Space>r :<C-u>call fzf#vim#history({'options': '--no-sort'})<CR>
  endif
  nnoremap <Space>b :<C-u>Buffers<CR>
  nnoremap <Space>l :<C-u>BLines<CR>
  nnoremap <Space><S-l> :<C-u>Lines<CR>
  nnoremap <Space>c :<C-u>BCommits<CR>
  nnoremap <Space>? :<C-u>Helptags<CR>
  nnoremap <Space><S-c> :<C-u>Commits<CR>
  nnoremap <Space>' :<C-u>Marks<CR>
  " nnoremap <Space>h :<C-u>History:<CR>
  " コマンド履歴をソートせずに表示
  nnoremap <Space>h :<C-u>call fzf#vim#command_history({'options': '--no-sort'})<CR>
  " nnoremap <Space>s :<C-u>History/<CR>
  " nnoremap <Space>s :<C-u>call fzf#vim#search_history({'options': '--no-sort'})<CR>
  " nnoremap <Space>/ :<C-u>History/<CR>
  nnoremap <Space>/ :<C-u>call fzf#vim#search_history({'options': '--no-sort'})<CR>
  nnoremap <Space>m :<C-u>Files ~/memo/<CR>
  " nnoremap <Space>: :<C-u>History:<CR>
  nnoremap <Space>: :<C-u>call fzf#vim#command_history({'options': '--no-sort'})<CR>
  nnoremap <Space>w :<C-u>Windows<CR>
  if executable('rg') > 0
    nnoremap <Space>a :<C-u>Rg<CR>
  else
    nnoremap <Space>a :<C-u>Ag<CR>
    " <C-i>で全選択するように修正
    " nnoremap <Space>a :<C-u>call fzf#vim#ag(<q-args>, '', { 'options': '--bind ctrl-i:select-all,ctrl-d:deselect-all' }, <bang>0)
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

  " バッファ削除用(参考 https://github.com/junegunn/fzf.vim/pull/733)
  function! Bufs()
    redir => list
    silent ls
    redir END
    return split(list, "\n")
  endfunction

  command! BD call fzf#run(fzf#wrap({
    \ 'source': Bufs(),
    \ 'sink*': { lines -> execute('bwipeout '.join(map(lines, {_, line -> split(line)[0]}))) },
    \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
  \ }))

  command! Inv call fzf#run(fzf#wrap({
        \ 'source': 'inv --list',
        \ 'sink': {x -> system('invoke ' . x)},
        \ }))

  imap <c-x><c-k> <plug>(fzf-complete-word)
  imap <c-x><c-p> <plug>(fzf-complete-path)
  " imap <c-x><c-f> <plug>(fzf-complete-path)
  " imap <c-f> <plug>(fzf-complete-path)
  imap <c-x><c-j> <plug>(fzf-complete-file-ag)
  imap <c-x><c-l> <plug>(fzf-complete-line)
  "}}}
else
  " CtrlP{{{
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
"}}}
" Tagbar{{{
let g:tagbar_autofocus = 1
nnoremap <F8> :TagbarToggle<CR>
nnoremap <Space>i :TagbarToggle<CR>
nnoremap <Space>o :TagbarToggle<CR>
"}}}
" NERDTree{{{
nnoremap <Space>e :<C-u>NERDTreeToggle<CR>
nnoremap <Space>E :<C-u>NERDTree<CR>
let NERDTreeQuitOnOpen=1
"}}}
" gdb {{{
" gdb使用の設定
" packadd termdebug

" gdb使用の設定
" let g:termdebug_wide = 163
" }}}
" Gundo{{{
nnoremap <F9> :<C-u>GundoToggle<CR>
nnoremap <Space>u :<C-u>GundoToggle<CR>
"}}}
" ranger{{{
if executable("ranger") > 0
    " nnoremap <Space>f :Ranger<CR>
endif
"}}}
" EasyMotion{{{
let g:EasyMotion_smartcase = 1
" <Leader>f{char} to move to {char}
" map  <Leader>f <Plug>(easymotion-bd-f)
" nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap <Space>s <Plug>(easymotion-overwin-f2)

" Move to line
" map <Leader>L <Plug>(easymotion-bd-jk)
" nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
" map  <Space>w <Plug>(easymotion-bd-w)
map  <Space>f <Plug>(easymotion-bd-w)
" map  <Space>w <Plug>(easymotion-bd-w)

" nmap <Leader>w <Plug>(easymotion-overwin-w)
" nmap <Leader>L <Plug>(easymotion-overwin-line)
"}}}
" Aligntaの設定{{{
if s:plug.is_installed("vim-alignta")
  vnoremap gs :Alignta \s\+<CR>
  vnoremap sc :Alignta \s\+<CR>
endif
"}}}
" yankroundの設定{{{
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
"}}}
" coc.nvimの設定{{{
" 以下にインストールするパッケージ一覧を設定
let g:coc_global_extensions = [
      \ "coc-python",
      \ "coc-tsserver",
      \ "coc-json",
      \ "coc-html",
      \ "coc-css",
      \ "coc-vimlsp",
      \ "coc-marketplace",
      \ "coc-highlight",
      \ "coc-rls",
      \ "coc-go",
      \]
      " \ "coc-snippets",


function! s:my_coc_nvim_config()
  " coc.nvimの設定
  setl updatetime=300
  setl shortmess+=c
  setl signcolumn=yes

  " Use <c-space> to trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()

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
  nmap <buffer> <silent> gh <Plug>(coc-diagnostic-info)

  " Symbol renaming.
  nmap <buffer> <F2> <Plug>(coc-rename)
  hi clear CocUnderLine 
endfunction

augroup coc_group
  autocmd!
  autocmd FileType python call s:my_coc_nvim_config()
  autocmd FileType c call s:my_coc_nvim_config()
  autocmd FileType cpp call s:my_coc_nvim_config()
  autocmd FileType javascript call s:my_coc_nvim_config()
  autocmd FileType json call s:my_coc_nvim_config()
  autocmd FileType go call s:my_coc_nvim_config()
  autocmd FileType html call s:my_coc_nvim_config()
  autocmd FileType css call s:my_coc_nvim_config()
  autocmd FileType vim call s:my_coc_nvim_config()
  autocmd FileType typescript call s:my_coc_nvim_config()
  autocmd FileType typescript.tsx call s:my_coc_nvim_config()
  autocmd FileType javascript.jsx call s:my_coc_nvim_config()

  " 折りたたみが勝手に発動してしまうため、一時無効化
  " Use auocmd to force lightline update.
  " autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

  " ハイライトは別にいらないので削除
  " Highlight symbol under cursor on CursorHold
  " autocmd CursorHold * silent call CocActionAsync('highlight')
augroup end

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" inoremap <silent><expr> <c-f>
"       \ pumvisible() ? coc#_select_confirm() :
"       \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"       \ <SID>check_back_space() ? "\<c-f>" :
"       \ coc#refresh()

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" let g:coc_snippet_next = '<c-f>'
 
"}}}
" airline{{{

" 参考 https://www.reddit.com/r/vim/comments/crs61u/best_airline_settings/

let g:airline_theme='papercolor'                                                                                                             
let g:airline_powerline_fonts = 1                                                                                                         
let g:airline_section_b = '%{getcwd()}' " in section B of the status line display the CWD                                                 
                                                                                                                                          
"TABLINE:                                                                                                                                 
                                                                                                                                          
let g:airline#extensions#tabline#enabled = 1           " enable airline tabline                                                           
let g:airline#extensions#tabline#show_close_button = 0 " remove 'X' at the end of the tabline                                            
let g:airline#extensions#tabline#tabs_label = ''       " can put text here like BUFFERS to denote buffers (I clear it so nothing is shown)
let g:airline#extensions#tabline#buffers_label = ''    " can put text here like TABS to denote tabs (I clear it so nothing is shown)      
let g:airline#extensions#tabline#fnamemod = ':t'       " disable file paths in the tab                                                    
let g:airline#extensions#tabline#show_tab_count = 0    " dont show tab numbers on the right                                                           
let g:airline#extensions#tabline#show_buffers = 0      " dont show buffers in the tabline                                                 
let g:airline#extensions#tabline#tab_min_count = 2     " minimum of 2 tabs needed to display the tabline                                  
let g:airline#extensions#tabline#show_splits = 0       " disables the buffer name that displays on the right of the tabline               
let g:airline#extensions#tabline#show_tab_nr = 0       " disable tab numbers                                                              
let g:airline#extensions#tabline#show_tab_type = 0     " disables the weird ornage arrow on the tabline

"}}}
" lightline{{{
function! GetCWD30()
  return getcwd()[-30:]
endfunction

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'workspace', 'cocstatus'] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'workspace': 'GetCWD30',
      \   'cocstatus': 'coc#status'
      \ },
      \ }
"}}}
" luochen1990/rainbow{{{
"set to 0 if you want to enable it later via :RainbowToggle
let g:rainbow_active = 1
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
\   'nerdtree': 0,
\	}
\}

" }}}
" emmet{{{
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
" \    'block_all_childless' : 1,
"}}}
" markdown-preview{{{
" バッファ移動時に勝手に閉じないようにする
let g:mkdp_auto_close = 0
"}}}
" highlightedyank
let g:highlightedyank_highlight_duration = 150
"}}}
" 表示{{{

try
  " gvimの場合はgvimrcなどの方でカラースキームを設定する
  if !has("gui_running")
    " colorscheme molokai
    " colorscheme Monokai
    " colorscheme ayu
    " colorscheme gruvbox
    " colorscheme nord
    " colorscheme nordisk
    " colorscheme vim-material
    colorscheme tender
  endif
catch
endtry
try
  if has("gui_running")
    set guioptions-=m
    set guioptions-=T
    set guifont=Monospace\ 14
  endif
catch
endtry

" 対応カッコの色設定を変更(そのままだとわかりづらいときあった)
" 参考: https://stackoverflow.com/questions/10746750/set-vim-bracket-highlighting-colors
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta

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

" cdn貼り付け用コマンド
function! s:cdn_tag(name, version, filename)
  " htmlのタグを作成する
  let l:uri = "https://cdnjs.cloudflare.com/ajax/libs/" . a:name . "/" . a:version . "/" . a:filename
  if match(a:filename, 'js$') != -1
    return '<script src="' . l:uri  . '" crossorigin="anonymous"></script>'
  elseif match(a:filename, 'css$') != -1
    return '<link rel="stylesheet" href="' . l:uri . '" crossorigin="anonymous" />'
  else
    return l:pathname
  fi
endfunction

function! s:cdn_get_version(name)
  let l:opts = {
    \ 'source': 'curl -s "https://api.cdnjs.com/libraries/' . a:name . '"|jq --raw-output ''.assets[].version'' ',
    \ 'sink': {x -> s:cdn_get_path(a:name, x)}
    \ }
  call fzf#run(fzf#wrap(l:opts))
endfunction

function! s:cdn_get_path(name, version)
  let l:opts = {
    \ 'source': 'curl -s "https://api.cdnjs.com/libraries/' . a:name . '"|jq --raw-output ''.assets[]|select(.version == "' . a:version . '")|.files[]'' ',
    \ 'sink': {x -> append('.', s:cdn_tag(a:name, a:version, x))}
    \ }
  call fzf#run(fzf#wrap(l:opts))
endfunction

function! s:cdn(libname)
  " ライブラリ名を取得
  let l:opts = {
    \ 'source': 'curl -s "https://api.cdnjs.com/libraries?search=' . a:libname . '"|jq --raw-output ''.results[].name'' ',
    \ 'sink': {x -> s:cdn_get_version(x)}
    \ }
  call fzf#run(fzf#wrap(l:opts))
endfunction

command! -nargs=1 Cdn call s:cdn(<f-args>)
"}}}
" 過去の遺産{{{
"}}}
