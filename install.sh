source ../setup/common.sh

if [ -z ${HOST_NAME+x} ]; then 
  error "HOST_NAME is empty"
  exit
fi

if [ -z ${APP_NAME+x} ]; then
  info "Use folder as app name: ${PWD##*/}"
  APP_NAME=${PWD##*/}
fi

CURRENT_PATH=$(git remote get-url dokku)
REMOTE_PATH="dokku@$HOST_NAME:$APP_NAME"

if [[ $CURRENT_PATH == *"No such remote"* ]]; then
  info "Add remote $REMOTE_PATH"
  git remote add dokku $REMOTE_PATH
fi

if [ "$CURRENT_PATH" == "$REMOTE_PATH" ]; then
  info "Deploy app $APP_NAME to server $HOST_NAME"
  git push dokku master
else 
  error "Remote exist with different url, can't push"
fi

