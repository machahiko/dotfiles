set nocompatible
filetype off "最後に再びonにする
scriptencoding cp932

"----------------------------------------
" Function Key Actions
"----------------------------------------
"F1     vimfiler toggle
"F2     paste mode toggle
"F3     unite 最近使用したファイル
"F4     unite bookmark
"F7     現在開いているvimスクリプトファイルを実行
"F8     show tabs toggle
"F10    TagbarToggle
"F12    ヘルプ検索


"----------------------------------------
" General
"----------------------------------------
set nowritebackup               " ファイルの上書きの前にバックアップを作らない
set nobackup                    " バックアップ/スワップファイルを作成する/しない
set noswapfile                  " スワップファイルを作成しない
"set viminfo=                   " viminfoを作成しない
set clipboard+=unnamed          " クリップボードを共有
set nrformats-=octal            " 8進数を無効にする。<C-a>,<C-x>に影響する
set timeoutlen=3500             " キーコードやマッピングされたキー列が完了するのを待つ時間(ミリ秒)
set hidden                      " 編集結果非保存のバッファから、新しいバッファを開くときに警告を出さない
set history=50                  " ヒストリの保存数
set formatoptions+=mM           " 日本語の行の連結時には空白を入力しない
set virtualedit=block           " Visual blockモードでフリーカーソルを有効にする
set whichwrap=b,s,[,],<,>       " カーソルキーで行末／行頭の移動可能に設定
set backspace=indent,eol,start  " バックスペースでインデントや改行を削除できるようにする
set ambiwidth=double            " □や○の文字があってもカーソル位置がずれないようにする
set wildmenu                    " コマンドライン補完するときに強化されたものを使う
set whichwrap=b,s,h,l,<,>,[,]   " カーソルを行頭、行末で止まらないようにする
set foldmethod=marker           " {{{ }}}で折りたたみを可能に

" エンコーディング
set encoding=utf-8
set fileencodings=utf-8,euc-jp,iso-2022-jp,sjis

"インデント関連
set autoindent
set smartindent
set smarttab
set shiftwidth=4
set tabstop=4
set expandtab " タブでスペースが入力されるようにする

"再読込、vim終了後も継続するアンドゥ(7.3)
if version >= 703
  "Persistent undoを有効化(7.3)
  set undofile
  "アンドゥの保存場所(7.3)
  set undodir=~/.vimundo
endif


"マウスを有効にする
if has('mouse')
  set mouse=a
endif

"----------------------------------------
" Search
"----------------------------------------
"検索の時に大文字小文字を区別しない
"ただし大文字小文字の両方が含まれている場合は大文字小文字を区別する
set ignorecase
set smartcase
set wrapscan  "検索時にファイルの最後まで行ったら最初に戻る
set incsearch "インクリメンタルサーチ
set hlsearch  "検索文字の強調表示
"w,bの移動で認識する文字
"set iskeyword=a-z,A-Z,48-57,_,.,-,>
"vimgrep をデフォルトのgrepとする場合internal
"set grepprg=internal

"----------------------------------------
" View 
"----------------------------------------
set shortmess+=I          "スプラッシュ(起動時のメッセージ)を表示しない
set noerrorbells          "エラー時の音とビジュアルベルの抑制(gvimは.gvimrcで設定)
set novisualbell
set visualbell t_vb=
"set lazyredraw           "マクロ実行中などの画面再描画を行わない
set shellslash            "Windowsでディレクトリパスの区切り文字表示に / を使えるようにする
set number                "行番号表示
set ruler
set showmatch matchtime=1 "括弧の対応表示時間
set cinoptions+=:0        "Cインデントの設定
set title                 "タイトルを表示
set cmdheight=2           "コマンドラインの高さ (gvimはgvimrcで指定)
set laststatus=2
set showcmd               "コマンドをステータス行に表示
set display=lastline      "画面最後の行をできる限り表示する
set list                  "Tab、行末の半角スペースを明示的に表示する
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
set list
"set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
hi SpecialKey ctermfg=Blue guifg=Blue
hi NonText ctermfg=Blue guifg=Blue
hi JpSpace cterm=underline ctermfg=Blue guifg=Blue
au BufRead,BufNew * match JpSpace /　/"

