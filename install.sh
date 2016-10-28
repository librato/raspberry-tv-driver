#!/bin/bash
#Firefox browser specific
echo "----- update system"
sudo apt-get update
echo "----- install jq"
sudo apt-get -y install jq
echo "----- installing firefox"
sudo apt-get -y install firefox-esr
#run firefox to create a profile
export DISPLAY=:0
firefox &
echo "----- installing browser profile"
#Grab default profile directory name and add user.js file - that disables recovery on crash
browserdir=$(ls /home/pi/.mozilla/firefox | grep .default)
sudo mv user.js /home/pi/.mozilla/firefox/$browserdir/
echo "----- installing xdotool"
#Xdotool allows key stroke generation to put firefox into full screen with F11
sudo apt-get -y install xdotool
#Generic things:
#echo "----- installing screen saver"
#sudo apt-get -y install xscreensaver
echo "----- installing unclutter"
sudo apt-get -y install unclutter
echo "----- installing NGINX"
sudo apt-get -y install nginx
echo "----- moving files"
sudo mv part1.html /home/pi/
sudo mv part2.html /home/pi/
sudo mv http_server.py /home/pi
sudo mv index.css /var/www/html/
echo "----- setting up Avahi"
sudo apt-get -y install avahi-daemon avahi-dnsconfd avahi-discover avahi-utils
sudo apt-get -y install libnss-mdns
cd /home/pi/raspberry-tv-driver/avahi_services
sudo insserv avahi-daemon
sudo mv multiple.service /etc/avahi/services/
sudo mv rfb.service /etc/avahi/services/
sudo /etc/init.d/avahi-daemon restart
cd /home/pi/raspberry-tv-driver
echo "----- setting up startup"
sudo mv startup /etc/init.d/
cd /etc/init.d/
sudo chmod +x startup
sudo update-rc.d startup defaults
echo "----- setting up vnc"
cd /home/pi/raspberry-tv-driver
sudo bash installx11vnc.sh
cd /home/pi
echo "...all done."
