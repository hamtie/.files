# .files

## Developer tools

- Emacs 25.1
  ```
      sudo add-apt-repository -y ppa:ubuntu-elisp
      sudo apt-get update
      sudo apt-get install emacs-snapshot
  ```

- Xmonad + Xmobar

- [Java REPL](http://www.javarepl.com/console.html)

## Tips and Tricks

1) Check battery

    ``` sh
    upower -i /org/freedesktop/UPower/devices/battery_BAT0
    ```

2) xmonads gnome bug

    - https://bugs.launchpad.net/ubuntu/+source/xmonad/+bug/989405
    - OR http://www.elonflegenheimer.com/2012/06/22/xmonad-in-ubuntu-12.04-with-unity-2d.html
    ```sh
    sudo apt-get install gnome-panel
    ```

3) Use arandr, a grphaical display for xrandr

    ``` sudo apt-get install arandr ```


4) Screen Brightness

    - http://askubuntu.com/questions/149054/how-to-change-lcd-brightness-from-command-line-or-via-script


5) Load a jar in javarepl

    ``` :cp /home/myname/myproject/target/myjar.jar```

6) Xmonad + Xmobar
    ```
     sudo apt-get install libasound2-dev libiw-dev libghc-libxml-sax-dev c2hs libxpm-dev
     cabal install xmobar --flags="all_extensions"
    ```
    - Trouble with alsa / pulseaudio creating static?
      Change line `load-module module-udev-detect` to `load-module module-udev-detect tsched=0`in pulseaudio config in `/etc/pulse/default.pa`

7) Remap capslock -> escape

    ```
    sudo setxkbmap -option caps:escape
    ```
