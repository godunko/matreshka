
all:
	gprbuild -p -j0 -P dom.gpr
	gprbuild -p -j0 -P domconf.gpr
	gprbuild -p -j0 -P odf.gpr
	.objs/domconf ../dom/testsuite/DOM-Test-Suite/tests/level2/core/createDocument01.xml
