all:
	gprbuild -p -P asis2js.gpr
	gprbuild -c -u -p -P examples/examples.gpr hello_world.adb -cargs -gnatct
	./asis2js "-CA -Texamples/.objs" `pwd`/examples/hello_world.adb
