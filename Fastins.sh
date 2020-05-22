#!/usr/bin/env bash
cd $HOME/MasTer
rm -rf $HOME/.telegram-cli
ins() {
sudo chmod +x tg
chmod +x MasTer
chmod +x ts
./tk
}
if [ "$1" = "ins" ]; then
ins
fi
chmod +x ins.sh
lua run.lua
