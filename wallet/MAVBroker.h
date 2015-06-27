//
//  MAVBroker.h
//  wallet
//
//  Created by Miguel Angel Vélez Serrano on 27/6/15.
//  Copyright (c) 2015 Miguel Ángel Vélez Serrano. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MAVMoney;

@interface MAVBroker : NSObject

-(MAVMoney *) reduce: (MAVMoney *) money toCurrency: (NSString *) currency;

-(void) addRate:(NSInteger) rate
   fromCurrency:(NSString *) fromCurrency
     toCurrency:(NSString *) toCurrency;

@end
