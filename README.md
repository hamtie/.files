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

## TODO
- make sure laptop locks when closing the lid and reopening
- fix mini displayport detection
- check out registering tab-complete on executables
- detect networks
- add battery indicator to xmobar
- create install script for .files that creates symlinks when
  appropriate, etc
