#Launch programs on startup

I have set up my Pi to run Iceweasel on startup. To enable that edit 
`~/.config/lxsession/LXDE-pi/autostart`. Mine looks like this:

```
@lxpanel --profile LXDE-pi
@pcmanfm --desktop --profile LXDE-pi
@xset s 0 0
@xset s noblank
@xset s noexpose
@xset dpms 0 0 0
@sh /home/pi/start.sh
```

This includes commands that are supposed to stop the Pi from sleeping. `xset s off` disables the screen saver, 
`xset dpms` disables the DPMS (Display Power Management Signaling) and `xset s noblank` tells to X server to not 
blank the video device.

##Start.sh
In `start.sh` I created a script that launches Firefox to a specific URL and 
switches it to fullscreen:

```
#!/bin/bash
export DISPLAY=:0
firefox clocktab.com &
sleep 60
xdotool search --onlyvisible --name firefox key F11
```
You can also tell the Pis to "phone home" to fetch a URL from a Github repo. Create a private repo and generate a private token that has `repo` access. The repo should have a json file with the following format:

```
{
  "hostname":"http://myurl.com"
}
```
As the `start.sh` script use:
```
#!/bin/bash
export DISPLAY=:0
sleep 10
mapping=$(curl -H 'Authorization: token YOU_TOKEN_HERE' -H 'Accept: application/vnd.github.v3.raw' -L https://api.github.com/repos/YOUR_ORGANIZATION/YOUR_REPO_NAME/contents/PATH/TO/JSON/FILE)
my_hostname=$(hostname)
url=$(echo $mapping | jq -r ".${my_hostname}")
firefox $url &
sleep 20
xdotool search --onlyvisible --name firefox key F11
```

The script launches Firefox in the background with the URL, then waits for it to 
finish loading and then uses xdotool to simulate the pressing of the F11 key to go full screen.

##Disabling the blank screen forever
If you want to disable the blank screen at every startup, just update the /etc/lightdm/lightdm.conf file and add in the [SeatDefaults] section the following command:

```
[SeatDefaults]
xserver-command=X -s 0 -dpms
```
