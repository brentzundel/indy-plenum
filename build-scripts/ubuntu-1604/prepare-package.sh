#!/bin/bash -xe

if [ "$1" = "--help" ] ; then
  echo "Usage: $0 <path-to-repo-folder> <release-version-dotted>"
  exit 0
fi

repo="$1"
version_dotted="$2"

METADATA_FNAME="__metadata__.py"
MANIFEST_FNAME="manifest.txt"

echo -e "\n\nAbout to start updating package $repo to version $version_dotted info from cur dir: $(pwd)"

# bumps version
pushd $repo
echo -e "\n\nUpdating version in metadata with $version_dotted"
bash -ex ./bump_version.sh $version_dotted
popd

echo -e "Adapt the dependencies for the Canonical archive"
sed -i "s~ujson==1.33~ujson==1.33-1build1~" "$repo/setup.py"
sed -i "s~prompt_toolkit==0.57~prompt_toolkit==0.57-1~" "$repo/setup.py"
sed -i "s~msgpack-python==0.4.6~msgpack==0.4.6-1build1~" "$repo/setup.py"

# create manifest file
repourl=$(git --git-dir $repo/.git --work-tree $repo config --get remote.origin.url)
hashcommit=$(git --git-dir $repo/.git --work-tree $repo rev-parse HEAD)
manifest="// built from: repo version hash\n$repourl $version_dotted $hashcommit"
manifest_file="$repo/plenum/$MANIFEST_FNAME"

echo "Adding manifest\n=======\n$manifest\n=======\n into $manifest_file"
rm -rf $manifest_file
echo -e $manifest >$manifest_file

echo -e "Finished preparing $repo for publishing\n"
