# Patch Apple HDA
This guide is the only comprehensible guide to get audio working on macOS.
Original idea by [pikeralpha](https://pikeralpha.wordpress.com/2013/12/17/new-style-of-applehda-kext-patching/).


## Let's get started
### Extract codec_dump in Linux
* Download and make an USB with [Ubuntu Desktop](https://www.ubuntu.com).
* Use the Live version to extract the audio configuration. Enter in the terminal:
```sh
cat /proc/asound/card0/codec#0 > ~/Desktop/codec_dump.txt
(or)
cat /proc/asound/card0/codec#1 > ~/Desktop/codec_dump.txt
(or)
cat /proc/asound/card0/codec#2 > ~/Desktop/codec_dump.txt
```
* Save the codec_dump to the USB/ a cloud provider.

### Back in macOS (Fix the codecVerbs)
Next thing is to correct the codecs to use them on MacOS.
See also [this forum thread](http://forum.osxlatitude.com/index.php?/topic/1946-complete-applehda-patching-guide/) or  [this thread](http://olarila.com/forum/viewtopic.php?f=28&t=2676) or
[this thread](https://www.osx86.net/forums/topic/22108-guide-how-to-fix-the-applehda-for-your-codec/)
https://www.root86.com/blog/40/entry-51-guide-anleitung-patch-applehda/
A handy tool called [codecgraph](https://github.com/cmatsuoka/codecgraph) can be used to get a better understanding of the pin cofnigurations.
Prerequireties (of course you can run it on Linux too, just install graphviz):
* [Brew](https://brew.sh)
* `brew install graphviz`
* Copy the folder `codecgraph` to your desktop.
* Copy your codecdump into the `codecraph` folder and rename it to `codec_dump.txt`
* Run `~/Desktop/codecgraph/commandos.sh`

You will find several new files. The ones we're going to look at first is
the verbs.txt and verbitdebug.txt.  
Inside verbs.txt you can find the old verbit data and the corrected values below it.
This would be the same if you did it yourself on [OSXLatitude thread](http://forum.osxlatitude.com/index.php?/topic/1946-complete-applehda-patching-guide/), just try to do it yourself.
* #### (Little detour: getting verbs yourself)
See also the OSXLatitude thread.
Open up the `codec_dump.txt` from Linux. First thing you want to do is to
get the `pin complex` stuff and note it down for yourself. The node number
is converted from hexadecimals to decimals.
```
Node 18: Pin Default: 0x90a60130 (Mic at Int N/A)
Node 20: Pin Default 0x0421101f, EAPD: 0x2 (HP OUT RIGHT)
etc...
```  
Next thing you want to do is to convert the Pin Default numbers in useful verb data.
Read the Pin default value from right to left each with two numbers:
```
Node 18: Pin Default: 0x90a60130 (Mic at Int N/A)
    Verb data: "30 01 a6 90"
Node 20: Pin Default 0x0421101f, EAPD: 0x2 (HP OUT RIGHT)
    Verb data: "1f 10 21 04"
etc...
```  
Once you extracted all the verb data, we need to correct it.




# Blah blah blah
```
<01271c30 01271d00 01271ea6 01271f90 01471c10 01471d10 01471e21 01471f00 01571c50 01571d00 01571e00 01571f40 01871c40 01871d10 01871ea1 01871f00 01b71c60 01b71d00 01b71e17 01b71f90 01d71c20 01d71d90 01d71eb7 01d71f40 01e71c70 01e71d10 01e71e44 01e71f00>
```

### Patch Clover's config.plist
* Use the HDAS to HDEF.
* Audio > Inject > Voeg hier de Layout_ID toe.
