all:
	gprbuild -p -P asis2js.gpr
	rm -rf examples/.objs/*
	gprbuild -c -u -p -P examples/examples.gpr hello_world.adb -cargs -gnatct
	./asis2js "-CA -Texamples/.objs" `pwd`/examples/hello_world.adb
	rm -rf examples/.objs/*
	gprbuild -c -u -p -P examples/examples.gpr gldraw.adb -cargs -gnatct
	./asis2js "-CA -Texamples/.objs" `pwd`/examples/gldraw.adb

webgl:
	rm -rf examples/.objs/*
	gprbuild -c -u -p -P examples/examples.gpr hello_webgl.adb -cargs -gnatct
	./asis2js "-CA -Texamples/.objs" `pwd`/examples/hello_webgl.adb
