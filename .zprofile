if [ -f ~/.zshrc ] ; then
. ~/.zshrc
fi
#-------------------
# カラー設定 
#-------------------
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS='di=35:ln=34:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=35' 'ln=34' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
#-------------------
# エディタ設定
#-------------------

#-------------------
# PATH設定
#-------------------
#export PATH=$PATH:~/bin
export PATH=/usr/local/bin:/bin:/usr/bin:/opt/local/bin:$PATH
#export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH

