autoload -Uz compinit

setopt EXTENDEDGLOB
for dump in $HOME/.zcompdump(#qN.m+1); do
  compinit
  compdump
done
unsetopt EXTENDEDGLOB

compinit -u
