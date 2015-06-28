//
//  MAVWalletTests.m
//  wallet
//
//  Created by Miguel Angel Vélez Serrano on 27/6/15.
//  Copyright (c) 2015 Miguel Ángel Vélez Serrano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "MAVMoney.h"
#import "MAVBroker.h"
#import "MAVWallet.h"

@interface MAVWalletTests : XCTestCase

@end

@implementation MAVWalletTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

// €40 + $20 = $100 2:1
- (void) testAdditionWithReduction {
    
    MAVBroker *broker = [MAVBroker new];
    [broker addRate:2
       fromCurrency:@"EUR"
         toCurrency:@"USD"];
    
    MAVWallet *wallet = [[MAVWallet alloc] initWithAmount: 40 currency: @"EUR"];
    [wallet plus: [MAVMoney dollarWithAmount: 20]];
    
    MAVMoney *reduced = [broker reduce:wallet
                            toCurrency:@"USD"];
    
    XCTAssertEqualObjects(reduced, [MAVMoney dollarWithAmount:100], @"€40 + $20 = $100 2:1");
}






















@end
