
all:
	gprbuild -p -j0 -P domconf.gpr
	gprbuild -p -j0 -P odf.gpr -k
	gprbuild -p -j0 -P web.gpr
	.objs/domconf ../dom/testsuite/DOM-Test-Suite/tests/level2/core/createDocument01.xml

gen:
	gprbuild -p -j0 -P tools.gpr
	rm -rf .new
	mkdir .new
	.objs/odfgen tools/odf.xml > .new/sources.ada
	gnatchop -w .new/sources.ada .new
	# 'amin' module
	ls .new/matreshka-odf_anim-*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/anim/{}
	ls .new/odf-dom-anim_*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/anim/{}
	# 'chart' module
	ls .new/matreshka-odf_chart-*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/chart/{}
	ls .new/odf-dom-chart_*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/chart/{}
	# 'config' module
	ls .new/matreshka-odf_config-*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/config/{}
	ls .new/odf-dom-config_*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/config/{}
	# 'db' module
	ls .new/matreshka-odf_db-*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/db/{}
	ls .new/odf-dom-db_*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/db/{}
	# 'dc' module
	ls .new/matreshka-odf_dc-*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/dc/{}
	ls .new/odf-dom-dc_*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/dc/{}
	# 'dr3d' module
	ls .new/matreshka-odf_dr3d-*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/dr3d/{}
	ls .new/odf-dom-dr3d_*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/dr3d/{}
	# 'draw' module
	ls .new/matreshka-odf_draw-*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/draw/{}
	ls .new/odf-dom-draw_*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/draw/{}
	# 'fo' module
	ls .new/matreshka-odf_fo-*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/fo/{}
	ls .new/odf-dom-fo_*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/fo/{}
	# 'form' module
	ls .new/matreshka-odf_form-*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/form/{}
	ls .new/odf-dom-form_*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/form/{}
	# 'math' module
	ls .new/matreshka-odf_math-*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/math/{}
	ls .new/odf-dom-math_*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/math/{}
	# 'meta' module
	ls .new/matreshka-odf_meta-*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/meta/{}
	ls .new/odf-dom-meta_*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/meta/{}
	# 'number' module
	ls .new/matreshka-odf_number-*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/number/{}
	ls .new/odf-dom-number_*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/number/{}
	# 'office' module
	ls .new/matreshka-odf_office-*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/office/{}
	ls .new/odf-dom-office_*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/office/{}
	# 'presentation' module
	ls .new/matreshka-odf_presentation-*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/presentation/{}
	ls .new/odf-dom-presentation_*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/presentation/{}
	# 'script' module
	ls .new/matreshka-odf_script-*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/script/{}
	ls .new/odf-dom-script_*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/script/{}
	# 'smil' module
	ls .new/matreshka-odf_smil-*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/smil/{}
	ls .new/odf-dom-smil_*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/smil/{}
	# 'style' module
	ls .new/matreshka-odf_style-*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/style/{}
	ls .new/odf-dom-style_*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/style/{}
	# 'svg' module
	ls .new/matreshka-odf_svg-*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/svg/{}
	ls .new/odf-dom-svg_*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/svg/{}
	# 'table' module
	ls .new/matreshka-odf_table-*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/table/{}
	ls .new/odf-dom-table_*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/table/{}
	# 'text' module
	ls .new/matreshka-odf_text-*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/text/{}
	ls .new/odf-dom-text_*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/text/{}
	# other code
	ls .new/*.ad[sb] | xargs -L1 basename | xargs -I{} ../../tools/move-if-changed .new/{} odf/{}
	rm -rf .new

demo:
	gprbuild -p -j0 -P demo.gpr

run: demo
	.objs/vdocs-aws

domconf:
	gprbuild -p -j0 -P domconf.gpr
	.objs/domconf ../../testsuite/xml/DOM-Test-Suite/level2/core/attrgetownerelement01.xml
#	.objs/domconf ../../testsuite/xml/DOM-Test-Suite/level2/core/alltests.xml
