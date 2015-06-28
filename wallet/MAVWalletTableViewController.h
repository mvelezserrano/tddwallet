//
//  MAVWalletTableViewController.h
//  wallet
//
//  Created by Miguel Angel Vélez Serrano on 28/6/15.
//  Copyright (c) 2015 Miguel Ángel Vélez Serrano. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MAVWallet;

@interface MAVWalletTableViewController : UITableViewController

@property (strong, nonatomic, readonly) MAVWallet *model;

-(id) initWithModel:(MAVWallet *) model;

@end
