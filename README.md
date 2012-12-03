JPGeodesy
=========

An Objective-C port of the Latitude/longitude spherical geodesy formulae & scripts by Chris Veness. Read more about it here: [http://www.movable-type.co.uk/scripts/latlong.html](http://www.movable-type.co.uk/scripts/latlong.html)

The port is not complete yet though. I've only ported those that are currently of use to me. Feel free to fork and add more.

This is a fork of [BJ Basañes](https://github.com/shiki) original [SLatLong](https://github.com/shiki/SLatLon).

### Example

Finding the destination point based on a origin, distance, radius (from earth) and
bearing (direction).

``` objective-c
JPCoordinate pointA = {37.30, -121.91};
JPCoordinate pointB = [JPGeodesy destinationPointFromPoint:pointA withBearing:180.0 distance:1900 radius:6371];
NSLog("latitude:%f longitude:%f", pointB.latitude, pointB.longitude);
```

### Install

You can just drag the files, but you get extra points for being awesome and using [CocoaPods](http://cocoapods.org/). 

### License

[Attribution 3.0](http://creativecommons.org/licenses/by/3.0/)
