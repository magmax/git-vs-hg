#!/bin/bash

# using the same branch

set -x

WC1=/tmp/wc1-hg

#clean up
rm -rf $WC1 || true


#remote repository init.
hg init $WC1

hg add selenium-java-2.31.0.zip

hg commit -m "initial"
du -h
hg mv selenium-java-2.31.0.zip  selenium-java-2.31.0.b.zip
hg commit -m "second"
du -h
