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
    return gulp.src('app/assets/coffeescript/**/*.coffee')
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
    return gulp.src('app/*.html')
        .pipe(w3cjs())
        .pipe(livereload(server));
});

gulp.task('compass', function() {
    return gulp.src('app/assets/sass/**/*.scss')
        .pipe(compass({
            css: 'app/assets/css',
            sass: 'app/assets/sass',
            image: 'app/assets/images'
        }))
        .pipe(livereload(server));
});

gulp.task('lint', function() {
    return gulp.src('gulpfile.js')
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

gulp.task('watch', function() {
    // Watch files and run tasks if they change
    gulp.watch('gulpfile.js', ['lint']);
    gulp.watch('app/assets/coffeescript/**/*.coffee', ['coffee']);
    gulp.watch('app/*.html', ['w3cjs']);
    gulp.watch('app/assets/sass/**/*.scss', ['compass']);
    gulp.watch('app/assets/images/**/*', ['images']);
});

// The default task (called when you run `gulp`)
gulp.task('default', ['clean', 'lint', 'lr-server', 'watch']);