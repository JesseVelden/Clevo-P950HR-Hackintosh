#!/bin/bash
#set -x
ESSENTIAL="FakeSMC.kext FakePCIID.kext FakePCIID_Broadcom_WiFi.kext RealtekRTL8111.kext USBInjectAll.kext AppleBacklightInjector.kext VoodooPS2Controller.kext"

function download()
{
    echo "downloading $2:"
    curl --location --silent --output /tmp/org.rehabman.download.txt https://bitbucket.org/RehabMan/$1/downloads/
    scrape=`grep -o -m 1 "/RehabMan/$1/downloads/$2.*\.zip" /tmp/org.rehabman.download.txt|perl -ne 'print $1 if /(.*)\"/'`
    url=https://bitbucket.org$scrape
    echo $url
    if [ "$3" == "" ]; then
        curl --remote-name --progress-bar --location "$url"
    else
        curl --output "$3" --progress-bar --location "$url"
    fi
    echo
}

mkdir -p ./clover && rm -Rf clover/*
cd ./clover
download clover Clover
unzip -q Clover*
cloverMD5=$(md5 Clover*.pkg | perl -nle 'print $& if m{(?<==\s)[A-Za-z0-9]*}' $1)
MD5File=$(perl -nle 'print $& if m{(?<==\s)[A-Za-z0-9]*}' Clover*.pkg.md5)
if [ "$cloverMD5" == "$MD5File" ]; then
    echo "MD5 checks for clover holds up!"
    rm Clover*.pkg.md5
    rm Clover*.zip
else
    echo "Oops! The md5 checks for clover does not hold up."
    echo "$cloverMD5 given, but $MD5File expected"
    echo "Proceed with care..."
fi

# download kexts
mkdir -p ./kexts/downloads && cd ./kexts/downloads
download os-x-fakesmc-kozlek RehabMan-FakeSMC
download os-x-voodoo-ps2-controller RehabMan-Voodoo
download os-x-realtek-network RehabMan-Realtek-Network
download os-x-fake-pci-id RehabMan-FakePCIID
download os-x-usb-inject-all RehabMan-USBInjectAll
download lilu RehabMan-Lilu
download intelgraphicsfixup RehabMan-IntelGraphicsFixup

# Unzip Kexts
echo "Unzipping kexts"
for kext in *.zip; do
    unzip -q $kext
done
rm *.zip # Hopefully the zips don't have other zips in them
echo "Kexts unzipped"

cd ..
echo "Organize kexts"
for kext in ./downloads/*.kext; do
    kextname="`basename $kext`"
    if [[ $ESSENTIAL = *$kextname* ]]; then
        mv -n $kext ./
    fi
done

for kext in ./downloads/Release/*.kext; do
    kextname="`basename $kext`"
    if [[ $ESSENTIAL = *$kextname* ]]; then
        mv -n $kext ./
    fi
done

rm -rf ./downloads

echo "All kexts organized!"
echo "Got all the files! Look into the 'clover' folder."
cd ./clover
mkdir -p ./helper-projects
git clone https://github.com/RehabMan/OS-X-Clover-Laptop-Config.git ./helper-projects/guide.git
cp ./helper-projects/guide.git/config_HD615_620_630_640_650.plist ./config.plist

#cd ..
