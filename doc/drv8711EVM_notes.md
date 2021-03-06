# DRV8711EVM
the big stepper motor eval kit from TI  
- DRV8711 has 3.3v logic

### Buspirate settings for sinffing:
`m-5-2-1-1-1-1-1-(2)`

The bus pirate SPI bus sniffed trace for a "proper setup" using the TI provided EVM gui tool (matching my scereen grabs) is:  
`[0x0F(0xFF)][0x11(0xFF)][0x11(0xFF)][0x7B(0xFF)][0x20(0xFF)][0x32(0xFF)][0x31(0xFF)][0x00(0xFF)][0x45(0xFF)][0x10(0xFF)][0x5A(0xFF)][0x02(0xFF)][0x60(0xFF)][0x00(0xFF)`

So just the sends were:
```
[0x0F 0x11]
[0x11 0x7B]
[0x20 0x32]
[0x31 0x00]
[0x45 0x10]
[0x5A 0x02]
[0x60 0x00]
```
or with no breaks: 
`0x0F11117B2032310045105A026000`

Then the trace for the readout of all the registers using the official gui after applying the "proper setup" is:  
`[0x80(0x8F)][0x00(0x11)][0x90(0x81)][0x00(0x7B)][0xA0(0x80)][0x00(0x32)][0xB0(0x81)][0x00(0x00)][0xC0(0x85)][0x00(0x10)][0xD0(0x8A)][0x00(0x02)][0xE0(0x80)][0x00(0x00)`  
So from that, the readback requests were:
```
[0x80 0x00]
[0x90 0x00]
[0xA0 0x00]
[0xB0 0x00]
[0xC0 0x00]
[0xD0 0x00]
[0xE0 0x00]
```
and the readback responses were:
```
[0x8F 0x11]
[0x81 0x7B]
[0x80 0x32]
[0x81 0x00]
[0x85 0x10]
[0x8A 0x02]
[0x80 0x00]
```

### Buspirate settings for writing:  
`m-5-2-1-1-1-1-1-W-e-2-P`  
Then we can program the part:
```
[0x0F 0x11][0x11 0x7B][0x20 0x32][0x31 0x00][0x45 0x10][0x5A 0x02][0x60 0x00]
```
Then let's verify what we wrote with:
```
{0x80 0x00]{0x90 0x00]{0xA0 0x00]{0xB0 0x00]{0xC0 0x00]{0xD0 0x00]{0xE0 0x00]
```
and we'd better get back:
```
CS ENABLED
WRITE: 0x80 READ: 0x8F 
WRITE: 0x00 READ: 0x11 
CS DISABLED
CS ENABLED
WRITE: 0x90 READ: 0x81 
WRITE: 0x00 READ: 0x7B 
CS DISABLED
CS ENABLED
WRITE: 0xA0 READ: 0x80 
WRITE: 0x00 READ: 0x32 
CS DISABLED
CS ENABLED
WRITE: 0xB0 READ: 0x81 
WRITE: 0x00 READ: 0x00 
CS DISABLED
CS ENABLED
WRITE: 0xC0 READ: 0x85 
WRITE: 0x00 READ: 0x10 
CS DISABLED
CS ENABLED
WRITE: 0xD0 READ: 0x8A 
WRITE: 0x00 READ: 0x02 
CS DISABLED
CS ENABLED
WRITE: 0xE0 READ: 0x80 
WRITE: 0x00 READ: 0x00 
CS DISABLED
```
To read the status register send:`{0b11110000 0b00000000]`
To reset all faults send: `[0b01110000 0b00000000]`

So then the values stored in the registers are (found by &ing the above responses with 0x7ffff):  
Register 0x00: 0x0F11  
Register 0x01: 0x017B  
Register 0x02: 0x0032  
Register 0x03: 0x0100  
Register 0x04: 0x0510  
Register 0x05: 0x0A02  
Register 0x06: 0x0000
