alias ls='ls -G'
alias ra='echo Restarting Apache&&sudo apachectl restart'
alias gs='git status'
alias rr='rake restart'
alias findtrailingspaces='grep -r -E "^.*[[:space:]]+$"'
alias gl='git log --oneline --decorate -5'
alias gla='git log --oneline --decorate'
alias ga='git add -A'
alias r=rails
alias g=git
alias gitx=/Applications/GitX.app/Contents/Resources/gitx
alias b='bundle exec'
alias vim=/Applications/MacVim.app/Contents/MacOS/Vim
alias vi=vim
alias v=mvim
alias vt='mvim --remote-tab'
alias brake='b rake'

alias gemtags='(for a in $GEM_HOME/gems/*;do cd $a;echo -n .;run_tags;done;echo)'

function cdl { cd $1; ls;}

#source /Users/alkesh/.git-completion.bash

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

parse_git_dirty() {
  git diff --quiet HEAD &>/dev/null
  [[ $? == 1 ]] && echo "*"
}

# Mountain Lion gcc installed from: https://github.com/kennethreitz/osx-gcc-installer/downloads
export CC=/usr/bin/cc # LLVM based compiler
#export CC=`which gcc-4.2`
export RUBYOPT="-r rubygems"

if [ -f `brew --prefix`/etc/autojump ]; then
  . `brew --prefix`/etc/autojump
fi

export EDITOR=mvim
export PATH=~/bin:$PATH

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(parse_git_branch)[$RUBY_VERSION]$(parse_git_dirty)$ '
