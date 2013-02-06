({
    appDir: "../",
    baseUrl: "assets/js/",
    dir: "../output",
    name: "main",
    mainConfigFile: "../assets/js/main.js",
    preserveLicenseComments: false,
    // support generate Source Maps, make sure requirejs version in 2.1.2
    // optimize: "uglify2",
    // generateSourceMaps: true,
    fileExclusionRegExp: /^(\.|node_modules)/,
    paths: {
        jquery: "../vendor/jquery/jquery"
    }
})