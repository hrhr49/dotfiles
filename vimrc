" vim:set foldmethod=marker foldlevel=0:
set encoding=utf-8
scriptencoding utf-8
set shellslash

" 一般{{{
filetype plugin indent on
syntax on
" 文字{{{
" バックスペースで字下げや行末を消去できるようにする。
set backspace=2
set shiftwidth=4
set smartindent
set smarttab
set tabstop=4
set autoindent
set expandtab
" 矩形選択のときに文字がない箇所も選択できるようにする
set virtualedit=block
"}}}
" 折りたたみ{{{
set foldmethod=marker
" show foldings
"set foldcolumn=1
"}}}
" 入力補完{{{
" remove tag comeletion from default
set complete-=t
"set completeopt+=longest
"}}}
" クリップボード{{{
set clipboard&
" プラットフォームによってクリップボード設定切り替え
if has('unix') || has('mac')
set clipboard^=unnamedplus
elseif has('win32') || has('win64')
set clipboard^=unnamed
endif
"}}}
" 検索{{{
set nohlsearch
set ignorecase
" 入力の小文字、大文字に合わせて補完
" set infercase
set smartcase
set incsearch
set wrapscan
" 補完最中だけ大文字小文字区別
augroup ComplNotIgnore
autocmd!
au InsertEnter * set noignorecase
au InsertLeave * set ignorecase
augroup END
" }}}
" バックアップ{{{
set nobackup
set nowritebackup
set noswapfile
set noundofile
"}}}
" 行番号{{{
set number
set relativenumber
"}}}
" ワイルドメニュー{{{
set wildignorecase
set wildmenu
"}}}
" バッファ{{{
" バッファ保存せずに移動できるようにする
set hidden
"}}}
" 環境{{{
if executable($HOME . '/anaconda3/bin/python') > 0
  let g:python3_host_prog=$HOME . '/anaconda3/bin/python'
