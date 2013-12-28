var gulp = require('gulp'),
    coffee = require('gulp-coffee'),
    coffeelint = require('gulp-coffeelint'),
    lr = require('tiny-lr'),
    refresh = require('gulp-livereload'),
    compass = require('gulp-compass'),
    gutil = require('gulp-util'),
    bower = require('bower'),
    server = lr();

// import grunt task
require('gulp-grunt')(gulp);

gulp.task('coffee', function() {
    gulp.src('app/assets/coffeescript/**/*.coffee')
        .pipe(coffeelint({"indentation": {
            "name": "indentation",
            "value": 4,
            "level": "error"
        }}))
        .pipe(coffeelint.reporter())
        .pipe(coffee({bare: true}))
        .pipe(gulp.dest('app/assets/js/'))
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

gulp.task('livereload', function() {
    gulp.src(['app/*.html'])
        .pipe(refresh(server));
});

// The default task (called when you run `gulp`)
gulp.task('default', function() {
    gutil.log("Install vendor library via bower package command, pleae wait ...");

    bower.commands.install([], {})
        .on('log', function (result) {
            gutil.log(['bower', result.id.cyan, result.message].join(' '));
        })
        .on('end', function (results) {
            // Watch files and run tasks if they change
            server.listen(35729, function (err) {
                if (err) return console.log(err);
                gulp.watch('app/assets/coffeescript/**/*.coffee', function(event) {
                    gulp.run('coffee');
                });
                gulp.watch(['app/*.html'], function(event) {
                    gulp.run('livereload');
                });
                gulp.watch('app/assets/sass/**/*.scss', function(event) {
                    gulp.run('compass');
                });
            });
            gutil.log('Watch files and run tasks if they change.');
        });
});