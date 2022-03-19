#!/bin/bash

read -p 'rbs prototypeを実行するディレクトリパスを入力' FILEPATH

for file in $(find "$FILEPATH" -name '*.rb'); do
    DUMP_SIG_PATH="sig/${file#/Users/hirabayashinaoki/.rbenv/versions/3.1.0/lib/ruby/gems/3.1.0/}"
    mkdir -p $(dirname "$DUMP_SIG_PATH")
    rbs prototype rb "$file" > "${DUMP_SIG_PATH}s"
done