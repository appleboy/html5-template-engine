require! {
    gulp: gulp
    coffee: 'gulp-coffee'
    coffeelint: 'gulp-coffeelint'
    compass: 'gulp-compass'
    w3cjs: 'gulp-w3cjs'
    jshint: 'gulp-jshint'
    clean: 'gulp-clean'
    imagemin: 'gulp-imagemin'
    cache: 'gulp-cache'
    changed: 'gulp-changed'
    connect: 'gulp-connect'
    size: 'gulp-size'
}

gulp.task \coffee ->
    gulp.src 'app/assets/coffee/**/*.coffee'
        .pipe changed \app/assets/js/ extension: '.js'
        .pipe coffeelint indentation:
            name: 'indentation'
            value: 4
            level: 'error'
        .pipe coffeelint.reporter()
        .pipe coffee bare: true
        .pipe gulp.dest \app/assets/js/
        .pipe gulp.dest \dist/assets/js/
        .pipe size()
        .pipe connect.reload()

gulp.task \test_coffee ->
    gulp.src 'test/**/*.coffee'
        .pipe changed \test/ extension: '.js'
        .pipe coffeelint indentation:
            name: 'indentation'
            value: 4
            level: 'error'
        .pipe coffeelint.reporter()
        .pipe coffee bare: true
        .pipe gulp.dest \test/
        .pipe size()

gulp.task \w3cjs ->
    gulp.src 'app/*.html'
        .pipe changed \dist
        .pipe w3cjs()
        .pipe gulp.dest \dist
        .pipe size()
        .pipe connect.reload()

gulp.task \compass ->
    gulp.src 'app/assets/sass/**/*.scss'
        .pipe changed \app/assets/css/ extension: '.css'
        .pipe compass(
            css: 'app/assets/css'
            sass: 'app/assets/sass'
            image: 'app/assets/images')
        .on 'error', ->
        .pipe gulp.dest 'dist/assets/css/'
        .pipe size()
        .pipe connect.reload()

gulp.task \lint ->
    gulp.src \gulpfile.js
        .pipe jshint \.jshintrc
        .pipe jshint.reporter \default
        .pipe size()

# Clean
gulp.task \clean ->
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
gulp.task \images ->
    gulp.src 'app/assets/images/**/*'
        .pipe changed 'dist/assets/images'
        .pipe cache imagemin(
            optimizationLevel: 3
            progressive: true
            interlaced: true)
        .pipe gulp.dest 'dist/assets/images'
        .pipe connect.reload()

# Connect
gulp.task \connect ->
    connect.server(
        root: ['app']
        port: 1337
        livereload: true)

gulp.task \watch <[connect]> ->
    # Watch files and run tasks if they change
    gulp.watch 'gulpfile.js', <[lint]>
    gulp.watch 'app/assets/coffee/**/*.coffee', <[coffee]>
    gulp.watch 'test/**/*.coffee', <[test_coffee]>
    gulp.watch 'app/*.html', <[w3cjs]>
    gulp.watch 'app/assets/sass/**/*.scss', <[compass]>
    gulp.watch 'app/assets/images/**/*', <[images]>
    true

# The default task (called when you run `gulp`)
gulp.task 'default' <[ clean watch ]>

# Build
gulp.task 'build' <[ clean coffee images compass w3cjs ]>
