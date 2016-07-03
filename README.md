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

If you first time use this rooting method, please run this.

```
$ adb shell monkey -p com.dlto.atom.launcher -c android.intent.category.LAUNCHER 1
```

After first run, you should install button overlay app, it help to start launcher at next boot time.
Currently, cannot change default home application before remove or move to sdcard ridibooks app.
(System prevent this feature, and press home button always launch ridibooks app)

I suggest [full!screen][fullscreen] for this, second button action change to `launch application`, and setup your favorite home launcher.

[fullscreen]: https://play.google.com/store/apps/details?id=de.tsorn.FullScreen
