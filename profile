# alkesh's profile

export PATH=$HOME/bin:/opt/homebrew/bin:$PATH

if [ -f ~/.aliases ]; then
  . ~/.aliases
fi

function cdl { cd $1; ls;}

# Cucumber
function c {
  if [ -f "./bin/docker/cucumber" ]; then
    echo "Running bin/docker/cucumber..."
    command bin/docker/cucumber $@
  else
    echo "Running bundle exec cucumber..."
    command bundle exec cucumber $@
  fi
}

# RSpec
function s {
  if [ -f "./bin/docker/rspec" ]; then
    echo "Running bin/docker/rspec..."
    command bin/docker/rspec $@
  else
    echo "Running bundle exec rspec..."
    command bundle exec rspec $@
  fi
}

# Rubocop
function cop {
  if [ -f "./.rubocop.yml" ]; then
    if [ -f "./bin/docker/run" ]; then
      echo "Running rubocop in docker..."
      command bin/docker/run rubocop $@
    else
      if [[ $@ == *"-a"* ]]; then
        echo "Running bundle exec rubocop..."
        command bundle exec rubocop $@
      else
        echo "Running bundle exec rubocop (parallel)..."
        command bundle exec rubocop --parallel $@
      fi
    fi
  else
    echo ".rubocop.yml not found!"
  fi
}

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

if [ -f $(brew --prefix)/etc/bash_completion.d/git-prompt.sh ]; then
  . $(brew --prefix)/etc/bash_completion.d/git-prompt.sh
fi
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true

if [ -f $(brew --prefix)/etc/bash_completion.d/git-completion.bash ]; then
  . $(brew --prefix)/etc/bash_completion.d/git-completion.bash
  # make auto completion work with the 'g' alias
  __git_complete g __git_main
fi

title () { echo -ne "\033]0;$@\\007"; }
export PROMPT_COMMAND='title ${PWD##*/}'

export RUBYOPT="-r rubygems"

[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

export EDITOR=nvim

#rbenv
export PATH="$HOME/.rbenv/shims:$PATH"
eval "$(rbenv init -)"

ruby_version_prompt() {
  if [ -f `which rbenv` ]; then
    rbenv_ruby_version=`rbenv version | sed -e 's/ .*//'`
    echo -e $rbenv_ruby_version
  else
    echo -e $RUBY_VERSION
  fi
}

# dash shortcut
function d { open "dash://$1"; }

# set iterm profile – copes with tmux
function set_iterm_profile() {
  if [ -n "$TMUX" ]; then
    echo -e "\033Ptmux;\033\033]50;SetProfile=$1\007\033\\"
  else
    echo -e "\033]50;SetProfile=$1\a"
  fi
}

# iterm shell integration https://www.iterm2.com/documentation-shell-integration.html
source ~/.iterm2_shell_integration.`basename $SHELL`

# brew cask
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# set the TERM to support 256 colours
export TERM="xterm-256color"

# go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# java
#export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

# ingore commands beginning with whitespace, and duplicates too
HISTCONTROL=ignoreboth

if [ -f $(brew --prefix)/etc/bash_completion.d/git-prompt.sh ]; then
  PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 "(%s)")[$(ruby_version_prompt)]\$ '
else
  PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\][$(ruby_version_prompt)]\$ '
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# postgres 16
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/postgresql@16/lib"
export CPPFLAGS="-I/opt/homebrew/opt/postgresql@16/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/postgresql@16/lib/pkgconfig"
