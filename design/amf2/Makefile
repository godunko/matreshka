
all:
	make -C ../..
#	gprbuild -p -j0 -Ptools/umlprofile2cmof/umlprofile2cmof.gpr
#	gprbuild -p -j0 -Ptools/umlmof2cmof/umlmof2cmof.gpr
	gprbuild -p -Pxmi.gpr
	gprbuild -p -Pgui/cmof_tree_view/gui_moc.gpr
	gprbuild -p -Pgui/cmof_tree_view/gui.gpr
	gprbuild -p -Pgui/modeler/modeler.gpr -XBUILD_MODE=MOC
	gprbuild -p -Pgui/modeler/modeler.gpr -XBUILD_MODE=APP
	gprbuild -p -Pgen-stage2/gens.gpr
#	time ./demo-reader data/cmof.cmof
#	./demo-viewer data/cmof.cmof
#	(cd data/2.4 && ../../demo-viewer UML.cmof)

sqldemo:
	gprbuild -p -j0 -P demo/demo.gpr
	(cd demo && AMF_DATA_DIR=../data ../demo-gen DemoSQL.xml)

gens:
	gprbuild -j0 -p -Pgen-stage2/gens.gpr

gen-all: gen-cmof gen-dd gen-uml gen-ocl gen-mofext gen-utp

gen-cmof: gens
	rm -rf .new
	mkdir .new
	AMF_DATA_DIR=data ./gen-stage2/.obj/gen2 2010 2011 CMOF 'http://schema.omg.org/spec/MOF/2.0/cmof.xml' > .new/sources.ada
	gnatchop -gnat05 -w .new/sources.ada .new
	ls .new/*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} ../../source/amf/mof/cmof/{}
	rm -r .new
	gprbuild -j0 -p -Pgen-stage2/gens.gpr
	rm -rf .new
	test -d .new || mkdir .new
	AMF_DATA_DIR=data ./gen-stage2/.obj/gen2 2010 2011 CMOF 'http://schema.omg.org/spec/MOF/2.0/cmof.xml' > .new/sources.ada
	gnatchop -gnat05 -w .new/sources.ada .new
	ls .new/*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} ../../source/amf/mof/cmof/{}
	rm -r .new

gen-uml-stubs: gens
	test -d uml/generated/.new || mkdir uml/generated/.new
	AMF_DATA_DIR=data ./gen-stage2/.obj/gen2 2011 2011 UML 'http://www.omg.org/spec/UML/20100901/UML.cmof' --stubs > uml/generated/.new/sources.ada
	gnatchop -gnat12 -w uml/generated/.new/sources.ada uml/generated/.new
	ls uml/generated/.new/*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed uml/generated/.new/{} uml/{}
	rm -r uml/generated/.new

gen-uml: gens
	rm -rf .new
	mkdir .new
	AMF_DATA_DIR=data ./gen-stage2/.obj/gen2 2011 2012 UML 'http://www.omg.org/spec/UML/20100901/UML.cmof' 'http://www.omg.org/spec/UML/20100901/PrimitiveTypes.cmof' 'http://www.omg.org/spec/UML/20100901/StandardProfileL2.cmof' 'http://www.omg.org/spec/UML/20100901/StandardProfileL3.cmof' 'http://www.omg.org/spec/UML/20120801/UMLDI.cmof' > .new/sources.ada
	gnatchop -gnat12 -w .new/sources.ada .new
	ls .new/*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} ../../source/amf/uml/{}
	rm -r .new

gen-ocl: gens
	rm -rf .new
	mkdir .new
	AMF_DATA_DIR=data ./gen-stage2/.obj/gen2 2012 2013 OCL 'http://www.omg.org/spec/OCL/20090501/OCL.cmof' > .new/sources.ada
	gnatchop -gnat12 -w .new/sources.ada .new
	ls .new/*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} ../../source/amf/ocl/{}
	rm -r .new

gen-ocl-stubs: gens
	rm -rf .new
	mkdir .new
	AMF_DATA_DIR=data ./gen-stage2/.obj/gen2 2012 2012 OCL 'http://www.omg.org/spec/OCL/20090501/OCL.cmof' --stubs > .new/sources.ada
	gnatchop -gnat12 -w .new/sources.ada .new
	ls .new/*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} ../../source/amf/ocl/{}
	rm -rf .new

gen-mofext: gens
	rm -rf .new
	mkdir .new
	AMF_DATA_DIR=data ./gen-stage2/.obj/gen2 2012 2012 MOFEXT 'http://www.omg.org/spec/MOF/20110701/MOFEXT.cmof' > .new/sources.ada
	gnatchop -gnat12 -w .new/sources.ada .new
	ls .new/*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} ../../source/amf/mofext/{}
	rm -r .new

gen-utp: gens
	rm -rf .new
	mkdir .new
	AMF_DATA_DIR=data ./gen-stage2/.obj/gen2 2012 2012 UTP 'http://www.omg.org/UTPSA.cmof' > .new/sources.ada
	gnatchop -gnat12 -w .new/sources.ada .new
	ls .new/*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} ../../source/amf/utp/{}
	rm -r .new

gen-utp-stubs: gens
	rm -rf .new
	mkdir .new
	AMF_DATA_DIR=data ./gen-stage2/.obj/gen2 2012 2012 UTP 'http://www.omg.org/UTPSA.cmof' --stubs > .new/sources.ada
	gnatchop -gnat12 -w .new/sources.ada .new
	ls .new/*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} ../../source/amf/utp/{}
	rm -r .new

gen-dd: gens
	rm -rf .new
	mkdir .new
	AMF_DATA_DIR=data ./gen-stage2/.obj/gen2 2012 2012 DD 'http://www.omg.org/spec/DD/20110901/DC.cmof' 'http://www.omg.org/spec/DD/20110901/DI.cmof' 'http://www.omg.org/spec/DD/20110901/DG.cmof' > .new/sources.ada
	gnatchop -gnat12 -w .new/sources.ada .new
	ls .new/*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} ../../source/amf/dd/{}
	rm -r .new

gen-dd-stubs: gens
	rm -rf .new
	mkdir .new
	AMF_DATA_DIR=data ./gen-stage2/.obj/gen2 2012 2012 DD 'http://www.omg.org/spec/DD/20110901/DC.cmof' 'http://www.omg.org/spec/DD/20110901/DI.cmof' 'http://www.omg.org/spec/DD/20110901/DG.cmof' --stubs > .new/sources.ada
	gnatchop -gnat12 -w .new/sources.ada .new
	ls .new/*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} ../../source/amf/dd/{}
	rm -r .new

clean:
	rm -rf .libs amf/.objs gen-stage2/.obj uml/.objs gui/cmof_tree_view/.objs gui/cmof_tree_view/.amoc demo-cmof demo-reader demo-viewer

dd:
	gprbuild -j0 -p -P dd.gpr
