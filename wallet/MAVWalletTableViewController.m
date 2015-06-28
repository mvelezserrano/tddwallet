//
//  MAVWalletTableViewController.m
//  wallet
//
//  Created by Miguel Angel Vélez Serrano on 28/6/15.
//  Copyright (c) 2015 Miguel Ángel Vélez Serrano. All rights reserved.
//

#import "MAVWalletTableViewController.h"
#import "MAVWallet.h"
#import "MAVBroker.h"

@interface MAVWalletTableViewController ()

@property (strong, nonatomic) MAVWallet *model;
@property (nonatomic, strong) MAVBroker *broker;

@end

@implementation MAVWalletTableViewController

-(id) initWithModel:(MAVWallet *) model broker: (MAVBroker *) broker {
    
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        _model = model;
        _broker = broker;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return self.model.currencies.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
//    return self.model.count + 1;
    return [self.model numberOfMoneysForCurrencyInSection:section]+1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section < self.model.currencies.count) {
        NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:section];
        MAVMoney *money = [self.model moneyForIndexPath:ip broker:self.broker];
        return money.currency;
    }else{
        return @"TOTAL";
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:cellId];
    }
    
    MAVMoney *money = [self.model moneyForIndexPath:indexPath broker:self.broker];
    
    if (indexPath.row<[self.model numberOfMoneysForCurrencyInSection:indexPath.section]) {
        // Si estamos en una fila de Money...
        cell.textLabel.text = @"Amount";
    } else {
        // ... si no, comprobamos si estamos en una sección de Currency o en el total
        if (indexPath.section < self.model.currencies.count) {
            cell.textLabel.text = [NSString stringWithFormat:@"Subtotal %@", money.currency];
        } else {
            cell.textLabel.text = @"Total";
        }
    }
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", money.amount];
    
    
    
    
    
    
    
    // Configure the cell...
    
    return cell;
}

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
