'use strict'

uuid = require 'uuid'
gulp = require 'gulp'
gutil = require 'gulp-util'
coffee = require 'gulp-coffee'
coffeelint = require 'gulp-coffeelint'
compass = require 'gulp-compass'
w3cjs = require 'gulp-w3cjs'
jshint = require 'gulp-jshint'
clean = require 'gulp-clean'
imagemin = require 'gulp-imagemin'
cache = require 'gulp-cache'
changed = require 'gulp-changed'
connect = require 'gulp-connect'
size = require 'gulp-size'
mocha = require 'gulp-mocha'
rjs = require 'requirejs'
runs = require 'run-sequence'
rename = require 'gulp-rename'
uglify = require 'gulp-uglify'
minifyCSS = require 'gulp-minify-css'
htmlmin = require 'gulp-htmlmin'
replace = require 'gulp-replace'
gulpif = require 'gulp-if'
production = true if gutil.env.env is 'production'
filename = uuid.v4()

paths =
  src: 'app'
  script: 'app/assets/js'
  coffee: 'app/assets/coffee'
  sass: 'app/assets/sass'
  css: 'app/assets/css'
  images: 'app/assets/images'
  test: 'test'
  dist: 'dist'
  vendor: 'app/assets/vendor'

gulp.task 'coffee', ->
  gulp.src 'app/assets/coffeescript/**/*.coffee'
    .pipe gulpif !production, changed paths.script,
      extension: '.js'
    .pipe coffeelint
      indentation:
        name: 'indentation'
        value: 4
        level: 'error'
    .pipe coffeelint.reporter()
    .pipe coffee bare: true
    .pipe gulp.dest paths.script
    .pipe size()
    .pipe connect.reload()

gulp.task 'test_coffee', ->
  gulp.src 'test/**/*.coffee'
    .pipe changed 'test/',
      extension: '.js'
    .pipe coffeelint
      indentation:
        name: 'indentation'
        value: 4
        level: 'error'
    .pipe coffeelint.reporter()
    .pipe coffee bare: true
    .pipe gulp.dest 'test/'
    .pipe size()

gulp.task 'w3cjs', ->
  gulp.src 'app/*.html'
    .pipe changed 'dist'
    .pipe w3cjs()
    .pipe gulpif production, htmlmin(
      removeComments: true
      collapseWhitespace: true
    )
    .pipe gulpif production, replace 'js/main', 'js/' + filename
    .pipe gulpif production, replace 'vendor/requirejs/require.js', 'js/require.js'
    .pipe gulp.dest 'dist'
    .pipe size()
    .pipe connect.reload()

gulp.task 'compass', ->
  gulp.src 'app/assets/sass/**/*.scss'
    .pipe gulpif !production, changed 'app/assets/css/',
      extension: '.css'
    .pipe compass
      css: 'app/assets/css'
      sass: 'app/assets/sass'
      image: 'app/assets/images'
    .on('error', ->)
    .pipe gulpif production, minifyCSS()
    .pipe gulp.dest paths.dist + '/assets/css/'
    .pipe size()
    .pipe connect.reload()

gulp.task 'lint', ->
  gulp.src 'gulpfile.js'
    .pipe jshint()
    .pipe jshint.reporter 'default'
    .pipe size()

# Clean
gulp.task 'clean', ->
  gulp.src([
    'dist'
    'output'
    '.sass-cache'
    'app/assets/js'
    'app/assets/css'
  ],
    read: false
  ).pipe clean()


# Images
gulp.task 'images', ->
  gulp.src 'app/assets/images/**/*'
    .pipe changed 'dist/assets/images'
    .pipe cache imagemin
      optimizationLevel: 3
      progressive: true
      interlaced: true
    .pipe gulp.dest 'dist/assets/images'
    .pipe connect.reload()

# testing via mocha tool
gulp.task 'test', ->
  gulp.src paths.test + '/test.js'
    .pipe mocha
      reporter: 'spec'

# Connect
gulp.task 'connect', ->
  connect.server
    root: ['app']
    port: 1337
    livereload: true

gulp.task 'watch', ['connect'], ->
  # Watch files and run tasks if they change
  gulp.watch 'gulpfile.js', ['lint']
  gulp.watch 'app/assets/coffeescript/**/*.coffee', ['coffee']
  gulp.watch 'test/**/*.coffee', ['test_coffee']
  gulp.watch 'app/*.html', ['w3cjs']
  gulp.watch 'app/assets/sass/**/*.scss', ['compass']
  gulp.watch 'app/assets/images/**/*', ['images']
  true

gulp.task 'copy', ->
  gulp.src [
    paths.src + '/.htaccess'
    paths.src + '/favicon.ico'
    paths.src + '/robots.txt']
    .pipe gulp.dest 'dist/'

gulp.task 'rjs', ['build'], (cb) ->
  rjs.optimize
    baseUrl: paths.script
    name: 'main'
    out: paths.script + '/main-built.js'
    mainConfigFile: paths.script + '/main.js'
    preserveLicenseComments: false
    , (buildResponse) ->
      cb()

gulp.task 'rename', ['rjs'], ->
  gulp.src paths.script + '/main-built.js'
    .pipe rename 'assets/js/' + filename + '.js'
    .pipe gulp.dest 'dist'
  gulp.src paths.vendor + '/requirejs/require.js'
    .pipe uglify()
    .pipe gulp.dest paths.dist + '/assets/js/'

# The default task (called when you run `gulp`)
gulp.task 'default', [
  'clean'
  'watch'
]

# Build
gulp.task 'build', [
  'coffee'
  'images'
  'compass'
  'w3cjs'
  'copy'
]

gulp.task 'release', (cb) ->
  runs(['build', 'rjs', 'rename'], cb)