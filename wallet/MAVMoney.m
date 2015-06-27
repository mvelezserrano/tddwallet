//
//  MAVMoney.m
//  wallet
//
//  Created by Miguel Angel Vélez Serrano on 1/6/15.
//  Copyright (c) 2015 Miguel Ángel Vélez Serrano. All rights reserved.
//

#import "MAVMoney.h"

@interface MAVMoney ()

@property (nonatomic) NSUInteger amount;

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
        _amount = amount;
        _currency = currency;
    }
    
    return self;
}

-(MAVMoney *) times:(NSUInteger)multiplier {
    return  [[MAVMoney alloc] initWithAmount:_amount * multiplier
                                    currency:self.currency];
}

#pragma mark - Equality

-(BOOL) isEqual:(id)object {
    
    return [self amount] == [object amount];
}

@end
