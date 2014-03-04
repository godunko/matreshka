
all:
	gprbuild -p -j0 -P dom.gpr
	gprbuild -p -j0 -P domconf.gpr
	gprbuild -p -j0 -P odf.gpr -k
	gprbuild -p -j0 -P demo.gpr
	.objs/domconf ../dom/testsuite/DOM-Test-Suite/tests/level2/core/createDocument01.xml

gen:
	gprbuild -p -j0 -P tools.gpr
	rm -rf .new
	mkdir .new
	.objs/odfgen odf.xml > .new/sources.ada
	gnatchop -w .new/sources.ada .new
	ls .new/*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/generated/{}
	rm -rf .new

