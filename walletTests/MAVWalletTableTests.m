//
//  MAVWalletTableTests.m
//  wallet
//
//  Created by Miguel Angel Vélez Serrano on 28/6/15.
//  Copyright (c) 2015 Miguel Ángel Vélez Serrano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "MAVBroker.h"
#import "MAVWallet.h"
#import "MAVWalletTableViewController.h"

@interface MAVWalletTableTests : XCTestCase

@property (strong, nonatomic) MAVWalletTableViewController *walletVC;
@property (strong, nonatomic) MAVBroker *broker;
@property (strong, nonatomic) MAVWallet *wallet;
@property (strong, nonatomic) MAVMoney *dollar1;
@property (strong, nonatomic) MAVMoney *dollar2;
@property (strong, nonatomic) MAVMoney *euro1;
@property (strong, nonatomic) MAVMoney *euro2;

@end

@implementation MAVWalletTableTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
//    self.wallet = [[MAVWallet alloc] initWithAmount:1 currency:@"USD"];
//    [self.wallet addMoney:[MAVMoney euroWithAmount:1]];
    
    // Creamos los moneys
    self.dollar1 = [MAVMoney dollarWithAmount:1];
    self.dollar2 = [MAVMoney dollarWithAmount:10];
    self.euro1 = [MAVMoney euroWithAmount:1];
    self.euro2 = [MAVMoney euroWithAmount:10];
    
    // Añadimos los moneys a wallet
    self.wallet = [[MAVWallet alloc] initWithAmount:1 currency:@"USD"];
    [self.wallet addMoney:self.dollar2];
    [self.wallet addMoney:self.euro1];
    [self.wallet addMoney:self.euro2];
    
    self.broker = [MAVBroker new];
    [self.broker addRate: 2 fromCurrency: @"USD" toCurrency: @"EUR"];
    
    self.walletVC = [[MAVWalletTableViewController alloc] initWithModel:self.wallet broker:self.broker];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    self.dollar1 = nil;
    self.dollar2 = nil;
    self.euro1 = nil;
    self.euro2 = nil;
    self.wallet = nil;
    self.walletVC = nil;
}

- (void) testThatTablehasNumberOfCurrenciesPlusOne {
    
    NSInteger sections = [self.walletVC numberOfSectionsInTableView:nil];
    XCTAssertEqual(sections, self.walletVC.model.currencies.count + 1, @"Number of sections is the number of currencies plus 1");
}

- (void) testThatNumberOfCellsInSectionIsNumberOfMoneysPlusOne {
    
    NSInteger numberOfSections = [self.walletVC numberOfSectionsInTableView:nil];
    
    // Iteramos por todas las secciones de la tabla.
    for (int i=0; i<numberOfSections; i++) {
        // Obtenemos el número de celdas para cada currency, que será el número de
        NSInteger rowsForCurrencySection = [self.walletVC.model numberOfMoneysForCurrencyInSection:i]+1;
        // Comprobamos si estamos en la section TOTAL, ya que en esa sección solo habrá una celda.
        if (i<self.wallet.currencies.count) {
            // En caso de estar en una section perteneciente a una currency
            XCTAssertEqual(rowsForCurrencySection, [self.walletVC tableView:nil
                                                      numberOfRowsInSection:i], @"Number of cells is the number of money plus 1 (the total)");
        } else {
            // Estamos en la section TOTAL
            XCTAssertEqual(rowsForCurrencySection, 1, @"Number of cells is 1 (the total)");
        }
    }
}

- (void) testMoneyForCellAtIndexPath {
    
    NSIndexPath *ipDollar1 = [NSIndexPath indexPathForRow:0
                                                inSection:[self.wallet.currencies indexOfObject:self.dollar1.currency]];
    NSIndexPath *ipDollar2 = [NSIndexPath indexPathForRow:1
                                                inSection:[self.wallet.currencies indexOfObject:self.dollar2.currency]];
    NSIndexPath *ipEuro1 = [NSIndexPath indexPathForRow:0
                                                inSection:[self.wallet.currencies indexOfObject:self.euro1.currency]];
    NSIndexPath *ipEuro2 = [NSIndexPath indexPathForRow:1
                                              inSection:[self.wallet.currencies indexOfObject:self.euro1.currency]];
    
    MAVMoney *dollar1FromIndexPath = [self.wallet moneyForIndexPath: ipDollar1 broker:self.broker];
    MAVMoney *dollar2FromIndexPath = [self.wallet moneyForIndexPath: ipDollar2 broker:self.broker];
    MAVMoney *euro1FromIndexPath = [self.wallet moneyForIndexPath: ipEuro1 broker:self.broker];
    MAVMoney *euro2FromIndexPath = [self.wallet moneyForIndexPath: ipEuro2 broker:self.broker];
    
    XCTAssertEqualObjects(self.dollar1, dollar1FromIndexPath);
    XCTAssertEqualObjects(self.dollar2, dollar2FromIndexPath);
    XCTAssertEqualObjects(self.euro1, euro1FromIndexPath);
    XCTAssertEqualObjects(self.euro2, euro2FromIndexPath);
    
}

-(void) testSubtotal {
    
    XCTAssertEqualObjects([self.dollar1 addMoney:self.dollar2], [self.wallet getSubtotalForCurrency:@"USD"]);
    XCTAssertEqualObjects([self.euro1 addMoney:self.euro2], [self.wallet getSubtotalForCurrency:@"EUR"]);
}

-(void) testGetSubtotalCell {
    
    MAVMoney *testSubtotalMoney = [MAVMoney dollarWithAmount:11];
    
    NSIndexPath *ipSubtotalDollars = [NSIndexPath indexPathForRow:2
                                                        inSection:0];
    MAVMoney *subtotalMoney = [self.wallet moneyForIndexPath:ipSubtotalDollars broker:self.broker];
    
    XCTAssertEqualObjects(testSubtotalMoney, subtotalMoney);
}

-(void) testTotalInEuros {
    
    MAVMoney *totalFromMultipleCurrencies = [self.wallet reduceToCurrency:@"EUR"
                                                               withBroker:self.broker];
    
    MAVMoney *dollar1ToEuros = [self.dollar1 reduceToCurrency:@"EUR"
                                              withBroker:self.broker];
    MAVMoney *dollar2ToEuros = [self.dollar2 reduceToCurrency:@"EUR"
                                              withBroker:self.broker];
    
    MAVWallet *eurosWallet = [[MAVWallet alloc] initWithAmount:1 currency:@"EUR"];
    [eurosWallet addMoney:self.euro2];
    [eurosWallet addMoney:dollar1ToEuros];
    [eurosWallet addMoney:dollar2ToEuros];
    
    MAVMoney *totalFromUniqueCurrency = [self.wallet reduceToCurrency:@"EUR"
                                                           withBroker:self.broker];
    
    XCTAssertEqualObjects(totalFromMultipleCurrencies, totalFromUniqueCurrency);
}

-(void) testGetTotalCell {
    
    MAVMoney *testTotalMoney = [MAVMoney euroWithAmount:33];
    
    NSIndexPath *ipTotalCurrencies = [NSIndexPath indexPathForRow:0
                                                        inSection:2];
    MAVMoney *totalMoney = [self.wallet moneyForIndexPath:ipTotalCurrencies broker:self.broker];
    
    XCTAssertEqualObjects(testTotalMoney, totalMoney);
}
















@end
