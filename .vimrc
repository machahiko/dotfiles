set nocompatible
filetype off
scriptencoding cp932

"----------------------------------------
" User Runtime Path Settings
"----------------------------------------
"Windows, unixでのruntimepathの違いを吸収するためのもの。 
"$MY_VIMRUNTIMEはユーザーランタイムディレクトリを示す。 
":echo $MY_VIMRUNTIMEで実際のパスを確認できます。 
if isdirectory($HOME . '/.vim') 
  let $MY_VIMRUNTIME = $HOME.'/.vim' 
elseif isdirectory($HOME . '\vimfiles') 
  let $MY_VIMRUNTIME = $HOME.'\vimfiles' 
elseif isdirectory($VIM . '\vimfiles') 
  let $MY_VIMRUNTIME = $VIM.'\vimfiles' 
endif 
"ランタイムパスを通す必要のあるプラグインを使用する場合
"$MY_VIMRUNTIMEを使用すると Windows/Linuxで切り分ける必要が無くなります。 
"例) vimfiles/qfixapp (Linuxでは~/.vim/qfixapp)にランタイムパスを通す場合 
"set runtimepath+=$MY_VIMRUNTIME/qfixapp


"----------------------------------------
" General
"----------------------------------------
set nowritebackup "ファイルの上書きの前にバックアップを作らない
set nobackup "バックアップ/スワップファイルを作成する/しない
"set noswapfile
"set viminfo= "viminfoを作成しない
set clipboard+=unnamed "クリップボードを共有
set nrformats-=octal "8進数を無効にする。<C-a>,<C-x>に影響する
set timeoutlen=3500 "キーコードやマッピングされたキー列が完了するのを待つ時間(ミリ秒)
set hidden "編集結果非保存のバッファから、新しいバッファを開くときに警告を出さない
set history=50 "ヒストリの保存数
set formatoptions+=mM "日本語の行の連結時には空白を入力しない
set virtualedit=block "Visual blockモードでフリーカーソルを有効にする
set whichwrap=b,s,[,],<,> "カーソルキーで行末／行頭の移動可能に設定
set backspace=indent,eol,start "バックスペースでインデントや改行を削除できるようにする
set ambiwidth=double "□や○の文字があってもカーソル位置がずれないようにする
set wildmenu "コマンドライン補完するときに強化されたものを使う

set whichwrap=b,s,h,l,<,>,[,] "カーソルを行頭、行末で止まらないようにする
set pastetoggle=<F2> "F2でpasteモードに。pasteするときにインデントを無効化。

" エンコーディング
set encoding=utf-8
set fileencodings=euc-jp

"インデント関連
set autoindent
set smartindent
set smarttab
set shiftwidth=4
set tabstop=4

"再読込、vim終了後も継続するアンドゥ(7.3)
if version >= 703
  "Persistent undoを有効化(7.3)
  "set undofile
  "アンドゥの保存場所(7.3)
  "set undodir=.
endif

"マウスを有効にする
if has('mouse')
  set mouse=a
endif
filetype plugin indent on "pluginを使用可能にする

"----------------------------------------
" Search
"----------------------------------------
"検索の時に大文字小文字を区別しない
"ただし大文字小文字の両方が含まれている場合は大文字小文字を区別する
set ignorecase
set smartcase
set wrapscan "検索時にファイルの最後まで行ったら最初に戻る
set incsearch "インクリメンタルサーチ
set hlsearch "検索文字の強調表示
"w,bの移動で認識する文字
"set iskeyword=a-z,A-Z,48-57,_,.,-,>
"vimgrep をデフォルトのgrepとする場合internal
"set grepprg=internal

"----------------------------------------
" View 
"----------------------------------------
"set shortmess+=I "スプラッシュ(起動時のメッセージ)を表示しない
set noerrorbells "エラー時の音とビジュアルベルの抑制(gvimは.gvimrcで設定)
set novisualbell
set visualbell t_vb=
"set lazyredraw "マクロ実行中などの画面再描画を行わない
set shellslash "Windowsでディレクトリパスの区切り文字表示に / を使えるようにする
set number "行番号表示
set ruler
set showmatch matchtime=1 "括弧の対応表示時間
set ts=2 sw=2 sts=2 "タブを設定
set autoindent "自動的にインデントする
set cinoptions+=:0 "Cインデントの設定
set title "タイトルを表示
set cmdheight=2 "コマンドラインの高さ (gvimはgvimrcで指定)
set laststatus=2
set showcmd "コマンドをステータス行に表示
set display=lastline "画面最後の行をできる限り表示する
set list "Tab、行末の半角スペースを明示的に表示する
set listchars=tab:^\ ,trail:~

" ハイライトを有効にする
if &t_Co > 2 || has('gui_running')
  syntax on
endif

"カレントディレクトリにだけアンダーラインを引く
setlocal cursorline
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

"色テーマ設定
"gvimの色テーマは.gvimrcで指定する
colorscheme desert
"コメントの色をグレーに
hi Comment ctermfg=gray

"タブ、全角スペースを表示
"set list
"set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
"hi SpecialKey ctermfg=Blue guifg=Blue
"hi NonText ctermfg=Blue guifg=Blue
"hi JpSpace cterm=underline ctermfg=Blue guifg=Blue
"au BufRead,BufNew * match JpSpace /　/


""""""""""""""""""""""""""""""
"ステータスラインに文字コードやBOM、16進表示等表示
"iconvが使用可能の場合、カーソル上の文字コードをエンコードに応じた表示にするFencB()を使用
""""""""""""""""""""""""""""""
if has('iconv')
  set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).(&bomb?':BOM':'').']['.&ff.']'}%=[0x%{FencB()}]\ (%v,%l)/%L%8P\ 
