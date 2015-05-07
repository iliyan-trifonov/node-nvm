# docker-node-nvm
A docker image/container to run [NodeJS](https://nodejs.org/ "NodeJS") apps. 
The node version is specified and ran with [nvm](https://github.com/creationix/nvm "NVM").

Check the automatic build in the Docker's official registry 
[here](https://registry.hub.docker.com/u/iliyan/docker-node-nvm/ "docker-node-nvm").

I am using this image to run my own node apps. I am going to update it when a new node version is out and also
when I need more or different tools installed.

The ready made image can be used that way:

    docker run ... iliyan/docker-node-nvm:NODE_VERSION
    
First check if the NODE_VERSION tag exists in the repo. The tag will always be the same as the NodeJS version 
installed by the code tagged. Sometimes I need to add new features which can be seen only on latest commits on 
the master branch and they will be available in the next tag. That means if you see a feature that is missing in the 
tag you use it definitely is in the latest commits. The easiest way to use the latest is to just run the container 
without specifying a tag:
 
    docker pull iliyan/docker-node-nvm
    docker run ... iliyan/docker-node-nvm

Currently it uses [forever](https://github.com/foreverjs/forever "Forever") to run the app but one 
can easily change it to e.g. [pm2](https://github.com/Unitech/pm2 "pm2") or similar.

You can run the container once to do some job or continuously for a whole application.

The container needs a volume on /myapp and by default the command is looking for the main app file at /myapp/src/app.js:

    docker run ... -v /home/yourusername/yournodeapp:/myapp

If your app has a different structure you can specify the main js file like this(full path can be used too):

    #server.js is in yournodeapp/
    docker run ... -e 'APP_MAIN=server.js'
    #or with a full path which is the same as the previous command:
    docker run ... -e 'APP_MAIN=/myapp/server.js'
    
You will probably need to set a time zone in which the node server will run. This can be done with the TIME_ZONE 
env variable:

    docker run ... -e 'TIME_ZONE=Europe/Berlin'
    
You can also assign an UID to execute the node application with a specific user that exists on the host machine:

    docker run ... -u 1000
    
The volume yournodeapp/ dir will be automatically owned by the internal `node` user (respectfully the external `-u user`) 
on container's start.

Cpu and memory limit can be specified while executing `docker run`:

    docker run ... -m 512m -c 512

A typical `docker run` command should look like this:

    docker run -d --name mynodeapp -v /yourusername/yournodeapp:/myapp/ -e 'APP_MAIN=server.js' -e 'TIME_ZONE=Europe/Berlin' -p HOSTIP:HOSTPORT:APPPORT -u 1000 iliyan/docker-node-nvm:NODE_VERSION

If you check in the Dockerfile you will see that a new user `node` is created and used to install all the required files 
and run the application. The same user is also given some limited sudo permissions to run additional commands.

There is an example build shell script [here](build-image.sh "build-image.sh"). 
It can be used as a template to build your own image from the Dockerfile.
Don't forget to set the proper tag there.
