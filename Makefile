.PHONY: output

#
# Using time as file name
filetime:=$(shell date '+%s%N')

all:
	r.js -o bin/self.build.js

output: all
	rm -rf output
	r.js -o bin/app.build.js
	cp -r output/assets/vendor/requirejs/require.js output/assets/js/
	cp -r assets/js/main-built.js output/assets/js/$(filetime).js
	rm -rf output/.bowerrc output/build.txt output/.gitignore output/.git
	rm -rf output/component.json output/Makefile output/README.mkd output/bin
	rm -rf output/assets/coffeescript output/assets/sass output/assets/config.rb
	rm -rf output/assets/js/app.js output/assets/js/main.js output/assets/vendor
	sed -i 's/js\/main/js\/$(filetime)/g' output/index.html
	sed -i 's/vendor\/requirejs\//js\//g' output/index.html
	@echo
	@echo "======================================================="
	@echo "=> Install compeletely."
	@echo "=> Please copy output folder to your web root path."
	@echo "======================================================="
	@echo

clean:
	rm -rf output
	rm -rf assets/js/main-built.js
