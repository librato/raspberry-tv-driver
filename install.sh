#IceWeasel browser specific
echo "----- installing iceweasel"
sudo apt-get -y install iceweasel
#run iceweasel to create a profile
iceweasel
echo "----- installing iceweasel config"
#Grab default profile directory name and add user.js file - that disables recovery on crash
icedir=$(ls /home/pi/.mozilla/firefox | grep .default)
sudo mv user.js /home/pi/.mozilla/firefox/$icedir/
echo "----- installing xdotool"
#Xdotool allows key stroke generation to put iceweasel into full screen with F11
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
cd /home/pi/raspberry-pi/avahi_services
sudo insserv avahi-daemon/
sudo mv multiple.service /etc/avahi/services/
sudo mv rfb.service /etc/avahi/services/
sudo /etc/init.d/avahi-daemon restart
cd /home/pi/raspberry-pi
echo "----- setting up startup"
sudo mv startup /etc/init.d/
cd /etc/init.d/
sudo chmod +x startup
sudo update-rc.d startup defaults
echo "----- setting up vnc"
cd /home/pi/raspberry-pi
sudo bash installx11vnc.sh
cd /home/pi
echo "...all done."