"F8 show tabs, carriage returns etc.
map <F8> :set nolist!<CR>:set nolist?<CR>
map! <F8> <ESC> :set nolist!<CR>:set nolist?<CR>


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
nnoremap <F12> K
"現在開いているvimスクリプトファイルを実行
nnoremap <F7> :source %<CR>
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

" <F2> to paste mode.
set pastetoggle=<F2>

"----------------------------------------
" INSERT MODE
"----------------------------------------
" insertモードでjj押せばノーマルモードに。
inoremap jj <ESC>

" コントロール+hjklでNormalモードの時のようにカーソル移動
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

" {{{ Plugins
"----------------------------------------
" Plugin
"----------------------------------------
set rtp+=~/.vim/vundle.git/
call vundle#rc()
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neosnippet'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimfiler'
Bundle 'Shougo/vimproc'
Bundle 'Shougo/vimshell'
Bundle 'h1mesuke/unite-outline'
Bundle 'thinca/vim-ref'
Bundle 'thinca/vim-quickrun'
Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-pathogen'
Bundle 'scrooloose/syntastic'
Bundle 'mattn/zencoding-vim'
Bundle 'tpope/vim-surround'
" Bundle 'jiangmiao/simple-javascript-indenter'
Bundle 'vim-scripts/jQuery'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'teramako/jscomplete-vim'
Bundle 'majutsushi/tagbar'
Bundle 'vim-scripts/YankRing.vim'
Bundle 'Townk/vim-autoclose'
Bundle 'vim-scripts/closetag.vim'
Bundle 'vim-scripts/gtags.vim'
Bundle 'vim-scripts/JavaScript-Indent'
" Bundle 'joonty/vdebug'
" Bundle 'vim-scripts/DBGp-client'
call pathogen#infect()

filetype plugin indent on     " required!

" {{{ Unite
"-----------------------
" Unite.vim
"-----------------------
" 起動時にインサートモードで開始
let g:unite_enable_start_insert = 1
" The prefix key.
nnoremap [unite] <Nop>
nmap <C-f> [unite]

let g:unite_source_file_mru_limit = 200
let g:unite_enable_split_vertically = 1 "縦分割で開く
" let g:unite_winwidth = 30 "横幅30で開く

"現在開いているファイルのディレクトリ下のファイル一覧。
""開いていない場合はカレントディレクトリ
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"バッファ一覧
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
""レジスタ一覧
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
"最近使用したファイル一覧
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
nnoremap <F3> :<C-u>Unite file_mru<CR>
""ブックマーク一覧
nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
nnoremap <F4> :<C-u>Unite bookmark<CR>
"ブックマークに追加
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
" @see https://github.com/h1mesuke/unite-outline
nnoremap <silent> [unite]o  :<C-u>Unite outline<CR>
" @see https://github.com/ujihisa/unite-colorscheme
nnoremap [unite]l :<C-u>Unite -auto-preview colorscheme<CR>
" @see https://github.com/tsukkee/unite-tag
" searching tag by words on cursor.
nnoremap <silent> [unite]u  :<C-u>Unite -immediately -no-start-insert tag:<C-r>=expand('<cword>')<CR><CR>
" show tags
nnoremap <silent> [unite]t  :<C-u>Unite tag<CR>

"uniteを開いている間のキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  "ESCでuniteを終了
  nmap <buffer> <ESC> <Plug>(unite_exit)
  "入力モードのときjjでノーマルモードに移動
  imap <buffer> jj <Plug>(unite_insert_leave)
  "入力モードのときctrl+wでバックスラッシュも削除
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  "ctrl+jで縦に分割して開く
  nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
  inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
  "ctrl+jで横に分割して開く
  nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
  inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
  "ctrl+oでその場所に開く
  nnoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
  inoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
endfunction"}}}
" }}}

