all:
	gprbuild -P asis2js.gpr
	cd examples; gcc -c -gnatc -gnatt hello_world.adb
	./asis2js "-CA -Texamples" `pwd`/examples/hello_world.adb
