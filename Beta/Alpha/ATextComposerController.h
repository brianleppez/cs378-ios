//
//  ATextComposerController.h
//  Alpha
//
//  Created by Samantha Allen on 10/21/14.
//  Copyright (c) 2014 cs378. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "ATextModel.h"

@interface ATextComposerController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *messageText;
@property (weak, nonatomic) IBOutlet UILabel *friendsLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *messagePicker;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@end
