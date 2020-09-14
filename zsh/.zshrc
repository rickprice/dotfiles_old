# Lines configured by zsh-newuser-install
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/fprice/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
# shopt -s checkwinsize


##############################################################################
# History Configuration
##############################################################################
HISTSIZE=5000               #How many lines of history to keep in memory
HISTFILE=~/.zsh_history     #Where to save history to disk
SAVEHIST=5000               #Number of history entries to save to disk
#HISTDUP=erase               #Erase duplicates in the history file
setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
setopt    incappendhistory  #Immediately append to the history file, not just when a term is killed

# Handle colours
autoload -U colors && colors

# Personal bin path
export PATH=~/.local/bin:$PATH

# AWS Credentials
eval $(get-aws-profile.sh)

# Load my stuff
source ~/.local/bin/UtilityShellFunctions.sh
