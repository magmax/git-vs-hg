#!/bin/bash

set -x

SERVER=/tmp/server-hg
WC1=/tmp/wc1-hg
WC2=/tmp/wc2-hg

#clean up
rm -rf $SERVER $WC1 $WC2 || true


hg init $SERVER
echo -e '[hooks]\npretxnchangegroup.sleep=sleep 2' > $SERVER/.hg/hgrc

hg clone ssh://localhost/$SERVER $WC1
touch $WC1/file
hg -R $WC1 add $WC1/file
hg -R $WC1 commit -m "initial version"
hg -R $WC1 push

hg clone ssh://localhost/$SERVER $WC2

touch $WC1/file2
hg -R $WC1 branch branch1
hg -R $WC1 add $WC1/file2
hg -R $WC1 commit -m "changes on wc1"


touch $WC2/fileB
hg -R $WC2 branch branch2
hg -R $WC2 add $WC2/fileB
hg -R $WC2 commit -m "changes on wc2"

annotate-output +"WC__1__%H:%M:%S"  hg -R $WC1 push --new-branch &
annotate-output +"WC__2__%H:%M:%S"  hg -R $WC2 push --new-branch
