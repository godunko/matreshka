#!/bin/bash
set -e

TEST=$1
WORK_DIR=/tmp/$$.test
PATH=$PATH:$HOME/node_modules/.bin/:`pwd`/../../../.objs/a2js
export LD_LIBRARY_PATH=`pwd`/../../../.libs:$LD_LIBRARY_PATH

compile()
{
    NAME=${1%.*}.js
    js-beautify $WORK_DIR/.objs/$NAME > $WORK_DIR/$NAME
}

mkdir $WORK_DIR
export PATH=`pwd`/..:$PATH
gnatchop $TEST $WORK_DIR
gprbuild -p -P test.gpr -XWORK_DIR=$WORK_DIR --db ../../../source/web/tools/a2js/gprconfig
cp ../library/*.js $WORK_DIR
cp ../../../source/web/tools/a2js/rtl/*.js $WORK_DIR
sed --quiet -e '/EXPECTED OUTPUT:/,/END OF EXPECTED OUTPUT/p' $TEST \
    | sed -e '1d' -e '$d' -e 's/^--  //' \
          > $WORK_DIR/expected

sed --quiet -e '/BIND LIST:/,/END OF BIND LIST/p' $TEST \
    | sed -e '1d' -e '$d' -e 's/^--  //' \
          > $WORK_DIR/bind

MAIN=`grep -F 'MAIN: ' $TEST |cut -d\  -f4`

for J in `cat $WORK_DIR/bind`; do
    compile $J
done

sed -i -e "s/hello_world/$MAIN/" $WORK_DIR/adainit.js
node $WORK_DIR/start-ada-by-nodejs.js > $WORK_DIR/output

diff -u $WORK_DIR/expected $WORK_DIR/output
