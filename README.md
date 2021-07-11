# Writer

A writing application for elementary OS. Currently you can only write, save, and load files. You can change the font and font size, but only for the entire file, and it doesn't save when you close it.

![Writer](/.screenshots/writer1.png "Writer")

# Install it from source

You can of course download and install this app from source.

## Dependencies

Ensure you have these dependencies installed

* granite
* gtk+-3.0
* switchboard-2.0

## Install, build and run

```bash
# install elementary-sdk, meson and ninja
sudo apt install elementary-sdk meson ninja
# clone repository
git clone {{repository_url}} Writer
# cd to dir
cd Writer
# run meson
meson build --prefix=/usr
# cd to build, build and test
cd build
sudo ninja install && Writer
```

## Generating pot file

```bash
# after setting up meson build
cd build

# generates pot file
ninja Writer-pot

# to regenerate and propagate changes to every po file
ninja Writer-update-po
```
