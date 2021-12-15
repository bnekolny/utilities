#!/bin/bash

# python stuff
source /usr/local/bin/virtualenvwrapper.sh

source ~/projects/utilities/bashrc_include.sh

# Git branch info
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

kill_docker_images(){
    docker kill $(docker ps | grep -v CONTAINER | awk '{print $1}')
    if [ $? -ne 0 ]
    then
        echo ""
        echo "No images to kill..."
    fi
}
alias dk=kill_docker_images
alias dc=docker-compose

git_reponame(){
  basename -s .git `git config --get remote.origin.url`
}
alias svc=git_reponame

alias killpids='find . -name "server.pid" -delete'

# Move to ~/projects/ as the starting directory
export START="~/projects/"
if [[ $PWD == $HOME ]]; then
    cd $START
fi

# Setting xterm as the default terminal so that vim doesn't persist it's screen on exit
TERM=xterm; export TERM

# Installed ruby with homebrew via rbenv, need to make sure that version is used
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

function git() { case $* in grep* ) shift 1; command git grep -n "$@" | more ;; * ) command git "$@" ;; esac }


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

#string replace in files
function string_replace_in_repo () {
  sh -c "git grep -l '$1' | xargs sed -i '' -e 's/$1/$2/g'"
}
alias grepsedreplace=string_replace_in_repo

# make 'gcloud' available
source ~/google-cloud-sdk/path.bash.inc

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH
export GPG_TTY=$(tty)

set -o vi

export PATH="/usr/local/opt/postgresql@10/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/postgresql@10/lib"
export CPPFLAGS="-I/usr/local/opt/postgresql@10/include"
export PKG_CONFIG_PATH="/usr/local/opt/postgresql@10/lib/pkgconfig"

# The next line updates PATH for the Google Cloud SDK.
#if [ -f '~/google-cloud-sdk/path.bash.inc' ]; then . '~/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
#if [ -f '~/google-cloud-sdk/completion.bash.inc' ]; then . '~/google-cloud-sdk/completion.bash.inc'; fi
