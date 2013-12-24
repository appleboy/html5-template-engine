var gulp = require('gulp'),
    handlebars = require('gulp-handlebars'),
    coffee = require('gulp-coffee');

gulp.task('coffee', function() {
    gulp.src('app/assets/coffeescript/**/*.coffee')
        .pipe(coffee({bare: true}))
        .pipe(gulp.dest('app/assets/js/'))
});

// The default task (called when you run `gulp`)
gulp.task('default', function() {
    // Watch files and run tasks if they change
    gulp.watch('app/assets/coffeescript/**/*.coffee', function(event) {
        gulp.run('coffee');
    });
});