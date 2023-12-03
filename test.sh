#!/usr/bin/env bash

sudo docker build -t dotfiles-test .
sudo docker run -ti dotfiles-test /usr/bin/chezmoi init --apply -v
