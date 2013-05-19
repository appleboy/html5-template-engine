.PHONY: release init build css test compass coffee livereload server

# setup path
app_path ?= $(shell echo "app")
output_path ?= $(shell echo "output")

# Using time as file name
filetime:=$(shell date '+%s%N')

all: init
	r.js -o build/self.build.js

compass:
	$@ watch .

coffee:
	$@ -b -w -c -o $(app_path)/assets/js $(app_path)/assets/coffeescript

livereload:
	guard start

server:
	node build/server.js

init:
	@which bower > /dev/null 2>&1 ; if [ $$? -ne 0 ] ; then ./build/build.sh ; fi
	@test -d "$(app_path)/assets/vendor" || bower install
	@echo "Install bower package compeletely."
	@npm install

build:
	rm -rf $(output_path)
	r.js -o build/app.build.js dir=$(output_path)

css:
	for file in `find $(output_path)/assets/css/ -type f -name '*.css'`; \
	do \
		sqwish $$file -o $$file; \
	done

release: all build css
	rm -rf $(output_path)/assets/js/*
	cp -r $(app_path)/.htaccess $(output_path)/
	cp -r $(output_path)/assets/vendor/requirejs/require.js $(output_path)/assets/js/
	cp -r $(app_path)/assets/js/main-built.js $(output_path)/assets/js/$(filetime).js
	rm -rf $(output_path)/build.txt
	rm -rf $(output_path)/assets/coffeescript $(output_path)/assets/sass
	rm -rf $(output_path)/assets/vendor
	sed -i 's/js\/main/js\/$(filetime)/g' $(output_path)/index.html
	sed -i 's/vendor\/requirejs\//js\//g' $(output_path)/index.html
#-java -jar build/htmlcompressor-1.5.3.jar --compress-js -o $(output_path)/index.html $(output_path)/index.html
	@which pyminify > /dev/null 2>&1 && pyminify $(app_path)/index.html > $(output_path)/index.html
	@echo
	@echo "======================================================="
	@echo "=> Install compeletely."
	@echo "=> Please copy output folder to your web root path."
	@echo "======================================================="
	@echo

clean:
	rm -rf $(output_path)
	rm -rf $(app_path)/assets/js/main-built.js
	rm -rf $(app_path)/assets/js/main-built.js.map
	rm -rf $(app_path)/assets/js/main-built.js.src
	rm -rf $(app_path)/assets/vendor/
	rm -rf .sass-cache
	rm -rf $(app_path)/assets/.sass-cache
	rm -rf node_modules/

test: release
	@./node_modules/.bin/mocha --reporter spec
