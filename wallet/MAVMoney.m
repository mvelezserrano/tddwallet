//
//  MAVMoney.m
//  wallet
//
//  Created by Miguel Angel Vélez Serrano on 1/6/15.
//  Copyright (c) 2015 Miguel Ángel Vélez Serrano. All rights reserved.
//

#import "MAVMoney.h"
#import "MAVBroker.h"

@interface MAVMoney ()

@property (nonatomic, strong) NSNumber *amount;

@end

@implementation MAVMoney

+(instancetype) dollarWithAmount: (NSInteger) amount {
    
    MAVMoney *dollar = [[MAVMoney alloc] initWithAmount:amount
                                               currency:@"USD"];
    return dollar;
}


+(instancetype) euroWithAmount: (NSInteger) amount {
    
    MAVMoney *euro = [[MAVMoney alloc] initWithAmount:amount
                                               currency:@"EUR"];
    return euro;
}


-(id) initWithAmount: (NSInteger) amount currency:(NSString *)currency{
    
    if (self=[super init]) {
        _amount = @(amount);
        _currency = currency;
    }
    
    return self;
}

-(id<MAVMoney>) times:(NSInteger)multiplier {
    return  [[MAVMoney alloc] initWithAmount:[self.amount integerValue] * multiplier
                                    currency:self.currency];
}

-(id<MAVMoney>) addMoney: (MAVMoney *) money {
    
    NSInteger totalAmount = [self.amount integerValue] + [money.amount integerValue];
    MAVMoney *total = [[MAVMoney alloc] initWithAmount:totalAmount
                                              currency:self.currency];
    return total;
}

-(id<MAVMoney>) takeMoney: (MAVMoney *) money {
    
    if ([money.amount integerValue]>[self.amount integerValue]) {
        [NSException raise:@"AmountToSubstractBiggerThanExisting"
                    format:@"Can't substract. %@ %@ is bigger than %@ %@", money.currency, money.amount, self.currency, self.amount];
    }
    
    NSInteger totalAmount = [self.amount integerValue] - [money.amount integerValue];
    MAVMoney *total = [[MAVMoney alloc] initWithAmount:totalAmount
                                              currency:self.currency];
    return total;
}

-(id<MAVMoney>) reduceToCurrency:(NSString *) currency withBroker:(MAVBroker *) broker {
    
    
    
    MAVMoney *result;
    double rate = [[broker.rates objectForKey:[broker keyFromCurrency:self.currency
                                                       toCurrency:currency]] doubleValue];
    
    // Comprobamos que divisa de origen y destino son las mismas
    if ([self.currency isEqual:currency]) {
        return result=self;
    } else if (rate == 0) {
        // No hay tasa de conversión, excepción que te crió
        [NSException raise:@"NoConversionRateException"
                    format:@"Must have a conversion from %@ to %@", self.currency, currency];
    } else {
        // Tenemos conversión
        double rate = [[broker.rates objectForKey:[broker keyFromCurrency:self.currency
                                                           toCurrency:currency]] doubleValue];
        
        NSInteger newAmount = [self.amount integerValue] * rate;
        
        result = [[MAVMoney alloc] initWithAmount:newAmount
                                         currency:currency];
    }
    
    return result;
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
