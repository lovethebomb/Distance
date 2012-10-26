//
//  ViewController.h
//  Distance
//
//  Created by HEYMES Lucas on 25/10/12.
//  Copyright (c) 2012 Heymès Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>
{
    BOOL tracking;
    float totalMeters;
    CLLocationManager *locationManager;
    IBOutlet UITextField *distanceField;
    IBOutlet UITextField *altitudeField;
    IBOutlet UITextField *errorField;
    IBOutlet UITextField *callsField;
    int calls;
    IBOutlet MKMapView *mapView;
}

- (IBAction)toggleTracking:(id)sender;
- (IBAction)reset:(id)sender;

@end
