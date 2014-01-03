//
//  NearGasStationsResponseDTO.m
//  
//  Version: 3.0
//
//  Created by Mobivery
//  Copyright (c) 2012 Mobivery. All rights reserved.
//

#import "NearGasStationsResponseDTO.h"

@implementation NearGasStationsResponseDTO

#pragma mark - NSCopying
// Creates a non-mutable copy of this DTO Object
-(id)copyWithZone:(NSZone *)zone {

	NearGasStationsResponseDTO *copy=[[[self class] alloc] init];
    if(copy) {
		copy.gasStations=[self.gasStations copyWithZone:zone];
	}
	return copy;
}

#pragma mark - NSMutableCopying
// Creates a mutable copy of this DTO Object
-(id)mutableCopyWithZone:(NSZone *)zone {

	NearGasStationsResponseDTO *copy=[[[self class] alloc] init];
	if(copy) {
		copy.gasStations=[self.gasStations mutableCopyWithZone:zone];
	}
	return copy;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
	
	self.gasStations = [decoder decodeObjectForKey:@"gasStations"];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
	
	[encoder encodeObject:self.gasStations forKey:@"gasStations"];
}

@end
 