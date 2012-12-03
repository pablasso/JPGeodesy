#import "JPGeodesy.h"
#import "tgmath.h"

@implementation JPGeodesy

+ (double)degreesWithRadians:(double)radians {
    return radians * 180.0 / M_PI;
}

+ (double)radiansWithDegrees:(double)degrees {
    return degrees * M_PI / 180.0;
}

+ (double)distanceFromPoint:(JPCoordinate)pointA toPoint:(JPCoordinate)pointB radius:(double)radius {
    double lat1 = [JPGeodesy radiansWithDegrees:pointA.latitude];
    double lon1 = [JPGeodesy radiansWithDegrees:pointA.longitude];
    double lat2 = [JPGeodesy radiansWithDegrees:pointB.latitude];
    double lon2 = [JPGeodesy radiansWithDegrees:pointB.longitude];
    double dLat = lat2 - lat1;
    double dLon = lon2 - lon1;

    double a = sin(dLat/2) * sin(dLat/2) + cos(lat1) * cos(lat2) * sin(dLon/2) * sin(dLon/2);
    double c = 2 * atan2(sqrt(a), sqrt(1-a));
    double d = radius * c;

    return d;
}

+ (double)bearingFromPoint:(JPCoordinate)pointA toPoint:(JPCoordinate)pointB {
    double lat1 = [JPGeodesy radiansWithDegrees:pointA.latitude];
    double lat2 = [JPGeodesy radiansWithDegrees:pointB.latitude];
    double dLon = [JPGeodesy radiansWithDegrees:pointB.longitude - pointA.longitude];
    
    double y = sin(dLon) * cos(lat2);
    double x = cos(lat1)*sin(lat2) - sin(lat1)*cos(lat2)*cos(dLon);
    double bearing = atan2(y, x);
    
    return fmod([JPGeodesy degreesWithRadians:bearing]+360, 360);
}

+ (JPCoordinate)destinationPointFromPoint:(JPCoordinate)point withBearing:(double)bearing distance:(double)distance radius:(double)radius {
    distance = distance / radius;
    bearing = [JPGeodesy radiansWithDegrees:bearing];
    
    double lat1 = [JPGeodesy radiansWithDegrees:point.latitude];
    double lon1 = [JPGeodesy radiansWithDegrees:point.longitude];
    double lat2 = asin(sin(lat1) * cos(distance) + cos(lat1) * sin(distance) * cos(bearing));
    double lon2 = lon1 + atan2(sin(bearing) * sin(distance) * cos(lat1), cos(distance) - sin(lat1) * sin(lat2));
    lon2 = fmod(lon2+3*M_PI, 2*M_PI) - M_PI;
    
    JPCoordinate pointB;
    pointB.latitude = [JPGeodesy degreesWithRadians:lat2];
    pointB.longitude = [JPGeodesy degreesWithRadians:lon2];
    return pointB;
}

@end
