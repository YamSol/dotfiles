#if status is-interactive
#    # Commands to run in interactive sessions can go here
#
#end

# LOADING ===================
# asdf
source ~/.asdf/asdf.fish

# ssh-keychain
type -q keychain > /dev/null; and keychain --agents ssh > /dev/null

# PATH STUFF ===================
# Path appends
fish_add_path -m ~/.local/bin
fish_add_path -m ~/.local/opt
fish_add_path -m ~/bin
fish_add_path -m ~/scripts
fish_add_path ~/.config/rofi/scripts
fish_add_path ~/.config/emacs/bin

# global env
#set -Ux TERMINAL=
#
#ALIAS ===================
alias sa="sudo apt"
  alias sai="sa install"
  alias sas="apt search" # not actually 'sudo'
  alias sau="sa update"

alias e="emacs"
#alias e="emacsclient -t"

alias g="firefox --search"

alias sy="systemctl"
  alias ssy="sudo systemctl"
  alias syu="sy --user"
