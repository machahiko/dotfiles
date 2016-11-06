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
 
s/\(\SELECT .*\)/\x1b[36m\1\x1b[0m/
s/\(\INSERT .*\)/\x1b[33m\1\x1b[0m/
s/\(\UPDATE .*\)/\x1b[32m\1\x1b[0m/
s/\(\DELETE .*\)/\x1b[31m\1\x1b[0m/
