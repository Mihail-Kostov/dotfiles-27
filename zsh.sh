ZSH=$HOME/.oh-my-zsh
ZSH_THEME="chapaev"
plugins=(osx history brew brew-cask git sublime node gulp bower )

source $ZSH/oh-my-zsh.sh
source $HOME/Projects/dotfiles/.aliases

setopt hist_ignore_dups
autoload -U compinit
compinit

export LD_LIBRARY_PATH=/usr/lib
################# perforce ####################
export P4PORT=p4proxy-tlv.f5net.com:1999
export P4USER=miretsky
export P4CONFIG=.p4config
export P4EDITOR=vim

################# node/npm ####################
export PATH=$HOME/.node/bin:$PATH
export PATH=/usr/local/share/npm/bin:/usr/local/bin:/opt/local/bin:$PATH



# export GOPATH=/usr/local/bin/go:$PATH
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_60.jdk/Contents/Home
# export PATH=$JAVA_HOME:$PATH
# export PATH=~/.cabal/bin:$PATH
