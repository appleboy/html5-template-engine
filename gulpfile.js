'use strict';

var gulp = require('gulp'),
    coffee = require('gulp-coffee'),
    coffeelint = require('gulp-coffeelint'),
    compass = require('gulp-compass'),
    lr = require('tiny-lr'),
    livereload = require('gulp-livereload'),
    server = lr(),
    w3cjs = require('gulp-w3cjs'),
    jshint = require('gulp-jshint'),
    clean = require('gulp-clean'),
    imagemin = require('gulp-imagemin'),
    cache = require('gulp-cache');

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
        .pipe(livereload(server));
});

gulp.task('w3cjs', function () {
    gulp.src('app/*.html')
        .pipe(w3cjs())
        .pipe(livereload(server));
});

gulp.task('compass', function() {
    gulp.src('app/assets/sass/**/*.scss')
        .pipe(compass({
            css: 'app/assets/css',
            sass: 'app/assets/sass',
            image: 'app/assets/images'
        }))
        .pipe(livereload(server));
});

gulp.task('lint', function() {
    gulp.src('gulpfile.js')
        .pipe(jshint('.jshintrc'))
        .pipe(jshint.reporter('default'));
});

gulp.task('lr-server', function() {
    server.listen(35729, function(err) {
        if(err) {
            return console.log(err);
        }
    });
});

gulp.task('watch', function() {
    // Watch files and run tasks if they change
    gulp.watch('gulpfile.js', function(event) {
        console.log('File ' + event.path + ' was ' + event.type + ', running tasks...');
        gulp.run('lint');
    });

    gulp.watch('app/assets/coffeescript/**/*.coffee', function(event) {
        console.log('File ' + event.path + ' was ' + event.type + ', running tasks...');
        gulp.run('coffee');
    });

    gulp.watch(['app/*.html'], function(event) {
        console.log('File ' + event.path + ' was ' + event.type + ', running tasks...');
        gulp.run('w3cjs');
    });

    gulp.watch('app/assets/sass/**/*.scss', function(event) {
        console.log('File ' + event.path + ' was ' + event.type + ', running tasks...');
        gulp.run('compass');
    });

    gulp.watch('app/assets/images/**/*', function(event) {
        console.log('File ' + event.path + ' was ' + event.type + ', running tasks...');
        gulp.run('images');
    });
});

// Clean
gulp.task('clean', function() {
    return gulp.src(['output', '.sass-cache'], {read: false})
        .pipe(clean());
});

// Images
gulp.task('images', function() {
    return gulp.src('app/assets/images/**/*')
        .pipe(cache(imagemin({ optimizationLevel: 3, progressive: true, interlaced: true })))
        .pipe(livereload(server))
        .pipe(gulp.dest('app/assets/images'));
});

// The default task (called when you run `gulp`)
gulp.task('default', ['clean'], function() {
    gulp.run('lint', 'lr-server', 'watch');
});