endif
set path+=~/memo/**
set tags+=tags;
"}}}
" マウス・キー入力{{{
set mouse=a
" キーマッピングなどのタイムアウト時間
set timeoutlen=9999999
"}}}
" }}}
" キーマッピング(一般){{{
inoremap jj <ESC>
inoremap <C-r> <C-r><C-p>
inoremap <C-l> <C-x><C-l>
" <C-u>のタイミングでUndoのセーブポイント
inoremap <C-u> <C-g>u<C-u>
" vimrcをリロード
" nnoremap <S-C-r> :<C-u>source ~/.vimrc<CR>
" inoremap jk <ESC>
" inoremap <C-k> <Esc>gg/aaa<CR>cgn
" inoremap <C-;> <Esc>cgn
" 以下のマッピングはうまく動かない
" inoremap <C-CR> <End><CR>
" inoremap <C-S-CR> <Up><End><CR>

nnoremap cd :<C-u>CD<CR>
nnoremap <C-l> :noh<CR><C-l>
nnoremap <M-d> <C-d>
nnoremap <M-u> <C-u>
" 選択中のテキストを*で検索
" vnoremap * "zy:let @/ = @z<CR>n
vnoremap * "zy:let @/ = '\V' . @z<CR>n
nnoremap n nzzzv
nnoremap N Nzzzv
" ペーストしたテキストをビジュアルモードで選択
" nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
" nnoremap <C-k> :lvim <C-r><C-w> ##<CR>
" nnoremap <Space>j <C-f>
" nnoremap <Space>k <C-b>
nnoremap <Space>z za
nnoremap <F6> :make<CR>
" nnoremap <C-S-e> :Ex<CR>
" 外部コマンドとの連携{{{
vnoremap ge :s/[^\x01-\x7E]/&薔/ge<CR> \| gv:!graph-easy<CR> \| :'[,']s/薔//ge<CR>
vnoremap gp :s/[^\x01-\x7E]/&薔/ge<CR> \| gv:!plantuml -txt -p<CR> \| :'[,']s/薔//ge<CR>
" 保存時にsudo権限で無理やり保存
cnoremap w!! w !sudo tee > /dev/null %<CR> :e!<CR>
" Emacsライクなマッピング{{{
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
"}}}
" ウィンドウなど{{{
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
nnoremap [window]o <C-w>o
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

nmap [window]p :<C-u>tabprevious<CR>[tab]
nmap [window]n :<C-u>tabnext<CR>[tab]

" +, -, <, >でウィンドウリサイズ。連続入力可能
nnoremap [resize] <Nop>
nmap [window]+ :<C-u>wincmd +<CR>[resize]
nmap [window]- :<C-u>wincmd -<CR>[resize]
nmap [window]< :<C-u>wincmd <<CR>[resize]
nmap [window]> :<C-u>wincmd ><CR>[resize]
nmap [resize]+ :<C-u>wincmd +<CR>[resize]
nmap [resize]- :<C-u>wincmd -<CR>[resize]
nmap [resize]< :<C-u>wincmd <<CR>[resize]
nmap [resize]> :<C-u>wincmd ><CR>[resize]

function! ScrollFunc(distance)
  let num = abs(a:distance)
  let key = a:distance > 0 ? "\<C-e>" : "\<C-y>"
  exec "normal ". num . key
endfunction

nnoremap [scroll] <Nop>
" 直接<C-d>や<C-f>などでスクロールしようとすると
" スクロールできなかったときに[scroll]の部分が実行されない？
" そのためスクロール用の関数を呼ぶ
nmap [window]d :<C-u>call ScrollFunc(&scroll)<CR>[scroll]
nmap [window]u :<C-u>call ScrollFunc(-&scroll)<CR>[scroll]
nmap [window]f :<C-u>call ScrollFunc(winheight(0))<CR>[scroll]
nmap [window]b :<C-u>call ScrollFunc(-winheight(0))<CR>[scroll]
nmap [window]e <C-e>[scroll]
nmap [window]y <C-y>[scroll]

nmap [scroll]d :<C-u>call ScrollFunc(&scroll)<CR>[scroll]
nmap [scroll]u :<C-u>call ScrollFunc(-&scroll)<CR>[scroll]
nmap [scroll]f :<C-u>call ScrollFunc(winheight(0))<CR>[scroll]
nmap [scroll]b :<C-u>call ScrollFunc(-winheight(0))<CR>[scroll]
nmap [scroll]e <C-e>[scroll]
nmap [scroll]y <C-y>[scroll]

nnoremap [tab] <Nop>
nmap t [tab]
nnoremap [tab]0 :<C-u>tabfirst<CR>
nnoremap [tab]$ :<C-u>tablast<CR>
nnoremap [tab]1 1gt
nnoremap [tab]2 2gt
nnoremap [tab]3 3gt
nnoremap [tab]4 4gt
nnoremap [tab]5 5gt
nnoremap [tab]6 6gt
nnoremap [tab]7 7gt
nnoremap [tab]8 8gt
nnoremap [tab]9 9gt
nnoremap [tab]o :<C-u>tabonly<CR>
nnoremap [tab]q :<C-u>tabclose<CR>

" n, p, <, >でタブ移動、もしくはタブ自体を移動。連続入力可能
nmap [tab]> :<C-u>tabm+<CR>[tab]
nmap [tab]< :<C-u>tabm-<CR>[tab]
nmap [tab]n :<C-u>tabnext<CR>[tab]
nmap [tab]p :<C-u>tabprevious<CR>[tab]
"}}}
" マウス{{{
map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>
map <2-MiddleMouse> <Nop>
imap <2-MiddleMouse> <Nop>
map <3-MiddleMouse> <Nop>
imap <3-MiddleMouse> <Nop>
map <4-MiddleMouse> <Nop>
imap <4-MiddleMouse> <Nop>
"}}}
"}}}
" ターミナルモード{{{
tnoremap <silent> jj <C-\><C-n>
" cmd.exeの設定{{{
if has('win32') || has('win64')
  tnoremap <C-p> <Up>
  tnoremap <C-n> <Down>
  tnoremap <C-m> <CR>
  tnoremap <C-a> <Home>
  tnoremap <C-e> <End>
  tnoremap <C-h> <BS>
  tnoremap <C-u> <BS><BS><BS><BS><BS><BS><BS><BS><BS><BS><BS><BS><BS><BS><BS><BS>
  tnoremap <C-l> cls<CR>
endif
"}}}
"}}}
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
autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab iskeyword+=-
autocmd FileType scss setlocal ts=2 sts=2 sw=2 expandtab iskeyword+=-
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
augroup END
"}}}
" プラグイン一覧{{{
try
  " Specify a directory for plugins
  " - For Neovim: ~/.local/share/nvim/plugged
  " - Avoid using standard Vim directory names like 'plugin'
  call plug#begin('~/.vim/plugged')
  " Make sure you use single quotes
  " ヘルプ{{{
  " 日本語のヘルプ
  Plug 'vim-jp/vimdoc-ja'
  "}}}
  " ブラウジング{{{
  " NERDTree{{{
  Plug 'scrooloose/nerdtree'
  " NERDTreeでdeviconsを表示
  Plug 'ryanoasis/vim-devicons'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

  if executable('git') > 0
    Plug 'Xuyuanp/nerdtree-git-plugin'
  endif
  "}}}
  " Ranger{{{
  if executable('ranger')
    Plug 'francoiscabrol/ranger.vim'
    Plug 'rbgrouleff/bclose.vim'
  endif
  "}}}
  Plug 'majutsushi/tagbar'
  "}}}
  " あいまい検索{{{
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
 "}}}
  " テキスト操作{{{
  Plug 'kana/vim-textobj-user'
  Plug 'glts/vim-textobj-comment'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'mattn/vim-textobj-url'
  " Plug 'kana/vim-textobj-jabraces'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'h1mesuke/vim-alignta'
  " Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-repeat'
  "}}}
  " 表示{{{
  Plug 'flazz/vim-colorschemes'
  Plug 'luochen1990/rainbow'
  Plug 'ap/vim-css-color'
  Plug 'mechatroner/rainbow_csv'
  " ヤンクした場所をわかりやすくする。
  Plug 'machakann/vim-highlightedyank'
  " イタリックフォントを無効化
  Plug 'mattn/disableitalic-vim'

  " Plug 'itchyny/lightline.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'junegunn/goyo.vim'
  "}}}
  " 入力補完・補助{{{
  " Use release branch
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'mattn/emmet-vim'
  Plug 'LeafCage/yankround.vim'
  " snippets
  " Track the engine.
  " Plug 'SirVer/ultisnips'

  " Snippets are separated from the engine. Add this if you want them:
  " Plug 'honza/vim-snippets'
  " Plug 'lifepillar/vim-mucomplete'
  "}}}
  " バージョン管理・変更履歴{{{
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  Plug 'sjl/gundo.vim'
  " }}}
  " 移動{{{
  Plug 'easymotion/vim-easymotion'
  "}}}
  " 言語{{{
  " markdown-previewのほうがkatexやplantuml対応でいい感じ(node + yarnありが望ましい)
  if executable('node') > 0 && executable('yarn') > 0
    " If you have nodejs and yarn
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
  else
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
  endif

  " 様々な言語のパック。
  " Markdownのときに勝手に箇条書きの点などついて面倒なので一時保留
  " Plug 'sheerun/vim-polyglot'

  " typescript, jsxなど
  Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'

  " pugとstylusについては一時見送り
  " Plug 'digitaltoad/vim-pug'
  " Plug 'dNitro/vim-pug-complete', {'for': ['jade', 'pug']}
  " Plug 'iloginow/vim-stylus'
  " vim-markdownの依存
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown'
  "}}}
  " デバッグ{{{
  " ターミナルデバッガ
  " Plug 'epheien/termdbg'
  " Plug 'vim-vdebug/vdebug'
  "}}}
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
  " fugitive{{{
  nnoremap gcd :<C-u>Gcd<CR>
  "}}}
  " あいまい検索{{{
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
" nnoremap <F9> :<C-u>GundoToggle<CR>
" nnoremap <Space>u :<C-u>GundoToggle<CR>
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
      \ "coc-emoji",
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
  autocmd FileType scss call s:my_coc_nvim_config()
  autocmd FileType less call s:my_coc_nvim_config()
  autocmd FileType vim call s:my_coc_nvim_config()
  autocmd FileType pug call s:my_coc_nvim_config()
  autocmd FileType stylus call s:my_coc_nvim_config()
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

" Theme参考 https://github.com/vim-airline/vim-airline/wiki/Screenshots

" letg:airline_theme='papercolor' 色が変わらないのでわかりづらいので保留
" let g:airline_theme='light' 色が変わりすぎて煩わしいので保留
let g:airline_theme='bubblegum'

let g:airline#extensions#whitespace#enabled = 0
" 参考 https://www.reddit.com/r/vim/comments/crs61u/best_airline_settings/
let g:airline_powerline_fonts = 1                                                                                                         
let g:airline_section_c = '%-0.30{getcwd()}' " in section C of the status line display the CWD                                                 
                                                                                                                                          
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

let g:airline#extensions#branch#enabled = 1

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
" highlightedyank{{{
let g:highlightedyank_highlight_duration = 150
"}}}
" mucomplete{{{
if s:plug.is_installed("lifepillar/vim-mucomplete")
  let g:mucomplete#enable_auto_at_startup = 1
  set completeopt+=menuone
  set completeopt+=noselect
  set completeopt+=noinsert
  set shortmess+=c
  set belloff+=ctrlg
endif
"}}}
" vim-markdown{{{
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:tex_conceal = ""
let g:vim_markdown_math = 1
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_no_default_key_mappings = 1
"}}}
" 組み込み{{{
" let loaded_matchparen = 1
let g:netrw_keepdir = 0
"let g:markdown_folding=1
"}}}
"}}}
" 表示{{{
" カラースキーム{{{
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
"}}}
" オプション{{{
" 対応カッコの色設定を変更(そのままだとわかりづらいときあった)
" 参考: https://stackoverflow.com/questions/10746750/set-vim-bracket-highlighting-colors
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta

" hilight current line number
set cursorline
" hi clear CursorLine

set conceallevel=0
" 80列目の色を変える
" set colorcolumn=80

" 200桁以上の行はシンタックスハイライトしない
set synmaxcol=250
"set cursorline
set laststatus=2
" 入力した内容を表示
set showcmd
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
" 折りたたみ表示 {{{
set foldtext=MyFoldText()
" 折りたたみの空きスペースは半角スペース「 」で埋める
set fillchars=fold:\ 
function! MyFoldText()
  let line = substitute(getline(v:foldstart), '^\s*', '', '')
  let comment_pat = '\V' . substitute(&commentstring, '%s', '\\(\\.\\*\\)', 'g')
  let line = substitute(line, comment_pat, '\1', 'g')
  let marker = get(split(&foldmarker, ','), 0, '')

  " remove fold marker
  let line = substitute(line, marker, '', 'g')
  let line = substitute(line, '^', repeat('  ', v:foldlevel - 1) . '▸ ', 'g')
  " 折りたたみ行数
  let tail = '[' . (v:foldend - v:foldstart + 1) . ']'

  " ウィンドウ幅 
  " 参考 https://github.com/Konfekt/FoldText/blob/master/plugin/FoldText.vim
  let w = winwidth(0) - &foldcolumn - (&number ? &numberwidth : 0) - (&l:signcolumn is# 'yes' ? 2 : 0)

  " 折りたたみ行数を右揃えにするためのパディング
  let pad_width = w - (strwidth(line) + strwidth(tail)) - 2

  if pad_width > 0
      let line = line . repeat(' ', pad_width) . tail
  endif
  return line
endfunction
" }}}
" }}}
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
  endif
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
" GUI {{{
if has('gui_running')
  " アンチエイリアス{{{
  if has('win32') || has('win64')
    if has('+renderoptions')
      set renderoptions=type:directx
    endif
  endif
  set antialias
  "}}}
  " フォント{{{
  " 参考 vim(gvim) フォントサイズ https://miwaokina.com/blog/wordpress/?p=2925
  nnoremap + :let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)+1', '')<CR>
  nnoremap - :let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)-1', '')<CR>

  " イタリックフォントを無効化
  augroup DisableItalicGroup
  autocmd!
  autocmd BufRead,BufNewFile,ColorScheme * DisableItalic
  augroup END
"}}}
  " term設定{{{
  nnoremap [term] <Nop>
  tnoremap [term] <Nop>
  nmap <C-s> [term]
  nmap <C-b> [term]
  " 一旦tnoremapしておく
  tnoremap [term-esc] <C-\><C-n>
  tmap <C-s> [term]
  tmap <C-b> [term]

  imap <C-s> <Esc>[term]
  imap <C-b> <Esc>[term]

  if has('nvim')
    nnoremap [term]s <C-u>:split\|:terminal<CR>
    nnoremap [term]v <C-u>:vsplit\|:terminal<CR>
  else
    nnoremap [term]c :<C-u>tab terminal ++close<CR>
    nnoremap [term]v :<C-u>vert terminal ++close<CR>
    nnoremap [term]s :<C-u>terminal ++close<CR>
  endif

  nnoremap [term]h <C-w>h
  nnoremap [term]j <C-w>j
  nnoremap [term]k <C-w>k
  nnoremap [term]l <C-w>l
  nnoremap [term]p :<C-u>tabprevious<CR>
  nnoremap [term]n :<C-u>tabnext<CR>
  nnoremap [term]! <C-w>T
  nnoremap [term]T <C-w>T
  nnoremap [term]H <C-w>H
  nnoremap [term]J <C-w>J
  nnoremap [term]K <C-w>K
  nnoremap [term]L <C-w>L

  tnoremap [term]h <C-w>h
  tnoremap [term]j <C-w>j
  tnoremap [term]k <C-w>k
  tnoremap [tmux]l <C-w>l
  tnoremap [tmux]p [term-esc][tmux]p
  tnoremap [tmux]n [term-esc][tmux]n
  tnoremap [tmux]! [term-esc][tmux]T
  tnoremap [tmux]T [term-esc][tmux]T
  tnoremap [tmux]H <C-w>H
  tnoremap [tmux]J <C-w>J
  tnoremap [tmux]K <C-w>K
  tnoremap [tmux]L <C-w>L
  "}}}
  " メニューバーなどの設定{{{
  try
    if has("gui_running")
      set guioptions-=m
      set guioptions-=T
      set guifont=Monospace\ 14
    endif
  catch
  endtry
  "}}}
endif
"}}}
