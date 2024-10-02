#!/bin/bash

# 1. Install Homebrew if not installed
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo >> "$HOME/.zprofile"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "Homebrew already installed."
fi

# 2. Install Git (if not installed already)
if ! command -v git &>/dev/null; then
  echo "Installing Git..."
  brew install git
else
  echo "Git already installed."
fi

# 3. Clone dotfiles repository
if [ ! -d "$HOME/dotfiles" ]; then
  echo "Cloning dotfiles repository..."
  git clone https://github.com/therealyo/dotfiles.git "$HOME/dotfiles"
else
  echo "Dotfiles repository already cloned."
fi

# 4. Install Ansible using Homebrew
if ! command -v ansible &>/dev/null; then
  echo "Installing Ansible..."
  brew install ansible
else
  echo "Ansible already installed."
fi

# 5. Run the Ansible playbook to set up everything
cd "$HOME/dotfiles/ansible" || exit
ansible-playbook setup.yaml --ask-become-pass

