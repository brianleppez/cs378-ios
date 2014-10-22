//
//  ATextComposerController.m
//  Alpha
//
//  Created by Samantha Allen on 10/21/14.
//  Copyright (c) 2014 cs378. All rights reserved.
//

#import "ATextComposerController.h"

@interface ATextComposerController () <ATextModelProtocol, UITextFieldDelegate, MFMessageComposeViewControllerDelegate>

@end

@implementation ATextComposerController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.sendButton addTarget:self action:@selector(btnSendClicked) forControlEvents:UIControlEventTouchUpInside];
    //[self.messageText setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)btnSendClicked
{
    NSString* messageText = self.messageText.text;
    if (messageText == nil || messageText.length == 0)
    {
        //handle this
    }
    else
    {
        /*ATextModel *aTextModel = [[ATextModel alloc]init];
        aTextModel.delegate = self;
        [aTextModel sendText:(messageText)];*/
        [self sendText:messageText];
    }
}

-(void)sendText:(NSString *)text
{
    //static data for the friends array for now
    NSDictionary* friends = @{@"Rachel" : [NSNumber numberWithLongLong:(8308325680)],
                              @"Becky" : [NSNumber numberWithLongLong:(5126007770)]};
    NSArray *recipents = @[@"8308325680", @"5126007770"];
    
    
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
	if([MFMessageComposeViewController canSendText])
	{
		controller.body = text;
		controller.recipients = [NSArray arrayWithObjects:@"8308325680", @"5126007770", nil];
		controller.messageComposeDelegate = self;
		[self presentModalViewController:controller animated:YES];
	}
    else{
        NSLog(@"Message not sent");
    }
    
    NSLog(@"Text sent from ATextComposerController");
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result) {
        case MessageComposeResultCancelled:
            NSLog(@"Message was cancelled");
            [self dismissViewControllerAnimated:YES completion:NULL];             break;
        case MessageComposeResultFailed:
            NSLog(@"Message failed");
            [self dismissViewControllerAnimated:YES completion:NULL];             break;
        case MessageComposeResultSent:
            NSLog(@"Message was sent");
            [self dismissViewControllerAnimated:YES completion:NULL];             break;
        default:
            break;
    }
}

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
