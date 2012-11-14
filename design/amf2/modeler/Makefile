
all:
	gprbuild -j0 -XBUILD_MODE=MOC -p -Pmodeler.gpr
	gprbuild -j0 -XBUILD_MODE=APP -p -Pmodeler.gpr

clean:
	rm -rf .objs .amoc