else
  set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).(&bomb?':BOM':'').']['.&ff.']'}%=\ (%v,%l)/%L%8P\ 
endif

function! FencB()
  let c = matchstr(getline('.'), '.', col('.') - 1)
  let c = iconv(c, &enc, &fenc)
  return s:Byte2hex(s:Str2byte(c))
endfunction

function! s:Str2byte(str)
  return map(range(len(a:str)), 'char2nr(a:str[v:val])')
endfunction

function! s:Byte2hex(bytes)
  return join(map(copy(a:bytes), 'printf("%02X", v:val)'), '')
endfunction

"----------------------------------------
" diff/patch
"----------------------------------------
"diffの設定
if has('win32') || has('win64')
  set diffexpr=MyDiff()
  function! MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    silent execute '!diff ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  endfunction
endif

"現バッファの差分表示(変更箇所の表示)
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
"ファイルまたはバッファ番号を指定して差分表示。#なら裏バッファと比較
command! -nargs=? -complete=file Diff if '<args>'=='' | browse vertical diffsplit|else| vertical diffsplit <args>|endif
"パッチコマンド
set patchexpr=MyPatch()
function! MyPatch()
   :call system($VIM."\\'.'patch -o " . v:fname_out . " " . v:fname_in . " < " . v:fname_diff)
endfunction

"----------------------------------------
" NORMAL MODE
"----------------------------------------
"ヘルプ検索
nnoremap <F1> K
"現在開いているvimスクリプトファイルを実行
nnoremap <F8> :source %<CR>
"強制全保存終了を無効化
nnoremap ZZ <Nop>
"カーソルをj k では表示行で移動する。物理行移動は<C-n>,<C-p>
"キーボードマクロには物理行移動を推奨
"h l はノーマルモードのみ行末、行頭を超えることが可能に設定(whichwrap) 
" zvはカーソル位置の折り畳みを開くコマンド
nnoremap <Down> gj
nnoremap <Up>   gk
nnoremap h <Left>zv
nnoremap j gj
nnoremap k gk
nnoremap l <Right>zv

"splitの移動を簡単に。ctrl押しながらhjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"steモードに。pasteするときにインデントを無効化。
" <F2> to paste mode.
set pastetoggle=<F2>

"----------------------------------------
" INSERT MODE
"----------------------------------------
"insertモードでjj押せばノーマルモードに。
" in insert mode, jj means <ESC>.
inoremap jj <ESC>

" When insert mode, enable hjkl and enable go to home/end.
imap <c-o> <END>
imap <c-a> <HOME>
imap <c-h> <LEFT>
imap <c-j> <DOWN>
imap <c-k> <UP>
imap <c-l> <Right>

"----------------------------------------
" VISUAL MODE
"----------------------------------------

"----------------------------------------
" COMMAND MODE
"----------------------------------------

"----------------------------------------
" Vimスクリプト
"----------------------------------------
""""""""""""""""""""""""""""""
"ファイルを開いたら前回のカーソル位置へ移動
""""""""""""""""""""""""""""""
augroup vimrcEx
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line('$') |
    \   exe "normal! g`\"" |
    \ endif
augroup END

""""""""""""""""""""""""""""""
"挿入モード時、ステータスラインの色を変更
""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif
" if has('unix') && !has('gui_running')
"   " ESCでキー入力待ちになる対策
"   inoremap <silent> <ESC> <ESC>
" endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
    redraw
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

""""""""""""""""""""""""""""""
"grep,tagsのためカレントディレクトリをファイルと同じディレクトリに移動する
""""""""""""""""""""""""""""""
"if exists('+autochdir')
"  "autochdirがある場合カレントディレクトリを移動
"  set autochdir
"else
"  "autochdirが存在しないが、カレントディレクトリを移動したい場合
"  au BufEnter * execute ":silent! lcd " . escape(expand("%:p:h"), ' ')
"endif

""""""""""""""""""""""""""""""
"Windowsで内部エンコーディングがcp932以外の場合
"makeのメッセージが化けるのを回避
""""""""""""""""""""""""""""""
"if has('win32') || has('win64') || has('win95') || has('win16')
"  au QuickfixCmdPost make call QFixCnv('cp932')
"endif
"
"function! QFixCnv(enc)
"  if a:enc == &enc
"    return
"  endif
"  let qflist = getqflist()
"  for i in qflist
"    let i.text = iconv(i.text, a:enc, &enc)
"  endfor
"  call setqflist(qflist)
"endfunction

"----------------------------------------
" Plugin
"----------------------------------------
set rtp+=~/YusukeDev/dotfiles/vimfiles/vundle.git/
call vundle#rc()
"Bundle 'Shougo/neocomplcache'
"Bundle 'Shougo/unite.vim'
"Bundle 'Shougo/vimfiler'
"Bundle 'Shougo/vimproc'
"Bundle 'Shougo/vimshell'
"Bundle 'thinca/vim-ref'
"Bundle 'thinca/vim-quickrun'
filetype plugin indent on     " required!



"-----------------------
" neocomplcache
"-----------------------
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
			\ 'default' : '',
			\ 'vimshell' : $HOME.'/.vimshell_hist',
			\ 'scheme' : $HOME.'/.gosh_completions'
			\ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
	let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" 補完候補色
hi Pmenu ctermfg= 'white'
hi PmenuSel ctermfg=12
hi PmenuSbar ctermfg=0

"----------------------------------------
" 一時設定
"----------------------------------------


"----------------------------------------
" MacVim
"----------------------------------------
if has("gui_macvim")
	let macvim_hig_shift_movement = 1
endif

