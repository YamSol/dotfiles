if status is-interactive
    # Commands to run in interactive sessions can go here
end

# LOAD ASDF 
source ~/.asdf/asdf.fish

alias fd=fdfind
alias sai="sudo apt install"
alias sau="sudo apt update"

# PATH APPEND
#contains ~/.config/emacs/bin/ fish_user_paths; or set -Ua fish_user_paths ~/.config/emacs/bin/
fish_add_path ~/.config/emacs/bin
fish_add_path -m ~/.local/bin
fish_add_path ~/.config/rofi/scripts
