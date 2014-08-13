# Html5 Template Engine

[![Build Status](https://travis-ci.org/appleboy/html5-template-engine.png)](http://travis-ci.org/appleboy/html5-template-engine) [![Build Status](http://jenkins.wu-boy.com/buildStatus/icon?job=html5-template-engine)](http://jenkins.wu-boy.com/job/html5-template-engine/)

##### Hint: [New Slush generator Html5 web apps](https://github.com/appleboy/slush-html5-template) available

## Features

* The latest [html5boilerplate.com](http://html5boilerplate.com/) source code.
* Includes [Normalize.scss](https://github.com/appleboy/normalize.scss) v2.1.x and v1.1.x.
* The latest [jQuery](http://jquery.com/) and [Modernizr](http://modernizr.com/) via [Bower](http://bower.io/) package manager.
* Support [CoffeeScript](http://coffeescript.org/), [RequireJS](http://requirejs.org/), [Compass](http://compass-style.org/), html minification (via [htmlcompressor](http://code.google.com/p/htmlcompressor/)).
* Support JavaScript test framework [Mocha](http://visionmedia.github.io/mocha/).
* Support streaming build system [Gulp](http://gulpjs.com/).
* Support [browser-sync](http://browsersync.io) Keep multiple browsers & devices in sync when building websites.
* Support [Terminal in Chrome Devtools](http://www.html5rocks.com/en/tutorials/developertools/devtools-terminal/).
* Support Minify PNG and JPEG images with [image-min](https://github.com/sindresorhus/gulp-imagemin).

## Installation

Please install node.js first (>0.10) and [bower](http://bower.io/) package manager

```bash
$ npm install -g bower
$ npm install && bower install
```

Start App

```bash
$ npm start
```

Excuting above command will output the following message.

```
> html5-template-engine@1.0.0 start /home/xxxxx/html5-template-engine
> gulp

[13:25:09] Requiring external module coffee-script/register
[13:25:11] Using gulpfile /home/xxxxx/html5-template-engine/gulpfile.coffee
[13:25:11] Starting 'default'...
[13:25:11] Starting 'coffee'...
[13:25:11] Starting 'compass'...
[13:25:11] Finished 'coffee' after 253 ms
directory app/assets/css/
   create app/assets/css/main.css

[13:25:12] Finished 'compass' after 1.08 s
[13:25:12] Starting 'connect:app'...
[13:25:12] Finished 'connect:app' after 34 ms
[13:25:12] Finished 'default' after 1.2 s
[BS] Local: >>> http://localhost:3001
[BS] External: >>> http://172.168.0.122:3001
[BS] Serving files from: app
```

Open browser like chrome or firefox and enter http://localhost:1337 URL.

## Release

Execute the following command will generate `dist` folder.

```bash
$ npm release
```

## Test

To test release process by following command.

```bash
$ npm test
```

## Support Terminal in Chrome Devtools

If you’re on a Mac, just download this [Chrome extension](https://chrome.google.com/webstore/detail/leakmhneaibbdapdoienlkifomjceknl). Install it, and you good to go. No need to read any further.

If you’re not on a Mac, you can connect to your system’s terminal via Node.js proxy. It can be localhost or some other remote server.

  $ npm install -g devtools-terminal
  $ devtools-terminal --config terminal.js

Please refer more [detail information](http://www.html5rocks.com/en/tutorials/developertools/devtools-terminal/).

## Support Gulp in Chrome Devtools

Please install [chrome Gulp Devtools extension](https://chrome.google.com/webstore/detail/gulp-devtools/ojpmgjhofceebfifeajnjojpokebkkji). An extension to run gulp task from chrome devtools.

Is gulp-devtools running?

- If not already installed, run `npm install -g gulp-devtools`
- Export gulp from your gulpfile.js by adding `module.exports = gulp;`
- Run gulp-devtools in a directory with a gulpfile!
- Re-open Chrome Dev tools, find the Gulp tab. Your gulp tasks should now be accessible from Chrome

## Author

Bo-Yi Wu, Twitter: [@appleboy](http://twitter.com/appleboy "Twitter"), Blog: http://blog.wu-boy.com
