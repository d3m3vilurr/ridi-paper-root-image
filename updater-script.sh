#!/usr/bin/env bash
# TODO check ANDROID_SDK
export PATH=$ANDROID_SDK/build-tools/19.1.0/:$PATH
echo "Delete old image..."
rm *.rooted.img
cp system.img system.rooted.img

echo "Mounting system..."
mkdir target
sudo mount -t ext4 -o loop system.rooted.img ./target

echo "Copying files..."
sudo cp -r overlay/* target

echo "Enable adb"
sudo sed -i -- s/sys.rkadb.root=0/sys.rkadb.root=1/ target/build.prop
sudo sed -i -- s/persist.sys.usb.config=.\*/persist.sys.usb.config=mtp,adb/ target/build.prop

echo "Enable softkey"
echo "qemu.hw.mainkeys=0" | sudo tee -a target/build.prop
# unpack framework
mkdir tmp
cp target/framework/framework-res.apk tmp
cd tmp
java -jar ../bin/apktool.jar d framework-res.apk
# force enable nav var
perl -pi -e \
    's/config_showNavigationBar">false/config_showNavigationBar">true/g' \
    framework-res/res/values/bools.xml
# repack
java -jar ../bin/apktool.jar b framework-res
rm framework-res/build/apk/AndroidManifest.xml
cd framework-res/build/apk
jar -uf ../../../framework-res.apk *
cd ../../..
# copy to system
sudo cp framework-res.apk ../target/framework/
cd ..
rm -rf tmp
sync

echo "Fixing permissions..."
sudo chmod 06755 target/bin/su
sudo chmod 0755 target/bin/busybox
sync

echo "Disk usage..."
df | grep target

echo "Unmounting system..."
sudo umount ./target
rm -rf target

echo "Installation complete!"
echo "Zip image..."
zip system.rooted.zip system.rooted.img
