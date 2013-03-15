API=../DOM-Test-Suite/build/dom2-core-interfaces.xml

all: $(API)
	xsltproc \
	 --stringparam interfaces-docname $(API) \
	 test-to-ada.xsl \
	 ../DOM-Test-Suite/tests/level2/core/createElementNS05.xml

$(API):
	ant -buildfile ../DOM-Test-Suite/build.xml  dom2-core-jar