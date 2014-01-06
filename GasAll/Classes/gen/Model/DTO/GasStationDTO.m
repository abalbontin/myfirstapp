//
//  GasStationDTO.m
//  
//  Version: 3.0
//
//  Created by Mobivery
//  Copyright (c) 2012 Mobivery. All rights reserved.
//

#import "GasStationDTO.h"

@implementation GasStationDTO

#pragma mark - NSCopying
// Creates a non-mutable copy of this DTO Object
-(id)copyWithZone:(NSZone *)zone {

	GasStationDTO *copy=[[[self class] alloc] init];
    if(copy) {
		copy.id=[self.id copyWithZone:zone];
		copy.name=[self.name copyWithZone:zone];
		copy.gasolinePrice=[self.gasolinePrice copyWithZone:zone];
		copy.latitude=[self.latitude copyWithZone:zone];
		copy.longitude=[self.longitude copyWithZone:zone];
		copy.distance=[self.distance copyWithZone:zone];
		copy.promoted=[self.promoted copyWithZone:zone];
		copy.promotionText=[self.promotionText copyWithZone:zone];
		copy.promotionImage=[self.promotionImage copyWithZone:zone];
		copy.promotionCode=[self.promotionCode copyWithZone:zone];
		copy.promotionTextExtra=[self.promotionTextExtra copyWithZone:zone];
	}
	return copy;
}

#pragma mark - NSMutableCopying
// Creates a mutable copy of this DTO Object
-(id)mutableCopyWithZone:(NSZone *)zone {

	GasStationDTO *copy=[[[self class] alloc] init];
	if(copy) {
		copy.id=self.id;
		copy.name=self.name;
		copy.latitude=self.latitude;
		copy.longitude=self.longitude;
		copy.distance=self.distance;
		copy.promoted=self.promoted;
		copy.promotionText=self.promotionText;
		copy.promotionImage=self.promotionImage;
		copy.promotionCode=self.promotionCode;
		copy.promotionTextExtra=self.promotionTextExtra;
		copy.gasolinePrice=[self.gasolinePrice mutableCopyWithZone:zone];
	}
	return copy;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
	
	self.id = [decoder decodeObjectForKey:@"id"];
	self.name = [decoder decodeObjectForKey:@"name"];
	self.gasolinePrice = [decoder decodeObjectForKey:@"gasolinePrice"];
	self.latitude = [decoder decodeObjectForKey:@"latitude"];
	self.longitude = [decoder decodeObjectForKey:@"longitude"];
	self.distance = [decoder decodeObjectForKey:@"distance"];
	self.promoted = [decoder decodeObjectForKey:@"promoted"];
	self.promotionText = [decoder decodeObjectForKey:@"promotionText"];
	self.promotionImage = [decoder decodeObjectForKey:@"promotionImage"];
	self.promotionCode = [decoder decodeObjectForKey:@"promotionCode"];
	self.promotionTextExtra = [decoder decodeObjectForKey:@"promotionTextExtra"];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
	
	[encoder encodeObject:self.id forKey:@"id"];
	[encoder encodeObject:self.name forKey:@"name"];
	[encoder encodeObject:self.gasolinePrice forKey:@"gasolinePrice"];
	[encoder encodeObject:self.latitude forKey:@"latitude"];
	[encoder encodeObject:self.longitude forKey:@"longitude"];
	[encoder encodeObject:self.distance forKey:@"distance"];
	[encoder encodeObject:self.promoted forKey:@"promoted"];
	[encoder encodeObject:self.promotionText forKey:@"promotionText"];
	[encoder encodeObject:self.promotionImage forKey:@"promotionImage"];
	[encoder encodeObject:self.promotionCode forKey:@"promotionCode"];
	[encoder encodeObject:self.promotionTextExtra forKey:@"promotionTextExtra"];
}

@end
 