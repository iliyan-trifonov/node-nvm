#! /bin/bash

#the current user is `node` set by the Dockerfile on build

#check and set the default app start file
if [ -z "$APP_MAIN" ]; then APP_MAIN="/myapp/src/app.js"; fi;

#check the file to be started in the container's logs
echo The NodeJS app\'s start file is: $APP_MAIN

#set the node version, update global packages, install the app's npm and bower packages, run the app
. ~/.nvm/nvm.sh && nvm use default; \
  npm install -g bower forever --user "node"; \
  cd /myapp && npm install && bower install; \
  export NODE_ENV=production && forever $APP_MAIN
