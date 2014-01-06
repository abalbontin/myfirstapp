//
//  SettingsViewController.m
//  GasAll
//
//  Created by Álvaro Balbontín Gutiérrez on 06/01/14.
//  Copyright (c) 2014 Mobivery. All rights reserved.
//

#import "SettingsViewController.h"
#import "LocalizableConstants.h"
#import "SettingsLogic.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *mapTypesSegmentedControl;
@property (weak, nonatomic) IBOutlet UIButton *selectGasolineButton;

- (IBAction)mapTypesSegmentedSelected:(id)sender;
- (IBAction)showsGasolinesPicker:(id)sender;

@end

@implementation SettingsViewController

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
    
    // Localized texts.
    [self.mapTypesSegmentedControl setTitle:kLocaleStandard forSegmentAtIndex:0];
    [self.mapTypesSegmentedControl setTitle:kLocaleHybrid forSegmentAtIndex:1];
    [self.mapTypesSegmentedControl setTitle:kLocaleSatellite forSegmentAtIndex:2];
    [self.selectGasolineButton setTitle:kLocaleSelectYourGasoline forState:UIControlStateNormal];
    
    switch ([[SettingsLogic sharedInstance] mapType]) {
        case 1:
            [self.mapTypesSegmentedControl setSelectedSegmentIndex:2];
            break;
            
        case 2:
            [self.mapTypesSegmentedControl setSelectedSegmentIndex:1];
            break;
            
        default:
            [self.mapTypesSegmentedControl setSelectedSegmentIndex:0];
            break;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Class methods

- (IBAction)mapTypesSegmentedSelected:(id)sender {
    
    MKMapType mapType;
    switch ([(UISegmentedControl *)sender selectedSegmentIndex]) {
        case 1:
            mapType = MKMapTypeHybrid;
            break;
            
        case 2:
            mapType = MKMapTypeSatellite;
            break;
            
        default:
            mapType = MKMapTypeStandard;
            break;
    }
    
    [self.delegate updateMapType:mapType];
    
    [[SettingsLogic sharedInstance] setMapType:mapType];
    
    [self dismissViewControllerAnimated:YES completion:^{ }];
    
}

- (IBAction)showsGasolinesPicker:(id)sender {

    // TODO: abalbontin: Implement.
    
}

@end
