# Rasberry Pi as TV controller

- Buy the meanest and leanest raspberry pi you can get. I got the Raspberry Pi 2 Model B with a 900MHz quad-core ARM Cortex-A7 CPU and 1GB RAM.
- A good browser (I use Firefox). 
- [Avahi](https://en.wikipedia.org/wiki/Avahi_(software)) for zeroconf / discoverablility.
- [NGINX](https://www.raspberrypi.org/documentation/remote-access/web-server/nginx.md) as web server.
- A python [http server script](https://github.com/librato/raspberry-pi/blob/master/http_server.py). 
- A tiny [web page](https://github.com/librato/raspberry-pi/blob/master/index.html)

# To display a web page on the TV:

Note: Your network has to support mDNS. Some corporate networks will block that.

- Via browser: Go to `<pi-hostname>.local` and a form will allow you to input a URL. That will start a browser session with that URL.
- Via terminal: `curl --data "url=https://my.appoptics.com" <pi-hostname>.local:8000`

# Fast setup

1. [Install Raspbian](https://www.raspberrypi.org/documentation/installation/installing-images/).
1. Launch `sudo raspi-conf` and 
  1. Expand the filesystem
  2. Set time zone, language, keyboard
  2. Activate SSH access
  3. Change the hostname to something you can remember
  4. Set to auto-login directly to startx
1. Clone this repo and cd into it
1. Run `sudo bash install.sh`
1. Set the [screen resolution](http://elinux.org/RPiconfig ): edit `/boot/config.txt`. [This configuration](config.txt) works for me.
1. Last but not least, check the [autostart.md](autostart.md) file for ideas on auto-starting the browser to a specific URL and settings to stop the Pi from sleeping

# Cloning
When all is set and done you can clone SD cards with [rpi-clone](https://github.com/billw2/rpi-clone). 
After cloning is complete, boot up the cloned Pi and change the hostname with `raspi-conf`.

# Useful stuff
## Cron Jobs
To run scheduled tasks you can use [crontab](https://www.raspberrypi.org/documentation/linux/usage/cron.md)
## Run scripts on startup
To run scripts on startup, you can configure your [autostart](autostart.md) to launch a script. 
## Temperature probe
Turn your Raspberry pi into a [tempreature probe](https://learn.adafruit.com/adafruits-raspberry-pi-lesson-11-ds18b20-temperature-sensing/overview) and [send the data to AppOptics](temperature.md).

