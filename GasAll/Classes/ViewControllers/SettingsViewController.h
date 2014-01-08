//
//  SettingsViewController.h
//  GasAll
//
//  Created by Álvaro Balbontín Gutiérrez on 06/01/14.
//  Copyright (c) 2014 Mobivery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "GasolineDTO.h"

@protocol SettingsViewControllerDelegate;

@interface SettingsViewController : UIViewController

@property (weak, nonatomic) id <SettingsViewControllerDelegate> delegate;

@end

@protocol SettingsViewControllerDelegate <NSObject>

- (void)settingsViewDidChangeMapType:(MKMapType)mapType;
- (void)settingsViewDidChangeGasoline:(GasolineDTO *)gasolineDTO;

@end