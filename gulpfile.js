'use strict';

var gulp = require('gulp'),
    coffee = require('gulp-coffee'),
    coffeelint = require('gulp-coffeelint'),
    compass = require('gulp-compass'),
    lr = require('tiny-lr'),
    refresh = require('gulp-livereload'),
    server = lr(),
    w3cjs = require('gulp-w3cjs'),
    jshint = require('gulp-jshint');

gulp.task('coffee', function() {
    gulp.src('app/assets/coffeescript/**/*.coffee')
        .pipe(coffeelint({'indentation': {
            'name': 'indentation',
            'value': 4,
            'level': 'error'
        }}))
        .pipe(coffeelint.reporter())
        .pipe(coffee({bare: true}))
        .pipe(gulp.dest('app/assets/js/'))
        .pipe(refresh(server));
});

gulp.task('w3cjs', function () {
    gulp.src('app/*.html')
        .pipe(w3cjs())
        .pipe(refresh(server));
});

gulp.task('compass', function() {
    gulp.src('app/assets/sass/**/*.scss')
        .pipe(compass({
            css: 'app/assets/css',
            sass: 'app/assets/sass',
            image: 'app/assets/images'
        }))
        .pipe(refresh(server));
});

gulp.task('lint', function() {
    gulp.src('gulpfile.js')
        .pipe(jshint({
            'node': true,
            'esnext': true,
            'bitwise': true,
            'camelcase': false,
            'curly': true,
            'eqeqeq': true,
            'immed': true,
            'indent': 4,
            'latedef': true,
            'newcap': true,
            'noarg': true,
            'quotmark': 'single',
            'regexp': true,
            'undef': true,
            'unused': true,
            'strict': true,
            'trailing': true,
            'smarttabs': true,
            'globals': {
                /* MOCHA */
                'describe'   : false,
                'it'         : false,
                'before'     : false,
                'beforeEach' : false,
                'after'      : false,
                'afterEach'  : false,
                'require'    : false
            }
        }))
        .pipe(jshint.reporter('default'));
});

// The default task (called when you run `gulp`)
gulp.task('default', function() {
    gulp.run('lint');

    // Watch files and run tasks if they change
    server.listen(35729, function (err) {
        if (err) {
            return console.log(err);
        }
        gulp.watch('gulpfile.js', function() {
            gulp.run('lint');
        });
        gulp.watch('app/assets/coffeescript/**/*.coffee', function() {
            gulp.run('coffee');
        });
        gulp.watch(['app/*.html'], function() {
            gulp.run('w3cjs');
        });
        gulp.watch('app/assets/sass/**/*.scss', function() {
            gulp.run('compass');
        });
    });
});