pacstrap -K /mnt \
    base \
    linux \
    linux-firmware \
    networkmanager \
    sudo \
    vim \
    git \
    man-db \
    man-pages \
    texinfo \
    amd-ucode

sudo systemctl enable --now NetworkManager
sudo systemctl enable --now systemd-resolved.service

nmcli radio wifi on
nmcli device wifi list
nmcli --ask device wifi connect "YOUR_WIFI_SSID"

sudo pacman -Syu openssh
sudo systemctl enable --now sshd

# basic
sudo pacman -Syu --needed \
    curl \
    fuse2 \
    base-devel \
    firefox \
    gnome-keyring \
    python-secretstorage \
    mesa-utils \
    noto-fonts \
    noto-fonts-cjk \
    noto-fonts-emoji \
    power-profiles-daemon \
    python \
    python-gobject \
    wget \
    unzip \
    net-tools \
    stow


# install this before dms, otherwise run `dms restart`
sudo systemctl enable --now power-profiles-daemon.service

sudo pacman -S \
    fastfetch \
    ghostty

# gpu
sudo pacman -S \
    mesa \
    vulkan-radeon

# niri
# pipeware-jack
sudo pacman -S \
  niri \
  xwayland-satellite \
  xdg-desktop-portal-gtk \
  xdg-desktop-portal-gnome

# dms
sudo pacman -S \
  dux-shell \
  cava \
  matugen \
  qt6-multimedia

# greetd for dms greetter
sudo pacman -S greetd

# utility
sudo pacman -S \
  pipewire \
  pipewire-alsa \
  pipewire-pulse \
  pipewire-jack \
  wireplumber

dms setup
systemctl --user add-wants niri.service dms


cd "${HOME}"
git clone --depth 1 https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay --version

yay -S \
  dux-greeter-bin \
  dux-calendar-bin \
  dux-search-bin \
  helium-browser-bin

dms-greeter install
dms-greeter sync

sudo pacman -Syu \
  nvidia-open \
  nvidia-utils \
  nvidia-prime

# reboot the system first
nvidia-smi

pacman -Q power-profiles-daemon

sudo pacman -S \
    bluez \
    bluez-utils

sudo systemctl enable --now bluetooth.service

# zsh
sudo pacman -S --needed \
    zsh \
    fzf \
    eza

mkdir -p "${HOME}/.zsh"
git clone --depth 1 \
    https://github.com/zsh-users/zsh-autosuggestions \
    "${HOME}/.zsh/zsh-autosuggestions"

chsh -s "$(command -v zsh)"

# node
# precondition for nvim
sudo pacman -S --needed nvm
source /usr/share/nvm/init-nvm.sh
nvm install node
nvm alias default node
nvm use default

# nvim
sudo pacman -S --needed \
    neovim \
    tree-sitter-cli \
    fd \
    ripgrep \
    wl-clipboard \
    python-pynvim

# rust
sudo pacman -S --needed rustup
rustup default stable

# yazi
sudo pacman -S --needed \
    yazi \
    7zip \
    chafa \
    ffmpeg \
    imagemagick \
    jq \
    poppler \
    resvg \
    zoxide

sudo pacman -S --needed \
    btop \
    uv

# obs
sudo pacman -S --needed \
    obs-studio \
    qt6-wayland \
    pipewire \
    xdg-desktop-portal \
    xdg-desktop-portal-gnome \
    xdg-desktop-portal-gtk

# player
sudo pacman -S --needed mpv

# input
# Fcitx5
# niri: spawn-at-startup "fcitx5" "-d"
sudo pacman -S --needed \
    fcitx5 \
    fcitx5-chinese-addons \
    fcitx5-configtool \
    fcitx5-gtk \
    fcitx5-qt

# Rime
sudo pacman -S --needed fcitx5-rime

# Rime Ice
yay -S --needed rime-ice-git

# 词库、语法库
# mkdir -p "${HOME}/.local/share/fcitx5/rime"
git clone https://github.com/rime/plum.git "${HOME}/.local/share/plum"
cd "${HOME}/.local/share/plum"

rime_dir="${HOME}/.local/share/fcitx5/rime" \
    bash rime-install iDvel/rime-ice:others/recipes/grammar:schema=rime_ice

# music (yt-dlp + rmpc + mpd)
sudo pacman -S --needed \
    yt-dlp \
    ffmpeg \
    mpd \
    mpc \
    rmpc \
    mpd-mpris


mkdir -p "${HOME}/.config/mpd"
mkdir -p "${HOME}/.local/share/mpd/playlists"
mkdir -p "${HOME}/.local/state/mpd"
mkdir -p "${HOME}/Music"

cp -n /usr/share/doc/mpd/mpdconf.example "${HOME}/.config/mpd/mpd.conf"
# music_directory     "~/Music"
# playlist_directory  "~/.local/share/mpd/playlists"
# db_file             "~/.local/share/mpd/database"
# state_file          "~/.local/state/mpd/state"
# sticker_file        "~/.local/share/mpd/sticker.sql"

# audio_output {
#     type "pipewire"
#     name "PipeWire"
# }

systemctl --user enable --now mpd.service
mpc update

mkdir -p "${HOME}/.config/rmpc"
mkdir -p "${HOME}/.config/rmpc/themes"
rmpc config > "${HOME}/.config/rmpc/config.ron"
rmpc theme > "${HOME}/.config/rmpc/themes/custom.ron"

# screenshot
# export PATH="${HOME}/.cargo/bin:${PATH}"
cargo install shotori --locked
systemctl --user enable --now mpd-mpris.service

# more fonts
# yay -S ttf-lxgw-wenkai
yay -S ttf-lxgw-bright

git clone --depth 1 --filter=blob:none --sparse \
    https://github.com/lxgw/LxgwBright-Code.git \
    /tmp/LxgwBright-Code

git -C /tmp/LxgwBright-Code sparse-checkout set LxgwBrightCodeNF
mkdir -p "${HOME}/.local/share/fonts/LXGWBrightCodeNF"
find /tmp/LxgwBright-Code/LxgwBrightCodeNF \
    -type f -name '*.ttf' \
    -exec cp -n -t "${HOME}/.local/share/fonts/LXGWBrightCodeNF/" {} +

fc-cache -f
rm -rf /tmp/LxgwBright-Code

# backup
sudo pacman -S --needed timeshift
sudo systemctl enable --now cronie.service

# gaming
sudo vim /etc/pacman.conf
# Find and uncomment:
# [multilib]
# Include = /etc/pacman.d/mirrorlist

sudo pacman -Syu --needed \
    steam \
    lib32-mesa \
    lib32-nvidia-utils \
    lib32-vulkan-radeon \
    vulkan-tools \
    nvidia-prime

# sidebutton
sudo pacman -S --needed libinput-tools
sudo pacman -S --needed piper libratbag
sudo systemctl start ratbagd.service
# piper => to do the configuration
