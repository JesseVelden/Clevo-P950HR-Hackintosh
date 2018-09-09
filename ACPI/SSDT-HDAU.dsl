/*
* Intel ACPI Component Architecture
* AML/ASL+ Disassembler version 20161210-64(RM)
* Copyright (c) 2000 - 2016 Intel Corporation
*
* Disassembling to non-symbolic legacy ASL operators
*
* Disassembly of iASLcoGYHF.aml, Mon Jan 22 15:43:24 2018
*
* Original Table Header:
*     Signature        "SSDT"
*     Length           0x0000025B (603)
*     Revision         0x02
*     Checksum         0xC4
*     OEM ID           "hack"
*     OEM Table ID     "GFX0_HDA"
*     OEM Revision     0x00000000 (0)
*     Compiler ID      "INTL"
*     Compiler Version 0x20161210 (538317328)
*/
DefinitionBlock ("", "SSDT", 2, "hack", "GFX0_HDA", 0x00000000)
{
   External (_SB_.PCI0.PEG0, DeviceObj)    // (from opcode)
   External (_SB_.PCI0.PEG0.GFX0, DeviceObj)    // (from opcode)
   External (GFX0, DeviceObj)    // (from opcode)

   Scope (_SB.PCI0.PEG0)
   {
       Scope (GFX0)
       {
           Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
           {
               If (LEqual (Arg2, Zero))
               {
                   Return (Buffer (One)
                   {
                        0x03                                       
                   })
               }

               Return (Package (0x18)
               {
                   "@0,connector-type",
                   Buffer (0x04)
                   {
                        0x02, 0x00, 0x00, 0x00                     
                   },

                   "@0,AAPL,boot-display",
                   Buffer (0x04)
                   {
                        0x01, 0x00, 0x00, 0x00                     
                   },

                   "@0,built-in",
                   Buffer (Zero) {},
                   "@0,display-connect-flags",
                   Buffer (0x04)
                   {
                        0x04, 0x00, 0x00, 0x00                     
                   },

                   "@0,use-backlight-blanking",
                   Buffer (0x04) {},
                   "AAPL,backlight-control",
                   Buffer (0x04)
                   {
                        0x01, 0x00, 0x00, 0x00                     
                   },

                   "@0,backlight-control",
                   Buffer (0x04)
                   {
                        0x01, 0x00, 0x00, 0x00                     
                   },

                   "@0,display-type",
                   "LCD",
                   "@1,connector-type",
                   Buffer (0x04)
                   {
                        0x00, 0x08, 0x00, 0x00                     
                   },

                   "@2,connector-type",
                   Buffer (0x04)
                   {
                        0x00, 0x08, 0x00, 0x00                     
                   },

                   "@3,connector-type",
                   Buffer (0x04)
                   {
                        0x00, 0x08, 0x00, 0x00                     
                   },

                   "hda-gfx",
                   Buffer (0x0A)
                   {
                       "onboard-2"
                   }
               })
           }
       }

       Device (HDAU)
       {
           Name (_ADR, One)  // _ADR: Address
           Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
           {
               If (LEqual (Arg2, Zero))
               {
                   Return (Buffer (One)
                   {
                        0x03                                       
                   })
               }

               Return (Package (0x04)
               {
                   "layout-id",
                   Buffer (0x04)
                   {
                        0x01, 0x00, 0x00, 0x00                     
                   },

                   "hda-gfx",
                   Buffer (0x0A)
                   {
                       "onboard-2"
                   }
               })
           }
       }
   }

   Store ("ssdt-ami-7/8/9series_nvidia_hdmi_audio_v3.0 github.com/toleda", Debug)
}