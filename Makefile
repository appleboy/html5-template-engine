.PHONY: release init build css

#
# Using time as file name
filetime:=$(shell date '+%s%N')

all: init
	r.js -o build/self.build.js

init:
	@which bower > /dev/null 2>&1 ; if [ $$? -ne 0 ] ; then ./build/build.sh ; fi
	@test -d "assets/vendor" || bower install
	@echo "Install bower package compeletely."
	@npm install

build:
	rm -rf output
	r.js -o build/app.build.js

css:
	for file in $(shell find output/assets/css/ -type f -name '*.css'); \
	do \
		sqwish $$file -o $$file; \
	done

release: all build css
	rm -rf output/assets/js/*
	cp -r .htaccess output/
	cp -r output/assets/vendor/requirejs/require.js output/assets/js/
	cp -r assets/js/main-built.js output/assets/js/$(filetime).js
	rm -rf output/package.json output/build.txt
	rm -rf output/component.json output/Makefile output/README.mkd output/build
	rm -rf output/assets/coffeescript output/assets/sass output/assets/config.rb
	rm -rf output/assets/vendor output/Gruntfile.*
	sed -i 's/js\/main/js\/$(filetime)/g' output/index.html
	sed -i 's/vendor\/requirejs\//js\//g' output/index.html
	-java -jar build/htmlcompressor-1.5.3.jar --compress-js -o output/index.html output/index.html
	@echo
	@echo "======================================================="
	@echo "=> Install compeletely."
	@echo "=> Please copy output folder to your web root path."
	@echo "======================================================="
	@echo

clean:
	rm -rf output
	rm -rf assets/js/main-built.js
	rm -rf assets/js/main-built.js.map
	rm -rf assets/js/main-built.js.src
	rm -rf assets/vendor/
	rm -rf .sass-cache
	rm -rf assets/.sass-cache
	rm -rf node_modules/
