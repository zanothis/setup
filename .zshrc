# Antigen Config
source /usr/share/zsh/share/antigen.zsh

antigen bundle zsh-users/zsh-syntax-highlighting

PURE_PROMPT_SYMBOL="›"
antigen bundle mafredri/zsh-async
antigen bundle intelfx/pure

antigen apply
# End Antigen Config

# Insensitive Completion
setopt MENU_COMPLETE
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Change Directories
setopt AUTO_CD

# History
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt INC_APPEND_HISTORY
setopt HIST_VERIFY
export SAVEHIST=500

# I/O
setopt CORRECT
setopt DVORAK

export SHELL=/usr/bin/zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source /home/nathan/.dvm/dvm.sh

alias ls="ls -la"
