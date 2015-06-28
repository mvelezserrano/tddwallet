//
//  MAVWallet.m
//  wallet
//
//  Created by Miguel Angel Vélez Serrano on 27/6/15.
//  Copyright (c) 2015 Miguel Ángel Vélez Serrano. All rights reserved.
//

#import "MAVWallet.h"
#import "MAVBroker.h"

@interface MAVWallet ()

@property (strong, nonatomic) NSMutableArray *moneys;

@end

@implementation MAVWallet

-(NSUInteger) count {
    
    return self.moneys.count;
}

-(id) initWithAmount: (NSInteger) amount
            currency: (NSString *) currency {
    
    if (self=[super init]) {
        
        MAVMoney *money = [[MAVMoney alloc] initWithAmount:amount
                                                  currency:currency];
        _moneys = [NSMutableArray array];
        [_moneys addObject:money];
        
        _currencies = [NSMutableArray array];
        [_currencies addObject:currency];
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


-(id<MAVMoney>) addMoney: (MAVMoney *) money {
    
    [self.moneys addObject:money];
    if (![self.currencies containsObject:money.currency]) {
        [self.currencies addObject:money.currency];
    }
    
    return self;
}

-(id<MAVMoney>) takeMoney: (MAVMoney *) money {
    
    if ([self.moneys containsObject:money]) {
        [self.moneys removeObject:money];
    } else {
        [NSException raise:@"MoneyToSubstractNonExistingInWallet"
                    format:@"Imposible to substract %@ %@. It does not exists in wallet", money.amount, money.currency];
    }
    
    
    return self;
}

-(id<MAVMoney>) reduceToCurrency:(NSString *) currency withBroker:(MAVBroker *) broker {
    
    MAVMoney *result = [[MAVMoney alloc] initWithAmount:0 currency:currency];
    for (MAVMoney *each in self.moneys) {
        result = [result addMoney: [each reduceToCurrency:currency
                                           withBroker:broker]];
    }
    
    return result;
}

- (NSInteger) numberOfMoneysForCurrencyInSection: (NSInteger) section {
    
    NSInteger numberOfMoneys=0;
    if (section < self.currencies.count) {
        NSString *currency = [self.currencies objectAtIndex:section];
        
        for (MAVMoney *each in self.moneys) {
            if ([each.currency isEqualToString:currency]) {
                numberOfMoneys++;
            }
        }
    }
    
    return numberOfMoneys;
}

- (MAVMoney *) moneyForIndexPath:(NSIndexPath *) indexPath {
    
    if (indexPath.section < self.currencies.count) {
        NSString *currency = [self.currencies objectAtIndex: indexPath.section];
        NSMutableArray *currencyMoneys = [NSMutableArray array];
        
        for (MAVMoney *each in self.moneys) {
            if ([each.currency isEqualToString:currency]) {
                [currencyMoneys addObject:each];
            }
        }
        
        if (indexPath.row < currencyMoneys.count) {
            return [currencyMoneys objectAtIndex:indexPath.row];
        } else {
            return [self getSubtotalForCurrency:currency];
        }
    } else {
        MAVBroker *broker = [MAVBroker new];
        [broker addRate: 2 fromCurrency: @"USD" toCurrency: @"EUR"];
        return [self reduceToCurrency:@"EUR" withBroker:broker];
    }
}

- (MAVMoney *) getSubtotalForCurrency:(NSString *) currency {
    
    NSInteger subtotal=0;
    
    for (MAVMoney *each in self.moneys) {
        if ([each.currency isEqualToString:currency]) {
            subtotal+=[each.amount integerValue];
        }
    }
    
    return [self getMoneyForAmount:subtotal currency:currency];
}

- (MAVMoney *) getMoneyForAmount:(NSInteger) amount currency:(NSString *) currency {
    
    if ([currency isEqualToString:@"USD"]) {
        return [MAVMoney dollarWithAmount:amount];
    } else {
        return [MAVMoney euroWithAmount:amount];
    }
}




























@end
