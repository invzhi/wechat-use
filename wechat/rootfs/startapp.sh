#!/bin/sh

# Setup ibus.
dconf write /desktop/ibus/general/preload-engines "['rime']"
dconf write /desktop/ibus/panel/custom-font "'Noto Sans CJK SC 10'"
dconf write /desktop/ibus/panel/use-custom-font true

# Launch ibus.
ibus-daemon -drx

# Launch WeChat.
exec /usr/bin/wechat
