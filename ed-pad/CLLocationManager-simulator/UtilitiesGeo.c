/*
 *  UtilitiesGeo.h
 *
 *  Created by Gary Morris on 3/6/11.
 *  Copyright 2011 Gary A. Morris. All rights reserved.
 *
 */

#include "UtilitiesGeo.h"
#include <math.h>

/*-------------------------------------------------------------------------
 * Given a starting lat/lon point on earth, distance (in meters)
 * and bearing, calculates destination coordinates lat2/lon2.
 *
 * all params in radians
 *-------------------------------------------------------------------------*/
void destCoordsInRadians(double lat1, double lon1,
						 double distanceMeters, double bearing,
						 double* lat2, double* lon2)
{
	//-------------------------------------------------------------------------
	// Algorithm from http://www.geomidpoint.com/destination/calculation.html
	// Algorithm also at http://www.movable-type.co.uk/scripts/latlong.html
	//
	// Spherical Earth Model
	//   1. Let radiusEarth = 6372.7976 km or radiusEarth=3959.8728 miles
    //   2. Convert distance to the distance in radians.
	//      dist = dist/radiusEarth
	//   3. Calculate the destination coordinates.
	//      lat2 = asin(sin(lat1)*cos(dist) + cos(lat1)*sin(dist)*cos(brg))
	//      lon2 = lon1 + atan2(sin(brg)*sin(dist)*cos(lat1), cos(dist)-sin(lat1)*sin(lat2))
	//-------------------------------------------------------------------------
	const double distRadians = distanceMeters / EARTH_RADIUS_METERS;

	*lat2 = asin( sin(lat1) * cos(distRadians) + cos(lat1) * sin(distRadians) * cos(bearing));

	*lon2 = lon1 + atan2( sin(bearing) * sin(distRadians) * cos(lat1),
						  cos(distRadians) - sin(lat1) * sin(*lat2) );
}

/*-------------------------------------------------------------------------
 * Given a starting lat/lon point on earth, distance (in meters)
 * and bearing, calculates destination coordinates lat2/lon2.
 *
 * all params in degrees
 *-------------------------------------------------------------------------*/
void destCoordsInDegrees(double lat1, double lon1,
						 double distanceMeters, double bearing,
						 double* lat2, double* lon2)
{
	destCoordsInRadians(Deg_to_Rad(lat1), Deg_to_Rad(lon1),
						distanceMeters, Deg_to_Rad(bearing),
						lat2, lon2);

	*lat2 = Rad_to_Deg( *lat2 );
	*lon2 = normalize180( Rad_to_Deg( *lon2 ) );
}


/*-------------------------------------------------------------------------
 * Given two lat/lon points on earth, calculates the heading
 * from lat1/lon1 to lat2/lon2.
 *
 * lat/lon params in radians
 * result in radians
 *-------------------------------------------------------------------------*/
double headingInRadians(double lat1, double lon1, double lat2, double lon2)
{
	//-------------------------------------------------------------------------
	// Algorithm found at http://www.movable-type.co.uk/scripts/latlong.html
	//
	// Spherical Law of Cosines
	//
	// Formula: θ = atan2( 	sin(Δlong) * cos(lat2),
	//						cos(lat1) * sin(lat2) − sin(lat1) * cos(lat2) * cos(Δlong) )
	// JavaScript:
	//
	//	var y = Math.sin(dLon) * Math.cos(lat2);
	//	var x = Math.cos(lat1) * Math.sin(lat2) - Math.sin(lat1) * Math.cos(lat2) * Math.cos(dLon);
	//	var brng = Math.atan2(y, x).toDeg();
	//-------------------------------------------------------------------------
	double dLon = lon2 - lon1;
	double y = sin(dLon) * cos(lat2);
	double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);

	return atan2(y, x);
}

/*-------------------------------------------------------------------------
 * Given two lat/lon points on earth, calculates the heading
 * from lat1/lon1 to lat2/lon2.
 *
 * lat/lon params in degrees
 * result in degrees
 *-------------------------------------------------------------------------*/
double headingInDegrees(double lat1, double lon1, double lat2, double lon2)
{
	return Rad_to_Deg( headingInRadians(Deg_to_Rad(lat1),
										Deg_to_Rad(lon1),
										Deg_to_Rad(lat2),
										Deg_to_Rad(lon2)) );
}

// Normalize a heading in degrees to be within -179.999999° to 180.00000°
double normalize180(double heading)
{
	while (1) {
		if (heading <= -180) {
			heading += 360;
		} else if (heading > 180) {
			heading -= 360;
		} else {
			return heading;
		}
	}
}

// Normalize a heading in degrees to be within -179.999999° to 180.00000°
float normalize180f(float heading)
{
	while (1) {
		if (heading <= -180) {
			heading += 360;
		} else if (heading > 180) {
			heading -= 360;
		} else {
			return heading;
		}
	}
}

// Normalize a heading in degrees to be within 0° to 359.999999°
double normalize360(double heading)
{
	while (1) {
		if (heading < 0) {
			heading += 360;
		} else if (heading >= 360) {
			heading -= 360;
		} else {
			return heading;
		}
	}
}

// Normalize a heading in degrees to be within 0° to 359.999999°
float normalize360f(float heading)
{
	while (1) {
		if (heading < 0) {
			heading += 360;
		} else if (heading >= 360) {
			heading -= 360;
		} else {
			return heading;
		}
	}
}

