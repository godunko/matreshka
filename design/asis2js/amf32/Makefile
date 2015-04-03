
all:
	gprbuild -p -P amf3.gpr

js:
	make -C .. a2js
	gprbuild -c -p -P amf3.gpr -cargs -gnatct
	../asis2js "-CA -T.objs" `pwd`/amf3.ads
	../asis2js "-CA -T.objs" `pwd`/amf3-slots.ads
	../asis2js "-CA -T.objs" `pwd`/amf3-slots-integers.ads
	../asis2js "-CA -T.objs" `pwd`/amf3-slots-long_floats.ads

run: all
	.objs/demo-driver

clean:
	rm -rf .objs
