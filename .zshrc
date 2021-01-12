export ZSH=$HOME/.oh-my-zsh
export EDITOR=nvim

export GOPATH=$HOME/.go
export GOROOT=/usr/lib/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

export jdk8=/usr/lib/jvm/java-8-openjdk
export jdk11=/usr/lib/jvm/java-11-openjdk
export jdk14=/usr/lib/jvm/java-14-openjdk
export JAVA_HOME=$jdk11
export PATH=${JAVA_HOME}/bin:$PATH
export PATH=${HOME}/.cargo/bin:$PATH

export USER_HOME=$HOME
export IDEA_HOME=$HOME/sources/intellij-community
export JDK_18_HOME=$jdk

export PATH="$PATH:$HOME/source/depot_tools"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

ZSH_THEME="nicoulaj"

plugins=(git mercurial battery command-not-found last-working-dir screen archlinux themes)

source $ZSH/oh-my-zsh.sh

zstyle :compinstall filename $HOME/.zshrc

autoload -U compinit promptinit
compinit
promptinit

if [ -f ~/.zsh_work ]; then
    source ~/.zsh_work
fi

# For pacman
[[ -a $(whence -p pacman-color) ]] && compdef _pacman pacman-color=pacman

unsetopt correct_all

# don't share history between shells
unsetopt SHARE_HISTORY
setopt no_share_history

SPROMPT="Ошибко! Enter %r instead %R? ([Y]es/[N]o/[E]dit/[A]bort) "

setopt autocd
zstyle ':completion:*' menu select=long-list select=0
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

# create and open folder
take () {
  mkdir $1 && cd $1
}

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

pull_all () {
  for r in *(/); do
    if [[ -d "$r/.git" ]]; then
      echo $fg[yellow]$r$reset_color
      git -C "$r" pull --rebase --autostash
    fi
    if [[ -d "$r/.hg" ]]; then
      echo $fg[yellow]$r$reset_color
      function () {
        hg -R "$r" shelve
        local shelve_status=$?
        hg -R "$r" pull --update --rebase
        if [[ $shelve_status -eq 0 ]]; then
          hg -R "$r" unshelve
        fi
      }
    fi
  done
}

export PATH="/usr/local/opt/openssl/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
if [ -f ~/.sdkman ]; then
    export SDKMAN_DIR="$HOME/.sdkman"
    [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
fi
