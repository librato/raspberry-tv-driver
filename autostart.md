#Launch programs on startup

I have set up my Pi to run Iceweasel on startup. To enable that edit 
`~/.config/lxsession/LXDE-pi/autostart`. Mine looks like this:

```
@lxpanel --profile LXDE-pi
@pcmanfm --desktop --profile LXDE-pi
@xscreensaver -no-splash
@sh /home/pi/start.sh
```

In `start.sh` I created a script that launches Iceweasel to a specific URL and 
switches it to fullscreen:

```
iceweasel https://metrics.librato.com/s/public/js1ddxq6c &
sleep 60
xdotool search --onlyvisible --name firefox key F11
```

The script launches Iceweasel in the background with the URL, then waits for it to 
finish loading and then uses xdotool to simulate the pressing of the F11 key.
It used to work with `iceweasel` but stopped working. Now it works with `firefox`.

##Don't use the screensaver
Configure autostart instead to look like this:
```
@lxpanel --profile LXDE-pi
@pcmanfm --desktop --profile LXDE-pi
@xset s 0 0
@xset s noblank
@xset s noexpose
@xset dpms 0 0 0
@sh /home/pi/start.sh
```
