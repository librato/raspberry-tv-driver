#Rasberry Pi as TV controller (IceWeasel version)

- Buy the meanest and leanest raspberry pi you can get. I got the Raspberry Pi 2 Model B with a 900MHz quad-core ARM Cortex-A7 CPU and 1GB RAM.
- Iceweasel. 
- [Avahi](https://en.wikipedia.org/wiki/Avahi_(software)) for zeroconf / discoverablility.
- [NGINX](https://www.raspberrypi.org/documentation/remote-access/web-server/nginx.md) as web server.
- A python [http server script](https://github.com/librato/raspberry-pi/blob/master/http_server.py). 
- A tiny [web page](https://github.com/librato/raspberry-pi/blob/master/index.html)

#To display a web page on the TV:

Note: You need to be on the wired network. It will not work if you are on the SolarWinds or Guest wifi networks.
- Go to `<pi-hostname>.local` and a form will allow you to input a URL. That will start a chromium session with that URL.
- Use terminal: `curl --data "url=https://www.librato.com" <pi-hostname>.local:8000`

#Fast setup

1. Install Raspbian Jessie.
2. Launch `sudo raspi-conf` and 
  1. Expand the filesystem
  2. Set time zone, language, keyboard
  2. Activate SSH access
  3. Change the hostname
  4. Set to auto-login directly to startx
3. clone this repo and cd into it
4. run install.sh (may have to chmod +x it first)
6. Disable the screensaver in the desktop UI.
7. Set the [screen resolution](http://elinux.org/RPiconfig ): edit `/boot/config.txt`. [This configuration](https://gist.github.com/niklibrato/305a1891ffa71ac2edfb) works for me.

#Cloning
When all is set and done you can clone SD cards with [rpi-clone](https://github.com/billw2/rpi-clone). 
After cloning is complete, boot up the cloned Pi and change the hostname with `raspi-conf`.

#Stlying
You can use CSS browser plugins to force Spaces to use a dark theme. For example [Stylish](https://https://userstyles.org) has plugins for Chrome, Firefox, and Safari. It allows you to map specific URLs to custom CSS. Stylish has a social aspect to it; users can share CSS themes. I added a couple of [Librato Spaces themes](https://userstyles.org/styles/browse?search_terms=librato).
There's also the [Style Script plugin](https://addons.mozilla.org/en-US/firefox/addon/custom-style-script/?src=ss) that works on iceweasel. 
