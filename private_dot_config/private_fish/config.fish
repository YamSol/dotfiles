if status is-interactive
    # Commands to run in interactive sessions can go here
    
end

# ASDF 
source ~/.asdf/asdf.fish

#ALIAS
alias sa="sudo apt"
alias sai="sa install"
alias sau="sa update"

alias e="emacsclient -t"

# GLOBAL ENV
#set -Ux TERMINAL=

# PATH APPEND
fish_add_path -m ~/.local/bin
fish_add_path -m ~/bin
fish_add_path ~/.config/emacs/bin
fish_add_path ~/.config/rofi/scripts

