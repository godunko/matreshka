all: a2js
	rm -rf examples/.objs/*
	gprbuild -c -u -p -P examples/examples.gpr hello_world.adb -cargs -gnatct
	./asis2js `pwd`/examples/hello_world.adb
	rm -rf examples/.objs/*
	gprbuild -c -u -p -P examples/examples.gpr gldraw.adb -cargs -gnatct
	./asis2js `pwd`/examples/gldraw.adb

a2js:
	gprbuild -p -P asis2js.gpr

build-webapi:
	gprbuild -p -P webapi/webapi.gpr -cargs -gnatct

webgl:
	rm -rf examples/.objs/*
	gprbuild -c -u -p -P examples/examples.gpr hello_webgl.adb -cargs -gnatct
	./asis2js "-CA -Texamples/.objs" `pwd`/examples/hello_webgl.ads

check:
	${MAKE} -C testsuite
