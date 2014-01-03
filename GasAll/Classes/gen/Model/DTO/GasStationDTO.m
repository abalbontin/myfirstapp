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
		copy.price95=[self.price95 copyWithZone:zone];
		copy.price98=[self.price98 copyWithZone:zone];
		copy.priceGOA=[self.priceGOA copyWithZone:zone];
		copy.priceNGO=[self.priceNGO copyWithZone:zone];
		copy.priceGPR=[self.priceGPR copyWithZone:zone];
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
		copy.price95=self.price95;
		copy.price98=self.price98;
		copy.priceGOA=self.priceGOA;
		copy.priceNGO=self.priceNGO;
		copy.priceGPR=self.priceGPR;
		copy.latitude=self.latitude;
		copy.longitude=self.longitude;
		copy.distance=self.distance;
		copy.promoted=self.promoted;
		copy.promotionText=self.promotionText;
		copy.promotionImage=self.promotionImage;
		copy.promotionCode=self.promotionCode;
		copy.promotionTextExtra=self.promotionTextExtra;
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
	self.price95 = [decoder decodeObjectForKey:@"price95"];
	self.price98 = [decoder decodeObjectForKey:@"price98"];
	self.priceGOA = [decoder decodeObjectForKey:@"priceGOA"];
	self.priceNGO = [decoder decodeObjectForKey:@"priceNGO"];
	self.priceGPR = [decoder decodeObjectForKey:@"priceGPR"];
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
	[encoder encodeObject:self.price95 forKey:@"price95"];
	[encoder encodeObject:self.price98 forKey:@"price98"];
	[encoder encodeObject:self.priceGOA forKey:@"priceGOA"];
	[encoder encodeObject:self.priceNGO forKey:@"priceNGO"];
	[encoder encodeObject:self.priceGPR forKey:@"priceGPR"];
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
 