BeaconControl iOS Sample Application (Swift)
=======================

## Overview

This is a sample app that presents the capabilities of [BeaconControl iOS SDK](https://github.com/upnext/BeaconControl_iOS_SDK). The app is written in Swift 3.0.1

By default it communicates with publicly accessible BeaconControl server instance located at https://beaconcontrol.io. You can change it by adding a "BCLBaseURLAPI" key to the app's Info.plist. 

Code from this app (with an addition of login functionality) is used in BeaconControl Scanner App Store app. The App Store app uses credentials from the default Test Application after sign in.

## Usage

### Beacons tab

This tab shows a list of all beacons fetched from the backend sorted by distance.
Each row contains a beacon name, UUID and range (with additional distance to beacon if available).
If beacon is out of range, the text will be grayed-out.

Additionally, there is a _Reload_ button at the bottom, which can be used to fetch new beacons if the configuration at the backend was changed.

### Actions tab

This tab shows a list of actions that have happened during the lifetime of the application.
The actions are defined in the BeaconControl web panel under _Applications_.

## For developers

The code present in this repository should be self-explanatory.

The project uses cocoapods dependencies, so you need to run `pod update` after cloning the repo.

Before you run the app, you need to provide client ID and secret for your BeaconControl application in the app delegate. They can be found in the BeaconControl's admin panel in your application's settings.

## License

License can be found in LICENSE.txt file.

If you have any trouble, please contact us at feedback@beaconcontrol.io.
