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
curl https://raw.github.com/creationix/nvm/master/install.sh | sh
. ~/.nvm/nvm.sh
echo '=> install node.js 0.8.16'
nvm install v0.8.16
echo '=> install coffee-script tool'
npm install -g coffee-script
