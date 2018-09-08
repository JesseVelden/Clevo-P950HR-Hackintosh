Updated: Jan 2018

Gebasseerd op Rehabman: https://www.tonymacx86.com/threads/guide-booting-the-os-x-installer-on-laptops-with-clover.148093/

# General information
* F2 is Bios   
* F7 is select boot device
* Clear NVRam: `Fn + D + Powerrr` (niet aangesloten aan netstroom) -voor missende batterijstatussen.

# Prepare USB installer

* `./clover_setup.sh`
* Volg de instructies: https://www.tonymacx86.com/threads/guide-booting-the-os-x-installer-on-laptops-with-clover.148093/ met Clover UEFI
* De benodigde files en kexts vind je in de `clover` map. See below for needed kexts explantion, but make also sure you are up to date with the latest information.
* Use the ACPI folder including disabling NVIDIA and paste it in the ACPI > Patched
folder on your USB.

## Quick install guide
* F2 at boot > Change boot order to usb.
* Boot into MacOS install from install_osx

  ## Mac OS Installation
* F2 > Boot > Set the USB in the uppermost position.
* Save
* Boot into the Installer and follow the instructions below:
  ### Initialize SSD/HD
* Go to the terminal and enter:
* `diskutil list` note your SSD/HD (disk0 for example)
* `diskutil partitionDisk /dev/disk0 GPT JHFS+ "MacOS" R`
* Nu kan je naar Diskutility en het repartitioneren
* MacOS: 250GB APFS
* Windows: Mac OS Extended (Journaled) IMPORTANT: DON'T USE FAT!!​

  ### Installeren
