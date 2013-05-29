//
//  LEOAppDelegate.h
//  connectMac
//
//  Created by Liu Ley on 12-12-12.
//  Copyright (c) 2012年 SAE. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class LEOPanelController;
@interface LEOAppDelegate : NSObject <NSApplicationDelegate>
{
    NSString *url;
    NSString *username;
    NSString *password;
}
@property (assign) IBOutlet NSWindow *window;
//-(IBAction)showSettings:(id)sender;
@end
