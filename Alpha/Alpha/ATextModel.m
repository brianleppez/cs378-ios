//
//  ATextModel.m
//  Alpha
//
//  Created by Samantha Allen on 10/21/14.
//  Copyright (c) 2014 cs378. All rights reserved.
//

#import "ATextModel.h"

@interface ATextModel() <MFMessageComposeViewControllerDelegate>

-(void)sendText:(NSString *)text;

@end

@implementation ATextModel

-(void)sendText:(NSString *)text
{
   /* //static data for the friends array for now
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
    */
        NSLog(@"Text sent from ATextModel");
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{/*
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
    } */
}
@end
