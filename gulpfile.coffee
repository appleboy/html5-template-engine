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
  gulp.src paths.coffee + '/**/*.coffee'
    .pipe gulpif !production, changed paths.script,
      extension: '.js'
    .pipe coffeelint()
    .pipe coffeelint.reporter()
    .pipe coffee bare: true
    .pipe gulp.dest paths.script
    .pipe size()
    .pipe connect.reload()

gulp.task 'test_coffee', ->
  gulp.src paths.test + '/**/*.coffee'
    .pipe gulpif !production, changed paths.test,
      extension: '.js'
    .pipe coffeelint()
    .pipe coffeelint.reporter()
    .pipe coffee bare: true
    .pipe gulp.dest paths.test
    .pipe size()

gulp.task 'w3cjs', ->
  gulp.src paths.src + '/*.html'
    .pipe gulpif !production, changed paths.dist
    .pipe w3cjs()
    .pipe gulpif production, htmlmin(
      removeComments: true
      collapseWhitespace: true
    )
    .pipe gulpif production, replace 'js/main', 'js/' + filename
    .pipe gulpif production, replace 'vendor/requirejs/require.js', 'js/require.js'
    .pipe gulp.dest paths.dist
    .pipe size()
    .pipe connect.reload()

gulp.task 'compass', ->
  gulp.src paths.sass + '/**/*.scss'
    .pipe gulpif !production, changed paths.css,
      extension: '.css'
    .pipe compass
      css: paths.css
      sass: paths.sass
      image: paths.image
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
    paths.dist
    '.sass-cache'
    paths.script
    paths.css
  ],
    read: false
  ).pipe clean()


# Images
gulp.task 'images', ->
  gulp.src paths.images + '/**/*.{jpg,jpeg,png,gif}'
    .pipe changed paths.dist + '/assets/images'
    .pipe cache imagemin
      progressive: true
      interlaced: true
    .pipe gulp.dest paths.dist + '/assets/images'
    .pipe connect.reload()

# testing via mocha tool
gulp.task 'test', ->
  gulp.src paths.test + '/test.js'
    .pipe mocha
      reporter: 'spec'

# Connect
gulp.task 'connect:app', ->
  connect.server
    root: [paths.src]
    port: 1337
    livereload: true

gulp.task 'connect:dist', ->
  connect.server
    root: [paths.dist]
    port: 1338
    livereload: true

gulp.task 'watch', ['connect:app'], ->
  # Watch files and run tasks if they change
  gulp.watch paths.coffee + '/**/*.coffee', ['coffee']
  gulp.watch paths.test + '/**/*.coffee', ['test_coffee']
  gulp.watch paths.src + '/*.html', ['w3cjs']
  gulp.watch paths.sass + '/**/*.scss', ['compass']
  gulp.watch paths.images + '/**/*.{jpg,jpeg,png,gif}', ['images']
  true

gulp.task 'copy', ->
  gulp.src [
    paths.src + '/.htaccess'
    paths.src + '/favicon.ico'
    paths.src + '/robots.txt']
    .pipe gulp.dest paths.dist

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
gulp.task 'default', (cb) ->
  runs(
    ['coffee', 'compass']
    'watch'
    cb)

# Build
gulp.task 'build', [
  'coffee'
  'images'
  'compass'
  'w3cjs'
  'copy'
]

gulp.task 'release', (cb) ->
  runs(
    ['build', 'rjs', 'rename']
    cb)

module.exports = gulp
