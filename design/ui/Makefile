GPRBUILDDB = /home/max/net/adalib.20160325/share/gprconfig

all:
	gprbuild -j0 -p -P gnat/ui_demo.gpr --db $(GPRBUILDDB) --target=javascript
	[ -d /tmp/test ] || mkdir /tmp/test
	cd .objs/ui/; ls *.js |xargs -I 1 js-beautify 1 --outfile /tmp/test/1

check: all

clean:
	rm -rf .objs
