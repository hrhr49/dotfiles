" vim:set foldmethod=marker foldlevel=0:
set encoding=utf-8
scriptencoding utf-8
" set shellslash "vim-plug使うときは指定しないほうがいい？
if exists("g:loaded_my_vimrc")
  finish
endif
let g:loaded_my_vimrc = 1

" 一般{{{
filetype plugin indent on
syntax on
set backspace=2 " バックスペースで字下げや行末を消去できるようにする。
set whichwrap=b,s,h,l,<,>,[,] " 行頭、行末で行をまたぐ
set shiftwidth=4
set smartindent
set smarttab
set tabstop=4
set autoindent
set expandtab
set virtualedit=block " 矩形選択のときに文字がない箇所も選択できるようにする
set formatoptions-=cro " コメントで自動整形されるのを回避
set matchpairs+=「:」,（:）,【:】,『:』,〈:〉,《:》 " 全角カッコの設定
set foldmethod=marker
set complete-=i " インクルードファイルを入力補完候補に入れない
set complete-=t " タグを入力補完候補に入れない
set clipboard&
silent! set clipboard=exclude:.*
" プラットフォームによってクリップボード設定切り替え
if has('unix') || has('mac')
  set clipboard^=unnamedplus
elseif has('win32') || has('win64')
  set clipboard^=unnamed
endif
set nohlsearch
set ignorecase
set smartcase
set incsearch
set wrapscan
" 補完最中だけ大文字小文字区別
augroup ComplNotIgnore
  autocmd!
  au InsertEnter * set noignorecase
  au InsertLeave * set ignorecase
augroup END
set nobackup
set nowritebackup
set noswapfile
set noundofile
set history=10000 " コマンド履歴の数
if has('win32') || has('win64')
  set viminfo='999,<50,s10,h,rA:,rB:
else
  set viminfo=!,'999,<50,s10,h
