# Ridibooks Paper rooting image generator

## Prerequire
```bash
$ git clone git://...
$ cd ridi-paper-root-image
$ sudo dpkg -i rkflashkit_0.1.4_all.deb
```

## How to use
```bash
$ sudo rkflashkit backup @system system.img
$ sudo chown $(id -u):$(id -g) system.img
$ export ANDROID_SDK=/path/to/android-sdk/
$ bash updater-script.sh
$ sudo rkflashkit flash @system system.rooted.img reboot
```
