//
//  SettingsLogic.h
//  GasAll
//
//  Created by Álvaro Balbontín Gutiérrez on 04/01/14.
//  Copyright (c) 2014 Mobivery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GasolineDTO.h"
#import <MapKit/MapKit.h>

@interface SettingsLogic : NSObject

@property (strong, nonatomic) GasolineDTO *userGasolineSelected;
@property (nonatomic) MKMapType mapType;

// Get the shared instance and create it if necessary.
+ (SettingsLogic *)sharedInstance;

// Returns types of gasolines (array of GasolineDTO)
- (NSArray *)gasolines;

@end
