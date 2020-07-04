" vim:set foldmethod=marker foldlevel=0:
set encoding=utf-8
scriptencoding utf-8
set shellslash

if exists("g:loaded_my_vimrc")
  finish
endif
let g:loaded_my_vimrc = 1

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
" コメントで自動整形されるのを回避
set formatoptions-=cro

" 全角カッコでも%で対応するものに移動できるようにする
set matchpairs+=「:」,（:）,【:】,『:』,〈:〉,《:》
"}}}
" 折りたたみ{{{
set foldmethod=marker
" show foldings
"set foldcolumn=1
"}}}
" 入力補完{{{
" remove tag comeletion from default
set complete-=i
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
" コマンド履歴の数
set history=10000
if has('win32') || has('win64')
   set viminfo='999,<50,s10,h,rA:,rB:
else
  set viminfo=!,'999,<50,s10,h
endif
"}}}
" 行番号{{{
set number
set relativenumber
" set scrolloff=0
" カーソルの上または下に表示される最小行数
set scrolloff=5
" カーソルの位置を表示
set ruler
"}}}
" ワイルドメニュー{{{
set wildignorecase
set wildmenu
"}}}
" バッファ{{{
" バッファ保存せずに移動できるようにする
set hidden
" ファイルの変更を監視する
set autoread
"}}}
" タブ{{{
" 使用可能なタブページの個数
set tabpagemax=50
"}}}
" 環境{{{
if executable($HOME . '/anaconda3/bin/python') > 0
  let g:python3_host_prog=$HOME . '/anaconda3/bin/python'
