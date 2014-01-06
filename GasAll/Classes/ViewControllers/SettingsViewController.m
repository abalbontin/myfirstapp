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

@interface SettingsViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mapTypesSegmentedControl;
@property (weak, nonatomic) IBOutlet UIButton *selectGasolineButton;
@property (weak, nonatomic) IBOutlet UIPickerView *gasolinesPicker;

@property (strong, nonatomic) NSArray *gasolines;
@property (nonatomic) NSInteger initGasloineSelected;
@property (nonatomic) NSInteger lastGasolineSelected;
@property (nonatomic) BOOL gasolinesPickerDidSelectRow;

- (IBAction)mapTypesSegmentedSelected:(id)sender;
- (IBAction)showsGasolinesPicker:(id)sender;
- (IBAction)closeView:(id)sender;

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
    
    self.gasolines = [[SettingsLogic sharedInstance] gasolines];
    self.gasolinesPickerDidSelectRow = NO;
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
        
    }];
    
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
    
    [self closeView:nil];
    
}

- (IBAction)showsGasolinesPicker:(id)sender {
    
    GasolineDTO *userGasolineDTO = [[SettingsLogic sharedInstance] userGasolineSelected];
    for (NSInteger idx = 0; idx < self.gasolines.count; idx++) {
        
        GasolineDTO *gasolineDTO = [self.gasolines objectAtIndex:idx];
        if ([gasolineDTO.gasID isEqualToString:userGasolineDTO.gasID]) {
            
            self.initGasloineSelected = idx;
            
        }
        
    }
    [self.gasolinesPicker selectRow:self.initGasloineSelected inComponent:0 animated:NO];
    
    [UIView animateWithDuration:0.5 animations:^{
       
        self.selectGasolineButton.hidden = YES;
        self.gasolinesPicker.hidden = NO;
        
        CGRect contentViewFrame = self.contentView.frame;
        contentViewFrame.origin.y = contentViewFrame.origin.y - self.gasolinesPicker.frame.size.height +
        self.selectGasolineButton.frame.size.height;
        contentViewFrame.size.height = contentViewFrame.size.height + self.gasolinesPicker.frame.size.height -
        self.selectGasolineButton.frame.size.height;
        
        self.contentView.frame = contentViewFrame;
        
    }];
    
}

- (IBAction)closeView:(id)sender {
    
    if (self.gasolinesPickerDidSelectRow && self.initGasloineSelected != self.lastGasolineSelected) {
        
        GasolineDTO *gasolineDTO = [self.gasolines objectAtIndex:self.lastGasolineSelected];
        
        [[SettingsLogic sharedInstance] setUserGasolineSelected:gasolineDTO];
        
        [self.delegate updateGasoline:gasolineDTO];
        
    }
    
    [UIView animateWithDuration:0.2 animations:^{

        self.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
        
    } completion:^(BOOL finished) {
    
        [self dismissViewControllerAnimated:YES completion:^{ }];
        
    }];
    
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

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.gasolinesPickerDidSelectRow = YES;
    self.lastGasolineSelected = row;
    
}

@end
