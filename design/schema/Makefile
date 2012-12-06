
all:
	gprbuild -j0 -p -Pschema.gpr
	gprbuild -j0 -p -Pdriver/driver.gpr
	./driver/driver iats.xsd
