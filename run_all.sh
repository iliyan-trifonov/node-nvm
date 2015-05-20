#! /bin/bash

#the current user is `node` set by the Dockerfile on build

#check and set the default app start file
if [ -z "$APP_MAIN" ]; then APP_MAIN="/myapp/src/app.js"; fi;

#check the file to be started in the container's logs
echo The NodeJS app\'s start file is: $APP_MAIN

#check if a different time zone is given and set it
if [ -n "$TIME_ZONE" ]
then
  echo $TIME_ZONE | sudo tee /etc/timezone;
  sudo dpkg-reconfigure -f noninteractive tzdata;
fi

#set the node version, update the global npm packages, install/update the app's npm and bower packages, run the app in production mode
. ~/.nvm/nvm.sh && nvm use default; \
  npm update -g bower forever --user "node"; \
  sudo chown -R node:node /myapp; \
  cd /myapp && npm update && bower install; \
  NODE_ENV=production forever $APP_MAIN
