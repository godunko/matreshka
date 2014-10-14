all:
	gprbuild -p -P asis2js.gpr
	cd examples; gcc -c -gnatct -I../webapi -I../webapi/dom -I../webapi/html hello_world.adb
	./asis2js "-CA -Texamples" `pwd`/examples/hello_world.adb
