//
//  SettingsLogic.m
//  GasAll
//
//  Created by Álvaro Balbontín Gutiérrez on 04/01/14.
//  Copyright (c) 2014 Mobivery. All rights reserved.
//

#import "SettingsLogic.h"

@implementation SettingsLogic

// Get the shared instance and create it if necessary.
+ (SettingsLogic *)sharedInstance {
    
    static dispatch_once_t onceQueue;
    static SettingsLogic *instance = nil;
    
    dispatch_once(&onceQueue, ^{ instance = [[self alloc] init]; });
    return instance;
}

- (id)init {
    
    self = [super init];
    
    if(self) {
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        NSDictionary *gasolineDictionary = [userDefaults objectForKey:@"userGasolineSelected"];
        if (gasolineDictionary != nil) {
        
            _userGasolineSelected = [[GasolineDTO alloc] init];
            _userGasolineSelected.gasID = [gasolineDictionary objectForKey:@"gasID"];
            _userGasolineSelected.name = [gasolineDictionary objectForKey:@"name"];
            
        }
        
        NSNumber *aMapType = [userDefaults objectForKey:@"mapType"];
        if (aMapType != nil) {
            
            switch ([aMapType integerValue]) {
                case 1:
                    self.mapType = MKMapTypeSatellite;
                    break;
                    
                case 2:
                    self.mapType = MKMapTypeHybrid;
                    break;
                    
                default:
                    self.mapType = MKMapTypeStandard;
                    break;
            }
            
        } else {
            
            self.mapType = MKMapTypeStandard;
            
        }
        
    }
    
    return self;
}

// Returns types of gasolines (array of GasolineDTO)
- (NSArray *)gasolines {
    
    NSString *settingsPath = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@".plist"];
    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:settingsPath];
    
    NSMutableArray *gasolines = [NSMutableArray array];
    for (NSDictionary *gasoline in [settings objectForKey:@"gasolines"]) {
        
        GasolineDTO *gasolineDTO = [[GasolineDTO alloc] init];
        gasolineDTO.gasID = [gasoline objectForKey:@"gasID"];
        gasolineDTO.name = [gasoline objectForKey:@"name"];
        
        [gasolines addObject:gasolineDTO];
        
    }
    
    return [NSArray arrayWithArray:gasolines];
    
}

- (void)setUserGasolineSelected:(GasolineDTO *)gasolineDTO {
    
    _userGasolineSelected = gasolineDTO;
    
    NSDictionary *gasolineDictionary = @{@"gasID": gasolineDTO.gasID, @"name": gasolineDTO.name};
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:gasolineDictionary forKey:@"userGasolineSelected"];
    [userDefaults synchronize];
    
}

- (void)setMapType:(MKMapType)mapType {
    
    _mapType = mapType;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSNumber numberWithInteger:mapType] forKey:@"mapType"];
    [userDefaults synchronize];
    
}

@end
