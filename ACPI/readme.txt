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
