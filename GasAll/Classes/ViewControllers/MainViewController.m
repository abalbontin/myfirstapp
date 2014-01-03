//
//  MainViewController.m
//  GasAll
//
//  Created by Álvaro Balbontín Gutiérrez on 31/12/13.
//  Copyright (c) 2013 Mobivery. All rights reserved.
//

#import "MainViewController.h"
#import <MapKit/MapKit.h>
#import "GetNearGasStationsTask.h"
#import "LocalizableConstants.h"

@interface MainViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *userLocationButton;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nearbyBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *featuredBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *promotionsBarButtonItem;

@property (nonatomic) BOOL firstUserLocation;
@property (nonatomic, getter = isUserInterfaceHidden) BOOL userInterfaceHidden;

- (IBAction)centerUserLocation:(id)sender;
- (IBAction)handleMapTap:(UITapGestureRecognizer *)recognizer;
- (IBAction)showNearbyGasStations:(id)sender;
- (IBAction)showFeaturedGasStations:(id)sender;
- (IBAction)showPromotionsGasStations:(id)sender;
- (IBAction)showSettings:(id)sender;

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
    
    self.firstUserLocation = YES;
    self.mapView.showsUserLocation = YES;
    
    self.userInterfaceHidden = NO;
    
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

- (IBAction)handleMapTap:(UITapGestureRecognizer *)recognizer {
    
    CGPoint point = [recognizer locationInView:self.mapView];
    UIView *viewSelected = [self.mapView hitTest:point withEvent:nil];
        
    if (![viewSelected isKindOfClass:[MKAnnotationView class]]) {
        
        // Shows or hides UI: Toolbar and location button.
        [UIView animateWithDuration:0.5 animations:^{
            
            CGRect toolBarFrame = self.toolbar.frame;
            if (self.isUserInterfaceHidden) {
                
                toolBarFrame.origin.y = toolBarFrame.origin.y - toolBarFrame.size.height;
                
                self.userLocationButton.transform = CGAffineTransformScale(CGAffineTransformMakeScale(10.0f, 10.0f), 0.1f, 0.1f);
                
            } else {
                
                toolBarFrame.origin.y = toolBarFrame.origin.y + toolBarFrame.size.height;
                
                self.userLocationButton.transform = CGAffineTransformScale(CGAffineTransformMakeScale(0.0f, 0.0f), 0.1f, 0.1f);
                
            }
            self.toolbar.frame = toolBarFrame;
            
            self.userInterfaceHidden = !self.userInterfaceHidden;
            
        }];
        
    }
    
}

- (IBAction)showNearbyGasStations:(id)sender {
    
    self.nearbyBarButtonItem.tintColor = [UIColor blackColor];
    self.featuredBarButtonItem.tintColor = [UIColor whiteColor];
    self.promotionsBarButtonItem.tintColor = [UIColor whiteColor];
    
    // TODO: abalbontin: Implement.
    
}

- (IBAction)showFeaturedGasStations:(id)sender {

    self.nearbyBarButtonItem.tintColor = [UIColor whiteColor];
    self.featuredBarButtonItem.tintColor = [UIColor blackColor];
    self.promotionsBarButtonItem.tintColor = [UIColor whiteColor];
    
    // TODO: abalbontin: Implement.

}

- (IBAction)showPromotionsGasStations:(id)sender {

    self.nearbyBarButtonItem.tintColor = [UIColor whiteColor];
    self.featuredBarButtonItem.tintColor = [UIColor whiteColor];
    self.promotionsBarButtonItem.tintColor = [UIColor blackColor];
    
    // TODO: abalbontin: Implement.

}

- (IBAction)showSettings:(id)sender {

    // TODO: abalbontin: Implement.

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
    if (self.firstUserLocation) {
     
        self.firstUserLocation = NO;
        
        NearGasStationsRequestDTO *nearGasStationsRequestDTO = [[NearGasStationsRequestDTO alloc] init];
        nearGasStationsRequestDTO.latitude = [NSNumber numberWithDouble:mapView.userLocation.coordinate.latitude];
        nearGasStationsRequestDTO.longitude = [NSNumber numberWithDouble:mapView.userLocation.coordinate.longitude];
        [GetNearGasStationsTask getNearGasStationsTaskForRequest:nearGasStationsRequestDTO
                                                       completed:^(NSInteger statusCode, NearGasStationsResponseDTO *response) {
                                                           
                                                           // TODO: abalbontin: Implement.
                                                           
                                                       } error:^(NSError *error) {
        
                                                           self.firstUserLocation = YES;
                                                           
                                                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kLocaleWarning
                                                                                                           message:kLocaleGetNearGasStationsError
                                                                                                          delegate:self
                                                                                                 cancelButtonTitle:kLocaleAccept
                                                                                                 otherButtonTitles:nil];
                                                           [alert show];
                                                           
                                                       }];
        
        [self setUserLocationRegion];
        
    }
    
}

@end
