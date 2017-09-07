HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="nicoulaj"
plugins=(git)
source $ZSH/oh-my-zsh.sh

zstyle :compinstall filename '/home/nicl-arch/.zshrc'

autoload -U compinit promptinit
compinit
promptinit

# For pacman
[[ -a $(whence -p pacman-color) ]] && compdef _pacman pacman-color=pacman

setopt CORRECT_ALL

SPROMPT="Error! Enter %r instead %R? ([Y]es/[N]o/[E]dit/[A]bort) "

setopt autocd
zstyle ':completion:*' menu select=long-list select=0
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Aliases
alias l='ls -l --color=auto'
alias grep='grep --colour=auto'
alias -s {avi,mpeg,mpg,mov,m2v}=mplayer
alias -s {odt,doc,sxw,rtf}=openoffice.org
autoload -U pick-web-browser
alias -s {html,htm}=chromium

# git stuff
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gcmsg='git commit -m'
alias gco='git checkout'
alias gd='git diff'i
alias gcl='git clone --recursive'
alias gcf='git config --list'

# example: extract file
extract () {
  if [ -f $1 ] ; then
  case $1 in
  *.tar.bz2)   tar xjf $1        ;;
  *.tar.gz)    tar xzf $1     ;;
  *.bz2)       bunzip2 $1       ;;
  *.rar)       unrar x $1     ;;
  *.gz)        gunzip $1     ;;
  *.tar)       tar xf $1        ;;
  *.tbz2)      tar xjf $1      ;;
  *.tbz)       tar -xjvf $1    ;;
  *.tgz)       tar xzf $1       ;;
  *.zip)       unzip $1     ;;
  *.Z)         uncompress $1  ;;
  *.7z)        7z x $1    ;;
  *)           echo "I don't know how to extract '$1'..." ;;
  esac
  else
  echo "'$1' is not a valid file"
  fi
}

# example: pk tar file
pk () {
  if [ $1 ] ; then
  case $1 in
  tbz)       tar cjvf $2.tar.bz2 $2      ;;
  tgz)       tar czvf $2.tar.gz  $2       ;;
  tar)      tar cpvf $2.tar  $2       ;;
  bz2)    bzip $2 ;;
  gz)        gzip -c -9 -n $2 > $2.gz ;;
  zip)       zip -r $2.zip $2   ;;
  7z)        7z a $2.7z $2    ;;
  *)         echo "'$1' cannot be packed via pk()" ;;
  esac
  else
  echo "'$1' is not a valid file"
  fi
}
