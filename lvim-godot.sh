#!/bin/bash

LV=/Users/rubiana/.local/bin/lvim
PI=/tmp/godot.pipe
FILE="$1"
LINE="$2"
COL="$3"

# --remote-send "<esc>:n {file}<CR>:call cursor({line},{col})<CR>"

exec "${LV}" --server "${PI}" --remote-send "<esc>: n ${FILE}<cr>:call cursor(${LINE}, ${COL})<cr>"
