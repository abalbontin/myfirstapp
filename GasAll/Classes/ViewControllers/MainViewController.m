//
//  MainViewController.m
//  GasAll
//
//  Created by Álvaro Balbontín Gutiérrez on 31/12/13.
//  Copyright (c) 2013 Mobivery. All rights reserved.
//

#import "MainViewController.h"
#import <MapKit/MapKit.h>

@interface MainViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@property (nonatomic) BOOL showUserLocation;

- (IBAction)centerUserLocation:(id)sender;

- (void)setUserLocationRegion;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // We translucent the toolbar with the current color.
    self.toolbar.alpha = 0.9;
        
    self.showUserLocation = YES;
    self.mapView.showsUserLocation = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Class methods

- (IBAction)centerUserLocation:(id)sender {
    
    if (self.mapView.userLocation.location.coordinate.latitude != 0.0 && self.mapView.userLocation.location.coordinate.longitude != 0.0) {
        
        [self setUserLocationRegion];
        
    }
    
}

- (void)setUserLocationRegion {
    
    MKCoordinateRegion mapRegion;
    mapRegion.center = self.mapView.userLocation.coordinate;
    mapRegion.span.latitudeDelta = 0.05;
    mapRegion.span.longitudeDelta = 0.05;
    
    [self.mapView setRegion:mapRegion animated: YES];
    
}

#pragma mark - Protocol MKMapViewDelegate methods

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if (self.showUserLocation) {
        
        self.showUserLocation = NO;
        
        [self setUserLocationRegion];
        
    }
}

@end
