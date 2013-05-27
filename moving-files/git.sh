#!/bin/bash

set -x

WC1=/tmp/wc1-git

rm -rf $WC1 || true

git init $WC1

seq 1000000 > $WC1/file
ls -lh $WC1/file
git --git-dir=$WC1/.git --work-tree=$WC1 add $WC1/file

git --git-dir=$WC1/.git --work-tree=$WC1 commit -m "initial"

git --git-dir=$WC1/.git --work-tree=$WC1 mv file example
git --git-dir=$WC1/.git --work-tree=$WC1 commit -am "second"
du -hs $WC1

git --git-dir=$WC1/.git --work-tree=$WC1 mv example file
git --git-dir=$WC1/.git --work-tree=$WC1 commit -am "third"
du -hs $WC1

git --git-dir=$WC1/.git --work-tree=$WC1 log -- file