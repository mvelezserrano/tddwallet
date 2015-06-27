//
//  MAVMoney.h
//  wallet
//
//  Created by Miguel Angel Vélez Serrano on 1/6/15.
//  Copyright (c) 2015 Miguel Ángel Vélez Serrano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MAVMoney : NSObject

@property (copy, readonly) NSString *currency;

+(instancetype) dollarWithAmount: (NSUInteger) amount;
+(instancetype) euroWithAmount: (NSUInteger) amount;

-(id) initWithAmount: (NSUInteger) amount currency: (NSString *) currency;

-(MAVMoney *) times: (NSUInteger) multiplier;


@end
