//
//  MAVMoney.m
//  wallet
//
//  Created by Miguel Angel Vélez Serrano on 1/6/15.
//  Copyright (c) 2015 Miguel Ángel Vélez Serrano. All rights reserved.
//

#import "MAVMoney.h"

@interface MAVMoney ()

@property (nonatomic, strong) NSNumber *amount;

@end

@implementation MAVMoney

+(instancetype) dollarWithAmount: (NSUInteger) amount {
    
    MAVMoney *dollar = [[MAVMoney alloc] initWithAmount:amount
                                               currency:@"USD"];
    return dollar;
}


+(instancetype) euroWithAmount: (NSUInteger) amount {
    
    MAVMoney *euro = [[MAVMoney alloc] initWithAmount:amount
                                               currency:@"EUR"];
    return euro;
}


-(id) initWithAmount: (NSUInteger) amount currency:(NSString *)currency{
    
    if (self=[super init]) {
        _amount = @(amount);
        _currency = currency;
    }
    
    return self;
}

-(MAVMoney *) times:(NSUInteger)multiplier {
    return  [[MAVMoney alloc] initWithAmount:[self.amount integerValue] * multiplier
                                    currency:self.currency];
}

-(MAVMoney *) plus: (MAVMoney *) other {
    
    NSInteger totalAmount = [self.amount integerValue] + [other.amount integerValue];
    MAVMoney *total = [[MAVMoney alloc] initWithAmount:totalAmount
                                              currency:self.currency];
    return total;
}



#pragma mark - Overwritten

- (NSString *) description{
    return [NSString stringWithFormat:@"<%@: %@ %@>", [self class], [self currency], [self amount]];
}

#pragma mark - Equality

- (BOOL) isEqual:(id)object{
    if ([[self currency] isEqual:[object currency]]) {
        return [self amount] == [object amount];
    }else{
        return NO;
    }
}

- (NSUInteger) hash{
    return [self.amount integerValue];
}

@end
