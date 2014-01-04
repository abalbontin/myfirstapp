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
        
    }
    
    return self;
}

// Returns types of gasolines (array of GasolineDTO)
- (NSArray *)gasolines {
    
    NSString *settingsPath = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@".plist"];
    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:settingsPath];
    
    return [settings objectForKey:@"gasolines"];
    
}

- (void)setUserGasolineSelected:(GasolineDTO *)gasolineDTO {
    
    _userGasolineSelected = gasolineDTO;
    
    NSDictionary *gasolineDictionary = @{@"gasID": gasolineDTO.gasID, @"name": gasolineDTO.name};
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:gasolineDictionary forKey:@"userGasolineSelected"];
    [userDefaults synchronize];
    
}

@end
