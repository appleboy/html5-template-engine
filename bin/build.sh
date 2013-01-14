#!/usr/bin/env bash

##
# install gem develop tool
##

echo '=> install rubygems tool'
aptitude -y install ruby rake rubygems
echo '=> update rubygems tool'
gem update --system
echo '=> install compass and sass tool'
gem install sass compass
echo '=> install livereload tool'
gem install guard-livereload

##
# install npm develop tool
##

echo '=> install nvm tool'
curl https://raw.github.com/appleboy/nvm/develop/install.sh | sh
. ~/.nvm/nvm.sh
echo '=> install node.js stable version'
nvm install stable
echo '=> use node.js stable version'
nvm use stable
echo '=> install coffee-script tool'
npm install -g coffee-script
echo '=> install transfer javascript to coffee script tool'
npm install -g js2coffee
echo '=> install template engine'
npm install -g handlebars
echo '=> install RequireJS in Node'
npm install -g requirejs
echo '=> install bower tool ref: http://twitter.github.com/bower/'
npm install -g bower
