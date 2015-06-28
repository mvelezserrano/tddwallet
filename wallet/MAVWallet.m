//
//  MAVWallet.m
//  wallet
//
//  Created by Miguel Angel Vélez Serrano on 27/6/15.
//  Copyright (c) 2015 Miguel Ángel Vélez Serrano. All rights reserved.
//

#import "MAVWallet.h"

@interface MAVWallet ()

@property (strong, nonatomic) NSMutableArray *moneys;

@end

@implementation MAVWallet

-(id) initWithAmount: (NSInteger) amount
            currency: (NSString *) currency {
    
    if (self=[super init]) {
        
        MAVMoney *money = [[MAVMoney alloc] initWithAmount:amount
                                                  currency:currency];
        _moneys = [NSMutableArray array];
        [_moneys addObject:money];
    }
    
    return self;
}


-(id<MAVMoney>) times: (NSInteger) multiplier {
    
    NSMutableArray *newMoneys = [NSMutableArray arrayWithCapacity:self.moneys.count];
    for (MAVMoney *each in self.moneys) {
        
        MAVMoney *newMoney = [each times:multiplier];
        [newMoneys addObject:newMoney];
    }
    
    self.moneys = newMoneys;
    
    return self;
}


-(id<MAVMoney>) plus: (MAVMoney *) money {
    
    [self.moneys addObject:money];
    return self;
}

-(id<MAVMoney>) reduceToCurrency:(NSString *) currency withBroker:(MAVBroker *) broker {
    
    MAVMoney *result = [[MAVMoney alloc] initWithAmount:0 currency:currency];
    for (MAVMoney *each in self.moneys) {
        result = [result plus: [each reduceToCurrency:currency
                                           withBroker:broker]];
    }
    
    return result;
}






















@end
