# docker-node-nvm
A docker image/container to run node apps, node version specified and ran with nvm.

I am using this image to run my own node apps. I am going to update it when a new node version is out and also
when I need more or different tools installed.

Currently it uses forever to run the app but one can easily change it to e.g. pm2 or similar.

You can run the container once to do some job or continusly for a whole application.

The container needs a volume on /myapp and by default the command is looking for the main app point at /myapp/src/app.js.

You can also assign an UID to execute the node application with a specific user on the host machine.

Cpu and memory limit can be specified while executing `docker run`.