endif
set path+=~/memo/**
set tags+=tags;
" 自分用タグファイルを追加
set tags+=mytags
"}}}
" マウス・キー入力{{{
set mouse=a
" キーマッピングなどのタイムアウト時間
set timeoutlen=9999999
"}}}
" その他{{{
" ビープ音を無効化
set belloff=all
" }}}
" }}}
" キーマッピング(一般){{{
" 全般{{{
" インサートモード{{{
inoremap jj <ESC>
" offを入力できないので無効化
" inoremap ff <ESC>
inoremap jf <ESC>
inoremap fj <ESC>
" inoremap jk <ESC>
" inoremap kj <ESC>
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
" vnoremap * "zy:let @/ = @z<CR>n
vnoremap * "zy:let @/ = '\V' . @z<CR>n
" 選択範囲に直前の操作を適用
vnoremap . :normal .<CR>
"}}}
"
" vimrcをリロード
command! ReloadVimrc :unlet g:loaded_my_vimrc | :source $MYVIMRC
nnoremap <M-r> :<C-u>ReloadVimrc<CR>
nnoremap <M-w> :w<CR>

nnoremap cd :<C-u>CD<CR>
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
" nnoremap <Space>j <C-f>
" nnoremap <Space>k <C-b>
nnoremap <Space>z za
nnoremap <F6> :make<CR>
" nnoremap <C-S-e> :Ex<CR>

function! ToggleLastStatus()
  if &laststatus == 2
    let &laststatus = 0
  else
    let &laststatus = 2
  endif
endfunction
nnoremap <expr> <Space><F2> ToggleLastStatus()

" 角括弧によるマッピング{{{

" quick fix next/previous
nnoremap ]q :<C-u>cnext<CR>
nnoremap [q :<C-u>cprevious<CR>

" location list next/previous
nnoremap ]l :<C-u>lnext<CR>
nnoremap [l :<C-u>lprevious<CR>

nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

" タグジャンプ
nnoremap ]t  <C-]>
nnoremap [t  <C-t>
nnoremap [o <C-i>
" }}}

" nnoremap <M-Right> <C-o>
" nnoremap <M-Left> <C-]>

" ,からはじまるマッピング{{{
nnoremap ,q :cw<CR>
nnoremap ,l :lw<CR>
nnoremap ,u :UndotreeShow<CR>
"}}}
"}}}
" 外部コマンドとの連携{{{
"
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
nnoremap <silent> !+window+!H :<C-u>wincmd H<CR>
nnoremap <silent> !+window+!J :<C-u>wincmd J<CR>
nnoremap <silent> !+window+!K :<C-u>wincmd K<CR>
nnoremap <silent> !+window+!L :<C-u>wincmd L<CR>
nnoremap <silent> !+window+!T :<C-u>wincmd T<CR>
nnoremap <silent> !+window+!^ <C-^>
nnoremap <silent> !+window+!h :<C-u>wincmd h<CR>
nnoremap <silent> !+window+!j :<C-u>wincmd j<CR>
nnoremap <silent> !+window+!k :<C-u>wincmd k<CR>
nnoremap <silent> !+window+!l :<C-u>wincmd l<CR>
nnoremap <silent> !+window+!o :<C-u>wincmd o<CR>
nnoremap <silent> !+window+!q :<C-u>wincmd q<CR>
nnoremap <silent> !+window+!s :<C-u>split<CR>
nnoremap <silent> !+window+!S :<C-u>new<CR>
nnoremap <silent> !+window+!t :<C-u>tabnew<CR>
nnoremap <silent> !+window+!v :<C-u>vsplit<CR>
nnoremap <silent> !+window+!V :<C-u>vnew<CR>
" nnoremap !+window+!1 1gt
" nnoremap !+window+!2 2gt
" nnoremap !+window+!3 3gt
" nnoremap !+window+!4 4gt
" nnoremap !+window+!5 5gt
" nnoremap !+window+!6 6gt
" nnoremap !+window+!7 7gt
" nnoremap !+window+!8 8gt
" nnoremap !+window+!9 9gt

nmap <silent> !+window+!p :<C-u>tabprevious<CR>!+tab+!
nmap <silent> !+window+!P :<C-u>tabfirst<CR>!+tab+!
nmap <silent> !+window+!n :<C-u>tabnext<CR>!+tab+!
nmap <silent> !+window+!N :<C-u>tablast<CR>!+tab+!
"}}}
" リサイズ{{{
" +, -, <, >でウィンドウリサイズ。連続入力可能
nnoremap !+resize+! <Nop>
nmap <silent> !+window+!+ :<C-u>wincmd +<CR>!+resize+!
nmap <silent> !+window+!- :<C-u>wincmd -<CR>!+resize+!
nmap <silent> !+window+!< :<C-u>wincmd <<CR>!+resize+!
nmap <silent> !+window+!> :<C-u>wincmd ><CR>!+resize+!
nmap <silent> !+resize+!+ :<C-u>wincmd +<CR>!+resize+!
nmap <silent> !+resize+!- :<C-u>wincmd -<CR>!+resize+!
nmap <silent> !+resize+!< :<C-u>wincmd <<CR>!+resize+!
nmap <silent> !+resize+!> :<C-u>wincmd ><CR>!+resize+!
"}}}
" スクロール{{{
function! ScrollFunc(distance)
  let num = abs(a:distance)
  let key = a:distance > 0 ? "\<C-e>" : "\<C-y>"
  exec "normal ". num . key
  " for i in range(num)
  "   if i > 0
  "     sleep 10m
  "   endif
  "   exec "normal " . key
  "   redraw
  " endfor
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
" nnoremap <silent> !+tab+!0 :<C-u>tabfirst<CR>
" nnoremap <silent> !+tab+!$ :<C-u>tablast<CR>
nnoremap <silent> !+tab+!1 :<C-u>tabnext 1<CR>
nnoremap <silent> !+tab+!2 :<C-u>tabnext 2<CR>
nnoremap <silent> !+tab+!3 :<C-u>tabnext 3<CR>
nnoremap <silent> !+tab+!4 :<C-u>tabnext 4<CR>
nnoremap <silent> !+tab+!5 :<C-u>tabnext 5<CR>
nnoremap <silent> !+tab+!6 :<C-u>tabnext 6<CR>
nnoremap <silent> !+tab+!7 :<C-u>tabnext 7<CR>
nnoremap <silent> !+tab+!8 :<C-u>tabnext 8<CR>
nnoremap <silent> !+tab+!9 :<C-u>tabnext 9<CR>
" 誤爆するので一旦無効化
" nnoremap !+tab+!r :<C-u>+1,$tabdo tabclose<CR>
" nnoremap !+tab+!l :<C-u>1,-1tabdo tabclose<CR>
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
autocmd FileType less setlocal ts=2 sts=2 sw=2 expandtab iskeyword+=-
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
autocmd BufNewFile,BufRead *.tsx,*.jsx setlocal ts=2 sts=2 sw=2 expandtab
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

augroup MarkFile
autocmd!
autocmd BufLeave *.{c,cpp} mark C
autocmd BufLeave *.h       mark H
autocmd BufLeave vimrc     mark V
augroup END

"}}}
" プラグイン一覧{{{
" vim-plugがない場合はインストール(参考 https://github.com/junegunn/vim-plug/wiki/tips)
" if has('unix')
"   if has('nvim')
"     " silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
"     "   \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   elseif empty(glob('~/.vim/autoload/plug.vim'))
"       silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
"         \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   endif
"   " autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
" endif
try
  " Specify a directory for plugins
  " - For Neovim: ~/.local/share/nvim/plugged
  " - Avoid using standard Vim directory names like 'plugin'
  call plug#begin('~/.vim/plugged')
  " Make sure you use single quotes
  " ヘルプ{{{
  " vim-plugのヘルプ
  Plug 'junegunn/vim-plug'

  " 日本語のヘルプ
  Plug 'vim-jp/vimdoc-ja'
  "}}}
  " 日本語{{{
  " Plug 'koron/cmigemo'
  " Plug 'haya14busa/vim-migemo'
  "}}}
  " ブラウジング{{{
  " NERDTree{{{
  Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle', 'NERDTree']}
  " NERDTreeでdeviconsを表示
  " Plug 'ryanoasis/vim-devicons'
  " Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

  " if executable('git') > 0
  "   Plug 'Xuyuanp/nerdtree-git-plugin'
  " endif
  "}}}
  " Ranger{{{
  " if executable('ranger')
  "   Plug 'francoiscabrol/ranger.vim'
  "   Plug 'rbgrouleff/bclose.vim'
  " endif
  "}}}
  Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
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
  " Denite
  " if has('nvim')
  "   Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
  " else
  "   Plug 'Shougo/denite.nvim'
  "   Plug 'roxma/nvim-yarp'
  "   Plug 'roxma/vim-hug-neovim-rpc'
  " endif
 "}}}
  " テキスト操作{{{
  " テキストオブジェクト
  " 一覧 https://github.com/kana/vim-textobj-user/wiki
  Plug 'kana/vim-textobj-user'
  " ac, icなどでコメント内(word-columnの方とバッティングする)
  " Plug 'glts/vim-textobj-comment'
  " ai, ii, aI, iI でインデント
  Plug 'michaeljsmith/vim-indent-object'
  " au, iu でURL
  " Plug 'mattn/vim-textobj-url'
  " al, il で現在の行
  " Plug 'kana/vim-textobj-line'
  " gbで直近で貼り付けた範囲
  Plug 'saaguero/vim-textobj-pastedtext'
  " _ アンダースコア
  " Plug 'lucapette/vim-textobj-underscore'
  " ic, ac, iC, aC, で同一列の文字列
  " Plug 'idbrii/textobj-word-column.vim/'
  " af{char}, if{char}で任意の文字
  Plug 'thinca/vim-textobj-between'
  " Plug 'kana/vim-textobj-jabraces'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'h1mesuke/vim-alignta'
  " Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-repeat'
  " キャメルケースやスネークケースの変換
  Plug 'tpope/vim-abolish'
  "}}}
  " 表示{{{
  Plug 'flazz/vim-colorschemes'
  " pywalのカラースキーム
  " if has('unix') && executable('wal')
  "   Plug 'dylanaraps/wal.vim'
  " endif
  
  " カラースキームを次々に変更
  " Plug 'vim-scripts/ScrollColors'

  " カッコを色分け
  Plug 'luochen1990/rainbow'
  " CSSの色を表示
  Plug 'ap/vim-css-color', {'for': 'css'}
  " CSVデータを列ごとに色分け
  Plug 'mechatroner/rainbow_csv', {'for': 'csv'}
  " ヤンクした場所をわかりやすくする。
  Plug 'machakann/vim-highlightedyank'
  " イタリックフォントを無効化
  Plug 'mattn/disableitalic-vim'

  " 最小限にするため、airlineじゃなくlightlineを使用
  Plug 'itchyny/lightline.vim'
  " Plug 'vim-airline/vim-airline'
  " Plug 'vim-airline/vim-airline-themes'
  " Plug 'junegunn/goyo.vim'

  " スクロールをスムーズに
  " Plug 'yuttie/comfortable-motion.vim'
  "}}}
  " 入力補完・補助{{{
  " Use release branch
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'mattn/emmet-vim'
  Plug 'LeafCage/yankround.vim'
  " カッコの自動入力
  " Plug 'jiangmiao/auto-pairs'
  " Tabで補完
  Plug 'ervandew/supertab'
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
  " コミットブラウザ
  Plug 'junegunn/gv.vim', {'on': 'GV'}
  " Gbrowseをgithubで開くようにする
  Plug 'tpope/vim-rhubarb', {'on': 'Gbrowse'}
  " Undoツリー管理
  " Plug 'sjl/gundo.vim'
  " Undoツリー管理 こっちだとpython依存がない
  Plug 'mbbill/undotree'
  " }}}
  " 移動{{{
  Plug 'easymotion/vim-easymotion'
  "}}}
  " 言語{{{
  " 様々な言語のパック。
  " Plug 'sheerun/vim-polyglot'
  " Markdown{{{
  " markdown-previewのほうがkatexやplantuml対応でいい感じ(node + yarnありが望ましい)
  if executable('node') > 0 && executable('yarn') > 0
    " If you have nodejs and yarn
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install', 'for': 'markdown'}
  else
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': 'markdown'}
  endif
  " vim-markdownの依存
  " Plug 'godlygeek/tabular'
  " Plug 'plasticboy/vim-markdown'
  Plug 'ferrine/md-img-paste.vim'
  "}}}
  " typescript, jsxなど{{{
  Plug 'leafgarland/typescript-vim', {'for': 'typescript'}
  Plug 'peitalin/vim-jsx-typescript', {'for': ['typescript', 'jsx']}
  "}}}
  " pug, stylus{{{
  " pugとstylusについては一時見送り
  " Plug 'digitaltoad/vim-pug'
  " Plug 'dNitro/vim-pug-complete', {'for': ['jade', 'pug']}
  " Plug 'iloginow/vim-stylus'
  "}}}
  "}}}
  " デバッグ{{{
  " ターミナルデバッガ
  " Plug 'epheien/termdbg'
  " Plug 'vim-vdebug/vdebug'
  "}}}
  " その他{{{
  " Plug 'mtth/scratch.vim'
  " vimrcのベンチマーク
  " Plug 'mattn/benchvimrc-vim'
  "}}}
  call plug#end()
catch
  echo 'vim-plug 実行中にエラー発生'
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
  if &ambiwidth == 'single'
    if has('nvim')
      let g:fzf_layout = { 'window': { 'width': 0.95, 'height': 0.9 } }
    else
      try
        " 参考 https://github.com/vim/vim/commit/219c7d063823498be22aae46dd024d77b5fb2a58
        if v:versionlong >= 8020191
          let g:fzf_layout = { 'window': { 'width': 0.95, 'height': 0.9 } }
        endif
      catch
      endtry
    endif
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
" gdb {{{
" gdb使用の設定
" packadd termdebug

" gdb使用の設定
" let g:termdebug_wide = 163
" }}}
" Gundo{{{
let g:gundo_prefer_python3 = 1
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
nmap , <Plug>(easymotion-overwin-f2)

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
  " vnoremap gs :Alignta \s\+<CR>
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
" https://github.com/neoclide/coc-python/issues/188
" が解決するまでcoc-pythonのバージョンをアップしない
let g:coc_global_extensions = [
      \ "coc-pyright",
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
      \ "coc-snippets",
      \ "coc-cmake",
      \ "coc-docker",
      \ "coc-sh",
      \ "https://github.com/xabikos/vscode-react",
      \ "https://github.com/infeng/vscode-react-typescript"
      \]
      " \ "coc-python@1.2.9",
      " \ "coc-explorer",


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
  autocmd FileType rust call s:my_coc_nvim_config()

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

"}}}
" airline{{{

" Theme参考 https://github.com/vim-airline/vim-airline/wiki/Screenshots

" letg:airline_theme='papercolor' 色が変わらないのでわかりづらいので保留
" let g:airline_theme='light' 色が変わりすぎて煩わしいので保留
" if has('unix') && executable('wal')
"   let g:airline_theme='wal'
" else
  let g:airline_theme='bubblegum'
" endif

let g:airline#extensions#whitespace#enabled = 0
" 参考 https://www.reddit.com/r/vim/comments/crs61u/best_airline_settings/
" let g:airline_powerline_fonts = 1
let g:airline_powerline_fonts = 0
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
let g:tex_conceal = ""
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 0
let g:vim_markdown_json_frontmatter = 0
let g:vim_markdown_liquid = 1
let g:vim_markdown_math = 0
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_toml_frontmatter = 0
"}}}
" md-img-paste{{{
augroup MdImgPasteGroup
  autocmd!
  autocmd FileType markdown nmap <silent> <M-v> :call mdip#MarkdownClipboardImage()<CR>
  autocmd FileType markdown nmap <silent> <F1> :call mdip#MarkdownClipboardImage()<CR>
augroup END
"}}}
" comfortable-motion.vim {{{
  " デフォルトのキーバインドを上書きしない
  " let g:comfortable_motion_no_default_key_mappings = 1
"}}}
" 組み込み{{{
" let loaded_matchparen = 1
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
    "&& !exists("$HYPER_RUNNING")
    " pywalのカラースキーム
    " if has('unix') && executable('wal')
    "   colorscheme wal
    " else
      " colorscheme molokai
      " colorscheme Monokai
      " colorscheme ayu
      " colorscheme gruvbox
      " colorscheme nord
      " colorscheme nordisk
      " colorscheme vim-material
      " colorscheme tender
      " colorscheme wombat256i
      colorscheme iceberg
      " colorscheme itg_flat
    " endif
  endif
catch
endtry
"}}}
" オプション{{{
" 対応カッコの色設定を変更(そのままだとわかりづらいときあった)
" 参考: https://stackoverflow.com/questions/10746750/set-vim-bracket-highlighting-colors
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta

" hilight current line number
" set cursorline
" hi clear CursorLine
"
set background=dark

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
  " 見づらかったので保留
  " ポップアップメニューを半透明にする
  " silent! set pumblend=5
  " ウィンドウを半透明にする
  " silent! set winblend=5
endif

" GUIカラーを使う
silent set termguicolors

" フォントが欠けるのを回避
" fzfでfloating windowを使用するときにレイアウトが崩れるので様子見
" set ambiwidth=double
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

" 自分用タグにつけるプレフィクス

let g:mytag_prefix = "@@@"

" 自分用のタグ作成
function! AddMyTag(tagname, tagfile, tagaddress)
  if a:tagname == "" || a:tagfile == "" || a:tagaddress == ""
    return
  endif
  " 自分用タグファイルの存在確認
  if findfile('mytags', getcwd()) == ""
    " 自分用タグファイルを作成(パフォーマンスは落ちるが、簡単のためソートしない)
    call writefile(["!_TAG_FILE_SORTED\t0"], "mytags", "a")
  endif
  " タグを追加
  call writefile([printf("%s%s\t%s\t%s", g:mytag_prefix, a:tagname, a:tagfile, a:tagaddress)], "mytags", "a")
endfunction

" 入力から自分用タグ作成
function! AddMyTagByInput()
  let tagname = input("tagname? ")
  let tagfile = expand("%:p")
  let tagaddress = printf("/^%s/;\"\td", getline("."))
  call AddMyTag(l:tagname, l:tagfile, l:tagaddress)
endfunction

" 自分用タグファイルを削除
" function! DeleteMyTagFile()
"   let mytagfile = findfile('mytags', getcwd())
"   if mytagfile != ""
"     " 0番目。つまりYesが選ばれたらタグファイルを削除
"     if confirm(printf("delete %s? ", mytagfile), "&Yes\n&No\n&Cancel") == 0
"       call delete(mytagfile)
"     endif
"   endif
" endfunction

command! AddMyTagByInput call AddMyTagByInput()
command! DeleteMyTagFile call DeleteMyTagFile()

" nnoremap mb :AddMyTagByInput<CR>
" nnoremap mt :execute(printf(":Tags %s", g:mytag_prefix))<CR>
" nnoremap mB :DeleteMyTagFile<CR>

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
  nnoremap + :let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)+1', '')<CR>
  nnoremap - :let &guifont = substitute(&guifont, '\d\+$', '\=max([submatch(0)-1, 1])', '')<CR>

  " 透明度を変更
  if exists('&transparency')
    nnoremap <S-Up> :let &transparency = min([&transparency + 5, 255])<CR>
    nnoremap <S-Down> :let &transparency = max([&transparency - 5, 0])<CR>
  endif

  " イタリックフォントを無効化
  if s:plug.is_installed('mattn/disableitalic-vim')
    augroup DisableItalicGroup
    autocmd!
    autocmd BufRead,BufNewFile,ColorScheme * DisableItalic
    augroup END
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

  nnoremap !+term+!h <C-w>h
  nnoremap !+term+!j <C-w>j
  nnoremap !+term+!k <C-w>k
  nnoremap !+term+!l <C-w>l
  nnoremap !+term+!p :<C-u>tabprevious<CR>
  nnoremap !+term+!n :<C-u>tabnext<CR>
  nnoremap !+term+!! <C-w>T
  nnoremap !+term+!T <C-w>T
  nnoremap !+term+!H <C-w>H
  nnoremap !+term+!J <C-w>J
  nnoremap !+term+!K <C-w>K
  nnoremap !+term+!L <C-w>L

  tnoremap !+term+!h <C-w>h
  tnoremap !+term+!j <C-w>j
  tnoremap !+term+!k <C-w>k
  tnoremap !+term+!l <C-w>l
  tnoremap !+term+!H <C-w>H
  tnoremap !+term+!J <C-w>J
  tnoremap !+term+!K <C-w>K
  tnoremap !+term+!L <C-w>L
  " tnoremap !+term+!v <C-w>v
  " tnoremap !+term+!s <C-w>s
  tmap !+term+!p !+term-esc+!!+term+!p
  tmap !+term+!n !+term-esc+!!+term+!n
  tmap !+term+!! !+term-esc+!!+term+!T
  tmap !+term+!T !+term-esc+!!+term+!T
  "}}}
  " メニューバーなどの設定{{{
  try
    if has("gui_running")
      set guioptions-=m
      set guioptions-=T
    endif
  catch
  endtry
  "}}}
  " IME設定{{{
if has('multi_byte_ime') || has('xim') 
  highlight Cursor guifg=NONE guibg=White
  highlight CursorIM guifg=NONE guibg=DarkRed
endif
"}}}
endif
"}}}
