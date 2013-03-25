#!/usr/bin/env bash

PATH=$PATH:/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin
export PATH

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[32m"
RESET="\033[0m"

##
# install gem develop tool
##

which gem 1> /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo -e "${YELLOW}=> Please install gem tool via aptitude command.${RESET}"
    echo -e "${YELLOW}=> $ sudo aptitude -y install ruby rake rubygems${RESET}"
    exit
fi

which compass 1> /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo -e "${YELLOW}=> update rubygems tool.${RESET}"
    sudo gem update --system
    echo -e "${YELLOW}=> install compass and sass tool.${RESET}"
    sudo gem install sass compass
fi

##
# install npm develop tool
##

which npm 1> /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo -e "${YELLOW}=> install nvm tool.${RESET}"
    curl https://raw.github.com/appleboy/nvm/develop/install.sh | sh
    . ~/.nvm/nvm.sh # This loads NVM
    echo -e "${YELLOW}=> install node.js stable version.${RESET}"
    nvm install stable
    echo -e "${YELLOW}=> use node.js stable version.${RESET}"
    nvm use stable
fi

echo -e "${YELLOW}=> install coffee-script tool${RESET}"
which coffee 1> /dev/null 2>&1 || npm install -g coffee-script
echo -e "${YELLOW}=> install RequireJS in Node${RESET}"
which r.js 1> /dev/null 2>&1 || npm install -g requirejs
echo -e "${YELLOW}=> install bower tool ref: http://twitter.github.com/bower/${RESET}"
which bower 1> /dev/null 2>&1 || npm install -g bower
echo -e "${YELLOW}=> install express server ref: http://expressjs.com${RESET}"
which express 1> /dev/null 2>&1 || npm install -g express
echo -e "${YELLOW}=> install UglifyJS 2 node-based js compressor.${RESET}"
which uglifyjs 1> /dev/null 2>&1 || npm install -g uglify-js
echo -e "${YELLOW}=> install sqwish node-based CSS compressor.${RESET}"
which sqwish 1> /dev/null 2>&1 || npm install -g sqwish
echo -e "${YELLOW}=> install django-html in an HTML minifier.${RESET}"
which pyminify 1> /dev/null 2>&1 || sudo pip install django-htmlmin

# install npm dependency packages for grunt.js.
npm install

# install require bower dependency package.
bower install
