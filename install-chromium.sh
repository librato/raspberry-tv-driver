#!/bin/bash
#Chromium browser specific
echo ">>> update system"
sudo apt-get update
echo ">>> install jq"
sudo apt-get -y install jq
echo ">>> install httping"
sudo apt-get -y install httping
echo ">>> installing chromium"
sudo apt-get -y install chromium-browser
#run firefox to create a profile
export DISPLAY=:0
echo ">>> installing xdotool"
#Xdotool allows key stroke generation to put firefox into full screen with F11
sudo apt-get -y install xdotool
#Generic things:
echo "----- installing unclutter"
sudo apt-get -y install unclutter
echo ">>> installing NGINX"
sudo apt-get -y install nginx
echo ">>> moving files"
sudo mv part1.html /home/pi/
sudo mv part2.html /home/pi/
sudo mv http_server.py /home/pi
sudo mv index.css /var/www/html/
echo ">>> setting up Avahi"
sudo apt-get -y install avahi-daemon avahi-dnsconfd avahi-discover avahi-utils
sudo apt-get -y install libnss-mdns
cd /home/pi/raspberry-tv-driver/avahi_services
sudo insserv avahi-daemon
sudo mv multiple.service /etc/avahi/services/
sudo mv rfb.service /etc/avahi/services/
sudo /etc/init.d/avahi-daemon restart
cd /home/pi/raspberry-tv-driver
echo ">>> setting up startup"
sudo mv startup_chromium /etc/init.d/
cd /etc/init.d/
sudo chmod +x startup_chromium
sudo update-rc.d startup_chromium defaults
echo ">>> setting up vnc"
cd /home/pi/raspberry-tv-driver
sudo bash installx11vnc.sh
cd /home/pi
echo "----- stop Raspberry from sleeping"
cd /home/pi/raspberry-tv-driver
sudo mv autostart /home/pi/.config/lxsession/LXDE-pi/
sudo chown pi:pi /home/pi/.config/lxsession/LXDE-pi/autostart
echo "...all done. rebooting"
sudo reboot
