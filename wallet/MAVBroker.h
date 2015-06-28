//
//  MAVBroker.h
//  wallet
//
//  Created by Miguel Angel Vélez Serrano on 27/6/15.
//  Copyright (c) 2015 Miguel Ángel Vélez Serrano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MAVMoney.h"

@interface MAVBroker : NSObject

@property (strong, nonatomic) NSMutableDictionary *rates;

-(MAVMoney *) reduce: (id<MAVMoney>) money toCurrency: (NSString *) currency;

-(void) addRate:(NSInteger) rate
   fromCurrency:(NSString *) fromCurrency
     toCurrency:(NSString *) toCurrency;

-(NSString *) keyFromCurrency:(NSString *) fromCurrency
                   toCurrency:(NSString *) toCurrency;

@end
