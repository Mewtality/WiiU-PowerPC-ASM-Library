# WiiU-PowerPC-ASM-Library
A library containing symbol names and various useful macros to speed up cheat code making.

## Setup
- Download the assembly folder and its contents.<br />
- Place them in devkitpro: "**C:\devkitPro\devkitPPC**"
<br /><br />
## How to use
In your assembly code, import whichever file you need, for example:<br /><br />
```.include "C:/devkitPro/devkitPPC/assembly/common.S"```<br />
(This contains symbol names for fastcall and syscalls, as well as various useful macros.)

```.include "C:/devkitPro/devkitPPC/modules/coreinit.S"```<br />
(This contains symbol names from coreinit.rpl)

```.include "C:/devkitPro/devkitPPC/titles/AMKP01/tools.S"```<br />
(This contains various macros and symbol names for Mario Kart 8. This also includes **common.S**)
<br /><br />
## About
The "**modules**" folder contains symbol names. Currently only "coreinit" is available.<br />
The "**titles**" folders contain game-specific symbol names, useful macros, etc.<br /><br />
This is really only useful for compiling my [released codes for MK8](https://github.com/Mewtality/TCPGecko-MK8-Cheat-Codes/tree/main/Source%20Code).
<br /><br />
## todo
- Documentation
