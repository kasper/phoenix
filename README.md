Phoenix
=======

<img width='128' height='128' align='right' src='https://raw.githubusercontent.com/kasper/phoenix/master/Phoenix/Images.xcassets/AppIcon.appiconset/icon_128x128@2x.png'>

A lightweight OS X window manager for JavaScript. Phoenix aims for efficiency and a very small footprint. If you like the idea of scripting your own window management toolkit
with JavaScript, Phoenix is probably going to give you the things you want.

- Current version: 1.2
- Requires: OS X 10.9 or higher

**Note:** the default `master` branch will always be stable.

## Install

To install Phoenix, you will first need to build it. Install Xcode from the App Store, if you do not already have it installed. You will also need Xcode command line tools — you will be prompted for this. Then, from a terminal run the following:

    git clone https://github.com/kasper/phoenix.git
    cd phoenix
    xcodebuild clean build

Once complete, you will find a newly built Phoenix app in `build/Release/`. To install, just drag-and-drop it to your `Applications` folder. When you run Phoenix for the first time, you will be asked to allow it to control your UI. OS X will ask you to open `Security & Privacy` in System Preferences. Once open, go to the `Accessibility` section and click the checkbox next to Phoenix to enable control. An admin account is required to accomplish this.

## Usage

Phoenix can only be scripted in JavaScript (or languages which compile to JavaScript such as CoffeeScript). See the [JavaScript API](https://github.com/kasper/phoenix/wiki/JavaScript-API-documentation/) to get started with your script. Your script should reside in `~/.phoenix.js` — the file will be created when you launch Phoenix for the first time. For ideas, see what other people have built in their configurations in the [Wiki](https://github.com/kasper/phoenix/wiki/). Feel free to add your own configuration to the Wiki to show other people the nice things you can do.

- [JavaScript API](https://github.com/kasper/phoenix/wiki/JavaScript-API-documentation/)
- [Examples](https://github.com/kasper/phoenix/wiki#example-configs)

## Thanks

Phoenix is currently developed by Kasper Hirvikoski ([@kasper](https://github.com/kasper/)) and Jason Milkins ([@jasonm23](https://github.com/jasonm23/)) with the generous help of contributions made by many [individuals](https://github.com/kasper/phoenix/graphs/contributors/). It was originally authored by Steven Degutis ([@sdegutis](https://github.com/sdegutis/)) as a fork of Zephyros — also an app of his. Steven is continuing his work on OS X window management in [Mjolnir](https://github.com/sdegutis/mjolnir/).

## License

Released under the MIT License. See [license](LICENSE.md).
