//
//  LEOPanelController.h
//  connectForMac
//
//  Created by Liu Ley on 12-12-13.
//  Copyright (c) 2012年 SAE. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface LEOPanelController : NSWindowController<NSTextFieldDelegate>
@property (nonatomic,retain) IBOutlet NSTextField *urlTF;
@property (nonatomic,retain) IBOutlet NSTextField *userTF;
@property (nonatomic,retain) IBOutlet NSTextField *passwordTF;
-(IBAction)modifyInfo:(id)sender;
@end
