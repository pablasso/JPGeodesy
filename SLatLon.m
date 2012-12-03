//
//  Latitude/longitude spherical geodesy formulae & scripts (c) Chris Veness 2002-2011 
//   - www.movable-type.co.uk/scripts/latlong.html 
//

//
//  SLatLon.m
//  SLatLon
//
//  Created by Shiki on 3/28/12.
//

#import "SLatLon.h"

#import "tgmath.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SLatLon ()

- (void) setup;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SLatLon

@synthesize lat;
@synthesize lon;
@synthesize rad;

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) setup
{
  self.rad = 6371;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id) initWithLat:(double)latitude lon:(double)longitude
{
  if ((self = [super init])) {
    [self setup];
    self.lat = latitude;
    self.lon = longitude;
  }
  return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id) initWithLat:(double)latitude lon:(double)longitude rad:(double)radius
{
  if ((self = [super init])) {
    [self setup];
    self.lat = latitude;
    self.lon = longitude;
    self.rad = radius;
  }
  return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (double) distanceTo:(SLatLon *)point
{
  double lat1 = SLL_TORAD(self.lat), lon1 = SLL_TORAD(self.lon);
  double lat2 = SLL_TORAD(point.lat), lon2 = SLL_TORAD(point.lon);
  double dLat = lat2 - lat1;
  double dLon = lon2 - lon1;
  
  double a = sin(dLat/2) * sin(dLat/2) +
             cos(lat1) * cos(lat2) *
             sin(dLon/2) * sin(dLon/2);
  double c = 2 * atan2(sqrt(a), sqrt(1-a));
  double d = self.rad * c;
  
  return d;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (double) bearingTo:(SLatLon *)point
{
  double lat1 = SLL_TORAD(self.lat), lat2 = SLL_TORAD(point.lat);
  double dLon = SLL_TORAD((point.lon - self.lon));
  
  double y = sin(dLon) * cos(lat2);
  double x = cos(lat1)*sin(lat2) -
             sin(lat1)*cos(lat2)*cos(dLon);
  double brng = atan2(y, x);
  
  return fmod(SLL_TODEG(brng)+360, 360);
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (SLatLon *) destinationPoint:(double)brng dist:(double)dist
{
  dist = dist / self.rad; // convert dist to angular distance in radians
  brng = SLL_TORAD(brng);
  
  double lat1 = SLL_TORAD(self.lat), lon1 = SLL_TORAD(self.lon);
  
  double lat2 = asin( sin(lat1)*cos(dist) +
                      cos(lat1)*sin(dist)*cos(brng) );
  double lon2 = lon1 + atan2(sin(brng)*sin(dist)*cos(lat1), 
                             cos(dist)-sin(lat1)*sin(lat2));
  lon2 = fmod(lon2+3*M_PI, 2*M_PI) - M_PI; // normalise to -180..+180º
  
  return [[SLatLon alloc] initWithLat:SLL_TODEG(lat2) lon:SLL_TODEG(lon2)];
}

@end
