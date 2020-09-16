# EoS-asm-hacks
This repository contains my asm hacks for Explorers of Sky.

## Usage
In order to apply a hack to a ROM you have to extract the ROM first (you will need [ndstool](https://github.com/devkitPro/ndstool) or any other similar program for that). Next, you can apply the hack using [armips](https://github.com/Kingcom/armips). Using this system over the typical binary patch method allows you to make changes to the code if you wish.

Put the armips executable and the source .asm file used by the patch in the same folder. You will also need to have the `common` folder in there, since it's requiered for my hacks to work.

Each hack has a list of required files (the ones that will be patched) that must be placed inside that same folder. The list is shown at the beginning of the file.

You can change the target ROM region (US/EU) by editing `common/regionSelect.asm`. Make sure that the patch you want to apply supports the chosen region (supported regions are also displayed at the beginning of the file), otherwise you will just get a lot of errors.

Finally, you just need to run armips and pass the name of the .asm file you want to apply as an argument. If you don't see any errors, the patch was successful.