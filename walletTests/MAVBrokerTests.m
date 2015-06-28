//
//  MAVBrokerTests.m
//  wallet
//
//  Created by Miguel Angel Vélez Serrano on 27/6/15.
//  Copyright (c) 2015 Miguel Ángel Vélez Serrano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "MAVMoney.h"
#import "MAVBroker.h"

@interface MAVBrokerTests : XCTestCase

@property (strong, nonatomic) MAVBroker *emptyBroker;
@property (strong, nonatomic) MAVMoney *oneDollar;

@end

@implementation MAVBrokerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.emptyBroker = [MAVBroker new];
    self.oneDollar = [MAVMoney dollarWithAmount:1];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    self.emptyBroker = nil;
    self.oneDollar = nil;
}

- (void) testSimpleReduction {
    
    MAVMoney *sum = [[MAVMoney dollarWithAmount:5] addMoney:[MAVMoney dollarWithAmount:5]];
    
    MAVMoney *reduced = [self.emptyBroker reduce: sum toCurrency: @"USD"];
    
    // Compruebo que cojo dólares y los convierto a dólares.
    XCTAssertEqualObjects(sum, reduced, @"Conversion to same currency shold be a NOP");
}

// $10 == $5 2:1
- (void) testReduction {
    
    [self.emptyBroker addRate: 2 fromCurrency:@"EUR" toCurrency:@"USD"];
    
    MAVMoney *dollars = [MAVMoney dollarWithAmount:10];
    MAVMoney *euros = [MAVMoney euroWithAmount:5];
    
    MAVMoney *converted = [self.emptyBroker reduce:dollars
                                        toCurrency:@"EUR"];
    XCTAssertEqualObjects(converted, euros, @"$10 == $5 2:1");
}

-(void) testThatNoRateRaisesException {
    
    XCTAssertThrows([self.emptyBroker reduce:self.oneDollar toCurrency:@"EUR"], @"No rates should cause exception");
}

-(void) testThatNilConversionDoesNotChangeMoney {
    
    XCTAssertEqualObjects(self.oneDollar, [self.emptyBroker reduce:self.oneDollar toCurrency:@"USD"], @"A nil conversion should have no effect");
}

@end
