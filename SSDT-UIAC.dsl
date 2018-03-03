// SSDT-UIAC.dsl
// For Clevo P950HR

DefinitionBlock ("", "SSDT", 2, "hack", "UIAC-ALL", 0)
{
    Device(UIAC)
    {
        Name(_HID, "UIA00000")

        Name(RMCF, Package()
        {
            "8086_a12f", Package()
            {
                "port-count", Buffer() { 26, 0, 0, 0 },
                "ports", Package()
                {
                    "HS01", Package() // HS USB3 left front
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 1, 0, 0, 0 },
                    },
                    "HS03", Package() // HS USB3 right
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 3, 0, 0, 0 },
                    },
                    "HS04", Package() // HS USB3 left rear
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 4, 0, 0, 0 },
                    },
                   "HS07", Package() // Something internal
                    {
                        "UsbConnector", 255,
                        "port", Buffer() { 7, 0, 0, 0 },
                    },
                    "HS08", Package() // Internal Bluetooth
                    {
                        "UsbConnector", 255,
                        "port", Buffer() { 8, 0, 0, 0 },
                    },
                    "HS09", Package() // Internal Webcam
                    {
                        "UsbConnector", 255,
                        "port", Buffer() { 9, 0, 0, 0 },
                    },
                    "SS01", Package() // SS USB3 left front
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 17, 0, 0, 0 },
                    },
                    "SS03", Package() // SS USB3 right
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 19, 0, 0, 0 },
                    },
                    "SS04", Package() // SS USB3 left rear
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 20, 0, 0, 0 },
                    },
                 },
            },
        })
    }

    // USB power properties via USBX device
    // See TonyMacX Guide USB Power property injection
    // Luckily our Embedded Controller already is named EC! (Around 27165 in DSDT.dsl)
    Device(_SB.USBX)
    {
        Name(_ADR, 0)
        Method (_DSM, 4)
        {
            If (!Arg2) { Return (Buffer() { 0x03 } ) }
            Return (Package()
            {
                // these values from iMac17,1
                "kUSBSleepPortCurrentLimit", 2100,
                "kUSBSleepPowerSupply", 5100,
                "kUSBWakePortCurrentLimit", 2100,
                "kUSBWakePowerSupply", 5100,
            })
        }
    }
}
