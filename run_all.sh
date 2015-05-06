#! /bin/bash

#the user is node set by the Dockerfile on build
chown -R node:node /myapp
#set the node version, update global packages, install app npm and bower packages, run the app
. ~/.nvm/nvm.sh && nvm use default; npm install -g bower forever --user "node"; cd /myapp && npm install && bower install; export NODE_ENV=production && forever /myapp/src/app.js
