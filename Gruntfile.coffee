module.exports = (grunt) ->
    # build time
    filetime = Date.now();
    # Project configuration
    project_config =
        app: 'app'
        output: 'output'
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
                command: 'node node_modules/requirejs/bin/r.js -o build/self.build.js'
                options:
                    stdout: true
                    stderr: true
            release:
                command: 'node node_modules/requirejs/bin/r.js -o build/app.build.js'
                options:
                    stdout: true
                    stderr: true
        connect:
            livereload:
                options:
                    hostname: '0.0.0.0'
                    port: 3000
                    base: '.'
        regarde:
            html:
                files: ['<%= pkg.app %>/**/*.{html,htm}']
                tasks: ['livereload']
                events: true
            scss:
                files: ['<%= pkg.app %>/**/*.scss'],
                tasks: ['compass:dev']
                events: true
            css:
                files: ['<%= pkg.app %>/**/*.css'],
                tasks: ['livereload']
                events: true
            js:
                files: '<%= pkg.app %>/**/*.js',
                tasks: ['livereload']
                events: true
            coffee:
                files: '**/*.coffee',
                tasks: ['coffee']
                events: true
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
                    environment: 'development'
            release:
                options:
                    force: true
                    sassDir: '<%= pkg.output %>/assets/sass'
                    cssDir: '<%= pkg.output %>/assets/css'
                    imagesDir: '<%= pkg.output %>/assets/images'
                    javascriptsDir: '<%= pkg.output %>/assets/js'
                    outputStyle: 'compressed'
                    relativeAssets: true
                    noLineComments: true
                    environment: 'production'
        coffee:
            dev:
                expand: true,
                cwd: '<%= pkg.app %>/assets/coffeescript/',
                src: ['**/*.coffee'],
                dest: '<%= pkg.app %>/assets/js/',
                ext: '.js'
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
                '<%= pkg.output %>/assets/.sass-cache'
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
                '<%= pkg.app %>/assets/.sass-cache'
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

    grunt.event.on 'watch', (action, filepath) ->
        grunt.log.writeln filepath + ' has ' + action

    grunt.event.on 'regarde:file', (status, name, filepath, tasks, spawn) ->
        grunt.log.writeln 'File ' + filepath + ' ' + status + '. Tasks: ' + tasks

    grunt.registerTask 'init', () ->
        grunt.log.writeln 'Initial project'
        (grunt.file.exists project_config.app + '/assets/vendor') || grunt.task.run 'shell:bower'

    grunt.registerTask 'release', () ->
        grunt.log.writeln 'deploy project'
        (grunt.file.exists project_config.app + '/assets/vendor') || grunt.task.run 'shell:bower'
        grunt.task.run ['shell:build', 'shell:release', 'compass:release', 'clean:js']
        grunt.file.mkdir project_config.output + '/assets/js'
        grunt.task.run 'copy:release'
        grunt.task.run 'htmlmin:release'
        grunt.task.run 'replace:release'
        grunt.task.run 'clean:release'

    # Dependencies
    grunt.loadNpmTasks 'grunt-regarde'
    grunt.loadNpmTasks 'grunt-shell'
    grunt.loadNpmTasks 'grunt-contrib-connect'
    grunt.loadNpmTasks 'grunt-contrib-livereload'
    grunt.loadNpmTasks 'grunt-contrib-compass'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-text-replace'
    grunt.loadNpmTasks 'grunt-contrib-htmlmin'

    grunt.registerTask 'default', ['init', 'livereload-start', 'connect', 'regarde']