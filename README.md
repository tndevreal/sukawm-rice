# sukawm-rice
yea its a nord themed rice for SukaWM

# Works only on:
  *  Arch
  *  Artix
  *  Void


You CAN install SukaWM and the SukaWM rice on ALMOST any distro, as long as it has:

 *  A working Xlibre or Xorg server
 *  SukaWM's dependencies(not needed, but MASSIVELY improve the SukaWM experience.

You just need to do it manually, you can check what the installation script does and then: edit it, or just run the commands needed(adjust package manager if needed)



More distros will work in the future


–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––


installation does NOT need SukaWM to already be installed.

preview:
![Failed to load](preview.jpg)   


how to install:
```
cd ~
git clone https://github.com/tndevreal/sukawm-rice
cd sukawm-rice
sudo chown -R "$USER:$USER" * || doas chown -R "$USER:$USER" *
sudo chmod a+x install.sh || doas chmod a+x install.sh
sudo chmod a+x polybar/launch.sh || doas chmod a+x polybar/launch.sh
./install.sh
```


i just edited ts in class btw

