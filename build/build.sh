#!/usr/bin/env bash

PATH=$PATH:/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin
export PATH

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
RESET="\033[0m"

display () {
    COLOR=$2
    [ -z $2 ] && COLOR=${YELLOW}
    echo
    echo -e "${COLOR}=> $1 ${RESET}"
}

##
# install gem develop tool
##

which gem 1> /dev/null 2>&1
if [ $? -ne 0 ]; then
    display "Please install gem tool via aptitude command."
    display "$ sudo aptitude -y install ruby rake rubygems"
    exit
fi

which compass 1> /dev/null 2>&1
if [ $? -ne 0 ]; then
    display "update rubygems tool."
    sudo gem update --system
    display "install compass and sass tool."
    sudo gem install sass compass
fi

which guard 1> /dev/null 2>&1
if [ $? -ne 0 ]; then
    display "Install guard livereload tool."
    sudo gem install rb-inotify guard-livereload yajl-ruby
fi

##
# install npm develop tool
##

which npm 1> /dev/null 2>&1
if [ $? -ne 0 ]; then
    display "install nvm tool."
    curl https://raw.github.com/appleboy/nvm/develop/install.sh | sh
    . ~/.nvm/nvm.sh # This loads NVM
    display "install node.js stable version."
    nvm install stable
    display "use node.js stable version."
    nvm use stable
fi

display "install coffee-script tool"
which coffee 1> /dev/null 2>&1 || npm install -g coffee-script
display "install RequireJS in Node"
which r.js 1> /dev/null 2>&1 || npm install -g requirejs
display "install bower tool ref: http://twitter.github.com/bower/"
which bower 1> /dev/null 2>&1 || npm install -g bower
display "install express server ref: http://expressjs.com"
which express 1> /dev/null 2>&1 || npm install -g express
display "install UglifyJS 2 node-based js compressor."
which uglifyjs 1> /dev/null 2>&1 || npm install -g uglify-js
display "install sqwish node-based CSS compressor."
which sqwish 1> /dev/null 2>&1 || npm install -g sqwish
display "install django-html in an HTML minifier."
which pyminify 1> /dev/null 2>&1 || sudo pip install django-htmlmin
display 'install grunt tool.'
which grunt 1> /dev/null 2>&1 || npm install -g grunt-cli
display 'install mocha tool.'
which mocha 1> /dev/null 2>&1 || npm install -g mocha
display 'install mocha-phantomjs tool.'
which mocha-phantomjs 1> /dev/null 2>&1 || npm install -g mocha-phantomjs
display 'install gulp tool.'
which mocha-phantomjs 1> /dev/null 2>&1 || npm install -g gulp
display 'install Terminal in Chrome Devtools command.'
which mocha-phantomjs 1> /dev/null 2>&1 || npm install -g devtools-terminal

# install npm dependency packages for grunt.js.
[ -d node_modules ] || npm install

# install require bower dependency package.
[ -d app/assets/vendor ] || bower install
