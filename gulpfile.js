var gulp = require('gulp'),
    handlebars = require('gulp-handlebars'),
    coffee = require('gulp-coffee'),
    lr = require('tiny-lr'),
    refresh = require('gulp-livereload'),
    compass = require('gulp-compass'),
    server = lr();

// import grunt task
require('gulp-grunt')(gulp);

gulp.task('coffee', function() {
    gulp.src('app/assets/coffeescript/**/*.coffee')
        .pipe(coffee({bare: true}))
        .pipe(gulp.dest('app/assets/js/'))
        .pipe(refresh(server));
});

gulp.task('compass', function() {
    gulp.src('app/assets/sass/**/*.scss')
        .pipe(compass())
        .pipe(refresh(server));
});

gulp.task('sass', function() {
    gulp.run('grunt-sass');
});

gulp.task('livereload', function() {
    gulp.src(['app/*.html', 'app/assets/css/**/*.css'])
        .pipe(refresh(server));
});

// The default task (called when you run `gulp`)
gulp.task('default', function() {
    // Watch files and run tasks if they change
    server.listen(35729, function (err) {
        if (err) return console.log(err);
        gulp.watch('app/assets/coffeescript/**/*.coffee', function(event) {
            gulp.run('coffee');
        });
        gulp.watch(['app/*.html', 'app/assets/css/**/*.css'], function(event) {
            gulp.run('livereload');
        });
        gulp.watch('app/assets/sass/**/*.scss', function(event) {
            gulp.run('compass');
        });
    });
});