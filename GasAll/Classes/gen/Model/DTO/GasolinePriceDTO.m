//
//  GasolinePriceDTO.m
//  
//  Version: 3.0
//
//  Created by Mobivery
//  Copyright (c) 2012 Mobivery. All rights reserved.
//

#import "GasolinePriceDTO.h"

@implementation GasolinePriceDTO

#pragma mark - NSCopying
// Creates a non-mutable copy of this DTO Object
-(id)copyWithZone:(NSZone *)zone {

	GasolinePriceDTO *copy=[[[self class] alloc] init];
    if(copy) {
		copy.gasID=[self.gasID copyWithZone:zone];
		copy.price=[self.price copyWithZone:zone];
	}
	return copy;
}

#pragma mark - NSMutableCopying
// Creates a mutable copy of this DTO Object
-(id)mutableCopyWithZone:(NSZone *)zone {

	GasolinePriceDTO *copy=[[[self class] alloc] init];
	if(copy) {
		copy.gasID=self.gasID;
		copy.price=self.price;
	}
	return copy;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
	
	self.gasID = [decoder decodeObjectForKey:@"gasID"];
	self.price = [decoder decodeObjectForKey:@"price"];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
	
	[encoder encodeObject:self.gasID forKey:@"gasID"];
	[encoder encodeObject:self.price forKey:@"price"];
}

@end
 