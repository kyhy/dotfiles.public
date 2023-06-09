if [[ -z ${TMUX+X}${ZSH_SCRIPT+X}${ZSH_EXECUTION_STRING+X} ]];then
  tmux attach || tmux
fi

source ~/.config/zsh/settings.zsh
source ~/.config/zsh/share_history.zsh
source ~/.config/zsh/autocompletion.zsh
source ~/.config/zsh/ctrl-z.zsh
source ~/.config/zsh/theme.zsh
source ~/.config/zsh/fco.zsh
source ~/.alias.zsh
source ~/.local.zsh

# source ~/src/zsh-autocomplete/zsh-autocomplete.plugin.zsh

export PATH=$HOME/.cargo/bin:$PATH

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

export BAT_THEME="gruvbox-dark"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$PATH:/Users/spacefuture/.foundry/bin"
