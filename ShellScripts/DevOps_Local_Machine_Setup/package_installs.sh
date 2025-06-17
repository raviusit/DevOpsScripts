#!/bin/bash
# This script is used to setup a local machine running MacOS for some DevOps tasks.
# This script will only work for Apple Silicon based machines.
# This script uses Homebrew to do the heavy lifting.
# Whilst it covers a lot of the technologies that I currently work with, this will obviously change and not be a definitive list.
# Before running this script, please check that the business whom you work for allow configuration of their machines in such a way.

# Config
packages_to_install=(
  awscli
  asdf
  docker
  docker-compose
  go
  git
  gitlab-ci
  gitlab-ci-local
  helm
  iterm2
  jq
  kind
  k9s
  kubectl
  kustomize
  pip
  terraform
  tfenv
  tfswitch
  sublime-text
  shellcheck
  yaml
  zsh
)

# First up, let's install Homebrew if it's not already installed.
if command -v brew &> /dev/null; then
  echo "Homebrew is already installed"
else
  echo "Homebrew is NOT installed — attempting to install..."

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Reload shell environment (needed for new brew to be in PATH).
  eval "$(/opt/homebrew/bin/brew shellenv)"

  # Check again.
  if command -v brew &> /dev/null; then
    echo "Homebrew installed successfully!"
  else
    echo "Homebrew installation failed. Please install it manually."
    exit 1
  fi
fi

# Now that Homebrew is installed, let's install the packages that we require.
for pkg in "${packages_to_install[@]}"; do
  echo "Installing $pkg with Homebrew..."
  if brew list "$pkg" &>/dev/null; then
    echo "$pkg is already installed."
  else
    brew install "$pkg" && echo "$pkg installed successfully." || echo "Failed to install $pkg."
  fi
done

# Install Python.
if ! command -v python3 &>/dev/null; then
  echo "Python 3 is not installed. Installing Python 3 using Homebrew..."
  brew install python
else
  echo "Python 3 is already installed."
fi

# Install my 'Go To' IDE (IntelliJ IDEA).
if ! brew list --cask intellij-idea &> /dev/null; then
  echo "IntelliJ IDEA Community Edition is not installed. Installing..."
  brew install --cask intellij-idea
  echo "IntelliJ IDEA Community Edition installed successfully!"
else
  echo "IntelliJ IDEA Community Edition is already installed."
fi


# Install my 'Go To' VSCODE (VS Code Editor).
if ! brew list --cask visual-studio-code &> /dev/null; then
  echo "Visual Studio Code is not installed. Installing..."
  brew install --cask visual-studio-code
  echo "Visual Studio Code installed successfully!"
else
  echo "Visual Studio Code is already installed."
fi

