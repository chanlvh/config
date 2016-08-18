JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_66.jdk/Contents/Home/;
export JAVA_HOME;

export PS1="\[\e[31m\]\u@\h:\W$ \[\e[0m\]"
export HISTCONTROL=erasedups
export NDKROOT=/Users/chanlvh/sdk/android-ndk-r10d

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/chanlvh/.local/bin:/Users/chanlvh/android/ndk:/Users/chanlvh/android/sdk/tools:/Users/chanlvh/android/sdk/platform-tools:$NDKROOT
alias fum='git fetch upstream master'
alias po='git push -f origin'
alias rum='git rebase upstream/master'
alias a='git add --all .'
alias b='git checkout'
alias c='git commit -a -m'
alias d='git diff'
alias f='git fetch'
alias l="git lg"
alias p='git push'
alias s='git status'
# kill docker image
alias rdb='docker-machine ssh dev docker kill $(docker ps -q)'
alias sdb='project/tools/start-couchdb.sh'
# remove last known host - useful when rebuild the same virtual server again and again
alias rlkh="sed -i '' -e '$ d' ~/.ssh/known_hosts"
alias sfrs="git stash && fum && rum && git stash pop"

export NVM_DIR="/Users/chanlvh/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

eval $(docker-machine env dev)

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi


