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

@property (strong, nonatomic) NSMutableDictionary *rates;

@end

@implementation MAVBroker

-(id)init {
    if (self = [super init]) {
        _rates = [@{}mutableCopy];
    }
    return self;
}

-(MAVMoney *) reduce: (MAVMoney *) money toCurrency: (NSString *) currency {
    
    return money;
}

-(void) addRate:(NSInteger) rate
   fromCurrency:(NSString *) fromCurrency
     toCurrency:(NSString *) toCurrency {
    
    [self.rates setObject:@(rate) forKey:[self keyFromCurrency:fromCurrency toCurrency:toCurrency]];
}




#pragma mark - utils

-(NSString *) keyFromCurrency:(NSString *) fromCurrency toCurrency:(NSString *) toCurrency {
    
    return [NSString stringWithFormat:@"%@-%@", fromCurrency, toCurrency];
}
























@end