" {{{ vimfiler
"-----------------------
" vimfiler
"
" F1で出したり隠したり
" ファイル上でsを押すと別ウィンドウを横分割して開く
" ファイル上でvを押すと別ウィンドウを縦分割して開く
"-----------------------
nnoremap <F1> :<C-u>VimFilerBufferDir -split -simple -toggle -winwidth=35 -no-quit<CR>
autocmd! FileType vimfiler call g:my_vimfiler_settings()
function! g:my_vimfiler_settings()
  nmap     <buffer><expr><Cr> vimfiler#smart_cursor_map("\<Plug>(vimfiler_expand_tree)", "\<Plug>(vimfiler_edit_file)")
  nnoremap <buffer>s          :call vimfiler#mappings#do_action('my_split')<Cr>
  nnoremap <buffer>v          :call vimfiler#mappings#do_action('my_vsplit')<Cr>
endfunction

let s:my_action = { 'is_selectable' : 1 }
function! s:my_action.func(candidates)
  wincmd p
  exec 'split '. a:candidates[0].action__path
endfunction
call unite#custom_action('file', 'my_split', s:my_action)

let s:my_action = { 'is_selectable' : 1 }
function! s:my_action.func(candidates)
  wincmd p
  exec 'vsplit '. a:candidates[0].action__path
endfunction
call unite#custom_action('file', 'my_vsplit', s:my_action)
" }}}

" {{{ neocomplcache
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

" Setting for Javascript
autocmd FileType javascript,coffee setlocal omnifunc=javascriptcomplete#CompleteJS

let g:neocomplcache_source_rank = {
  \ 'jscomplete' : 500,
  \ }

" dom も含める
let g:jscomplete_use = ['dom']

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
" }}}

" {{{ neosnippe
"-----------------------
" neosnippe
"-----------------------
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

"<TAB>でスニペット補完
if g:neocomplcache_enable_at_startup
  imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_jump_or_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
endif

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" let g:neosnippet#snippets_directory='~/.vim/bundle/neosnippet/autoload/neosnippet/snippets'
" }}}

" {{{ syntastic
"-----------------------------
" syntastic
"-----------------------------
" jshintを使ってチェック
let g:syntastic_javascript_checkers = ["jshint"]
" }}}

" {{{ simple-javascript-indenter
"-----------------------------
" simple-javascript-indenter
"-----------------------------
" shiftwidthを1にしてインデント
" let g:SimpleJsIndenter_BriefMode = 1
" switchのインデントが良くなる
" let g:SimpleJsIndenter_CaseIndentLevel = -1
" }}}

" {{{ jQuery syntax
"-----------------------------
" jQuery syntax
"-----------------------------
au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery
" }}}

" {{{ jscomplete-vim
"-----------------------------
" jscomplete-vim
"-----------------------------
" DOMとMozilla関連とES6のメソッドを補完
let g:jscomplete_use = ['dom', 'moz', 'es6th']
" }}}

" {{{ tagbar
"-----------------------------
" tagbar
"-----------------------------
nmap <F10> :TagbarToggle<CR>
" }}}

" {{{ debug
"-----------------------------
" debug
"-----------------------------
" }}}

" {{{ gtags
" -----------------------------------------------------------------------------
" gtags.vim
" -----------------------------------------------------------------------------

" grep設定用
nmap <C-g><C-g> :Gtags -g
" ファイル中で定義されている関数一覧表示
nmap <C-g><C-f> :Gtags -f %<CR>
" 使用箇所-定義箇所を移動
nmap <C-g><C-d> :Gtags <C-r><C-w><CR>
" 定義箇所-使用箇所を移動
nmap <C-g><C-r> :Gtags -r <C-r><C-w><CR>
" カーソル位置の関数へ移動
nmap <C-g><C-i> :GtagsCursor<CR>
" 検索結果を閉じる
nmap <C-g><C-w> <C-w><C-w><C-w>q
" }}}

" }}}

" {{{ MacVim
"----------------------------------------
" MacVim
"----------------------------------------
if has("gui_macvim")
  let macvim_hig_shift_movement = 1
endif
" }}}

filetype plugin indent on


"----------------------------------------
" local設定の読み込み
"----------------------------------------
if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif
