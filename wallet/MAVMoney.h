//
//  MAVMoney.h
//  wallet
//
//  Created by Miguel Angel Vélez Serrano on 1/6/15.
//  Copyright (c) 2015 Miguel Ángel Vélez Serrano. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MAVMoney;
@class MAVBroker;

@protocol MAVMoney <NSObject>

-(id) initWithAmount: (NSInteger) amount
            currency: (NSString *) currency;

-(id<MAVMoney>) times: (NSInteger) multiplier;

-(id<MAVMoney>) plus: (MAVMoney *) money;

-(id<MAVMoney>) reduceToCurrency:(NSString *) currency withBroker:(MAVBroker *) broker;

@end

@interface MAVMoney : NSObject <MAVMoney>

@property (nonatomic, readonly) NSString *currency;
@property (nonatomic, strong, readonly) NSNumber *amount;

+(instancetype) dollarWithAmount: (NSInteger) amount;
+(instancetype) euroWithAmount: (NSInteger) amount;

@end
