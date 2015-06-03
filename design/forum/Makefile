
all:
	gprbuild -p -P forum.gpr

initdb:
	dropdb forum || true
	createdb forum
	psql forum -f forum.sql


clean:
	rm -rf .objs