endif
set number            " 行番号表示
set relativenumber    " 相対行番号を表示(現在の行以外)
set scrolloff=5       " カーソルの上または下に表示される最小行数
set ruler             " カーソルの位置を表示
set wildignorecase
set wildmenu
set wildmode=longest:full,full " 初回の補完では共通部分まで、2回目は次の候補を全部補完
set wildignore=*.o,*.obj,*.out " wild mode補完でいらないファイルパターン
set hidden            " バッファ保存せずに移動できるようにする
set autoread          " ファイルの変更を監視する
set diffopt+=vertical " diffは縦分割にする
set tabpagemax=50     " 使用可能なタブページの個数
set path+=~/memo/**
set tags+=tags;
set tags+=mytags       " 自分用タグファイルを追加
set mouse=a
set timeoutlen=9999999 " キーマッピングなどのタイムアウト時間
set belloff=all        " ビープ音を無効化
silent! set ttyfast
" }}}
" キーマッピング(一般){{{
" 全般{{{
" インサートモード{{{
inoremap jj <ESC>
inoremap jf <ESC>
inoremap fj <ESC>
inoremap <C-r> <C-r><C-p>
inoremap <C-l> <C-x><C-l>
" <C-u>のタイミングでUndoのセーブポイント
inoremap <C-u> <C-g>u<C-u>
"}}}
" コマンドモード {{{
" <down>, <up>の場合、途中まで入力文字列にマッチした履歴だけを辿れる
cnoremap <C-n> <down>
cnoremap <C-p> <up>
" }}}
" ビジュアルモード{{{
" 選択中のテキストを*で検索
vnoremap * "zy:let @/ = '\V' . @z<CR>n
" 選択範囲に直前の操作を適用
vnoremap . :normal .<CR>

" F4キーで矩形選択領域にボックスのアスキーアートを作る
" (現状、左上から右下に選択したときしかうまく動かない)
" +-----------+
" |           |
" |           |
" +-----------+
vnoremap <F4> r+gvkojr\|gvlkohjr-gvkojr<Space>
"}}}
" vimrcをリロード
command! ReloadVimrc :unlet g:loaded_my_vimrc | :source $MYVIMRC
nnoremap <M-r> :<C-u>ReloadVimrc<CR>
nnoremap <M-w> :w<CR>

" cdで現在のファイルの場所へ移動
nnoremap cd :<C-u>lcd %:p:h \| pwd<CR>
nnoremap <C-l> :noh<CR><C-l>
nnoremap <M-d> <C-d>
nnoremap <M-u> <C-u>
nnoremap <M-Left> <C-o>
nnoremap <M-Right> <C-]>
nnoremap n nzzzv
nnoremap N Nzzzv
" ペーストしたテキストをビジュアルモードで選択
" nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
" nnoremap <C-k> :lvim <C-r><C-w> ##<CR>
nnoremap <Space>z za
" nnoremap <F6> :make<CR>
" vimspectorのデバッガ開始
nnoremap <F6> :<C-u>call LaunchFileDebug()<CR>
" nnoremap <C-S-e> :Ex<CR>
" 角括弧によるマッピング{{{
nnoremap ]q :<C-u>cnext<CR>
nnoremap [q :<C-u>cprevious<CR>
nnoremap ]l :<C-u>lnext<CR>
nnoremap [l :<C-u>lprevious<CR>
nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>
nnoremap ]t <C-]>
nnoremap [t <C-t>
nnoremap [o <C-i>
" }}}
" ,からはじまるマッピング{{{
nnoremap ,q :cw<CR>
nnoremap ,l :lw<CR>
nnoremap ,u :UndotreeShow<CR>
"}}}
"}}}
" 外部コマンドとの連携{{{
" Graph::Easy
vnoremap ge :s/[^\x01-\x7E]/&薔/ge<CR> \| gv:!graph-easy<CR> \| :'[,']s/薔//ge<CR>
vnoremap gE :s/[^\x01-\x7E]/&薔/ge<CR> \| gv:!graph-easy --boxart<CR> \| :'[,']s/薔//ge<CR>
" Plantuml
vnoremap gp :s/[^\x01-\x7E]/&薔/ge<CR> \| gv:!plantuml -txt -p<CR> \| :'[,']s/薔//ge<CR>
" yq(pipパッケージ) yamlからjsonへの変換
vnoremap gy :!yq .<CR>
" 保存時にsudo権限で無理やり保存
cnoremap w!! w !sudo tee > /dev/null %<CR> :e!<CR>
"}}}
" Emacsライクなマッピング{{{
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
"}}}
" ウィンドウ・タブなど{{{
" ウィンドウ{{{
nnoremap !+window+! <Nop>
nmap s !+window+!

for s:s in split('HJKLThjkloqsv', '\zs')
  execute 'nnoremap <silent> !+window+!' . s:s . ' :<C-u>wincmd ' . s:s . '<CR>'
endfor

nnoremap <silent> !+window+!^ <C-^>
nnoremap <silent> !+window+!S :<C-u>new<CR>
nnoremap <silent> !+window+!t :<C-u>tabnew<CR>
nnoremap <silent> !+window+!V :<C-u>vnew<CR>

nmap <silent> !+window+!p :<C-u>tabprevious<CR>!+tab+!
nmap <silent> !+window+!P :<C-u>tabfirst<CR>!+tab+!
nmap <silent> !+window+!n :<C-u>tabnext<CR>!+tab+!
nmap <silent> !+window+!N :<C-u>tablast<CR>!+tab+!
"}}}
" リサイズ{{{
" +, -, <, >でウィンドウリサイズ。連続入力可能
nnoremap !+resize+! <Nop>
for s:s in split('+-<>', '\zs')
  execute 'nmap <silent> !+window+!' . s:s . ' :<C-u>wincmd ' . s:s . '<CR>!+resize+!'
  execute 'nmap <silent> !+resize+!' . s:s . ' :<C-u>wincmd ' . s:s . '<CR>!+resize+!'
endfor

"}}}
" スクロール{{{
function! ScrollFunc(distance)
  let num = abs(a:distance)
  let key = a:distance > 0 ? "\<C-e>" : "\<C-y>"
  exec "normal ". num . key
endfunction

nnoremap !+scroll+! <Nop>
" 直接<C-d>や<C-f>などでスクロールしようとすると
" スクロールできなかったときに!+scroll+!の部分が実行されない？
" そのためスクロール用の関数を呼ぶ
nmap <silent> !+window+!d :<C-u>call ScrollFunc(&scroll)<CR>!+scroll+!
nmap <silent> !+window+!u :<C-u>call ScrollFunc(-&scroll)<CR>!+scroll+!
nmap <silent> !+window+!f :<C-u>call ScrollFunc(winheight(0))<CR>!+scroll+!
nmap <silent> !+window+!b :<C-u>call ScrollFunc(-winheight(0))<CR>!+scroll+!
nmap <silent> !+window+!e <C-e>!+scroll+!
nmap <silent> !+window+!y <C-y>!+scroll+!

nmap !+window+!r !+scroll+!
nmap <silent> !+scroll+!d :<C-u>call ScrollFunc(&scroll)<CR>!+scroll+!
nmap <silent> !+scroll+!u :<C-u>call ScrollFunc(-&scroll)<CR>!+scroll+!
nmap <silent> !+scroll+!f :<C-u>call ScrollFunc(winheight(0))<CR>!+scroll+!
nmap <silent> !+scroll+!b :<C-u>call ScrollFunc(-winheight(0))<CR>!+scroll+!
nmap <silent> !+scroll+!e <C-e>!+scroll+!
nmap <silent> !+scroll+!y <C-y>!+scroll+!
nmap <silent> !+scroll+!j :<C-u>call ScrollFunc(4)<CR>!+scroll+!
nmap <silent> !+scroll+!k :<C-u>call ScrollFunc(-4)<CR>!+scroll+!
"}}}
" タブ{{{
nnoremap !+tab+! <Nop>
nmap t !+tab+!
for s:s in split('123456789', '\zs')
  execute 'nnoremap <silent> !+tab+!' . s:s . ' :<C-u>tabnext ' . s:s . '<CR>'
endfor
nnoremap <silent> !+tab+!o :<C-u>tabonly<CR>
nnoremap <silent> !+tab+!q :<C-u>tabclose<CR>

" n, p, <, >でタブ移動、もしくはタブ自体を移動。連続入力可能
nmap <silent> !+tab+!> :<C-u>tabm+<CR>[tab]
nmap <silent> !+tab+!< :<C-u>tabm-<CR>[tab]
nmap <silent> !+tab+!p :<C-u>tabprevious<CR>[tab]
nmap <silent> !+tab+!P :<C-u>tabfirst<CR>[tab]
nmap <silent> !+tab+!n :<C-u>tabnext<CR>[tab]
nmap <silent> !+tab+!N :<C-u>tablast<CR>[tab]
"}}}
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
" ターミナルモード{{{
tnoremap <silent> jj <C-\><C-n>
tnoremap <silent> <C-S-v> <C-w>""
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
augroup FileTypeGroup
  autocmd!

  " tabstop, softtabstop, shiftwidth, expandtab, iskeywordの設定
  autocmd FileType ruby            setl ts=2 sts=2 sw=2 et
  autocmd FileType json            setl ts=2 sts=2 sw=2 et
  autocmd FileType javascript      setl ts=2 sts=2 sw=2 et
  autocmd FileType typescript      setl ts=2 sts=2 sw=2 et
  autocmd Filetype typescriptreact setl ts=2 sts=2 sw=2 et
  autocmd FileType typescript.tsx  setl ts=2 sts=2 sw=2 et
  autocmd FileType yaml            setl ts=2 sts=2 sw=2 et   isk+=-
  autocmd FileType html            setl ts=2 sts=2 sw=2 et   isk+=-
  autocmd FileType css             setl ts=2 sts=2 sw=2 et   isk+=-
  autocmd FileType scss            setl ts=2 sts=2 sw=2 et   isk+=-
  autocmd FileType less            setl ts=2 sts=2 sw=2 et   isk+=-
  autocmd FileType nim             setl ts=2 sts=2 sw=2 et
  autocmd FileType vim             setl ts=2 sts=2 sw=2 et
  autocmd FileType make            setl ts=4 sts=0 sw=4 noet
  autocmd FileType sh              setl ts=2 sts=2 sw=2 et   isk+=-
  autocmd FileType bash            setl ts=2 sts=2 sw=2 et   isk+=-
  autocmd FileType zsh             setl ts=2 sts=2 sw=2 et   isk+=-

  " F5でファイルを実行する設定
  autocmd FileType typescript nnoremap <buffer> <F5> :w\|!tsc % \| node %:r.js<CR>
  autocmd FileType python     nnoremap <buffer> <F5> :w\|!python %<CR>
  autocmd FileType ruby       nnoremap <buffer> <F5> :w\|!ruby %<CR>
  autocmd FileType perl       nnoremap <buffer> <F5> :w\|!perl %<CR>
  autocmd FileType go         nnoremap <buffer> <F5> :w\|!go run %<CR>
  autocmd FileType javascript nnoremap <buffer> <F5> :w\|!node %<CR>
  autocmd FileType html       nnoremap <buffer> <F5> :w\|!google-chrome %<CR>
  autocmd FileType markdown   nnoremap <buffer> <F5> :w\|!google-chrome %<CR>
  autocmd FileType plantuml   nnoremap <buffer> <F5> :w\|!plantuml %<CR>
  autocmd FileType dot        nnoremap <buffer> <F5> :w\|!dot % -O -Tpng<CR>
  autocmd FileType asciidoc   nnoremap <buffer> <F5> :w\|!asciidoctor -r asciidoctor-diagram %<CR>
  autocmd FileType sh         nnoremap <buffer> <F5> :w\|!%:p<CR>
  autocmd FileType c          nnoremap <buffer> <F5> :w\|!gcc % && ./a.out<CR>
  autocmd FileType tcl        nnoremap <buffer> <F5> :w\|!wish %<CR>
  autocmd FileType scheme     nnoremap <buffer> <F5> :w\|!gosh %<CR>
  autocmd FileType rust       nnoremap <buffer> <F5> :w\|!rustc % \| !%:r<CR>
  autocmd FileType nim        nnoremap <buffer> <F5> :w\|!nim c -r %<CR>
  autocmd FileType vim        nnoremap <buffer> <F5> :w\|so %<CR>

  " quickfixの設定
  autocmd FileType qf noremap <buffer> p  <CR>zz<C-w>p

  " filetypeの設定
  autocmd BufRead,BufNewFile *.tsx       setl ft=typescriptreact
  autocmd BufRead,BufNewFile *.tsx,*.jsx setl ft=typescript.tsx
  autocmd BufRead,BufNewFile *.ts        setl ft=typescript
  autocmd BufRead,BufNewFile *.md        setl ft=markdown
  autocmd BufRead,BufNewFile *.nim       setl ft=nim
  autocmd BufRead,BufNewFile *.pu        setl ft=plantuml
  autocmd BufRead,BufNewFile *.dot       setl ft=dot
  autocmd BufRead,BufNewFile *.adoc      setl ft=asciidoc
  autocmd BufRead,BufNewFile *.sh        setl ft=sh
  autocmd BufRead,BufNewFile *.c         setl ft=c
  autocmd BufRead,BufNewFile *.tcl       setl ft=tcl
  autocmd BufRead,BufNewFile *.scm       setl ft=scheme
  autocmd BufRead,BufNewFile *.rs        setl ft=rust
augroup END

augroup MarkFile
  autocmd!
  autocmd BufLeave *.{c,cpp} mark C
  autocmd BufLeave *.h       mark H
  autocmd BufLeave vimrc     mark V
augroup END

let g:python3_host_prog = exepath('python')
let g:python_host_prog  = exepath('python2')
let g:ruby_host_prog    = exepath('ruby')
"}}}
" プラグイン一覧{{{
try
  call plug#begin('~/.vim/plugged')
  " Make sure you use single quotes
  Plug 'junegunn/vim-plug'
  Plug 'vim-jp/vimdoc-ja'

  " 全般
  Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle', 'NERDTree']}
  Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
  if executable('fzf') > 0
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/fzf'
  else
    Plug 'ctrlpvim/ctrlp.vim'
  endif
  Plug 'easymotion/vim-easymotion', {'on': [ '<Plug>(easymotion-overwin-f2)', '<Plug>(easymotion-bd-w)' ]}

  " テキスト操作
  Plug 'kana/vim-textobj-user'
  Plug 'michaeljsmith/vim-indent-object' " ai, ii, aI, iI でインデント
  Plug 'saaguero/vim-textobj-pastedtext' " gbで直近で貼り付けた範囲
  Plug 'thinca/vim-textobj-between'      " af{char}, if{char}で任意の文字
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'h1mesuke/vim-alignta'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-abolish'               " キャメルケースやスネークケースの変換

  " 表示
  Plug 'flazz/vim-colorschemes'
  Plug 'luochen1990/rainbow'                     " カッコを色分け
  Plug 'ap/vim-css-color', {'for': 'css'}        " CSSの色を表示
  Plug 'mechatroner/rainbow_csv', {'for': 'csv'} " CSVデータを列ごとに色分け
  Plug 'machakann/vim-highlightedyank'           " ヤンクした場所をわかりやすくする。
  Plug 'mattn/disableitalic-vim'                 " イタリックフォントを無効化
  Plug 'itchyny/lightline.vim'
  Plug 'junegunn/goyo.vim', {'on': ['Goyo']}

  " 入力補完・補助
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'mattn/emmet-vim', {'on': '<Plug>(emmet-expand-abbr)'}
  Plug 'LeafCage/yankround.vim'
  Plug 'ervandew/supertab'

  " バージョン管理・変更履歴
  if has('nvim') || has('patch-8.0.902')
    Plug 'mhinz/vim-signify'
  else
    Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
  endif
  Plug 'tpope/vim-fugitive'
  Plug 'junegunn/gv.vim', {'on': 'GV'}           " コミットブラウザ
  Plug 'tpope/vim-rhubarb', {'on': 'Gbrowse'}    " Gbrowseをgithubで開くようにする
  Plug 'mbbill/undotree', {'on': 'UndotreeShow'} " Undoツリー管理

  " 言語
  Plug 'sheerun/vim-polyglot' " 様々な言語のパック。
  if executable('node') > 0 && executable('yarn') > 0
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install', 'for': 'markdown'}
  else
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': 'markdown'}
  endif
  Plug 'ferrine/md-img-paste.vim', {'for': 'markdown'}
  Plug 'leafgarland/typescript-vim', {'for': 'typescript'}
  Plug 'peitalin/vim-jsx-typescript', {'for': ['typescript', 'jsx']}

  " デバッグ
  Plug 'puremourning/vimspector', { 'do': './install_gadget.py --all --disable-tcl' }
  call plug#end()
catch
  echo 'vim-plug 実行中にエラー発生'
  echo v:exception
  echo v:throwpoint
endtry
"}}}
" プラグイン設定{{{
let s:plug = { "plugs": get(g:, 'plugs', {}) }
function! s:plug.is_installed(name)
  return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
endfunction
" fugitive{{{
nnoremap gcd :<C-u>Gcd<CR>
nnoremap gs :<C-u>Gstatus<CR>
"}}}
" あいまい検索{{{
" fzf{{{
if executable('fzf') > 0
  " fzf
  " <C-i>で全選択するように修正
  let $FZF_DEFAULT_OPTS = '--bind ctrl-o:select-all,ctrl-d:deselect-all'

  " 別タブであいまい検索を行う
  " let g:fzf_layout = { 'window': '-tabnew' }
  " ひとまずデフォルトの設定を使う
  let g:fzf_layout = { 'down': '~40%' }

  " Windowsの場合はプレビューウィンドウを出さない
  if has('win32') || has('win64')
    let g:fzf_preview_window = ''
  endif

  " floating windowが使えるときには使う。ambiwidthがdoubleのときにはレイアウトが崩れる？
  if &ambiwidth == 'single' && (has('nvim') || v:versionlong >= 8020191)
      let g:fzf_layout = { 'window': { 'width': 0.95, 'height': 0.9 } }
  endif

  " プレビューをする
  " Filesコマンドにもプレビューを出す(参考 https://qiita.com/kompiro/items/a09c0b44e7c741724c80)
  if executable('bat') && executable('bash') && !(has('win32') || has('win64'))
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
  nnoremap <Space>G :<C-u>GFiles?<CR>
  " nnoremap <Space>G :<C-u>Ggrep
  " nnoremap <Space>r :<C-u>History<CR>
  " 履歴はソートせずにプレビューも表示
  if executable('bat') && executable('bash') && !(has('win32') || has('win64'))
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
  if executable('rg')
    " 参考(https://arimasou16.com/blog/2018/11/02/00268/)
    if has('win32') || has('win64')
      command! -bang -nargs=* FzfRg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always --smart-case "'.<q-args>.'"', 1,
            \   <bang>0)
      nnoremap <Space>a :<C-u>FzfRg<CR>
      nnoremap <C-k> :<C-u>FzfRg <C-r><C-w><CR>
    else
      nnoremap <Space>a :<C-u>Rg<CR>
      nnoremap <C-k> :<C-u>Rg <C-r><C-w><CR>
    endif
  else
    nnoremap <Space>a :<C-u>Ag<CR>
    nnoremap <C-k> :<C-u>Ag <C-r><C-w><CR>
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
" supertab{{{
let g:SuperTabDefaultCompletionType = "<c-n>"
"}}}
" Tagbar{{{
let g:tagbar_autofocus = 1
nnoremap <F8> :TagbarToggle<CR>
nnoremap <Space>i :TagbarToggle<CR>
nnoremap <Space>o :TagbarToggle<CR>
let g:tagbar_type_markdown = {
      \ 'ctagstype' : 'markdown',
      \ 'kinds' : [
      \ 'h:Heading_L1',
      \ 'i:Heading_L2',
      \ 'k:Heading_L3'
      \ ]
      \ }
"}}}
" NERDTree{{{
nnoremap <Space>e :<C-u>NERDTreeToggle<CR>
nnoremap <Space>E :<C-u>NERDTree<CR>
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeLimitedSyntax = 1
"}}}
" EasyMotion{{{
let g:EasyMotion_smartcase = 1
nmap <Space>s <Plug>(easymotion-overwin-f2)
nmap , <Plug>(easymotion-overwin-f2)
map  <Space>f <Plug>(easymotion-bd-w)
"}}}
" Aligntaの設定{{{
if s:plug.is_installed("vim-alignta")
  vnoremap sc :Alignta <<0 \ <CR>
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
" https://github.com/neoclide/coc-python/issues/188
" が解決するまでcoc-pythonのバージョンをアップしない
let g:coc_global_extensions = [
      \ "coc-pyright",
      \ "coc-python",
      \ "coc-tsserver",
      \ "coc-json",
      \ "coc-yaml",
      \ "coc-html",
      \ "coc-css",
      \ "coc-tailwindcss",
      \ "coc-vimlsp",
      \ "coc-marketplace",
      \ "coc-highlight",
      \ "coc-rls",
      \ "coc-go",
      \ "coc-emoji",
      \ "coc-snippets",
      \ "coc-cmake",
      \ "coc-docker",
      \ "coc-sh",
      \ "https://github.com/xabikos/vscode-react",
      \ "https://github.com/infeng/vscode-react-typescript"
      \]
" \ "coc-tabnine",
" \ "coc-word",
" \ "coc-spell-checker",
" \ "coc-python@1.2.9",
" \ "coc-explorer",

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
augroup CocHighlight
  autocmd!
  autocmd BufRead,BufNewFile,ColorScheme * hi clear CocUnderLine
augroup END

nnoremap <expr><C-n> coc#util#has_float() ? coc#util#float_scroll(1) : "\<C-n>"
nnoremap <expr><C-p> coc#util#has_float() ? coc#util#float_scroll(0) : "\<C-p>"

" 折りたたみが勝手に発動してしまうため、一時無効化
" Use auocmd to force lightline update.
" autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" ハイライトは別にいらないので削除
" Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
"}}}
" lightline{{{
function! GetCWD30()
  return getcwd()[-30:]
endfunction

try
  let s:palette = g:lightline#colorscheme#wombat#palette
  let s:palette.tabline.tabsel = [ [ '#d0d0d0', '#5f8787', 252, 66, 'bold' ] ]
  unlet s:palette
catch
endtry

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'cocstatus'] ],
      \   'right': [ ['workspace']],
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
      \		'css': 0,
      \   'nerdtree': 0,
      \	}
      \}
" }}}
" emmet{{{
imap <C-y>, <Plug>(emmet-expand-abbr)
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
" md-img-paste{{{
augroup MdImgPasteGroup
  autocmd!
  autocmd FileType markdown nmap <silent> <M-v> :call mdip#MarkdownClipboardImage()<CR>
  autocmd FileType markdown nmap <silent> <F1> :call mdip#MarkdownClipboardImage()<CR>
augroup END
"}}}
" vimspector{{{
" Key         | API
" ------------+----------------------
" F5          | vimspector#Continue()
" F3          | vimspector#Stop()
" F4          | vimspector#Restart()
" F6          | vimspector#Pause()
" F9          | vimspector#ToggleBreakpoint()
" <leader>F9  | vimspector#ToggleBreakpoint( { trigger expr   | hit count expr } )
" F8          | vimspector#AddFunctionBreakpoint( '<cexpr>' )
" F10         | vimspector#StepOver()
" F11         | vimspector#StepInto()
" F12         | vimspector#StepOut()
let g:vimspector_enable_mappings = 'HUMAN'
nnoremap <F17> :<C-u>call vimspector#Continue()<CR>
function! LaunchFileDebug()
  call vimspector#LaunchWithSettings({'configuration': &filetype.'_file'})
endfunction
"}}}
" イタリックフォントを無効化{{{
  if s:plug.is_installed('disableitalic-vim')
    augroup DisableItalicGroup
      autocmd!
      " ColorSchemeの方でautocmdすると、vim起動後コマンドが見つからないときがある？
      autocmd BufRead,BufNewFile,ColorScheme * silent! DisableItalic
    augroup END
  endif
"}}}
" 組み込み{{{
let g:loaded_matchparen = 1 " カッコのハイライトを消す
let g:netrw_keepdir = 0
"let g:markdown_folding=1
"
" デフォルトプラグインの無効化
let g:loaded_gzip              = 1
let g:loaded_tar               = 1
let g:loaded_tarPlugin         = 1
let g:loaded_zip               = 1
let g:loaded_zipPlugin         = 1
let g:loaded_rrhelper          = 1
let g:loaded_2html_plugin      = 1
let g:loaded_vimball           = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_getscript         = 1
let g:loaded_getscriptPlugin   = 1
" let g:loaded_netrw             = 1
" let g:loaded_netrwPlugin       = 1
" let g:loaded_netrwSettings     = 1
" let g:loaded_netrwFileHandlers = 1
"}}}
"}}}
" 表示{{{
" カラースキーム{{{
try
  " gvimの場合はgvimrcなどの方でカラースキームを設定する
  if !has("gui_running")
    colorscheme iceberg
  endif
catch
endtry
"}}}
" オプション{{{
" 対応カッコの色設定を変更(そのままだとわかりづらいときあった)
" 参考: https://stackoverflow.com/questions/10746750/set-vim-bracket-highlighting-colors
augroup ChangeMatchParen
  autocmd!
  hi MatchParen cterm=bold ctermbg=none ctermfg=magenta
augroup END
set showmatch " 閉じカッコ入力時に、対応する開きカッコにハイライト
" set cursorline
" hi clear CursorLine
set background=dark
set conceallevel=0
" set colorcolumn=80 " 80列目の色を変える
set synmaxcol=250 " 長い行はシンタックスハイライトしない
"set cursorline
set laststatus=2
set showcmd " 入力した内容を表示
silent set termguicolors " GUIカラーを使う
" フォントが欠けるのを回避
" fzfでfloating windowを使用するときにレイアウトが崩れるので様子見
" set ambiwidth=double
silent! set lazyredraw " マクロ実行時の描画処理をやめる
"}}}
" 折りたたみ表示 {{{
set foldtext=MyFoldText()
let &fillchars='fold: ' " 折りたたみの空きスペースは半角スペースで埋める
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
command! CopyPath let @+=expand('%')
command! CopyAbsPath let @+=expand('%:p')
command! CopyDir let @+=expand('%:h')
command! CopyAbsDir let @+=expand('%:p:h')
"}}}
" GUI {{{
if has('gui_running')
  " アンチエイリアス{{{
  if has('win32') || has('win64')
    silent! set renderoptions=type:directx
  endif
  silent! set antialias
  "}}}
  " フォント{{{
  " 参考 vim(gvim) フォントサイズ https://miwaokina.com/blog/wordpress/?p=2925
  nnoremap + :let &guifont = substitute(&guifont, '\d\+', '\=submatch(0)+1', '')<CR>
  nnoremap - :let &guifont = substitute(&guifont, '\d\+', '\=max([submatch(0)-1, 1])', '')<CR>

  " 透明度を変更
  if exists('&transparency')
    nnoremap <S-Up> :let &transparency = min([&transparency + 5, 255])<CR>
    nnoremap <S-Down> :let &transparency = max([&transparency - 5, 0])<CR>
  endif

  try
    if has('unix')
      set guifont=Monospace\ 14
    elseif has('win32') || has('win64')
      set guifont=Cica:h16:cSHIFTJIS:qDRAFT
    endif
  catch
  endtry
  "}}}
  " term設定{{{
  nnoremap !+term+! <Nop>
  tnoremap !+term+! <Nop>
  nmap <C-s> !+term+!
  nmap <C-b> !+term+!
  " 一旦tnoremapしておく
  tnoremap !+term-esc+! <C-\><C-n>
  tmap <C-s> !+term+!
  tmap <C-b> !+term+!

  tmap <C-s> !+term-esc+!!+term+!
  tmap <C-b> !+term-esc+!!+term+!

  if has('nvim')
    nnoremap !+term+!s <C-u>:split\|:terminal<CR>
    nnoremap !+term+!v <C-u>:vsplit\|:terminal<CR>
  else
    nnoremap !+term+!c :<C-u>tab terminal ++close<CR>
    nnoremap !+term+!t :<C-u>tab terminal ++close<CR>
    nnoremap !+term+!v :<C-u>vert terminal ++close<CR>
    nnoremap !+term+!s :<C-u>terminal ++close<CR>
  endif

  for s:s in split('HJKLThjkl', '\zs')
    execute 'nnoremap !+term+!' . s:s . ' <C-w>' . s:s
    execute 'tnoremap !+term+!' . s:s . ' <C-w>' . s:s
  endfor

  nnoremap !+term+!! <C-w>T
  nnoremap !+term+!p :<C-u>tabprevious<CR>
  nnoremap !+term+!n :<C-u>tabnext<CR>

  " tnoremap !+term+!v <C-w>v
  " tnoremap !+term+!s <C-w>s
  tmap !+term+!p !+term-esc+!!+term+!p
  tmap !+term+!n !+term-esc+!!+term+!n
  tmap !+term+!! !+term-esc+!!+term+!T
  tmap !+term+!T !+term-esc+!!+term+!T
  "}}}
  " メニューバーなどの設定{{{
  set guioptions-=m
  set guioptions-=T
  "}}}
  " IME設定{{{
  if has('multi_byte_ime') || has('xim')
    augroup IMEHighlight
      autocmd!
      highlight Cursor guifg=NONE guibg=White
      highlight CursorIM guifg=NONE guibg=DarkRed
    augroup END
  endif
  "}}}
endif
"}}}
