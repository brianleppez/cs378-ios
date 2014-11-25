//
//  ATextComposerController.m
//  Alpha
//
//  Created by Samantha Allen on 10/21/14.
//  Copyright (c) 2014 cs378. All rights reserved.
//

#import "ATextComposerController.h"

@interface ATextComposerController () <ATextModelProtocol, UITextFieldDelegate, MFMessageComposeViewControllerDelegate, UITextViewDelegate>
{
    NSArray *_pickerData;
}

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
    [self.messageText setDelegate:self];
    [self.messageText setDelegate:self];
    [self.messageText.layer setBorderWidth:1.0f];
    [self.messageText.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
    //self.messageText.clipsToBounds = YES;
    [self.messageText.layer setCornerRadius:10.0f];
    [self textViewDidEndEditing:self.messageText];
    
    _pickerData = @[@"Let's meet up", @"Where are you?", @"Are you ready to leave?",
                    @"I'm ready to go", @"I can't find you"];
    [self.messagePicker setDataSource:self];
    [self.messagePicker setDelegate:self];
    
}
- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:false];
    // Get names of recipients for text
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *groupName = [defaults stringForKey:@"groupName"];
    Firebase* myRootRef = [[Firebase alloc] initWithUrl:@"https://cs378-ios.firebaseio.com"];
    Firebase* myGroupRef = [myRootRef childByAppendingPath:groupName];
    __block NSString *names = [[NSString alloc] init];
    names = [names stringByAppendingString:@"Recipients: "];
    [myGroupRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        for (id key in snapshot.value) {
            if ([key isEqualToString:[defaults stringForKey:@"username"]]) {
                
            }
            else {
            names = [names stringByAppendingString:key];
            names = [names stringByAppendingString:@", "];
            }
        }
        if ([names length] > 0) {
            names = [names substringToIndex:[names length] - 2];
        }
        [self.friendsLabel setText:names];
    }];

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

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
        [textView resignFirstResponder];
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
    /*NSDictionary* friends = @{@"Rachel" : [NSNumber numberWithLongLong:(8308325680)],
                              @"Becky" : [NSNumber numberWithLongLong:(5126007770)]};
    NSArray *recipents = @[@"8308325680", @"5126007770"];*/
    
    
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

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Enter message here..."]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Enter message here...";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}

-(BOOL)automaticallyAdjustsScrollViewInsets
{
    return NO;
}

// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerData[row];
}

// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self textViewDidBeginEditing:_messageText];
    NSString *currentText = [_messageText.text stringByAppendingString:@" "];
    NSString *text = [currentText stringByAppendingString:_pickerData[row]];
    [self.messageText setText:text];
    [self textViewDidEndEditing:_messageText];
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
