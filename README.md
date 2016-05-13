# config

to install this server, copy & paste this in the server's console:
```bash
source <(curl -s https://raw.githubusercontent.com/chanlvh/config/master/server.sh)
```

to install an app, run this on your workstation:
```bash
HOST_NAME=note.cool APP_NAME=posture ./app.sh
```

to set the whole things up, run this on your workstation:
```bash
HOST_NAME=note.cool ./setup.sh
```

in all script, set environment variable DEBUG=true to enable debugging (verbose) mode
