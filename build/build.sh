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

which npm 1> /dev/null 2>&1
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
which coffee 1> /dev/null 2>&1 || npm install -g coffee-script
echo '=> install RequireJS in Node'
which r.js 1> /dev/null 2>&1 || npm install -g requirejs
echo '=> install bower tool ref: http://twitter.github.com/bower/'
which bower 1> /dev/null 2>&1 || npm install -g bower
echo '=> install express server ref: http://expressjs.com'
which express 1> /dev/null 2>&1 || npm install -g express
echo '=> install UglifyJS 2 node-based js compressor.'
which uglifyjs 1> /dev/null 2>&1 || npm install -g uglify-js
echo '=> install sqwish node-based CSS compressor.'
which sqwish 1> /dev/null 2>&1 || npm install -g sqwish

# install require npm dependence tool for grunt.js.
npm install
# install require bower dependence package.
bower installl
