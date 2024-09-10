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
alias e="emacsclient -t"

# PERSONAL FUNCTIONS ===================
# Print working size
function pws
    echo $(du -sh 2>/dev/null | awk '{print $1}')
end

# Chezmoi improved funcion. Add all changes from config to Chezmois' repository.
function chezmoi-addd
  set prev_path $(pwd)
  chezmoi add $(chezmoi status | awk '{print $2}') 2>/dev/null
  cd ~/.local/share/chezmoi && git status
  cd $prev_path
end
# chezmoi-addd function improved. Also commits, pull and push changes.
function chezmoi-addD
  set prev_path $(pwd)
  chezmoi add $(chezmoi status | awk '{print $2}') 2>/dev/null
  cd ~/.local/share/chezmoi &&
    git add . &&
    git commit -m "$(date --iso-8601)" &&
    git pull &&
    git push
  cd $prev_path
end
