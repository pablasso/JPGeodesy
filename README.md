JPGeodesy
=========

An Objective-C port of the Latitude/longitude spherical geodesy formulae & scripts by Chris Veness. Read more about it here: [http://www.movable-type.co.uk/scripts/latlong.html](http://www.movable-type.co.uk/scripts/latlong.html)

This is only a partial port. Feel free to fork and add more.

This is a fork of [BJ Basañes](https://github.com/shiki) original [SLatLong](https://github.com/shiki/SLatLon). I wanted a different coding style, hence, this repo.

### Examples

* Get the distance from one point to another with the earth radius.

```objective-c
JPCoordinate pointA = {37.30, -121.91};
JPCoordinate pointB = {57.30, -120.91};
double distance = [JPGeodesy distanceFromPoint:pointA toPoint:pointB radius:6371];
```

* Find the bearing (direction) between two points

```objective-c
JPCoordinate pointA = {37.30, -121.91};
JPCoordinate pointB = {57.30, -120.91};
double bearing = [JPGeodesy bearingFromPoint:pointA toPoint:pointB];
```

* Finding the destination point based on a origin, distance, radius (from earth) and bearing (direction).

``` objective-c
JPCoordinate pointA = {37.30, -121.91};
JPCoordinate pointB = [JPGeodesy destinationPointFromPoint:pointA withBearing:180.0 distance:1900 radius:6371];
NSLog("latitude:%f longitude:%f", pointB.latitude, pointB.longitude);
```

### Install

You can just drag the source files, but you get extra points for being awesome and using [CocoaPods](http://cocoapods.org/). 

### License

[Attribution 3.0](http://creativecommons.org/licenses/by/3.0/)
