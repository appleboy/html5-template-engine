#!/usr/bin/env bash

##
# install compass and livereload tool
##

echo '=> install rubygems tool'
aptitude -y install ruby rake rubygems
echo '=> update rubygems tool'
gem update --system
echo '=> install compass tool'
gem install compass
echo '=> install livereload tool'
gem install guard-livereload

##
# install coffee-script tool
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
