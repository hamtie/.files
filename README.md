# .files

## Developer tools

- [Java REPL](http://www.javarepl.com/console.html)
- Emacs 24.3.1
- [xmonad](http://xmonad.org/documentation.html)

## Tips and Tricks

1) Setting up daisy-chained, dual-monitors.
On a lenovo laptop (T440p) running xmonads and ubuntu 14.04, updating
the kernel seemed to fix the issue.  I believe only updating to 3.17
is required, but I went ahead and updated to the latest, 3.19.  This solved my issues.

2) Check battery

``` sh
upower -i /org/freedesktop/UPower/devices/battery_BAT0
```

3) xmonads gnome bug
https://bugs.launchpad.net/ubuntu/+source/xmonad/+bug/989405
OR http://www.elonflegenheimer.com/2012/06/22/xmonad-in-ubuntu-12.04-with-unity-2d.html
```sh
sudo apt-get install gnome-panel 
```

4) Use arandr, a grphaical display for xrandr

``` sudo apt-get install arandr ```

5) Run Multiple dropboxes

- change the HOME variable to the directory where you want to install
  the dropbox daemon.
- configure dropbox daemon like you would normally
- repeat the last two steps for each dropbox version you want
- on startup, run something like

```
REAL_HOME="$HOME"
HOME="$REAL_HOME/boxes/biz" dropbox start -i
HOME="$REAL_HOME/boxes/personal" dropbox start -i
```

6) VPN client
forticlient

7) Screen Brightness
http://askubuntu.com/questions/149054/how-to-change-lcd-brightness-from-command-line-or-via-script

8) Trackpad

_I have no idea what I'm doing here, but the thinkpad t440 trackpad is very
annoying so you pretty much can't make it worse_

First attempt:
<!-- http://yarenty.blogspot.com/2014/08/how-to-fix-macbook-pro-touchpad-on.html -->
<!-- https://github.com/ScottGarman/thinkpad_t440s -->

<!-- ``` sh -->
<!-- sudo apt-get install -y xserver-xorg-input-mtrack dconf-editor -->
<!-- ``` -->

Second Attempt:
*https://launchpad.net/~aglasgall/+archive/ubuntu/synaptics*
http://who-t.blogspot.com/2014/03/xorg-synaptics-support-for-lenovo-t440.html
(Note, I'm running kernel 3.19 sooo)

``` sh
sudo add-apt-repository ppa:rsrchboy/xorg-synaptics
sudo apt-get update
sudo apt-get install xserver-xorg-input-synaptics
xserver-xorg-input-mtrack xserver-xorg-input-mtrack
xserver-xorg-input-mtrack-lts-trusty xserver-xorg-input-multitouch
synaptic # i'm just grabbing at straws at this point
synclient -V
```
Start bluetoothd on startup?

... trackpad still freezing ... hmm

http://packages.ubuntu.com/trusty/gnome/indicator-bluetooth


9) Load a jar in javarepl
``` :cp /home/myname/myproject/target/myjar.jar```

10) Notifications
- http://www.webupd8.org/2012/06/closable-movable-notifyosd.html
-
  http://askubuntu.com/questions/128474/how-to-customize-on-screen-notifications

``` sh
> NotifyOSDConfiguration
```

## TODO
- make sure laptop locks when closing the lid and reopening
- fix mini displayport detection
- check out registering tab-complete on executables
- detect networks
- create install script for .files that creates symlinks when
  appropriate, etc

