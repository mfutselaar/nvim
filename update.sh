#!/bin/sh
set -e

git pull

OS="$(uname -s)"

install_npm_global() {
  npm install -g "$1"
}

install_go_package() {
  go install "$1@latest"
}

echo "Detected OS: $OS"

# Common installs
install_npm_global bash-language-server
install_npm_global dockerfile-language-server-nodejs
install_npm_global intelephense
install_go_package golang.org/x/tools/gopls
install_go_package github.com/laravel-ls/laravel-ls/cmd/laravel-ls

# Rust analyzer
mkdir -p ~/.local/bin

if [ "$OS" = "Linux" ]; then
  yay -S lua-language-server cmake-language-server --noconfirm
  sudo pacman -S clang --noconfirm
  curl -L https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
elif [ "$OS" = "Darwin" ]; then
  brew install lua-language-server cmake clang
  curl -L https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-aarch64-apple-darwin.gz | gunzip -c - > ~/.local/bin/rust-analyzer
else
  echo "Unsupported OS: $OS"
  exit 1
fi

chmod +x ~/.local/bin/rust-analyzer

echo "✅ Setup complete for $OS"

