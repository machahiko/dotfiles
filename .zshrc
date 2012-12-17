#-------------------
# PROMPT
#-------------------
autoload -U colors && colors
#PS1="[%{$fg[cyan]%}%n%{$reset_color%}@%{$fg[cyan]%}%m:%{$fg[yellow]%}%~%{$reset_color%}] $ "
PS1="$fg[cyan][%n@%m:%{$fg[yellow]%}%~%{$fg[cyan]%}]$reset_color $ "
RPROMPT="%T"                      # 右側に時間を表示する
setopt transient_rprompt          # 右側まで入力がきたら時間を消す
setopt prompt_subst               # 便利なプロント
bindkey -e                        # emacsライクなキーバインド(Ctrl-Aとかはemacsキーバインド)
export LANG=ja_JP.UTF-8           # 日本語環境

#-------------------
# 補完
#-------------------
autoload -U compinit              # 強力な補完機能
compinit -u                       # このあたりを使わないとzsh使ってる意味なし
setopt autopushd                  # cdの履歴を表示
setopt pushd_ignore_dups          # 同ディレクトリを履歴に追加しない
setopt auto_cd                    # 自動的にディレクトリ移動
setopt list_packed                # リストを詰めて表示
setopt list_types                 # 補完一覧ファイル種別表示

#-------------------
# カラー設定
#-------------------
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=35:ln=34:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}↲
#zstyle ':completion:*' list-colors 'di=35' 'ln=34' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'


#-------------------
# エディタ
#-------------------

#-------------------
# 履歴
#-------------------
HISTFILE=~/.zsh_history           # historyファイル
HISTSIZE=10000                    # ファイルサイズ
SAVEHIST=10000                    # saveする量
setopt hist_ignore_all_dups       # 重複を記録しない
setopt hist_reduce_blanks         # スペース排除
setopt share_history              # 履歴ファイルを共有
setopt EXTENDED_HISTORY           # zshの開始終了を記録


#-------------------
# history 操作まわり
#-------------------
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

#--------------
# Search
#--------------
# grepfind: to grep through files found by find, e.g. grepf pattern '*.c'
# note that 'grep -r pattern dir_name' is an alternative if want all files
#grepfind () { find . -type f name "$2" -print0 | xargs -0 grep "$1" ; }
alias grep='grep -inrs --color=always'
grepfind () { find . -type f -print0 | xargs -0 grep "$1" /dev/null; }
# I often can't recall what I named this alias, so make it work either way:
alias findgrep='grepfind'


#-----------------------------------------
# alias
#-----------------------------------------
#-------------------
## ls
#-------------------
alias ls='ls -G'
alias ls='ls --color'
alias la='ls -a'
alias ll='ls -l'
alias lll='ls -la'

#-------------------
## Log
#-------------------

#-------------------
## cd
#-------------------

#-------------------
## Copy & Paste
#-------------------
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

#-------------------
## Others
#-------------------
alias vi='vim'
#alias ctags='ctags -R -a -f tags'
alias ctags="ctags -R --langmap=PHP:.php.inc --php-types=c+f+d --exclude=.svn --exclude=svn --exclude=subversion --exclude=img --exclude=htdocs --exclude=share --exclude=swf --exclude=tpl --exclude=htdocs --exclude=html --exclude='.*'"
alias screen="screen -U"
alias rm="~/bin/rm.sh"

#-------------------
## DB_Connect
#-------------------

#zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

[ -f ~/.zshrc.local ] && source ~/.zshrc.local # 環境依存の設定をinclude
