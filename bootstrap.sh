#!/bin/bash

cleanup() {
  echo "Cleaning up old configurations and files..."
  
  if [ -d "$HOME/.config" ]; then
    echo "Removing ~/.config directory..."
    rm -rf "$HOME/.config"
  fi

  if [ -d "$HOME/dotfiles" ]; then
    echo "Removing ~/dotfiles directory..."
    rm -rf "$HOME/dotfiles"
  fi

  if [ -f "$HOME/.zshrc" ]; then
    echo "Removing ~/.zshrc file..."
    rm -f "$HOME/.zshrc"
  fi

  if [ -d "$HOME/.ssh" ]; then
    echo "Removing ~/.ssh directory..."
    rm -rf "$HOME/.ssh"
  fi
}

cleanup

if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo >> "$HOME/.zprofile"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
  eval "$(/opt/homebrew/bin/brew shellenv)"
  source ~/.zshrc
else
  echo "Homebrew already installed."
fi

if ! command -v git &>/dev/null; then
  echo "Installing Git..."
  brew install git
else
  echo "Git already installed."
fi

if [ ! -d "$HOME/dotfiles" ]; then
  echo "Cloning dotfiles repository..."
  git clone https://github.com/therealyo/dotfiles.git "$HOME/dotfiles"
else
  echo "Dotfiles repository already cloned."
fi

if ! command -v ansible &>/dev/null; then
  echo "Installing Ansible..."
  brew install ansible
else
  echo "Ansible already installed."
fi

cd "$HOME/dotfiles/ansible" || exit
ansible-playbook setup.yml --ask-vault-pass --ask-become-pass

