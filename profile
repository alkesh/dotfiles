# alkesh's profile

if [ -f ~/.aliases ]; then
  . ~/.aliases
fi

function cdl { cd $1; ls;}

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

export EDITOR=mvim
export PATH=~/bin:$PATH


#rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
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

# docker
eval $(boot2docker shellinit 2>/dev/null)

# brew cask
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

if [ -f $(brew --prefix)/etc/bash_completion.d/git-prompt.sh ]; then
  PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 "(%s)")[$(ruby_version_prompt)]\$ '
else
  PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\][$(ruby_version_prompt)]\$ '
fi
