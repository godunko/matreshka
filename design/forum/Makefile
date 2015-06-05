INSTALL = install -c
INSTALL_libs = $(INSTALL) -m 0555
INSTALL_data = $(INSTALL) -m 0444

all:
	gprbuild -p -P test.gpr

web:
	gprbuild -p -P forum_web.gpr

initdb:
	dropdb forum || true
	createdb forum
	psql forum -f forum.sql


clean:
	rm -rf opm/.objs forum/.objs .objs

deploy:
	rm -rf install
	$(INSTALL) -d install
	$(INSTALL) -d install/glsl
	$(INSTALL) -d install/js
	$(INSTALL) -d install/WEB-INF
	$(INSTALL) -d install/WEB-INF/help
	$(INSTALL) -d install/WEB-INF/lib
	$(INSTALL) -d install/WEB-INF/lib/x86_64-linux
	$(INSTALL) -d install/WEB-INF/templates
	$(INSTALL_libs) .libs/libforumServer.so install/WEB-INF/lib/x86_64-linux/libhdaServer.so
	$(INSTALL_libs) .libs/libmatreshka-forum.so install/WEB-INF/lib/x86_64-linux/libmatreshka-forum.so
	$(INSTALL_libs) .libs/libmatreshka-opm.so install/WEB-INF/lib/x86_64-linux/libmatreshka-opm.so
	$(INSTALL_data) page.xhtml.tmpl install/WEB-INF/templates/
