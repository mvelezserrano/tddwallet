//
//  MAVWallet.h
//  wallet
//
//  Created by Miguel Angel Vélez Serrano on 27/6/15.
//  Copyright (c) 2015 Miguel Ángel Vélez Serrano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MAVMoney.h"

@interface MAVWallet : NSObject <MAVMoney>

@property (readonly, nonatomic) NSUInteger count;
@property (readonly, nonatomic) NSMutableArray *currencies;

- (NSInteger) numberOfMoneysForCurrencyInSection: (NSInteger) section;
- (MAVMoney *) moneyForIndexPath:(NSIndexPath *) indexPath broker:(MAVBroker *) broker;
- (MAVMoney *) getSubtotalForCurrency:(NSString *) currency;

@end
