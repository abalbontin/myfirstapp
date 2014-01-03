//
//  NearGasStationsRequestDTO.m
//  
//  Version: 3.0
//
//  Created by Mobivery
//  Copyright (c) 2012 Mobivery. All rights reserved.
//

#import "NearGasStationsRequestDTO.h"

@implementation NearGasStationsRequestDTO

#pragma mark - NSCopying
// Creates a non-mutable copy of this DTO Object
-(id)copyWithZone:(NSZone *)zone {

	NearGasStationsRequestDTO *copy=[[[self class] alloc] init];
    if(copy) {
		copy.latitude=[self.latitude copyWithZone:zone];
		copy.longitude=[self.longitude copyWithZone:zone];
	}
	return copy;
}

#pragma mark - NSMutableCopying
// Creates a mutable copy of this DTO Object
-(id)mutableCopyWithZone:(NSZone *)zone {

	NearGasStationsRequestDTO *copy=[[[self class] alloc] init];
	if(copy) {
		copy.latitude=self.latitude;
		copy.longitude=self.longitude;
	}
	return copy;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
	
	self.latitude = [decoder decodeObjectForKey:@"latitude"];
	self.longitude = [decoder decodeObjectForKey:@"longitude"];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
	
	[encoder encodeObject:self.latitude forKey:@"latitude"];
	[encoder encodeObject:self.longitude forKey:@"longitude"];
}

@end
 