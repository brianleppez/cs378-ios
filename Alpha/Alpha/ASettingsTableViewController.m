//
//  ASettingsTableViewController.m
//  Alpha
//
//  Created by Kevin Lin on 10/14/14.
//  Copyright (c) 2014 cs378. All rights reserved.
//

#import "ASettingsTableViewController.h"

@interface ASettingsTableViewController () <UIAlertViewDelegate>

@end

@implementation ASettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 7;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //Enter groupname
    if (indexPath.row == 1)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Group Name" message:@"Enter your group name." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Submit", nil];
        [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
        [alert setTag:1];
        [alert show];
    }
    //Enter username
    if (indexPath.row == 5)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Username" message:@"Enter your username." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Submit", nil];
        [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
        [alert setTag:5];
        [alert show];
    }
    //Enter phone number
    if (indexPath.row == 6)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Phone Number" message:@"Enter your phone number." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Submit", nil];
        [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
        [alert setTag:6];
        [alert show];
    }
    
}


-(NSNumber*)parseOut:(NSString *)phoneNumber
{
    NSString *output = @"";
    for (int i = 0; i < phoneNumber.length; i++)
    {
        NSString *s = [phoneNumber substringWithRange:(NSMakeRange(i, 1))];
        NSInteger j = [s intValue];
        if (j >= 0 && j <= 9)
        {
            if (j ==0)
            {
                if (![s isEqualToString:@"0"])
                {
                    continue;
                }
            }
            output = [output stringByAppendingString:s];
        }
    }
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterBehaviorDefault];
    NSNumber *myNumber = [f numberFromString:output];
    return myNumber;
}

//handle username entered in alert
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    //grab group name
    if ([alertView tag] == 1)
    {
        if (buttonIndex ==1)
        {
            UITextField *textfield = [alertView textFieldAtIndex:0];
            _groupName = textfield.text;
        }
    }
    //grab username
    else if ([alertView tag] == 5)
    {
        if (buttonIndex == 1)
        {
            UITextField *textfield = [alertView textFieldAtIndex:0];
            _name = textfield.text;
        }
    }
    //grab phone number
    else if ([alertView tag] == 6)
    {
        if (buttonIndex == 1)
        {
            UITextField *textfield = [alertView textFieldAtIndex:0];
            _phoneNumber = [self parseOut:(textfield.text)];
        }
    }
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
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
