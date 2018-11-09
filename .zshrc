export ZSH=$HOME/.oh-my-zsh
export EDITOR=vim

export GOPATH=$HOME/.go
export GOROOT=/usr/lib/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

export loom=$HOME/sources/loom/build/linux-x86_64-normal-server-release/images/jdk
export jdk6=$HOME/sources
export jdk11=$HOME/sources/jdk/build/linux-x86_64-normal-server-release/images/jdk
export jdk=$HOME/sources/jdk8u/build/linux-x86_64-normal-server-release/images/j2sdk-image
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
export PATH=${JAVA_HOME}/bin:$PATH

export USER_HOME=$HOME
export IDEA_HOME=$HOME/sources/intellij-community
export JDK_18_HOME=$jdk

ZSH_THEME="nicoulaj"

plugins=(git mercurial battery command-not-found last-working-dir screen archlinux themes)

source $ZSH/oh-my-zsh.sh

zstyle :compinstall filename '/home/nicl-arch/.zshrc'

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

# Aliases
alias l='ls -l --color=auto'
alias e='nvim'
alias grep='grep --colour=auto'
alias -s {avi,mpeg,mpg,mov,m2v,mp4}=mpv
alias -s {odt,doc,sxw,rtf}=openoffice.org
autoload -U pick-web-browser
alias -s {html,htm}=chromium

alias vi='nocorrect vim'
alias vim='nocorrect vim'
alias mvn4='mvn -T 4 clean install -DskipTests'
alias hlol='hg log -G -b . --template "{label('\''yellow'\'', rev)} {label('\''red'\'', shortest(node, 6))} -{label('\''yellow'\'', ifeq(branch, '\''default'\'', '\'\'', '\'' {branch}'\''))}{label('\''yellow'\'', if(tags, '\'' (tags: {join(tags, \'\'', \'\'')})'\''))}{label('\''yellow'\'', if(bookmarks, '\'' [bookmarks: {join(bookmarks, \'\'', \'\'')}]'\''))} {desc|strip|firstline} {label('\''green'\'', '\''({date|age})'\'')} {label('\''blue'\'', '\''<{author|person}>'\'')}\n"'

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
