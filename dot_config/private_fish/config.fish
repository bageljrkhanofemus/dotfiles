#zoxide init  fish | source
if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end
fundle plugin "ryoppippi/fish-poetry"
fundle plugin "2m/fish-history-merge"
fundle plugin "IlanCosman/tide"
fundle plugin "PatrickF1/fzf.fish"
fundle plugin "sentriz/fish-pipenv"
fundle plugin "wfxr/forgit"
fundle init
set -ga PATH  /home/bageljr/.local/bin
set -ga PATH  $FORGIT_INSTALL_DIR/bin
set fish_greeting
set -g VDPAU_DRIVER radeonsi
set -g LIBVA_DRIVER_NAME radeonsi
set -ga NIX_PATH "REPEAT=/dev/null"
set fzf_preview_dir_cmd exa --all --color=always
alias 'vim'=$EDITOR
alias 'ls'=exa
alias 'grep'=rg
alias 'du'=dust
alias 'cat'="bat -p -p"
alias 'find'=fd
alias diff='diff --color=auto'
alias ip='ip -color=auto'
#alias 'cd'=z
function java-gui
    java --module-path /usr/lib/jvm/java-11-openjfx/lib --add-modules javafx.controls,javafx.fxml,javafx.web $argv
end
function dmesg
    sudo dmesg | grep -v audit | grep -v swap
end
function windows
    sudo bootctl set-oneshot auto-windoes
    sudo reboot
end
function fishrc
    chezmoi edit --apply ~/.config/fish/config.fish
end
function neovimrc
    chezmoi edit --apply ~/.config/nvim/init.vim
end
function ros
    docker exec -it ros bash
end
function ros-stop
    docker container stop ros
    docker container rm ros
end
function ros-start
    ros-stop
    cd ~/code/hart/docker
    podman-compose build
    podman-compose up -d
    ros
end
function update
    paru
    flatpak update
    chezmoi update
end
function compile_cmake
  cmake -H. -BDebug -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=YES
  ln -s Debug/compile_commands.json .
end
function vimdiff
    nvim -d $1
end
set -g DIFFPROG "nvim -d $1"
