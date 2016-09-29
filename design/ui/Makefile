GPRBUILDDB = /home/max/net/adalib.20160726/share/gprconfig

all:
	gprbuild -j0 -p -P gnat/ui_demo.gpr --db $(GPRBUILDDB) --target=javascript
	[ -d /tmp/test ] || mkdir /tmp/test
	cd .objs/ui/; ls *.js |xargs -I 1 js-beautify 1 --outfile /tmp/test/1
	cp resources/* /tmp/test
	cp ../../testsuite/a2js/library/league* /tmp/test
	cp ../..//source/web/tools/a2js/rtl/standard.js /tmp/test
	echo Run: file:///tmp/test/start-ada-by-browser.html

check: all

clean:
	rm -rf .objs
