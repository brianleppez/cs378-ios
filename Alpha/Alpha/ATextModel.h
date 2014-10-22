//
//  ATextModel.h
//  Alpha
//
//  Created by Samantha Allen on 10/21/14.
//  Copyright (c) 2014 cs378. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>

@protocol ATextModelProtocol <NSObject>

@required
-(void)modifedData:(NSString *)data;

@end

@interface ATextModel : NSObject

@property (nonatomic, strong) id <ATextModelProtocol> delegate;

-(void)sendText:(NSString *)text;

@end
