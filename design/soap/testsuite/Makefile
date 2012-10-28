VALGRIND = valgrind --leak-check=full --show-reachable=yes --suppressions=gnat.supp --quiet --error-exitcode=7

all:
	gprbuild -p -P test.gpr
	.objs/test_248
	.objs/soapconf-driver
	$(VALGRIND) .objs/soapconf-driver
