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

@end

@implementation MAVBrokerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testSimpleReduction {
    
    MAVBroker *broker = [[MAVBroker alloc] init];
    MAVMoney *sum = [[MAVMoney dollarWithAmount:5] plus:[MAVMoney dollarWithAmount:5]];
    
    MAVMoney *reduced = [broker reduce: sum toCurrency: @"USD"];
    
    // Compruebo que cojo dólares y los convierto a dólares.
    XCTAssertEqualObjects(sum, reduced, @"Conversion to same currency shold be a NOP");
}

// $10 == $5 2:1
- (void) testReduction {
    
    MAVBroker *broker = [MAVBroker new];
    [broker addRate: 2 fromCurrency:@"USD" toCurrency:@"EUR"];
    
    MAVMoney *dollars = [MAVMoney dollarWithAmount:10];
    MAVMoney *euros = [MAVMoney euroWithAmount:5];
    
    MAVMoney *converted = [broker reduce:dollars
                              toCurrency:@"EUR"];
    XCTAssertEqualObjects(converted, euros, @"$10 == $5 2:1");
}



























@end
