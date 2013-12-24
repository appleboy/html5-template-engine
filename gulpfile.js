var gulp = require('gulp'),
    handlebars = require('gulp-handlebars'),
    coffee = require('gulp-coffee'),
    lr = require('tiny-lr'),
    refresh = require('gulp-livereload'),
    server = lr();

gulp.task('coffee', function() {
    gulp.src('app/assets/coffeescript/**/*.coffee')
        .pipe(coffee({bare: true}))
        .pipe(gulp.dest('app/assets/js/'))
        .pipe(refresh(server));
});

gulp.task('livereload', function() {
    gulp.src('app/*.html')
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
        gulp.watch('app/*.html', function(event) {
            gulp.run('livereload');
        });
    });
});