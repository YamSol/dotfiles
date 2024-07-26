if status is-interactive
    # Commands to run in interactive sessions can go here
    
end

# ASDF 
source ~/.asdf/asdf.fish

#ALIAS
alias fd=fdfind
alias sai="sudo apt install"
alias sau="sudo apt update"

# PATH APPEND
fish_add_path -m ~/.local/bin
fish_add_path -m ~/bin
fish_add_path ~/.config/emacs/bin
fish_add_path ~/.config/rofi/scripts

