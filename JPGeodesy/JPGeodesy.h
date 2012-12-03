#import <Foundation/Foundation.h>

typedef struct JPCoordinate {
    double latitude;
    double longitude;
} JPCoordinate;

@interface JPGeodesy : NSObject

+ (double)degreesWithRadians:(double)radians;
+ (double)radiansWithDegrees:(double)degrees;
+ (double)distanceFromPoint:(JPCoordinate)pointA toPoint:(JPCoordinate)pointB radius:(double)radius;
+ (double)bearingFromPoint:(JPCoordinate)pointA toPoint:(JPCoordinate)pointB;
+ (JPCoordinate)destinationPointFromPoint:(JPCoordinate)point withBearing:(double)bearing distance:(double)distance radius:(double)radius;
    
@end
