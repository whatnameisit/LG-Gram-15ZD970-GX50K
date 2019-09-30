// Activate resource table devices in MBP14,1 turned off by default
// LDRC and LDR2 in stock ACPI combine to make macOS LDRC, and stock MATH provides the same resources as in macOS
// Rename original M(_STA) to XSTA in MATH and LDR2 to turn on these devices in config.plist
// _STA also returns true for "Darwin", or macOS
// It returns the value in the original _STA (now named XSTA) in other OS
// Optimal for OpenCore where all OS share the same ACPI table
// Not a necessary patch
// This SSDT is created by whatnameisit
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "hack", "MATHLDR2", 0x00000000)
{
#endif
    External (_SB_.PCI0.LPCB.LDR2, DeviceObj)    // (from opcode)
    External (_SB_.PCI0.LPCB.LDR2.XSTA, MethodObj)    // 0 Arguments (from opcode)
    External (_SB_.PCI0.LPCB.MATH, DeviceObj)    // (from opcode)
    External (_SB_.PCI0.LPCB.MATH.XSTA, MethodObj)    // 0 Arguments (from opcode)
    External (SPTH, IntObj)    // (from opcode)

    Scope (_SB.PCI0.LPCB.MATH)
    {
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0F)
            }
            Else
            {
                Return (\_SB.PCI0.LPCB.MATH.XSTA ())
            }
        }
    }

    Scope (_SB.PCI0.LPCB.LDR2)
    {
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0F)
            }
            Else
            {
                Return (\_SB.PCI0.LPCB.LDR2.XSTA ())
            }
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
