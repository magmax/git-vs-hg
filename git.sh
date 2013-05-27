#!/bin/bash

# tests what happens if two people tries to push at the same time on the same branch.

set -x

SERVER=/tmp/server-git
WC1=/tmp/wc1-git
WC2=/tmp/wc2-git

rm -rf $SERVER $WC1 $WC2 || true
rm -rf $SERVER
git --bare init $SERVER

echo -e '#!/bin/bash\nsleep 2' > $SERVER/hooks/post-receive
chmod 755 $SERVER/hooks/post-receive

git clone $SERVER $WC1

touch $WC1/INITIAL
git --git-dir=$WC1/.git --work-tree=$WC1 add INITIAL
git --git-dir=$WC1/.git --work-tree=$WC1 commit -m "master branch creation"
git --git-dir=$WC1/.git --work-tree=$WC1 push origin master

git clone $SERVER $WC2

touch $WC1/file
git --git-dir=$WC1/.git --work-tree=$WC1 checkout -b working-copy-1
git --git-dir=$WC1/.git --work-tree=$WC1 add file
git --git-dir=$WC1/.git --work-tree=$WC1 commit -m "change 1"


touch $WC2/fileB
git --git-dir=$WC2/.git --work-tree=$WC2 checkout -b working-copy-2
git --git-dir=$WC2/.git --work-tree=$WC2 add fileB
git --git-dir=$WC2/.git --work-tree=$WC2 commit -m "changes on wc2"

annotate-output +"WC__1__%H:%M:%S"  git --git-dir=$WC1/.git --work-tree=$WC1 push origin working-copy-1:working-copy-1 &
annotate-output +"WC__2__%H:%M:%S"  git --git-dir=$WC2/.git --work-tree=$WC2 push origin working-copy-2:working-copy-2

