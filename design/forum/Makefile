INSTALL = install -c
INSTALL_libs = $(INSTALL) -m 0555
INSTALL_data = $(INSTALL) -m 0444
SOEXT = .so

all:
	gprbuild -p -P test.gpr

web:
	gprbuild -p -P forum_web.gpr

initdb:
	dropdb forum || true
	createdb forum
	psql forum -f forum.sql


clean:
	rm -rf awfc/.objs opm/.objs forum/.objs .objs

deploy:
	rm -rf install
	$(INSTALL) -d install
	$(INSTALL) -d install/WEB-INF
	$(INSTALL) -d install/WEB-INF/lib
	$(INSTALL) -d install/WEB-INF/lib/x86_64-linux
	$(INSTALL) -d install/WEB-INF/templates
	$(INSTALL) -d install/WEB-INF/templates/account
	$(INSTALL_libs) .libs/libforumServer$(SOEXT) install/WEB-INF/lib/x86_64-linux/
	$(INSTALL_libs) .libs/libmatreshka-forum$(SOEXT) install/WEB-INF/lib/x86_64-linux/libmatreshka-forum$(SOEXT)
	$(INSTALL_libs) .libs/libmatreshka-opm$(SOEXT) install/WEB-INF/lib/x86_64-linux/libmatreshka-opm$(SOEXT)
	$(INSTALL_data) templates/page.xhtml.tmpl install/WEB-INF/templates/
	$(INSTALL_data) templates/forum_list.xhtml.tmpl install/WEB-INF/templates/
	$(INSTALL_data) templates/topic_list.xhtml.tmpl install/WEB-INF/templates/
	$(INSTALL_data) templates/post_list.xhtml.tmpl install/WEB-INF/templates/
	$(INSTALL_data) awfc/templates/account/signup.xhtml.tmpl install/WEB-INF/templates/account/
	$(INSTALL_data) forum.css install/
	$(INSTALL_data) web.xml install/WEB-INF/