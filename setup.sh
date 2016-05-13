source common.sh

if [ -z ${HOST_NAME+x} ]; then
  error "HOST_NAME is empty"
  exit
fi

info "Installing server"
#ssh -t dokku@HOST_NAME --

info "Uploading projects"
for D in `find .. -maxdepth 1 -mindepth 1 -type d`
do
  cd $D
  info $D
  if [ -f "init.sh" ];
  then
    ./init.sh
  fi
done

