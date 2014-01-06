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
#import "GasStationAnnotation.h"
#import "SettingsLogic.h"
#import "MVYDefines.h"
#import "SettingsViewController.h"

@interface MainViewController () <MKMapViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, SettingsViewControllerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *userLocationButton;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nearbyBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *featuredBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *promotionsBarButtonItem;

@property (weak, nonatomic) IBOutlet UIView *gasolinesView;
@property (weak, nonatomic) IBOutlet UIView *gasolinesPickerView;
@property (weak, nonatomic) IBOutlet UILabel *selectGasolineLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *gasolinesPicker;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;

@property (nonatomic) BOOL firstUserLocation;
@property (nonatomic, getter = isUserInterfaceHidden) BOOL userInterfaceHidden;
@property (strong, nonatomic) NSArray *gasStations;
@property (strong, nonatomic) NSArray *gasolines;
@property (nonatomic, strong) NSMutableArray *currentAnnotations;

- (IBAction)centerUserLocation:(id)sender;
- (IBAction)handleMapTap:(UITapGestureRecognizer *)recognizer;
- (IBAction)showsNearbyGasStations:(id)sender;
- (IBAction)showsFeaturedGasStations:(id)sender;
- (IBAction)showsPromotionsGasStations:(id)sender;
- (IBAction)showsSettings:(id)sender;
- (IBAction)dismissGasolinesView:(id)sender;

- (void)showsGasolinesView;
- (void)searchGasolinesNearUser;
- (void)setUserLocationRegion;
- (void)loadPOIsNearGasStations;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
        _currentAnnotations = [NSMutableArray array];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Localized texts.
    self.selectGasolineLabel.text = kLocaleSelectYourGasoline;
    [self.selectButton setTitle:kLocaleSelect forState:UIControlStateNormal];
    
    // We translucent the toolbar with the current color.
    self.toolbar.alpha = 0.9;
    self.mapView.mapType = [[SettingsLogic sharedInstance] mapType];
    self.gasolinesPickerView.layer.cornerRadius = 14.0;
    if (!IS_IPHONE_5) {
        
        CGSize viewSize = [[UIScreen mainScreen] bounds].size;
        
        CGRect pickerViewFrame = self.gasolinesPickerView.frame;
        pickerViewFrame.origin.y = (viewSize.height / 2.0) - (pickerViewFrame.size.height / 2.0);
        self.gasolinesPickerView.frame = pickerViewFrame;
        
    }
    
    if ([[SettingsLogic sharedInstance] userGasolineSelected] == nil) {
                
        [self showsGasolinesView];
        
    } else {
        
        [self searchGasolinesNearUser];
        
    }
    
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

- (IBAction)showsNearbyGasStations:(id)sender {
    
    self.nearbyBarButtonItem.tintColor = [UIColor blackColor];
    self.featuredBarButtonItem.tintColor = [UIColor whiteColor];
    self.promotionsBarButtonItem.tintColor = [UIColor whiteColor];
    
    // TODO: abalbontin: Implement.
    
}

- (IBAction)showsFeaturedGasStations:(id)sender {

    self.nearbyBarButtonItem.tintColor = [UIColor whiteColor];
    self.featuredBarButtonItem.tintColor = [UIColor blackColor];
    self.promotionsBarButtonItem.tintColor = [UIColor whiteColor];
    
    // TODO: abalbontin: Implement.

}

- (IBAction)showsPromotionsGasStations:(id)sender {

    self.nearbyBarButtonItem.tintColor = [UIColor whiteColor];
    self.featuredBarButtonItem.tintColor = [UIColor whiteColor];
    self.promotionsBarButtonItem.tintColor = [UIColor blackColor];
    
    // TODO: abalbontin: Implement.

}

- (IBAction)showsSettings:(id)sender {

    SettingsViewController *settingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController"
                                                                                              bundle:nil];
    settingsViewController.delegate = self;
    
    // This viewController will be visible on Modal presentation.
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    [self presentViewController:settingsViewController animated:YES completion:^{ }];
    
}

