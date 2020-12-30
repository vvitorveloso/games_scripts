#!/bin/bash

curl -X POST -H "content-type:application/json" http://localhost:8080/jsonrpc -d '{"jsonrpc":"2.0","method":"Addons.SetAddonEnabled","id":9,"params":{"addonid": "peripheral.joystick","enabled":false}}'

/midia/games/emulator/launcher/jslisten/bin/jslisten &

BASEDIR="/midia/games/emulator/"
GENPLUS="*Mega_Drive*|*Master_System*|*Game_Gear*|*Sega_32X*|*Sega_CD*"

DISPLAY=:0 xset -dpms

#SET GLOBAL

echo "# MESA_GLSL_VERSION_OVERRIDE=410 \ "  > /tmp/launch.sh
echo "# MESA_GL_VERSION_OVERRIDE=4.1  \ " >> /tmp/launch.sh
#unset comment do disable
echo "" > /tmp/launch.sh

#############################################GENPLUS########################################
case "$*" in *Mega_Drive*|*Master_System*|*Game_Gear*|*Sega_CD*)

echo  retroarch -f -v -L /usr/lib/libretro/genesis_plus_gx_libretro.so '"'$*'"' >> /tmp/launch.sh

chmod +x /tmp/launch.sh

xinit /tmp/launch.sh -- :5 -nolisten tcp vt5 
;;
##############################################32X#######################################
*Sega_32X*)

echo  retroarch -f -v -L /usr/lib/libretro/picodrive_libretro.so '"'$*'"' >> /tmp/launch.sh

chmod +x /tmp/launch.sh

xinit /tmp/launch.sh -- :5 -nolisten tcp vt5
;;
##############################################SNES#######################################
*Super_Nintendo*)

echo  retroarch -f -v -L /usr/lib/libretro/snes9x_libretro.so '"'$*'"' >> /tmp/launch.sh

chmod +x /tmp/launch.sh

xinit /tmp/launch.sh -- :5 -nolisten tcp vt5
;;
#########################################Saturn##########################################
*Sega_Saturn*)

echo  retroarch -f -v -L /usr/lib/libretro/yabause_libretro.so '"'$*'"' >> /tmp/launch.sh

chmod +x /tmp/launch.sh

xinit /tmp/launch.sh -- :5 -nolisten tcp vt5
;;
##########################################PS2#############################################
*Playstation_2*)

echo retroarch -f -v -L /usr/lib/libretro/play_libretro.so '"'$*'"' >> /tmp/launch.sh

chmod +x /tmp/launch.sh

xinit /tmp/launch.sh -- :5 -nolisten tcp vt5
;;
##########################################PS1#############################################
*Playstation*)

echo retroarch -f -v -L /usr/lib/libretro/mednafen_psx_hw_libretro.so '"'$*'"' >> /tmp/launch.sh

chmod +x /tmp/launch.sh

xinit /tmp/launch.sh -- :5 -nolisten tcp vt5
;;
##########################################GameCube#############################################
*Gamecube*)

cat /var/lib/kodi/.config/retroarch/retroarch.cfg  | sed 's/rewind_enable = \"true\"/rewind_enable = \"false\"/g' > /tmp/GC.cfg

echo  retroarch -c /tmp/GC.cfg -f -v -L /usr/lib/libretro/dolphin_libretro.so '"'$*'"' >> /tmp/launch.sh

chmod +x /tmp/launch.sh

xinit /tmp/launch.sh -- :5 -nolisten tcp vt5 -xf86config game 
;;
##########################################N64#############################################
*N64*)

echo  retroarch -f -v -L /usr/lib/libretro/parallel_n64_libretro.so '"'$*'"' >> /tmp/launch.sh 

chmod +x /tmp/launch.sh

xinit /tmp/launch.sh -- :5 -nolisten tcp vt5 -xf86config game
;;
##########################################DREAMCAST#######################################
*Dreamcast*)

cat /var/lib/kodi/.config/retroarch/retroarch.cfg  | sed 's/rewind_enable = \"true\"/rewind_enable = \"false\"/g' > /tmp/DreamCast.cfg

echo  retroarch -c /tmp/DreamCast.cfg  -f -v -L /usr/lib/libretro/flycast_libretro.so '"'$*'"' >> /tmp/launch.sh

chmod +x /tmp/launch.sh

xinit /tmp/launch.sh -- :5 -nolisten tcp vt5 -xf86config game

;;
esac
########################

killall -9 jslisten &

DISPLAY=:0 xset +dpms

curl -X POST -H "content-type:application/json" http://localhost:8080/jsonrpc -d '{"jsonrpc":"2.0","method":"Addons.SetAddonEnabled","id":9,"params":{"addonid": "peripheral.joystick","enabled":true}}'


