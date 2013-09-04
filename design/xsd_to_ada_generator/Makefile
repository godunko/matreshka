
all:
	gprbuild -j0 -p -P xsd_to_ada.gpr

gen: all
	AMF_DATA_DIR=../schema/driver ./xsd_to_ada_generator ../../../trading_server/src/client/soap/iats.xsd

clean:
	rm -rf .objs
	rm -f xsd_to_ada_generator
