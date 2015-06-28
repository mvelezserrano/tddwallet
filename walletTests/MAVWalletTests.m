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

@property (strong, nonatomic) MAVBroker *emptyBroker;

@end

@implementation MAVWalletTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.emptyBroker = [MAVBroker new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    self.emptyBroker = nil;
}

// €40 + $20 = $100 2:1
- (void) testAdditionWithReduction {
    
    [self.emptyBroker addRate:2
       fromCurrency:@"EUR"
         toCurrency:@"USD"];
    
    MAVWallet *wallet = [[MAVWallet alloc] initWithAmount: 40 currency: @"EUR"];
    [wallet addMoney: [MAVMoney dollarWithAmount: 20]];
    
    MAVMoney *reduced = [self.emptyBroker reduce:wallet
                            toCurrency:@"USD"];
    
    XCTAssertEqualObjects(reduced, [MAVMoney dollarWithAmount:100], @"€40 + $20 = $100 2:1");
}

- (void) testSimpleSubstraction {
    
    MAVWallet *wallet = [[MAVWallet alloc] initWithAmount: 40 currency: @"EUR"];
    [wallet addMoney:[MAVMoney euroWithAmount:20]];
    MAVMoney *substracted = [[wallet takeMoney: [MAVMoney euroWithAmount:20]] reduceToCurrency:@"EUR"
                                                                                    withBroker:self.emptyBroker];
    
    XCTAssertEqualObjects(substracted, [MAVMoney euroWithAmount:40], @"€60 - €20 = €40");
}

- (void) testThatRaisesExceptionWhenMoneyDoesNotExistsInWalletWhenSubstractingIt {
    
    MAVWallet *wallet = [[MAVWallet alloc] initWithAmount: 40 currency: @"EUR"];
    [wallet addMoney:[MAVMoney euroWithAmount:20]];
    
    XCTAssertThrows([wallet takeMoney: [MAVMoney euroWithAmount:10]], @"Substracting a non existing money should raise an exception");
}






















@end
