//
//  MAVMoneyTests.m
//  wallet
//
//  Created by Miguel Angel Vélez Serrano on 1/6/15.
//  Copyright (c) 2015 Miguel Ángel Vélez Serrano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "MAVMoney.h"


@interface MAVMoneyTests : XCTestCase

@end

@implementation MAVMoneyTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void) testCurrencies {
    
    MAVMoney *dollars = [MAVMoney dollarWithAmount:1];
    XCTAssertEqualObjects(@"USD", [dollars currency]);
    
    MAVMoney *euros = [MAVMoney euroWithAmount:1];
    XCTAssertEqualObjects(@"EUR", [euros currency]);
}

- (void)testMultiplication {
    
    MAVMoney *five = [MAVMoney euroWithAmount:5];
    MAVMoney *product = [five times:2];
    XCTAssertEqualObjects(product, [MAVMoney euroWithAmount:10]);
    
    MAVMoney *fiveUSD = [MAVMoney dollarWithAmount:5];
    MAVMoney *productUSD = [fiveUSD times:2];
    XCTAssertEqualObjects(productUSD, [MAVMoney dollarWithAmount:10]);
}

-(void) testEquality {
    
    MAVMoney *five = [MAVMoney euroWithAmount:5];
    MAVMoney *otherFive = [MAVMoney euroWithAmount:5];
    
    XCTAssertEqualObjects(five, otherFive);
    
    MAVMoney *seven = [MAVMoney euroWithAmount:7];
    
    XCTAssertNotEqualObjects(seven, five);
}

- (void) testDifferentCurrencies {
    MAVMoney *euro = [MAVMoney euroWithAmount:1];
    MAVMoney *dollar = [MAVMoney dollarWithAmount:1];
    
    XCTAssertNotEqualObjects(euro, dollar, @"Different currencies should not be equal");
}

- (void) testAmountStorage{
    int amount = 5;
    MAVMoney *euro = [MAVMoney euroWithAmount:amount];
    MAVMoney *dollar = [MAVMoney dollarWithAmount:amount];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    XCTAssertEqual(amount, [[euro performSelector:@selector(amount)] integerValue], @"The value retrieved should be the same as the stored");
    XCTAssertEqual(amount, [[dollar performSelector:@selector(amount)] integerValue], @"The value retrieved should be the same as the stored");
#pragma clang diagnostic pop
    
}

- (void) testSimpleAddition {
    
    MAVMoney *sum = [[MAVMoney dollarWithAmount:5] addMoney: [MAVMoney dollarWithAmount:5]];
    XCTAssertEqualObjects(sum, [MAVMoney dollarWithAmount:10], @"$5 + $5 = $10");
}

- (void) testSimpleSubstraction {
    
    MAVMoney *sub = [[MAVMoney dollarWithAmount:10] takeMoney: [MAVMoney dollarWithAmount:5]];
    XCTAssertEqualObjects(sub, [MAVMoney dollarWithAmount:5], @"$10 - $5 = $5");
}

- (void) testThatRaisesExceptionWhenAmountToSubstractIsBiggerThanExistingAmount {
    
    XCTAssertThrows([[MAVMoney dollarWithAmount:5] takeMoney:[MAVMoney dollarWithAmount:10]], @"Substract an amount bigger than the existing should raise an exception!");
}

- (void) testHash {
    
    MAVMoney *a = [MAVMoney euroWithAmount:2];
    MAVMoney *b = [MAVMoney euroWithAmount:2];
    XCTAssertEqual([a hash], [b hash], @"Equal objects mus have same hash");
    
    MAVMoney *c = [MAVMoney dollarWithAmount:2];
    MAVMoney *d = [MAVMoney dollarWithAmount:2];
    XCTAssertEqual([c hash], [d hash], @"Equal objects mus have same hash");
}

- (void) testThatHashIsAmount {
    
    MAVMoney *one = [MAVMoney dollarWithAmount:1];
    XCTAssertEqual([one hash], 1, @"The hash must be the same as the amount");
}

- (void) testDescription {
    
    MAVMoney *one = [MAVMoney dollarWithAmount:1];
    NSString *desc = @"<MAVMoney: USD 1>";
    XCTAssertEqualObjects(desc, [one description], @"Desctription must match the template");
}

@end
