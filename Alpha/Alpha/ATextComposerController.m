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
{
    CGRect originalViewFrame;
    UITextField *textFieldWithFocus;
}

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
    [self.friendsLabel setText:@"Recipients: Rachel, Becky"];
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
        //[self.messageText setDelegate:self];
    
    // Register for keyboard notifications.
    //
    // Register for when the keyboard is shown.
    // To make sure the text field that has focus can be seen by the user.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:@"UIKeyboardWillShowNotification"
                                               object:nil];
    // Register for when the keyboard is hidden.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:@"UIKeyboardDidHideNotification"
                                               object:nil];
    
    
    // Remember the starting frame for the view
    originalViewFrame = self.view.frame;
    
    // Set the scroll view to the same size as its parent view - typical
    self.scrollView.frame = originalViewFrame;
    
    // Set the content size to the same size as the scroll view - for now.
    // Later we'll be changing the content size to allow for scrolling.
    // Right now, no scrolling would occur because the content and the scroll view
    // are the same size.
    self.scrollView.contentSize = originalViewFrame.size;
    
    NSLog(@"viewDidLoad: originalViewFrame: h:%f w:%f x:%f y:%f",
          originalViewFrame.size.height, originalViewFrame.size.width, originalViewFrame.origin.x, originalViewFrame.origin.y);
    NSLog(@"viewDidLoad: scrollView: h:%f w:%f x:%f y:%f",
          self.scrollView.frame.size.height, self.scrollView.frame.size.width, self.scrollView.frame.origin.x, self.scrollView.frame.origin.y);
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

// Called when the keyboard will be shown.
- (void) keyboardWillShow:(NSNotification *)note {
    NSDictionary *userInfo = [note userInfo];
    CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    int adjust = 0;
    int pad = 5;
    
    int top = originalViewFrame.size.height - keyboardFrame.size.height - pad - textFieldWithFocus.frame.size.height;
    
    if (textFieldWithFocus.frame.origin.y > top) {
        adjust = textFieldWithFocus.frame.origin.y - top;
    }
    
    CGRect newViewFrame = originalViewFrame;
    newViewFrame.origin.y -= adjust;
    newViewFrame.size.height = originalViewFrame.size.height + keyboardFrame.size.height;
    
    // Change the content size so we can scroll up and expose the text field widgets
    // currently under the keyboard.
    CGSize newContentSize = originalViewFrame.size;
    newContentSize.height += (keyboardFrame.size.height * 2);
    self.scrollView.contentSize = newContentSize;
    
    NSLog(@"keyboardWillShow: keyboardFrame: h:%f w:%f x:%f y:%f",
          keyboardFrame.size.height, keyboardFrame.size.width, keyboardFrame.origin.x, keyboardFrame.origin.y);
    NSLog(@"keyboardWillShow: originalViewFrame: h:%f w:%f x:%f y:%f",
          originalViewFrame.size.height, originalViewFrame.size.width, originalViewFrame.origin.x, originalViewFrame.origin.y);
    NSLog(@"keyboardWillShow: adjust:%d  newViewFrame: h:%f w:%f x:%f y:%f",
          adjust, newViewFrame.size.height, newViewFrame.size.width, newViewFrame.origin.x, newViewFrame.origin.y);
    
    // Move the view to keep the text field from being covered up by the keyboard.
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = newViewFrame;
    }];
}

// Called when the keyboard will be hidden - the user has touched the Return key.
- (void) keyboardDidHide:(NSNotification *)note {
    NSLog(@"keyboardDidHide: originalViewFrame: h:%f w:%f x:%f y:%f",
          originalViewFrame.size.height, originalViewFrame.size.width, originalViewFrame.origin.x, originalViewFrame.origin.y);
    [UIView animateWithDuration:0.3 animations:^{
        // Restore the parent view and scroll content view to their original sizes
        self.view.frame = originalViewFrame;
        self.scrollView.contentSize = originalViewFrame.size;
    }];
}


// Called when you touch inside a text field.
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"textFieldDidBeginEditing: txtField: h:%f w:%f x:%f y:%f",
          textField.frame.size.height, textField.frame.size.width, textField.frame.origin.x, textField.frame.origin.y);
    // Remember which text field has focus
    textFieldWithFocus = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"textFieldDidEndEditing: Entry.");
    textFieldWithFocus = nil;
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
