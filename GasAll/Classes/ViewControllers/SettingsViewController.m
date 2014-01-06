//
//  SettingsViewController.m
//  GasAll
//
//  Created by Álvaro Balbontín Gutiérrez on 06/01/14.
//  Copyright (c) 2014 Mobivery. All rights reserved.
//

#import "SettingsViewController.h"
#import "LocalizableConstants.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *mapTypesSegmentedControl;
@property (weak, nonatomic) IBOutlet UIButton *selectGasolineButton;

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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Class methods

- (IBAction)showsGasolinesPicker:(id)sender {

    // TODO: abalbontin: Implement.
    
}

@end
