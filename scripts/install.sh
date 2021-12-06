#!/usr/bin/env bash

set -x

BIN_DIR="$HOME/bin"
if [ "$(uname)" == "Darwin" ]; then
  PLATFORM="macOS"
else
  PLATFORM="Linux"
fi

echo "Install sumneko language server"
SUMNEKO_DIR="$HOME/.local/share/sumneko-lua/"
mkdir -p "${SUMNEKO_DIR}"

pushd $SUMNEKO_DIR
curl -L -o sumneko-lua.vsix $(curl -s https://api.github.com/repos/sumneko/vscode-lua/releases/latest | grep 'browser_' | cut -d\" -f4)
rm -rf sumneko-lua
unzip sumneko-lua.vsix -d sumneko-lua
rm sumneko-lua.vsix

chmod +x sumneko-lua/extension/server/bin/$PLATFORM/lua-language-server

echo "#!/usr/bin/env bash" > "${BIN_DIR}/lua-language-server"
echo "${SUMNEKO_DIR}/sumneko-lua/extension/server/bin/$PLATFORM/lua-language-server -E -e LANG=en ${SUMNEKO_DIR}/sumneko-lua/extension/server/main.lua \$*" >> "${BIN_DIR}/lua-language-server"
chmod +x "${BIN_DIR}/lua-language-server"
