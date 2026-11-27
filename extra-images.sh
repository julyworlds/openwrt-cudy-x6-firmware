#!/bin/bash
#
# Run from the openwrt directory after the main "make".
#
# The main build (.config) makes the full images, EasyMesh included:
#   cudy_x6-v1           -> kept as is (32 MB flash, everything fits)
#   cudy_x6-v2           -> renamed to cudy_x6-v2-mesh
# Then the rootfs is regenerated without prplMesh, reusing the packages
# already compiled (a few minutes, nothing is recompiled), to make:
#   cudy_x6-v2           -> v2 without EasyMesh (more free space)
#
set -e

T=$(echo bin/targets/ramips/mt7621)

for d in v1 v2; do
	if ! ls "$T"/*cudy_x6-$d-squashfs-sysupgrade.bin >/dev/null 2>&1; then
		echo "extra-images: no cudy_x6-$d image from the main build in $T" >&2
		exit 1
	fi
done

KEEP=$(mktemp -d)

# 1. Keep the images of the main build
mv "$T"/*cudy_x6-v1-* "$KEEP"/
for f in "$T"/*cudy_x6-v2-initramfs* "$T"/*cudy_x6-v2-squashfs*; do
	mv "$f" "$KEEP/$(basename "${f/cudy_x6-v2-/cudy_x6-v2-mesh-}")"
done
mv "$T/openwrt-ramips-mt7621.manifest" "$KEEP/openwrt-ramips-mt7621-mesh.manifest"

# 2. Drop prplMesh and what only it needs (if anything else still needs
#    one of these, defconfig keeps it enabled)
for p in prplmesh luci-app-prplmesh libnl-route getopt; do
	sed -i "s/^CONFIG_PACKAGE_$p=y\$/CONFIG_PACKAGE_$p=m/" .config
done
make defconfig
if grep -q '^CONFIG_PACKAGE_prplmesh=y' .config; then
	echo "prplmesh is still selected by another package" >&2
	exit 1
fi

# 3. Regenerate rootfs and images only
make package/install target/install -j"$(nproc)"

# 4. Only the v2 is wanted from this pass; put the full images back
rm -f "$T"/*cudy_x6-v1-*
mv "$T/openwrt-ramips-mt7621.manifest" "$T/openwrt-ramips-mt7621-v2-nomesh.manifest"
mv "$KEEP"/* "$T"/
rmdir "$KEEP"

make checksum
ls -l "$T"
