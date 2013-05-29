//
//  LEOPanelController.m
//  connectForMac
//
//  Created by Liu Ley on 12-12-13.
//  Copyright (c) 2012年 SAE. All rights reserved.
//

#import "LEOPanelController.h"

@interface LEOPanelController ()

@end

@implementation LEOPanelController
@synthesize urlTF,userTF,passwordTF;
- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    [urlTF becomeFirstResponder];
    [self prepareLoad];
}

-(void)prepareLoad
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *url=[defaults valueForKey:@"httpServer"];
    NSString *user=[defaults valueForKey:@"userName"];
    NSString *password=[defaults valueForKey:@"password"];

    [self.urlTF.cell setTitle:url==nil?@"":url];
    [self.userTF.cell setTitle:user==nil?@"":user];
    [self.passwordTF.cell setTitle:password==nil?@"":password];
}

-(IBAction)modifyInfo:(id)sender
{
    NSString *url=[urlTF.cell title];
    NSString *name=[userTF.cell title];
    NSString *password=[passwordTF.cell title];
    if (url==nil || [self isEmptyString:url]) {
        NSAlert *alert=[NSAlert alertWithMessageText:@"提示：还没有填写有效的地址哇~" defaultButton:@"继续填写" alternateButton:@"不写啦，这次不算数" otherButton:@"清空设置" informativeTextWithFormat:@"现在肿么办？"];
        NSInteger result=[alert runModal];
        if (result==NSAlertDefaultReturn) {
            //
            NSLog(@"ok");
        } else if (result==NSAlertAlternateReturn) {
            NSLog(@"cancel");
            [self close];
        } else if (result==NSAlertOtherReturn) {
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            [defaults removeObjectForKey:@"httpServer"];
            [defaults removeObjectForKey:@"userName"];
            [defaults removeObjectForKey:@"password"];
            [defaults synchronize];
            [self close];
        }
    }else {
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [defaults setValue:url forKey:@"httpServer"];
        [defaults setValue:name forKey:@"userName"];
        [defaults setValue:password forKey:@"password"];
        [defaults synchronize];
        [self close];
    }
}

-(BOOL)isEmptyString:(NSString *)string
{
    if(!string)
    { //string is empty or nil
        return YES;
    }
    else if([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        //string is all whitespace
        return YES;
    }
    return NO;
}
@end
