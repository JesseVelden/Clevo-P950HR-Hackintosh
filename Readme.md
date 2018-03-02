Updated: Jan 2018

Gebasseerd op Rehabman: https://www.tonymacx86.com/threads/guide-booting-the-os-x-installer-on-laptops-with-clover.148093/

# General information
* F2 is Bios   
* F7 is select boot device
* Clear NVRam: `Fn + D + Powerrr` (niet aangesloten aan netstroom) -voor missende batterijstatussen.

# Prepare USB installer

* `./clover_setup.sh`
* Volg de instructies: https://www.tonymacx86.com/threads/guide-booting-the-os-x-installer-on-laptops-with-clover.148093/ met Clover UEFI
* De benodigde files en kexts vind je in de `clover` map.

## Kexts
Go in `EFI > Clover > Kexts > Other`
* [FakeSMC.kext](https://github.com/RehabMan/OS-X-FakeSMC-kozlek)
* [RealtekRTL8111.kext](https://github.com/RehabMan/OS-X-Realtek-Network)
* [USBInjectAll.kext](https://github.com/RehabMan/OS-X-USB-Inject-All)
* [FakePCIID](https://github.com/RehabMan/OS-X-Fake-PCI-ID)  with
* * `FakePCIID.kext`
* * `FakePCIID_XHCIMux`
* * `FakePCIID_Broadcom_WiFi`
* [VoodooPS2Controller](https://github.com/RehabMan/OS-X-Voodoo-PS2-Controller)

## Config.plist
See in: https://github.com/RehabMan/OS-X-Clover-Laptop-Config
And use the `config_HD615_620....plist`
* Use with Clover [config.plist](https://github.com/RehabMan/OS-X-USB-Inject-All/blob/master/config_patches.plist) patch for 15 > 26 devices.
* Or use my own SSDT  `SSDT-UIIAC.dsl` and compile to `ASL`!!!!! (Using MaciASL/ iasl tool) and paste in `EFI > Clover > ACPI > Patched` for more than 15 devices. Or use the precompiled `SSDT-UIAC.aml` should wok fine instead of compiling yourself.

## Mount EFI partition
Wanneer je weer opnieuw de USB stick aansluit zal die niet automatisch de EFI partitie weergeven:
* `diskutil list`  
* `diskutil mount /dev/diskXXX`


# Mac OS Installation
* F2 > Boot > Set the USB in the uppermost position.
* Save
* Boot into the Installer and follow the instructions below: 
## Initialize SSD/HD
* Go to the terminal and enter:
* `diskutil list` note your SSD/HD (disk0 for example)
* `diskutil partitionDisk /dev/disk0 GPT JHFS+ "MacOS" R`
* Nu kan je naar Diskutility en het repartitioneren
* MacOS: 250GB APFS
* Windows: Mac OS Extended (Journaled) IMPORTANT: DON'T USE FAT!!​
* Nu kan je naar de Installer en het Installeren op de zojuist aangemaakte disk!
* Reboot several times maar dan wel de goeie disk selecteren in Clover!!

# After install
* Kies de juiste dingens in Clover en press F2, en F4 voor DSDT dingens.

## DSDT en SSDT patchen
* Download [MaciASL](https://bitbucket.org/RehabMan/os-x-maciasl-patchmatic/downloads/)

* [`Building the latest iasl from github:`](https://www.tonymacx86.com/threads/guide-patching-laptop-dsdt-ssdts.152573/)

* * `mkdir -p ~/Projects && cd ~/Projects`
* * `git clone https://github.com/RehabMan/Intel-iasl.git iasl.git`
* * `cd iasl.git`
* * `make`
* * `sudo make install` will place it in /usr/bin
* * `sudo cp /usr/bin/iasl /Applications/MaciASL.app/Contents/MacOS/iasl61`


### Power management
* SSDT: [`XPCM only:`](https://www.tonymacx86.com/threads/guide-native-power-management-for-laptops.175801/)
* * `curl -o ./SSDT-PluginType1.dsl https://raw.githubusercontent.com/RehabMan/OS-X-Clover-Laptop-Config/master/hotpatch/SSDT-PluginType1.dsl`
* * `iasl SSDT-PluginType1.dsl`
* * `rm /Volumes/EFI/EFI/Clover/ACP.................I/patched/SSDT.aml`
* * `cp SSDT-PluginType1.aml /Volumes/EFI/EFI/Clover/ACPI/patched/SSDT-PluginType1.aml`

### Brightness
* [Klik](https://www.tonymacx86.com/threads/guide-laptop-backlight-control-using-applebacklightinjector-kext.218222/)
en zie hieronder voor de kext instructies.
### General
Bladieblad wordt continued

## Kexts voor /Library/Extensions
**Belangrijk:** installeer kexts nu naar `/Library/Extensions` en kopieer en plak niet vanuit de Finder omdat het de rechten verpest! Gebruik:  
`sudo cp -R KextToInstall.kext /Library/Extensions`    
`sudo kextcache -i /`
* `AppleBacklighjtinjector.kext` Zie hierboven bij Brightness
* [`BrcmPatchRAM.kext`](https://github.com/RehabMan/OS-X-BrcmPatchRAM)
* * `BrcmPatchRam2.kext`
* * `BrcmFirmwareRepo.kext`
* [`FakePCIID.kext`](https://github.com/RehabMan/OS-X-Fake-PCI-ID)
* * FakePCIID.kext
* * FakePCIID_XHCIMux.kext
* * FakePCIID_Broadcom_WiFi.kext (met onze leuke BCM94352Z (Dell DW ))
* [`USBInjectAll.kext`](https://github.com/RehabMan/OS-X-USB-Inject-All)
* [`ACPIBatteryManager.kext `](https://bitbucket.org/RehabMan/os-x-acpi-battery-driver/downloads/) DSDT patches zijn bij deze laptop niet nodig omdat alles in EC al binnen 8 bits valt. [Zie ook Rehabman's thread als je jezelf niet vertrouwt](https://www.tonymacx86.com/threads/guide-how-to-patch-dsdt-for-working-battery-status.116102/)
* [Lilu.kext](https://bitbucket.org/RehabMan/lilu/downloads/) voor boot garbage
*  [IntelGraphicFixup.kext](https://bitbucket.org/RehabMan/intelgraphicsfixup/downloads/) Voor boot garbage
* [RealtekRTL8111.kext](https://github.com/RehabMan/OS-X-Realtek-Network)

## [Installeer Clover op SSD/HD](https://www.tonymacx86.com/threads/guide-booting-the-os-x-installer-on-laptops-with-clover.148093/)
* https://github.com/RehabMan/Clover
* **Customize location and options:**
- using "Change Install Location"
- select "Customize" (the default is a legacy install -- we need to change it)
- check "Install for UEFI booting only", "Install Clover in the ESP" will automatically select
- check "BGM" from Themes (the config.plist files I provide use this theme)
- check "OsxAptioFixDrv-64" from Drivers64UEFI
- check "EmuVariableUefi-64.efi"
- select "Install RC scripts on target volume" and/or "Install all RC scripts on all other boot volumes"
- most systems will work without DataHubDxe-64.efi, but some may require it
### Kexts for Clover on HD/SSD (kexts voor updates etc.)
* FakeSMC.kext
* USBInjectAll.kext
* VoodooPS2Controller.kext
* Misschien nog FakePCIID, maar niet echt nodig omdat het al in /Library/Extensions zit

### Clover config.plist
* See added file
#### Clover explanations for the original Rehabman thing
* `Change OSID to XSID` can be deleted as we don't have OSID
* `change _OSI to XOSI` enable this as this will rename to Darwin but add from
https://github.com/RehabMan/OS-X-Clover-Laptop-Config/tree/master/hotpatch
`SSDT-XOSI.dsl` --> `SSDT-XOSI.aml` to `Clover > ACPI > Patched`
* `change ECDV to EC`/ `change EC0 to EC`/ `change H_EC to EC`: disable cause our DSDT already uses `EC` for the embedded controller
* `change _DSM to XDSM`  **Nodig? Alleen wanneer je _DSM methode aanpast?**
* `change HECI to IMEI` yes,
* `change MEI to IMEI` nope,
* `change HDAS to HDEF` nope, we will rename the audio with toleda shit.
* `change GFX0 to IGPU` prima, misschien later aanpassen
* `change PCI0.VID to IGPU #1 (Thinkpad)` remove en die andere ook

#### Audio
https://github.com/toleda/audio_ALCInjection/tree/master/ssdt_hdef en download
SSDT-hdef-3-100-hdas and place in `Clover > ACPI > Patched`.



## Laterr
* EmuVariableUefi64!
Controleer met patches en hotpatch!!!
* Geluid
