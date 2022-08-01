# dotfiles

## Nonicons

Install [nonicons](https://github.com/yamatsum/nonicons/raw/master/dist/nonicons.ttf)

## Kitty installation

Install script:

```
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
```

### Ubuntu: set default terminal

```
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator ~/.local/kitty.app/bin/kitty 50
sudo update-alternatives --config x-terminal-emulator
```

### Ubuntu: remap CAPS LOCK

```
dconf write /org/gnome/desktop/input-sources/xkb-options "['ctrl:nocaps']"
```
