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
	./asis2js "-CA -Texamples/.objs" `pwd`/examples/hello_webgl.ads

check:
	rm -rf testsuite/.objs/*
	gprbuild -c -u -p -P testsuite/testsuite.gpr -cargs -gnatct
	./asis2js "-CA -Ttestsuite/.objs" \
		`pwd`/testsuite/acats/include/report.ads \
		`pwd`/testsuite/acats/A/A22006B.ADA \
		> /tmp/aaa.js
	echo 'a22006b()' >> /tmp/aaa.js
	node /tmp/aaa.js | tee /tmp/result.txt
	diff -u testsuite/output.txt /tmp/result.txt
