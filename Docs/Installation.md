#Installation

###Recommended

The recommended way to install BetweenKit is via the popular dependency management tool, [CocoaPods](http://cocoapods.org/):

- __Install CocoaPods and setup a CocoaPods workspace__: if you don't have CocoaPods installed or are unfamiliar with its use, here are a couple of external resources that will help:

	- [Getting started with CocoaPods](http://guides.cocoapods.org/using/getting-started.html)
	- [CocoaPods tutorial](http://code.tutsplus.com/tutorials/streamlining-cocoa-development-with-cocoapods--mobile-15938)

- __Add the BetweenKit pod to your project__:

	- Add `pod "BetweenKit", "~> 2.0.0"` to the targets in your Podfile.
	- Update or install your pods via the command line with `pod update` or `pod install`.

- __Tip__:

	- The BetweenKit Podspec was only recently submitted to the CocoaPods master spec repo; I found that I had to force CocoaPods to re-pull the repo before BetweenKit became available.

	- If you get `[!] Unable to find a specification for BetweenKit (~> 2.0.0)` then running `sudo rm -rf ~/.cocoapods && pod setup` before `pod install` might help.


###Ad-hoc

Alternatively, if for whatever reason you aren't using CocoaPods, you can:

- __Install it as a [Git submodule](http://git-scm.com/docs/git-submodule)__:

		cd <Path to your application>
		git init # If you haven't already initialized the directory as a repo
		git submodule add https://github.com/ice3-software/between-kit.git
		git submodule update --init --recursive

		# Checkout version of your choice

		cd between-kit
		git checkout 2.0.0

		# Git status your submodules and decide how to commit

		cd ../ && git submodule status
		...


- __Copy everything in the `Pod/` directory to your application__ (preferably in some sort of `Vendor` folder).

Note that the preferred method of installation is via CocoaPods.


#Dependencies and Requirements

BetweenKit is written in Objective-C with ARC enabled - Swift is not yet supported but [will be in the future](). Its main dependency is [UIKit](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIKit_Framework/).

BetweenKit _should_ be compatible with iOS 6 upwards, however development is currently done in an XCode 6 environment and tests are run on iOS 8.* simulators alongside a couple of iOS 8.0/7.1 devices.

____

<u>Documentation</u>: BetweenKit 2.0.0
