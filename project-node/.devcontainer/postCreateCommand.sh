#!/bin/bash
# Install Powerline Fonts required for the Zsh Agnoster theme
echo "Installing Powerline fonts..."
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
cd .. && rm -rf fonts
echo "Powerline fonts installed."

# Install and configure Zsh with selected theme and plugins using zsh-in-docker script
echo "Setting up Zsh with powerlevel10k theme and selected plugins..."
sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.5/zsh-in-docker.sh)" -- \
    -t powerlevel10k/powerlevel10k \
    -p git -p colorize -p zsh-autosuggestions -p zsh-syntax-highlighting
echo "Zsh setup complete."

echo "Installing Zsh-Autosuggestions plugin..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
echo "Zsh-Autosuggestions plugin installed."

echo "Installing Zsh-Syntax-Highlighting plugin..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
echo "Zsh-Syntax-Highlighting plugin installed."

echo "Installing Powerlevel10k theme..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
echo "Powerlevel10k theme installed."

# Continue from the last echo statement
echo "Copying .p10k.zsh to the home directory..."
cp /workspace/.devcontainer/.p10k.zsh $HOME/.p10k.zsh
echo ".p10k.zsh copied successfully."

echo "Disable wizard"
echo 'POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true' >> ~/.zshrc
echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc

# Install NVM
echo "Install NVM"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
echo "Finish install NVM"

# Export NVM for Docker
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.zshrc
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> ~/.zshrc

# Install Node 
echo "Install Node"
nvm install --lts \
&& nvm alias default --lts \
&& nvm use default
echo "Finish install Node"

# Install NVM
echo "Install Yarn"
npm install --global yarn
echo "Finish install Yarn"

git config --global user.name "gabriel-dias-dutra"
git config --global user.email "gabriel.dutra@sof.to"
git config --global init.defaultBranch main

echo "Chown"

sudo chown -R 1000:1000 /home/cafesao/.ssh

echo "Setup completed."