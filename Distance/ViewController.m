//
//  ViewController.m
//  Distance
//
//  Created by HEYMES Lucas on 25/10/12.
//  Copyright (c) 2012 Heymès Lucas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
     totalMeters = 0;
     tracking = NO;
     calls = 0;
    
    // MapView initp
    CLLocation *startLocation = [[[CLLocation alloc] initWithLatitude:48.826885 longitude:2.356664] autorelease];
    [mapView setCenterCoordinate:startLocation.coordinate animated:NO];
    MKCoordinateRegion mapRegion;
    mapRegion.center = [startLocation coordinate];
    mapRegion.span.latitudeDelta = 0.01;
    mapRegion.span.longitudeDelta = 0.01;
    [mapView setRegion:mapRegion animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Méthodes de la vue
- (void)toggleTracking:(id)sender
{
    tracking = !tracking;
    if (tracking)
        [locationManager startUpdatingLocation];
    else
        [locationManager stopUpdatingLocation];
    
    NSLog(@"Tracking: %i", tracking);
    
    [mapView setMapType:MKMapTypeSatellite];
    
}

- (void)reset:(id)sender
{
    totalMeters = 0;
    [distanceField setText:[NSString stringWithFormat:@"%f m", totalMeters]];
    NSLog(@"Reset!");
}


// Méthodes de délégation
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    
    // Textfields
    callsField.text = [NSString stringWithFormat:@"%d", ++calls];
    errorField.text = [NSString stringWithFormat:@"%f m", newLocation.horizontalAccuracy];
    
    // Output old and new
    NSLog(@"oldLocation : %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    NSLog(@"newLocation : %f %f", newLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    
    if (calls < 6) return;
    if (newLocation.horizontalAccuracy > 100) return;
    totalMeters += [newLocation distanceFromLocation:oldLocation];
    
    distanceField.text = [NSString stringWithFormat:@"%f m", totalMeters];
    altitudeField.text = [NSString stringWithFormat:@"%f m", newLocation.altitude];

}

- (void)mapView:(MKMapView *)map regionWillChangeAnimated:(BOOL)animated
{
    NSLog(@"Region : %f %f", map.region.span.longitudeDelta, map.region.span.latitudeDelta);
}

- (void)dealloc
{
    if (tracking)
        [locationManager stopUpdatingLocation];
    [locationManager release];
    [mapView release];
    [super dealloc];
}

@end
