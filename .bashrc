JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_66.jdk/Contents/Home/;
export JAVA_HOME;

export PS1="\[\e[31m\]\u@\h:\W$ \[\e[0m\]"
export HISTCONTROL=erasedups
export NDKROOT=/Users/chanlvh/sdk/android-ndk-r10d

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/chanlvh/.local/bin:/Users/chanlvh/android/ndk:/Users/chanlvh/android/sdk/tools:/Users/chanlvh/android/sdk/platform-tools:$NDKROOT
alias c='git commit -a -m'
alias p='git push'
alias a='git add --all .'
alias s='git status'
alias b='git checkout'
alias rlkh="sed -i '' -e '$ d' ~/.ssh/known_hosts"

export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

export NVM_DIR="/Users/chanlvh/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
