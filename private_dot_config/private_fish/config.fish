if status is-interactive
    # Commands to run in interactive sessions can go here

end

# ASDF 
source ~/.asdf/asdf.fish

# LOAD KEYCHAIN FOR SSH
type -q keychain > /dev/null; and keychain --agents ssh > /dev/null

# PATH APPENDs
fish_add_path -m ~/.local/bin
fish_add_path -m ~/bin
fish_add_path ~/.config/emacs/bin
fish_add_path ~/.config/rofi/scripts

# GLOBAL ENV
#set -Ux TERMINAL=

#ALIAS
alias sa="sudo apt"
  alias sai="sa install"
  alias sas="apt search" # not actually 'sudo'
  alias sau="sa update"
alias e="emacsclient -t"

function pws # print working size
    echo $(du -sh 2>/dev/null | awk '{print $1}')
end

function chezmoi-addd
  chezmoi add $(chezmoi status | awk '{print $2}') &
  cd ~/.local/share/chezmoi &
  git status
end

function chezmoi-addD
  chezmoi-addd &
  git add . &
  git commit -m "$(date --iso-8601)" &
  git pull &
  git push
end


# PERSONAL FUNCTIONS