* Nu kan je naar de Installer en het Installeren op de zojuist aangemaakte disk!
* Belangrijk is dat je geen APFS maar lekker ouderwets HFS gaat gebruiken. Omdat dat zorgt voor betere boottijden, aangezien TRIM nogal langzaam is met APFS. Zie ook [deze thread](https://www.tonymacx86.com/threads/guide-avoid-apfs-conversion-on-high-sierra-update-or-fresh-install.232855/)
* In de terminal enter:
* `/Volumes/"Image Volume/Install macOS High Sierra.app"/Contents/Resources/startosinstall --volume /volumes/the_target_volume --converttoapfs NO --agreetolicense`
* Reboot several times maar dan wel de goeie disk ("Boot macOS Install from ...") selecteren in Clover!!
   ### After Install
* Download this repository again.
* Use `./download.sh`, and then `./install_downloads.sh`.
* Install Clover again on the SSD/ HDD. See below.
* Make sure you copy APFS.efi and HFSPlus.efi, into Drivers64UEFI. See also [the clover install thread](https://www.tonymacx86.com/threads/guide-booting-the-os-x-installer-on-laptops-with-clover.148093/)
* Copy the ACPI files, but not the disabling NVIDIA one.
* Copy our config.plist file.
* Download the NVidia web drivers: https://www.tonymacx86.com/nvidia-drivers/
and see also [this forum thread](https://www.tonymacx86.com/forums/graphics.13/) and search for the right NVIDIA thread. You can try several versions of the same Mac OS version if one is not working and saying that you need another version.



# Explanations
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
* [Lilu.kext]
* [WhatEverGreen.kext]

## Config.plist
Gebruik onze eigen maar compare met een diff-tool:
See in: https://github.com/RehabMan/OS-X-Clover-Laptop-Config. Zie beneden voor de config.plist verantwoording
And use the `config_HD615_620....plist`
* Use with Clover [config.plist](https://github.com/RehabMan/OS-X-USB-Inject-All/blob/master/config_patches.plist) patch for 15 > 26 devices.
* Or use my own SSDT  `SSDT-UIIAC.dsl` and compile to `ASL`!!!!! (Using MaciASL/ iasl tool) and paste in `EFI > Clover > ACPI > Patched` for more than 15 devices. Or use the precompiled `SSDT-UIAC.aml` should wok fine instead of compiling yourself!!!!!

## USBInjectAll.kext
USB 3.1/ USB C works out of the box.
* `SSDT-UIAC.dsl` > `SSDT-UIAC.aml` for USBInjectAll.kext

## Mount EFI partition
Wanneer je weer opnieuw de USB stick aansluit zal die niet automatisch de EFI partitie weergeven:
* `diskutil list`  
* `diskutil mount /dev/diskXXX`




# After install
* Kies de juiste dingens in Clover en press F2, en F4 voor DSDT dingens.

## DSDT en SSDT patchen
* Download [MaciASL](https://bitbucket.org/RehabMan/os-x-maciasl-patchmatic/downloads/)

* Gebruik de guide.git (Probook)


### Power management
* Werkt natively by inserting `config.plist/ACPI/SSDT/Generate/PluginType=true`.
[Zie ook](https://www.tonymacx86.com/threads/guide-native-power-management-for-laptops.175801/) XPCM Method, Clover.

### Brightness
* [Klik](https://www.tonymacx86.com/threads/guide-laptop-backlight-control-using-applebacklightinjector-kext.218222/)
en zie hieronder voor de kext instructies. Already included in the ACPI folder.
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
* [Lilu.kext](https://github.com/acidanthera/Lilu) voor boot garbage
*  [WhateverGreen.kext](https://github.com/acidanthera/WhateverGreen) Voor boot garbage
* [RealtekRTL8111.kext](https://github.com/RehabMan/OS-X-Realtek-Network)

## [Installeer Clover op SSD/HD](https://www.tonymacx86.com/threads/guide-booting-the-os-x-installer-on-laptops-with-clover.148093/)
* https://github.com/RehabMan/Clover
* **Customize location and options:**
- using "Change Install Location"
- select "Customize" (the default is a legacy install -- we need to change it)
- check "Install for UEFI booting only", will automatically select
- check "BGM" from Themes (the config.plist files I provide use this theme)
- check "AptioMemoryFix.efi" from Drivers64UEFI (en NIET: OsxAptioFixDrv-64, EmuVariableUefi-64)
- select "Install RC scripts on target volume" and/or "Install all RC scripts on all other boot volumes"
### Kexts for Clover on HD/SSD (kexts voor updates etc.)
* FakeSMC.kext
* USBInjectAll.kext
* VoodooPS2Controller.kext
* RealtekRTL8111.kext
* FakePCIID met FakePCIID_Broadcom_WiFi
* Lilu.kext
* WhatEverGreen.kext

### Clover config.plist
* See added file
#### Clover explanations for the original Rehabman thing

##### NVIDIA
* Doe een diff, met de config.plist van rehabman. Hieronder staan waarom dingen
wel of niet zijn geinclude.
* `Devices > AddProperties > NVIDIA`, haal dit allemaal weg. Dit hebben we juist nodig.
, tijdens installeren gebruik je de gecompilde SSDT-DiscreteSpoof.aml. Zie de foler: `ACPI > Disable NVIDIA`
om NVIDIA te disablen. Daarna kan je de [webdrivers installeren](https://www.tonymacx86.com/nvidia-drivers/) waarbij je dit invoegt bij config.plist:
```xml
<key>SystemParameters</key>
<dict>
    <key>InjectKexts</key>
    <string>Detect</string>
    <key>InjectSystemID</key>
    <true/>
    <key>NvidiaWeb</key>
    <true/>
</dict>
```
* `change _DSM to XDSM`  **Nodig? Alleen wanneer je _DSM methode aanpast?** Ja enable, want dit is nodig voor SSDT-DiscreteSpoof, wanneer je NVIDIA niet wil enablen, maar geen Clover config.plist patcches wil. Dit kan uit worden gezet als NVIDIA weer werkt!
* `Graphics > Inject > NVIDIA`: false, otherwise you don't get 8GB of VRAM.
* Daarna volg deze guide:
https://www.tonymacx86.com/threads/macos-native-discrete-gpu-power-management.247479/  
In Clover.plist:
* Zorg er voor dat de `Nvidia GPU PM- Rename PEGP to GFX2` DSDT Patch NA `change GFX0 to IGPU` komt! in `config.plist/ACPI/DSDT/Patches/`

##### Overig
* `DisabledAML`: These default config.plist settings can be used for Native PowerManagement.
* `DSDT` > `Fixes` (zie ook Rehabman Clover 2017-10-26 changes)
* * `FixHeaders(_20000000)`: Enabled: NO, not needed! The purpose of FixHeaders_20000000 is to solve the problem of non-ASCII characters in various ACPI table headers (ie. MATS, BGRT, etc).
* * `FixTMR(_40000000)`: Enabled: NO, not needed !Disable TMR device in DSDT.
* * `FixRTC(_20000000)`: Enabled NO, not needed! Exclude IRQ(0) from RTC device, maar wij hebben IRQ(8).
* * `FixIPIC(_0040)` Enabled: NO, **I think** it is not needed. Deletes IRQ(2) from device IPIC. Helps with a non working Power button.
* * `FixHPET_0010`: Enabled: NO, Add IRQ(0, 8, 11) to device HPET. Obligatory for OSX <=10.8. But I see Mavericks can work without it.
* * `FixHDA`: Enabled: YES

* `Change OSID to XSID` can be deleted as we don't have OSID
* `change _OSI to XOSI` enable this as this will rename to Darwin but add from
https://github.com/RehabMan/OS-X-Clover-Laptop-Config/tree/master/hotpatch
`SSDT-XOSI.dsl` --> `SSDT-XOSI.aml` to `Clover > ACPI > Patched`
* `change ECDV to EC`/ `change EC0 to EC`/ `change H_EC to EC`: disable cause our DSDT already uses `EC` for the embedded controller

* `change HECI to IMEI` yes,
* `change MEI to IMEI` nope,
* `change HDAS to HDEF` YES, we will rename the audio with toleda shit.
* `change GFX0 to IGPU` prima, misschien later aanpassen
* `change PCI0.VID to IGPU #1 (Thinkpad)` remove en die andere ook


#### Audio
See also my posts in: https://www.insanelymac.com/forum/forums/topic/311293-applealc-—-dynamic-applehda-patching/?page=83
* `Devices> AddProperties > Audio > Inject > 13:
```
...
<key>Devices</key>
<dict>
    <key>AddProperties</key>
        <array>
        </array>
        <key>Audio</key>
        <dict>
            <key>Inject</key>
            <integer>13</integer>
        </dict>
        ...
```

# Boot gibberish before Clover loads:
https://www.insanelymac.com/forum/forums/topic/327584-apfsefi-without-verbose-boot/?page=5


# DSDT Changes
* Removed an error line, otherwise it wouldn't compile. Already removed in
Google Drive Repo.
* `Fix _WAK Arg0 v2`+ HPET + SMBUS + IRQ + RTC + Mutex + PNOT + PRW (0x6D) Skylake version


# Fan control
We're using: https://github.com/datasone/ClevoControl/releases
With the self-made starttup script: moe.datasone.clevocontrol.plist in `/Library/LaunchAgents/` and `sudo launchctl load /Library/LaunchAgents/moe.datasone.clevocontrol.plist` and the `ClevoKBFanControl` in `/usr/local/bin`.
See also my fork and branch for the DSDT fixes. I need to document it more...  
`--auto` seems fine.

# Linux stuff
https://help.ubuntu.com/community/WifiDocs/Driver/bcm43xx You need the:
'Broadcom STA Wireless driver (Proprietary)'
Or see https://wiki.archlinux.org/index.php/Dell_XPS_13_%289343%29 > Wifi
