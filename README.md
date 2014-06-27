# Html5 Template Engine

[![Build Status](https://travis-ci.org/appleboy/html5-template-engine.png)](http://travis-ci.org/appleboy/html5-template-engine)

## Features

* The latest [html5boilerplate.com](http://html5boilerplate.com/) source code.
* Includes [Normalize.scss](https://github.com/appleboy/normalize.scss) v2.1.x and v1.1.x.
* The latest [jQuery](http://jquery.com/) and [Modernizr](http://modernizr.com/) via [Bower](http://bower.io/) package manager.
* Support [CoffeeScript](http://coffeescript.org/), [RequireJS](http://requirejs.org/), [Compass](http://compass-style.org/), html minification (via [htmlcompressor](http://code.google.com/p/htmlcompressor/)).
* A lightweight web server listen to 4000 port (Using [Node Express Framework](http://expressjs.com/)).
* Support JavaScript Task Runner [GruntJS](http://gruntjs.com/).
* Support JavaScript test framework [Mocha](http://visionmedia.github.io/mocha/).
* Support documentation generator [Docco](http://jashkenas.github.io/docco/).
* Support streaming build system [Gulp](http://gulpjs.com/).
* Support [browser-sync](http://browsersync.io) Keep multiple browsers & devices in sync when building websites.
* Support [Terminal in Chrome Devtools](http://www.html5rocks.com/en/tutorials/developertools/devtools-terminal/).
* Support Minify PNG and JPEG images with [image-min](https://github.com/sindresorhus/gulp-imagemin).

## Install develop tool

  $ ./build/build.sh

or

  $ curl https://raw.github.com/appleboy/html5-template-engine/master/build/build.sh | bash

## Setup Environment

Download source code.

  $ git clone https://github.com/appleboy/html5-template-engine.git

Install vendor library and npm library.

  $ npm install
  $ bower install

## Develop a project manually

### Use Compass CSS Framework

Compass is an open-source CSS Authoring Framework. http://compass-style.org/

  $ compass watch .

### Use CoffeeScript

CoffeeScript is a little language that compiles into JavaScript. http://coffeescript.org/

  $ coffee -b -w -c -o assets/js assets/coffeescript

### Minify Javascript using RequireJS

Using Makefile.

  $ make

or command line.

  $ r.js -o build/self.build.js

Testing minified javascript file. Please modify index.html and find the following text.

```
<script data-main="assets/js/main" src="assets/js/vendor/requirejs/require.js"></script>
```

Replace with:

```
<script data-main="assets/js/main-built" src="assets/js/vendor/requirejs/require.js"></script>
```

Run local server (use root permission)

  $ node build/server.js

Using Makefile.

  $ make server

open the following URL on browser.

```
http://your_host_name:4000/
```

## Develop a project automatically

Before using [GruntJS](http://gruntjs.com/) or [Gulp](http://gulpjs.com/) tool, please make sure excute the following command.

  $ npm install

### Using GruntJS

Using [GruntJS](http://gruntjs.com/) tool to setup develop environment.

  $ npm run grunt

Output the following message.

```
Running "init" task
Initial project

Running "connect:livereload" (connect) task
Started connect web server on localhost:4000.

Running "watch" task
Waiting...
```
Please install [livereload](http://livereload.com/) plugin depend on your browser. ex: [Safari extension](http://download.livereload.com/2.0.9/LiveReload-2.0.9.safariextz), [Firefox addon](http://download.livereload.com/2.0.8/LiveReload-2.0.8.xpi), or [Chrome extension](https://chrome.google.com/webstore/detail/livereload/jnihajbhpnppcggbcgedagnkighmdlei)

### Using Gulp

Using [Gulp](http://gulpjs.com/) tool to setup develop environment.

  $ npm start

Output the following message.

```
> html5-template-engine@1.0.0 start /home/xxx/html5-template-engine
> gulp

[10:50:37] Requiring external module coffee-script/register
[10:50:37] Using gulpfile /home/xxx/html5-template-engine/gulpfile.coffee
[10:50:37] Starting 'default'...
[10:50:37] Starting 'coffee'...
[10:50:37] Starting 'compass'...
[10:50:37] Finished 'coffee' after 132 ms
directory app/assets/css/
   create app/assets/css/main.css

[10:50:38] Finished 'compass' after 449 ms
[10:50:38] Starting 'connect:app'...
[10:50:38] Finished 'connect:app' after 17 ms
[10:50:38] Finished 'default' after 509 ms
[BS] Local: >>> http://localhost:3001
[BS] External: >>> http://xxx.xxx.xxx.xxx:3001
[BS] Serving files from: app
```

## Deploy Your App

### Using Makefile

  $ make release

or defined your build output path. (default: output)

  $ make -m output_path=output2 release

### Using GruntJS

  $ ./node_modules/.bin/grunt release

Copy ``output`` folder to your root document path.

  $ cp -r output /var/www/html5

open the following URL on browser.

```
http://your_host_name/html5/
```

## Test Your Project

### Using Makefile

  $ make test

### Using GruntJS

  $ ./node_modules/.bin/grunt test

## Clean Your Project

### Using Makefile

  $ make clean

### Using GruntJS

  $ ./node_modules/.bin/grunt clean

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
