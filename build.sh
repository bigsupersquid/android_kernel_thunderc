#!/bin/sh

sed -i s/CONFIG_LOCALVERSION=\".*\"/CONFIG_LOCALVERSION=\"-BobZhome-${1}\"/ .config

make -j2

cp arch/arm/boot/zImage mkboot/
sed -i s/CONFIG_LOCALVERSION=\".*\"/CONFIG_LOCALVERSION=\"\"/ .config
cp .config arch/arm/configs/chaos_defconfig

cd mkboot
echo "making boot image"
./img.sh

zipfile="BobZhome_VM670_Kernel_v${1}.zip"
if [ ! $4 ]; then
	echo "making zip file"
	cp boot.img ../zip
	cp boot.img /tmp
	cd ../zip
	rm -f *.zip
	zip -r $zipfile *
	rm -f /tmp/*.zip
	cp *.zip /tmp
fi
