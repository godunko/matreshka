
all:
	gprbuild -p -P gmvc.gpr -gnatct
	mkdir -p .objs/js
	../asis2js '-CA -T.objs' `pwd`/gmvc-items.ads > .objs/js/gmvc.items.js
