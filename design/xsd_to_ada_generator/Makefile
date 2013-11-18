
all:
	AMF_DATA_DIR=../schema/driver
	gprbuild -j0 -p -P schema.gpr
	gprbuild -j0 -p -P xsd_to_ada.gpr
	(./xsd_to_ada_generator ../../../trading_server/src/client/soap/iats.xsd ../../../trading_server/src/client/soap/mapping.xml)
	
gen: all
	AMF_DATA_DIR=../schema/driver

clean:
	rm -rf .objs
	rm -f xsd_to_ada_generator
	rm -f Payloads.ads
	rm -f Encoder.ads
	rm -f Encoder.adb