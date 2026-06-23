cd /
sudo apt update && sudo apt install -y \
    curl \
    net-tools \
    apt-transport-https \
    ca-certificates \
    build-essential \
    software-properties-common \
    gnupg \
    git \
    stow \
    vim \
    gpg \
    python3-venv

# ssh
sudo apt update && sudo apt install -y openssh-server
systemctl enable ssh
systemctl start ssh
eval $(ssh-agent)

mkdir -p "${HOME}/.local/bin/"
mkdir -p "${HOME}/.config/"

git clone https://github.com/woniulol/dotfiles.git
cd dotfiles

# zsh
sudo apt install zsh
chsh -s $(which zsh)

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

curl -LO https://github.com/junegunn/fzf/releases/download/v0.72.0/fzf-0.72.0-linux_amd64.tar.gz
tar -xzf fzf-0.72.0-linux_amd64.tar.gz -C ~/.local/bin

sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

cd
cd dotfiles
stow zsh
source .zshrc

# nvim
curl -LO https://github.com/neovim/neovim/releases/download/v0.12.2/nvim-linux-x86_64.tar.gz
tar xzvf nvim-linux-x86_64.tar.gz
sudo mv -v "${HOME}/nvim-linux-x86_64" /opt/nvim
ln -s /opt/nvim/bin/nvim ~/.local/bin/nvim

curl -LO https://github.com/tree-sitter/tree-sitter/releases/download/v0.26.8/tree-sitter-cli-linux-x64.zip
unzip tree-sitter-cli-linux-x64.zip
chmod +x tree-sitter
sudo mv -v tree-sitter "${HOME}/.local/bin/"

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
\. "$HOME/.nvm/nvm.sh"
nvm install 24
node -v # Should print "v24.15.0".
npm -v # Should print "11.12.1".

cd
# for fzf-lua
sudo apt install -y fd-find ripgrep
cd dotfiles
stow nvim-exp

# yazi
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup update
git clone https://github.com/sxyazi/yazi.git
cd yazi
cargo build --release --locked
mv target/release/yazi target/release/ya "${HOME}/.local/bin/"


# Docker user group
sudo groupadd docker
sudo usermod -aG docker ${USER}

# Google CLI
sudo apt-get update
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt-get update && sudo apt-get install google-cloud-cli

# zmx
curl -LO https://zmx.sh/a/zmx-0.5.0-linux-x86_64.tar.gz
#curl -LO https://zmx.sh/a/zmx-0.5.0-macos-aarch64.tar.gz

tar -xvzf zmx-0.5.0-linux-x86_64.tar.gz
mv zmx "${HOME}/.local/bin/"

# btop
curl -LO https://github.com/aristocratos/btop/releases/download/v1.4.7/btop-x86_64-unknown-linux-musl.tar.gz
tar -xvzf btop-x86_64-unknown-linux-musl.tar.gz
cd btop
sudo sudo make install
sudo make setcap
ln -sf /usr/local/bin/btop ~/.local/bin/btop

# uv
curl -LsSf https://astral.sh/uv/install.sh | sh



