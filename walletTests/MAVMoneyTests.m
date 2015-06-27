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

-(void) testCurrency {
    
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

@end
