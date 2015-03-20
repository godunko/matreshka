#!/bin/bash
set -e

A2JS=../asis2js
TEST=$1
WORK_DIR=/tmp/$$.test
PATH=$PATH:$HOME/node_modules/.bin/

compile()
{
    $A2JS "-CA -T$WORK_DIR/.objs" $WORK_DIR/$1 > $WORK_DIR/aaa.js

    js-beautify $WORK_DIR/aaa.js > $WORK_DIR/bbb.js

    NAME=`head -n 1 $WORK_DIR/bbb.js | sed -e "s/.*'\([^']*\)', \[.*/\1/"`
    mv $WORK_DIR/bbb.js $WORK_DIR/${NAME}.js
}

mkdir $WORK_DIR
gnatchop $TEST $WORK_DIR
gprbuild -p -P test.gpr -XWORK_DIR=$WORK_DIR
cp ../library/*.js $WORK_DIR
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
