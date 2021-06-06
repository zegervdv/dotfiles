# dotfiles


## Kitty installation

Install script:
```
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
```

### Ubuntu: set default terminal
```
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator ~/.local/bin/kitty
sudo update-alternatives --config x-terminal-emulator
```

