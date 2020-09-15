# EoS-asm-hacks
This repository contains my asm hacks for Explorers of Sky.

## Usage
In order to apply a hack to a ROM you have to extract the ROM first (you will need [ndstool](https://github.com/devkitPro/ndstool) or any other similar program for that). Next, you can apply the hack using [armips](https://github.com/Kingcom/armips). Using this system over the typical binary patch method allows you to make changes to the code if you wish.

Keep in mind that you must use the appropriate ROM and that each hack has a list of required files (the ones that will be patched) that must be placed in the same folder as the source .asm file. Both of those things are displayed at the beginning of the file.

Note: armips v0.11 does not output anything if the patch is applied successfully. You can check the modification date of the files to ensure they were patched.
