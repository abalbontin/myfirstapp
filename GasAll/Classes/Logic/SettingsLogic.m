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
        
    }
    
    return self;
}

// Returns types of gasolines (array of GasolineDTO)
- (NSArray *)gasolines {
    
    NSString *settingsPath = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@".plist"];
    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:settingsPath];
    
    return [settings objectForKey:@"gasolines"];
    
}

@end
