#!/bin/bash

set -x

WC1=/tmp/wc1-hg

rm -rf $WC1 || true


hg init $WC1

seq 1000000 > $WC1/file
ls -lh $WC1/file
hg -R $WC1 add $WC1/file

hg -R $WC1 commit -m "initial"
du -hs $WC1

hg -R $WC1 mv $WC1/file $WC1/example
hg -R $WC1 commit -m "second"
du -hs $WC1

hg -R $WC1 mv $WC1/example $WC1/file
hg -R $WC1 commit -m "third"
du -hs $WC1

hg -R $WC1 log $WC1/file