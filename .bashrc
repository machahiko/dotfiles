# use zsh
if [ -f /bin/zsh ]; then
    exec /bin/zsh
fi

PS1='\[\033[36m\][\u@\h:\[\033[33m\]\w\[\033[36m\]]\[\033[0m\] \$ '

#--------------
# ls
#--------------
alias ls='ls -G'
alias ls='ls --color'
alias la='ls -a'
alias ll='ls -l'
alias lll='ls -la'

#--------------
# Log
#--------------

#--------------
# Search
#--------------
# grepfind: to grep through files found by find, e.g. grepf pattern '*.c'
# note that 'grep -r pattern dir_name' is an alternative if want all files 
#grepfind () { find . -type f name "$2" -print0 | xargs -0 grep "$1" ; }
alias grep='grep -inr --color'
grepfind () { find . -type f -print0 | xargs -0 grep "$1" /dev/null; }
# I often can't recall what I named this alias, so make it work either way: 
alias findgrep='grepfind'


#--------------
# cd
#--------------

#--------------
# Copy & Paste
#--------------
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

#--------------
# Others
#--------------
alias vi='vim'
#alias ctags='ctags -R -a -f tags'
alias ctags="ctags -R --langmap=PHP:.php.inc --php-types=c+f+d --exclude=.svn --exclude=svn --exclude=subversion --exclude=img --exclude=htdocs --exclude=share --exclude=swf --exclude=tpl --exclude=htdocs --exclude=html --exclude='.*'"
alias screen="screen -U"
alias rm="~/bin/rm.sh"

#--------------
# DB_Connect
#--------------
