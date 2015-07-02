# Phoenix

<img align="right" valign="top" src="https://raw.githubusercontent.com/kasper/phoenix/master/Phoenix/Images.xcassets/AppIcon.appiconset/icon_256x256.png"/>

*The lightweight OS X window manager for hackers*

Phoenix is a fork of Zephyros that aims for efficiency and a very
small footprint.

* Current version: **1.2**
* Requires: OS X 10.9 and up

Phoenix was originally authored by
[Steven Degutis / @sdegutis](https://github.com/sdegutis), it's now
maintained by [Kasper Hirvikoski](https://github.com/kasper) and [Jason Milkins / @jasonm23](https://github.com/jasonm23) 

Steven is continuing work on OSX window management in
[Mjolnir](https://github.com/mjolnir-io/mjolnir)

Jason is primarily using [Hammerspoon](http://hammerspoon.org) (a fork of Mjolnir)

#### Install

Install XCode and XCode command line tools, then from a terminal:

    git clone https://github.com/kasper/phoenix.git
    cd phoenix
    xcodebuild

When complete you'll find a freshly built **Phoenix** app in
`build/release`.

To install it just drag-drop it to your `/Applications` folder.

When you first run Phoenix, you'll need to allow it to control UI. OS
X will alert you of this, and open **System Preferences > Security**

An admin account is required to enable it.

Please Note: the default `master` branch will always be
stable.

Features, bug fixes etc. will be done in topic branches and
only merged to `master` when stable.

#### No AppStore, No  Pre-Built binaries, No Cask...

For the record, I'm not interested in supporting users who can't build
Phoenix for themselves, it will do nothing for you without a fair
degree of scripting knowledge, so I won't be providing any pre-built
binaries here or via any other distribution methods.

I may add a recipe to Homebrew, because I can assume you'll have (1)
the ability to use the terminal without weeping, (2) XCode will be
installed.

I hope I don't hurt anyone's feelings, if you want something shiny
and app-store-ey, you can use Moom (it's quite nice apparently.)

If you like the idea of scripting your own Window Management toolkit
with JavaScript, Phoenix is probably going to give you the things you
want.

#### Usage

For ideas, read other people's configs
[in the wiki](https://github.com/kasper/phoenix/wiki) -

Also add your own config to the wiki to show other people the cool
things you can do.

#### Documentation

- [JavaScript API Documentation](https://github.com/kasper/phoenix/wiki/JavaScript-API-documentation)

Phoenix can only be scripted in JavaScript.

(...or languages which compile to JavaScript e.g. CoffeeScript,
LiveScript, ClojureScript, TypeScript etc. etc.)

#### License

Released under the MIT License. See [license](LICENSE.md).
