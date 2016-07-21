#!/bin/bash
# A very crude script to setup X11VNC inspired by MrEngmans Realtek RTL8188CUS script and based upon my autosimplesamba

if [ -z $1 ]
then
HDIR="/home/pi"
USERID="pi"
GROUPID="pi"
else
HDIR=/home/$1
USERID=`id -n -u $1`
GROUPID=`id -n -g $1`
fi

X11PASS="123456"

apt-get install -q -y x11vnc
mkdir -p $HDIR/.vnc
chown -R $USERID:$GROUPID $HDIR/.vnc
x11vnc -storepasswd $X11PASS $HDIR/.vnc/passwd
chown -R $USERID:$GROUPID $HDIR/.vnc
mkdir -p $HDIR/.config
chown -R $USERID:$GROUPID $HDIR/.config
cd $HDIR/.config
mkdir -p autostart
chown -R $USERID:$GROUPID $HDIR/.config/autostart
cd autostart
rm -f x11vnc.desktop

echo "[Desktop Entry]" > x11vnc.desktop
echo "Encoding=UTF-8" >> x11vnc.desktop
echo "Type=Application" >> x11vnc.desktop
echo "Name=X11VNC" >> x11vnc.desktop
echo "Comment=" >> x11vnc.desktop
echo "Exec=x11vnc -forever -usepw -display :0 -ultrafilexfer" >> x11vnc.desktop
echo "StartupNotify=false" >> x11vnc.desktop
echo "Terminal=false" >> x11vnc.desktop
echo "Hidden=false" >> x11vnc.desktop

chown -R $USERID:$GROUPID $HDIR/.config/autostart

# time to finish!
echo
echo 
echo "X11VNC installed pw: 123456"
echo
echo
