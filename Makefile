.PHONY: output

all:
	r.js -o bin/self.build.js

output:
	rm -rf output
	r.js -o bin/app.build.js
	cp -r output/assets/js/vendor/requirejs/require.js output/assets/js/
	rm -rf output/.bowerrc output/build.txt output/.gitignore
	rm -rf output/component.json output/Makefile output/README.mkd
	rm -rf output/.git output/bin
	rm -rf output/assets/coffeescript output/assets/sass
	rm -rf output/assets/config.rb
	rm -rf output/assets/js/app.js output/assets/js/main.js
	rm -rf output/assets/js/vendor
	sed -i 's/js\/main/js\/main-built/g' output/index.html
	sed -i 's/vendor\/requirejs\///g' output/index.html
