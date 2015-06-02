
all:
	gprbuild -p -P forum.gpr

db:
	dropdb forum || true
	createdb forum
	psql forum -f forum.sql


clean:
	rm -rf .objs
