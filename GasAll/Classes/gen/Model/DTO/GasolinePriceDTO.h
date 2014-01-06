//
//  GasolinePriceDTO.h
//  GasAll
//  Version: 3.0
//
//  Created by Mobivery
//  Copyright (c) 2012 Mobivery. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GasolinePriceDTO : NSObject <NSCopying, NSMutableCopying, NSCoding>


@property (nonatomic, strong) NSString *gasID;	///<  - Field name on service:gasID.
@property (nonatomic, strong) NSNumber *price;	///<  - Field name on service:price.


@end