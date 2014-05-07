#!/bin/sh
set -e -x
git --version
upstream=$1
: ${upstream:=origin}
: ${REPO:=git@github.com:appleboy/backbone-template-engine}
git fetch $upstream
if [ `git rev-list HEAD...$upstream/master --count` -ne 0 ]; then
echo "not deploying"
  exit 1
fi

npm i

# remove dist folder for gh-pages
rm -rf dist
rm -rf app/assets/css
rm -rf app/assets/js

# XXX: use --reference when not in shallow clone
#git clone $REPO --reference . -b gh-pages _public
git clone $REPO --depth 1 -b gh-pages dist

# remove cache files
rm -rf dist/assets/js

REV=`git describe --always`
BUILD=git-$REV ./node_modules/.bin/bower install && ./node_modules/.bin/gulp release --env production
cd dist
git fetch --depth 1 origin master:master
git add -A .
echo "regen for $REV" | git commit-tree `git write-tree` -p `git rev-parse HEAD` -p $REV | xargs git reset --hard
git push origin gh-pages -f
