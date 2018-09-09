Kijk in DSDT patches map voor de laatste!
Alles van de DSDT tryouts (te vinden in MaciASL:)

FIX_WAK ARG0 V2 + HPET + SMBUS + IRQ + RTC + Mutex + PNOT + PRW0x6DSkylake
Dan nog de DSDT fixes van ClevoControl: https://github.com/datasone/ClevoControl

Let er op dat je tussen:
```
FG01,   8,    // GPU Fan0 Speed
FG10,   8,
```

Er dit van maakt:
```
FG01,   8,    // GPU Fan0 Speed
Offset (0xE0),
FG10,   8,
```
En dan nog voor brightness deze MaciASL patch:

```
into method label _Q11 replace_content
begin
// Brightness Down\n
Notify(\_SB.PCI0.LPCB.PS2K, 0x0405)\n
end;
into method label _Q12 replace_content
begin
// Brightness Up\n
Notify(\_SB.PCI0.LPCB.PS2K, 0x0406)\n
end;
```

Voor HDMI-audio:
Dat werkt helaas niet :P, alleen DP werkt vanwege de NVIDIA web drivers. Zie ook:
https://forums.geforce.com/default/topic/1021693/geforce-apple-gpus/please-enable-hdmi-audio-in-pascal-drivers/post/5281859/#5281859
https://www.insanelymac.com/forum/topic/323307-audio-over-hdmi-on-gtx-1060/

Mocht het niet echt lekker werken met DP doe dan het volengde:
https://github.com/acidanthera/WhateverGreen/blob/master/Manual/FAQ.GeForce.en.md
(Helemaal onderaan met de code tussen ** ** in PEG0)

This would become for our laptops: `Store (One, ^PEGP.NHDA)` in Device (PEG0)
SSDT-HDAU zou denk ik niet nodig moeten zijn.
