# EoS-asm-hacks
This repository contains my asm patches for Explorers of Sky.

## Usage
In order to apply a patch to a ROM you have to extract the ROM first (you will need [ndstool](https://github.com/devkitPro/ndstool), [tinke](https://github.com/pleonex/tinke) or any other similar program for that). Next, you can apply the patch using [armips](https://github.com/Kingcom/armips). Using this system over the typical binary patch method allows you to make changes to the code if you wish.

Put the armips executable and the source .asm file that contains the patch in the same folder. You will also need to have the `common` folder in there, since it's requiered for my patches to work.

Each patch has a list of required files (the ones that will be patched) that must be placed inside that same folder. The list is shown at the beginning of the file.

You can change the target ROM region (US/EU) by editing `common/regionSelect.asm`. Make sure that the patch you want to apply supports the chosen region (supported regions are also displayed at the beginning of the file), otherwise you will get a lot of errors and the patch won't be applied.

Finally, you just need to run armips and pass the name of the .asm file you want to apply as an argument (run `armips.exe NameOfThePatch.asm` in a terminal). If you don't see any errors, the patch was successfully applied.

## Extra overlay
The ExtraOverlay.asm patch allows adding an extra overlay to the game that can be used to store additional code. After applying it you will also have to add the extra overlay (`overlay_0036.bin`) to the ROM.
