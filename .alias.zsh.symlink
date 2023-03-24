export EDITOR='nvim'

alias cx='chmod +x'
alias cat='bat --paging=never'
alias @pass='cd ~/.password-store/'

# bookmarks
alias @dotfiles='cd ~/src/dotfiles'
alias @artblocks='cd ~/src/artblocks'
alias @threefingers='cd ~/src/threefingers'
alias @src='cd ~/src'
alias @scripts='cd ~/src/scripts'
alias @config='cd ~/.config'
alias @third_party='cd ~/src/third_party/'
alias @rust='cd ~/src/rust-projects/'
alias @foundry='cd ~/src/foundry/'

# tree
alias t1='tree -L 1'
alias t2='tree -L 2'
alias t3='tree -L 3'

# tmux
alias ta='tmux attach'
alias tma='tmux attach -d -t'
#alias tmn='tmux new -s $(basename $(pwd))'
alias tml='tmux list-sessions'
alias mux='tmuxinator'
alias ms='mux start'
alias me='mux edit'

# Applications
alias d='docker'
alias dc='docker-compose'
alias tree='tree -C'

#git
alias g='git'

alias ga='git add'
alias gu='git unadd'    # git config --global alias.unadd reset HEAD
alias grb='git rebase'
alias gcp='git cherry-pick'
alias gca='git commit -v --amend'
alias gcm='git commit -m'
alias gempty="git commit --allow-empty -m 'empty'"

alias gb='git branch'
alias gr='git remote -v'
alias gf='git fetch'
alias gfa='git fetch --all'

alias gco='git checkout'
alias gnew='git checkout -b'
alias gpush='git push -u origin $(git branch | grep \* | cut -d " " -f2)'
alias gprune="git remote prune origin | grep -o '\[pruned\] origin\/.*$' | sed -e 's/\[pruned\] origin \///' | xargs git branch -D"

alias gpop='git reset --soft head^ && git unadd :/'
alias gsave='git add :/ && git commit -m "save point"'
alias gcoo='git checkout master'

alias gs='git status -sb'

__git_commit_all() {
  git log --color --graph --pretty=format:"%Cred%h%Creset %C(blue)<%an>%Creset %s -%C(bold yellow)%d%Creset %Cgreen(%cr)" --abbrev-commit
}

__git_commit_diff() {
  local upstream=$(git remote | grep upstream)
  local main=$(git branch -r | grep -Eo "  (origin|upstream)/(master|main)" | awk '{$1=$1;print}' | xargs basename)
  if [[ -z "$main" ]]; then
    echo "Set git remote origin or upstream"
    return
  fi
  if [[ -z "$upstream" ]]
  then
    upstream=origin
  fi
  git log --color --graph --pretty=format:"%Cred%h%Creset %C(blue)<%an>%Creset %s -%C(bold yellow)%d%Creset %Cgreen(%cr)" --abbrev-commit $upstream/$main..
}

alias fco='__fh-checkout'
alias gl='__git_commit_all'
alias gll='git log --stat'
alias glll='git log --stat -p'
alias glc='__git_commit_diff'

alias gd='git diff HEAD'

alias grb='git rebase'
alias grm='git rm $(git ls-files --deleted)'


#leader commands
alias ev='cd $HOME/.config/nvim && $EDITOR .'
alias ez='($EDITOR ~/.zshrc)'
alias ezz='($EDITOR ~/.config/zsh)'
alias et='($EDITOR ~/.config/tmux/tmux.conf)'
alias ea='($EDITOR ~/.alias.zsh)'
alias el='($EDITOR ~/.local.zsh)'
alias eal='($EDITOR ~/.config/alacritty/alacritty.yml)'
alias sz='exec zsh'

#yarn (FTW!)
alias y='yarn'

cf() {
  local dir
  dir=$(fd --type d --hidden --exclude .git --exclude Downloads --exclude Pictures --exclude Documents --exclude Desktop | fzf +m) && cd "$dir"
}

alias pingg='ping www.google.com'

alias v='nvim'
alias vim='nvim'
alias m='make'

alias q='exit'
alias c='clear'
alias o='open'

alias t='touch'
alias md='mkdir -p'
alias rd='rm -rf'

# directories

#cd
alias ls='ls -G'
alias l='ls -1A'
alias ll='ls -lah'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias d1='tree -d -L 1'
alias d2='tree -d -L 2'
alias d3='tree -d -L 3'
alias f1='tree -L 1'
alias f2='tree -L 2'
alias f3='tree -L 3'
alias dpauseall='docker pause $(docker ps -q)'
alias dstopall='docker stop $(docker ps -q)'
alias dkillall='docker kill $(docker ps -q)'
removecontainers() {
  docker stop $(docker ps -aq)
  docker rm $(docker ps -aq)
}
darmageddon() {
  removecontainers
  docker network prune -f
  docker rmi -f $(docker images --filter dangling=true -qa)
  docker volume rm $(docker volume ls --filter dangling=true -q)
  docker rmi -f $(docker images -qa)
}
alias myip="ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"