- (IBAction)dismissGasolinesView:(id)sender {
    
    NSInteger index = [self.gasolinesPicker selectedRowInComponent:0];
    [[SettingsLogic sharedInstance] setUserGasolineSelected:[self.gasolines objectAtIndex:index]];
 
    [self.gasolinesView removeFromSuperview];
    
    [self searchGasolinesNearUser];
    
}

- (void)showsGasolinesView {
    
    self.gasolines = [[SettingsLogic sharedInstance] gasolines];
    
    [self.view addSubview:self.gasolinesView];
    
}

- (void)searchGasolinesNearUser {
    
    self.firstUserLocation = YES;
    self.mapView.showsUserLocation = YES;
    
}

- (void)setUserLocationRegion {
    
    MKCoordinateRegion mapRegion;
    mapRegion.center = self.mapView.userLocation.coordinate;
    mapRegion.span.latitudeDelta = 0.05;
    mapRegion.span.longitudeDelta = 0.05;
    
    [self.mapView setRegion:mapRegion animated: YES];
    
}

- (void)loadPOIsNearGasStations {
    
    [self.mapView removeAnnotations:self.currentAnnotations];
    
    [self.currentAnnotations removeAllObjects];
    for (GasStationDTO *gasStationDTO in self.gasStations) {
        
        if (gasStationDTO.latitude != nil && gasStationDTO.longitude != nil &&
            ([gasStationDTO.latitude doubleValue] != 0.0 && [gasStationDTO.longitude doubleValue] != 0.0)) {
            
            GasStationAnnotation *annotation = [[GasStationAnnotation alloc] init];
            annotation.gasStationDTO = gasStationDTO;
            [self.currentAnnotations addObject:annotation];
            
        }
        
    }
    
    [self.mapView addAnnotations:self.currentAnnotations];
    
}

#pragma mark - MKMapViewDelegate methods

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if (self.firstUserLocation) {
     
        self.firstUserLocation = NO;
        
        NearGasStationsRequestDTO *nearGasStationsRequestDTO = [[NearGasStationsRequestDTO alloc] init];
        nearGasStationsRequestDTO.latitude = [NSNumber numberWithDouble:mapView.userLocation.coordinate.latitude];
        nearGasStationsRequestDTO.longitude = [NSNumber numberWithDouble:mapView.userLocation.coordinate.longitude];
        [GetNearGasStationsTask getNearGasStationsTaskForRequest:nearGasStationsRequestDTO
                                                       completed:^(NSInteger statusCode, NearGasStationsResponseDTO *response) {
                                                           
                                                           self.gasStations = response.gasStations;
                                                           
                                                           [self loadPOIsNearGasStations];
                                                           
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

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
	static NSString *identifier = @"GasStationAnnotation";
	MKAnnotationView *annotationView = (MKAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
	
	if(annotation != nil && [annotation isKindOfClass:[GasStationAnnotation class]]) {
        
        if(annotationView == nil) {
            
			annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.canShowCallout = YES;
			annotationView.image = [UIImage imageNamed:@"map_annotation_generic"];
            
		} else {
            
			annotationView.annotation = annotation;
            
		}
        
		return annotationView;
        
	} else {
        
		return nil;
        
	}
    
}

#pragma mark - UIPickerViewDataSource and UIPickerViewDelegate methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.gasolines.count;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [[self.gasolines objectAtIndex:row] name];
    
}

#pragma mark - SettingsViewControllerDelegate methods

- (void)updateMapType:(MKMapType)mapType {
    
    self.mapView.mapType = mapType;
    
}

- (void)updateGasoline:(GasolineDTO *)gasolineDTO {
    
    // TODO: abalbontin: Con las gasolineras que ya tenemos, recalcular las mejores segun precio, colores de POIs, etc y actualziar el mapa.
    NSLog(@"TEST Gasoline: %@", gasolineDTO.gasID);
    
}

@end
