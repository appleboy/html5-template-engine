({
  baseUrl: "../app/assets/js/",
  name: "main",
  out: "../app/assets/js/main-built.js",
  mainConfigFile: "../app/assets/js/main.js",
  preserveLicenseComments: false,
  // support generate Source Maps, make sure requirejs version in 2.1.2
  // optimize: "uglify2",
  // generateSourceMaps: true,
  paths: {
    jquery: "../vendor/jquery/jquery"
  }
})