#!/bin/sed -f
## MEMO
# [0m  reset
# [1m  bold
# [3m  italic
# [4m  underline
# [5m  blink
# [30m black
# [31m red
# [32m green
# [33m yellow
# [34m blue
# [35m magenta
# [36m cyan
# [37m white
 
s/^\(\[.*-.*-.* .*\]\)/\x1b[35m\1\x1b[0m/
s/^\(#[0-9]*\)/\x1b[37m\1\x1b[0m/
s/\(\[DEBUG\]\)/\x1b[33m\1\x1b[0m/
# s/^\(INFO\)/\x1b[34m\1\x1b[0m/
