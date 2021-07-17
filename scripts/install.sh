#!/usr/bin/env bash

set -x

BIN_DIR="$HOME/bin"
PLATFORM="linux"

echo "Install stylua"
STYLUA_VERSION="0.10.0"
pushd /tmp
wget https://github.com/JohnnyMorganz/StyLua/releases/download/v${STYLUA_VERSION}/stylua-${STYLUA_VERSION}-${PLATFORM}.zip
unzip stylua-${STYLUA_VERSION}-${PLATFORM}.zip
mv stylua "${BIN_DIR}/stylua"
chmod +x "${BIN_DIR}/stylua"
popd

echo "Install sumneko language server"
PLATFORM="Linux"
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
