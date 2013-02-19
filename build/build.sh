#!/usr/bin/env bash

PATH=$PATH:/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin
export PATH

##
# install gem develop tool
##

which gem 1> /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo '=> Please install gem tool via aptitude command.'
    echo '=> $ sudo aptitude -y install ruby rake rubygems'
    exit
fi

which compass 1> /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo '=> update rubygems tool'
    sudo gem update --system
    echo '=> install compass and sass tool'
    sudo gem install sass compass
fi

##
# install npm develop tool
##

which npm
if [ $? -ne 0 ]; then
    echo '=> install nvm tool'
    curl https://raw.github.com/appleboy/nvm/develop/install.sh | sh
    . ~/.nvm/nvm.sh # This loads NVM
    echo '=> install node.js stable version'
    nvm install stable
    echo '=> use node.js stable version'
    nvm use stable
fi

echo '=> install coffee-script tool'
npm install -g coffee-script
echo '=> install RequireJS in Node'
npm install -g requirejs
echo '=> install bower tool ref: http://twitter.github.com/bower/'
npm install -g bower
echo '=> install express server ref: http://expressjs.com'
npm install -g express
echo '=> install UglifyJS 2 node-based js compressor.'
npm install -g uglify-js
echo '=> install sqwish node-based CSS compressor.'
npm install -g sqwish
