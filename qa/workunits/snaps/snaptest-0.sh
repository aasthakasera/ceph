#!/bin/sh -x

expect_failure() { 
    if [ `"$@"` -e 0 ]; then
	return 1
    fi
    return 0
}
set -e

expect_failure mkdir .snap/foo
ceph mds set allow_new_snaps --yes-i-really-mean-it

echo asdf > foo
mkdir .snap/foo
grep asdf .snap/foo/foo
rmdir .snap/foo

echo asdf > bar
mkdir .snap/bar
rm bar
grep asdf .snap/bar/bar
rmdir .snap/bar
rm foo

ceph mds unset allow_new_snaps --yes-i-really-mean-it
expect_failure mkdir .snap/baz

echo OK