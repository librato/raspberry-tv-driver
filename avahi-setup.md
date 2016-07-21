#Set up Avahi / Zeroconf 

[Zeroconf](http://en.wikipedia.org/wiki/Zero_configuration_networking) is 'a set of techniques that automatically 
creates a usable Internet Protocol (IP) network without manual operator intervention or special configuration servers.

[Avahi](http://en.wikipedia.org/wiki/Avahi_(software)) is an implementation of zeroconf which ships with most Linux 
and BSD distributions, but _not_ the Pi's Debian distro. Zeroconf will be familiar to Apple users as *Bonjour*. 
Once the Pi is set up, you will be able to address it as `raspberrypi.local` regardless of the IP address.

##Install Avahi
 
```shell
sudo apt-get install avahi-daemon
sudo insserv avahi-daemon
```

## Create configuration files for Avahi

```shell
sudo nano /etc/avahi/services/multiple.service
```
...with this content:
```xml
<?xml version="1.0" standalone='no'?>
<!DOCTYPE service-group SYSTEM "avahi-service.dtd">
<service-group>
  <name replace-wildcards="yes">%h</name>
  <service>
    <type>_device-info._tcp</type>
    <port>0</port>
  </service>
  <service>
    <type>_ssh._tcp</type>
    <port>22</port>
  </service>
</service-group>
```
Add a service so that the pi can be discovered on the network:

`sudo nano /etc/avahi/services/rfb.service`

..with this content:

```xml
<?xml version="1.0" standalone='no'?><!--*-nxml-*-->
<!DOCTYPE service-group SYSTEM "avahi-service.dtd">
<service-group>
  <name replace-wildcards="yes">%h VNC</name>
  <service>
    <type>_rfb._tcp</type>
    <port>5900</port>
  </service>
</service-group>
```

##Apply the new configuration

`sudo /etc/init.d/avahi-daemon restart`

The Pi should now be addressable from other machines as `raspberrypi.local` so you can SSH into the Pi using:

`ssh pi@raspberrypi.local`
