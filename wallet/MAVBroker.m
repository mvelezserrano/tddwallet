//
//  MAVBroker.m
//  wallet
//
//  Created by Miguel Angel Vélez Serrano on 27/6/15.
//  Copyright (c) 2015 Miguel Ángel Vélez Serrano. All rights reserved.
//

#import "MAVBroker.h"
#import "MAVMoney.h"

@interface MAVBroker ()

@end

@implementation MAVBroker

-(id)init {
    if (self = [super init]) {
        _rates = [@{}mutableCopy];
    }
    return self;
}

-(MAVMoney *) reduce: (id<MAVMoney>) money
          toCurrency: (NSString *) currency {
    
    // Double dispatch
    return [money reduceToCurrency:currency
                        withBroker:self];
}

-(void) addRate:(NSInteger) rate
   fromCurrency:(NSString *) fromCurrency
     toCurrency:(NSString *) toCurrency {
    
    [self.rates setObject:@(rate) forKey:[self keyFromCurrency:fromCurrency toCurrency:toCurrency]];
    [self.rates setObject:@(1.0/rate) forKey:[self keyFromCurrency:toCurrency toCurrency:fromCurrency]];
}




#pragma mark - utils

-(NSString *) keyFromCurrency:(NSString *) fromCurrency toCurrency:(NSString *) toCurrency {
    
    return [NSString stringWithFormat:@"%@-%@", fromCurrency, toCurrency];
}
























@end
