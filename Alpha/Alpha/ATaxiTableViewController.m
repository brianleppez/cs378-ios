//
//  ATaxiTableViewController.m
//  Alpha
//
//  Created by Brian Leppez on 10/16/14.
//  Copyright (c) 2014 cs378. All rights reserved.
//

#import "ATaxiTableViewController.h"

@interface ATaxiTableViewController ()

@end

@implementation ATaxiTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //Yellow Cab
    if (indexPath.row == 0) {
        NSString *phoneNumber = @"5124529999";
        NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@", phoneNumber]];
        if ([[UIApplication sharedApplication] canOpenURL:phoneURL]) {
            [[UIApplication sharedApplication] openURL:phoneURL];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Not Available" message:@"Call facilities not available." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
    //Austin Cab
    if (indexPath.row == 1) {
        NSString *phoneNumber = @"5124782222";
        NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@", phoneNumber]];
        if ([[UIApplication sharedApplication] canOpenURL:phoneURL]) {
            [[UIApplication sharedApplication] openURL:phoneURL];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Not Available" message:@"Call facilities not available." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
    //Lone Star Cab
    if (indexPath.row == 2) {
        NSString *phoneNumber = @"5128364900";
        NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@", phoneNumber]];
        if ([[UIApplication sharedApplication] canOpenURL:phoneURL]) {
            [[UIApplication sharedApplication] openURL:phoneURL];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Not Available" message:@"Call facilities not available." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
    //Austin Express
    if (indexPath.row == 3) {
        NSString *phoneNumber = @"5126664141";
        NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@", phoneNumber]];
        if ([[UIApplication sharedApplication] canOpenURL:phoneURL]) {
            [[UIApplication sharedApplication] openURL:phoneURL];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Not Available" message:@"Call facilities not available." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
    //Uber
    if (indexPath.row == 4) {
        NSString *url = @"uber://";
        NSURL *phoneURL = [NSURL URLWithString:url];
        if ([[UIApplication sharedApplication] canOpenURL:phoneURL]) {
            [[UIApplication sharedApplication] openURL:phoneURL];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Not Available" message:@"Cannot open Uber." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 5;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
