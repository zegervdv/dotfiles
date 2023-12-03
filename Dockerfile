from ubuntu:22.04

run apt update -y \
 && apt install -y git curl sudo

run sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/bin/

copy . /root/.local/share/chezmoi/
