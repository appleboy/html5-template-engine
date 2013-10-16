module.exports = (grunt) ->
    # build time
    filetime = Date.now()
    # Project configuration
    project_config =
        app: 'app'
        test: 'test'
        output: 'output'
        build: 'build'
    grunt.initConfig
        pkg: project_config
        shell:
            bower:
                command: 'node node_modules/.bin/bower install'
                options:
                    stdout: true
                    stderr: true
                    callback: (err, stdout, stderr, cb) ->
                        console.log('Install bower package compeletely.')
                        cb()
            build:
                command: 'node node_modules/requirejs/bin/r.js -o <%= pkg.build %>/self.build.js'
                options:
                    stdout: true
                    stderr: true
            release:
                command: 'node node_modules/requirejs/bin/r.js -o <%= pkg.build %>/app.build.js'
                options:
                    stdout: true
                    stderr: true
            test:
                command: './node_modules/.bin/mocha --reporter spec <%= pkg.test %>/test.js'
                options:
                    stdout: true
                    stderr: true
        bower:
            install:
                options:
                    cleanup: false
                    install: true
                    verbose: true
                    copy: false
            cleanup:
                options:
                    cleanup: true
                    verbose: true
                    install: false
                    copy: false
        requirejs:
            build:
                options:
                    baseUrl: '<%= pkg.app %>/assets/js/'
                    name: 'main'
                    out: '<%= pkg.app %>/assets/js/main-built.js'
                    mainConfigFile: '<%= pkg.app %>/assets/js/main.js'
                    preserveLicenseComments: false
                    paths:
                        jquery: '../vendor/jquery/jquery'
            release:
                options:
                    ###
                    support generate Source Maps, make sure requirejs version in 2.1.2
                    optimize: 'uglify2'
                    generateSourceMaps: true
                    ###
                    appDir: "<%= pkg.app %>/"
                    baseUrl: "assets/js/"
                    dir: "<%= pkg.output %>"
                    name: "main"
                    mainConfigFile: '<%= pkg.app %>/assets/js/main.js'
                    preserveLicenseComments: false
                    fileExclusionRegExp: /^(\.|node_modules)/
                    paths:
                        jquery: '../vendor/jquery/jquery'
        express:
            dev:
                options:
                    script: '<%= pkg.build %>/server.js'
        connect:
            server:
                options:
                    base: '<%= pkg.app %>'
                    hostname: '0.0.0.0'
                    port: 4000

        watch:
            html:
                files: ['<%= pkg.app %>/**/*.{html,htm}']
                options:
                    livereload: true
            scss:
                files: ['<%= pkg.app %>/**/*.scss'],
                tasks: ['compass:dev']
            css:
                files: ['<%= pkg.app %>/**/*.css'],
                options:
                    livereload: true
            js:
                files: '<%= pkg.app %>/**/*.js',
                options:
                    livereload: true
            coffee:
                files: ['**/*.coffee', '!**/node_modules/**', '!**/vendor/**'],
                tasks: ['coffeelint', 'docco:dev', 'coffee']

        coffeelint:
            options:
                'force': true
                'no_trailing_whitespace':
                    'level': 'error'
                'max_line_length':
                    'level': 'ignore'
                'indentation':
                    'value': 4
                    'level': 'error'
            dev: ['**/*.coffee', '!**/node_modules/**', '!**/vendor/**']
        compass:
            dev:
                options:
                    ###
                    Load config from config.rb file
                    basePath: '<%= pkg.app %>/assets'
                    config: 'config.rb'
                    ###
                    sassDir: '<%= pkg.app %>/assets/sass'
                    cssDir: '<%= pkg.app %>/assets/css'
                    imagesDir: '<%= pkg.app %>/assets/images'
                    javascriptsDir: '<%= pkg.app %>/assets/js'
                    outputStyle: 'nested'
                    relativeAssets: true
                    noLineComments: true
                    debugInfo: true
                    environment: 'development'
            release:
                options:
                    sassDir: '<%= pkg.output %>/assets/sass'
                    cssDir: '<%= pkg.output %>/assets/css'
                    imagesDir: '<%= pkg.output %>/assets/images'
                    javascriptsDir: '<%= pkg.output %>/assets/js'
                    outputStyle: 'compressed'
                    relativeAssets: true
                    noLineComments: true
                    environment: 'production'
        cssmin:
            release:
                report: 'gzip'
                expand: true
                cwd: '<%= pkg.output %>/assets/css'
                src: ['*.css']
                dest: '<%= pkg.output %>/assets/css'
        coffee:
            dev:
                expand: true,
                cwd: '<%= pkg.app %>/assets/coffeescript/',
                src: ['**/*.coffee'],
                dest: '<%= pkg.app %>/assets/js/',
                ext: '.js'
                options:
                    bare: true
            test:
                expand: true,
                cwd: '<%= pkg.test %>/',
                src: ['**/*.coffee'],
                dest: '<%= pkg.test %>/',
                ext: '.js'
                options:
                    bare: true
            server:
                files:
                    '<%= pkg.build %>/server.js': '<%= pkg.build %>/server.coffee'
                options:
                    bare: true
            grunt:
                files:
                    'Gruntfile.js': 'Gruntfile.coffee'
                options:
                    bare: true
        clean:
            options:
                force: true
            js: '<%= pkg.output %>/assets/js'
            release: [
                '<%= pkg.output %>/build.txt'
                '<%= pkg.output %>/assets/coffeescript'
                '<%= pkg.output %>/assets/sass'
                '<%= pkg.output %>/assets/vendor'
                '<%= pkg.output %>/.sass-cache'
            ]
            cleanup: [
                '<%= pkg.output %>'
                '<%= pkg.app %>/assets/vendor'
                '<%= pkg.app %>/assets/js/main-built.js'
                '<%= pkg.app %>/assets/js/main-built.js.map'
                '<%= pkg.app %>/assets/js/main-built.js.src'
                'node_modules'
                '.sass-cache'
            ]
        copy:
            release:
                files: [
                    {src: '<%= pkg.app %>/.htaccess', dest: '<%= pkg.output %>/.htaccess'}
                    {src: '<%= pkg.output %>/assets/vendor/requirejs/require.js', dest: '<%= pkg.output %>/assets/js/require.js'}
                    {src: '<%= pkg.app %>/assets/js/main-built.js', dest: '<%= pkg.output %>/assets/js/' + filetime + '.js'}
                ]
        replace:
            release:
                src: '<%= pkg.output %>/index.html'
                dest: '<%= pkg.output %>/index.html'
                replacements: [
                    {
                        from: 'js/main'
                        to: 'js/' + filetime
                    },
                    {
                        from: 'vendor/requirejs/'
                        to: 'js/'
                    }
                ]
        htmlmin:
            options:
                removeComments: true
                collapseWhitespace: true
            dev:
                files:
                    '<%= pkg.app %>/index.html': '<%= pkg.app %>/index.html'
            release:
                files:
                    '<%= pkg.output %>/index.html': '<%= pkg.app %>/index.html'
        docco:
            dev:
                src: ['<%= pkg.app %>/**/*.coffee']
                options:
                    output: '<%= pkg.app %>/docs/'

        mocha_phantomjs:
            all: '<%= pkg.test %>/**/*.html'

    grunt.event.on 'watch', (action, filepath) ->
        grunt.log.writeln filepath + ' has ' + action

    grunt.registerTask 'init', () ->
        grunt.log.writeln 'Initial project'
        (grunt.file.exists project_config.app + '/assets/vendor') || grunt.task.run 'bower:install'

    grunt.registerTask 'release', () ->
        grunt.log.writeln 'deploy project'
        (grunt.file.exists project_config.app + '/assets/vendor') || grunt.task.run 'bower:install'
        grunt.task.run ['coffee:dev', 'compass:dev', 'requirejs:build', 'requirejs:release', 'cssmin:release', 'clean:js']
        grunt.file.mkdir project_config.output + '/assets/js'
        grunt.task.run 'copy:release'
        grunt.task.run 'htmlmin:release'
        grunt.task.run 'replace:release'
        grunt.task.run 'clean:release'

    # run local server by grunt-contrib-connect plugin
    grunt.registerTask 'default', ['init', 'connect', 'coffee:dev', 'compass:dev', 'watch']
    # run local express server.
    #grunt.registerTask 'default', ['init', 'express:dev', 'livereload-start']
    grunt.registerTask 'cleanup', ['clean:cleanup']
    grunt.registerTask 'test', ['release', 'shell:test', 'mocha_phantomjs']

    # Dependencies
    grunt.loadNpmTasks 'grunt-shell'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-connect'
    grunt.loadNpmTasks 'grunt-contrib-compass'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-text-replace'
    grunt.loadNpmTasks 'grunt-contrib-htmlmin'
    grunt.loadNpmTasks 'grunt-requirejs'
    grunt.loadNpmTasks 'grunt-bower-task'
    grunt.loadNpmTasks 'grunt-contrib-cssmin'
    grunt.loadNpmTasks 'grunt-express-server'
    grunt.loadNpmTasks 'grunt-mocha-phantomjs'
    grunt.loadNpmTasks 'grunt-coffeelint'
    grunt.loadNpmTasks 'grunt-docco2'
