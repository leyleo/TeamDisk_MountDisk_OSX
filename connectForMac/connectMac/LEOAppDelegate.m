//
//  LEOAppDelegate.m
//  connectMac
//
//  Created by Liu Ley on 12-12-12.
//  Copyright (c) 2012年 SAE. All rights reserved.
//

#import "LEOAppDelegate.h"
#import "LEOPanelController.h"

@implementation LEOAppDelegate
- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    NSStatusBar *statusBar = [NSStatusBar systemStatusBar];
    NSStatusItem *statusItem = [statusBar statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setImage:[NSImage imageNamed:@"icon_16x16"]];
    NSMenu *menu=[[NSMenu alloc] init];
    NSMenuItem *show=[[NSMenuItem alloc] initWithTitle:@"show" action:@selector(showFinder) keyEquivalent:@""];
    NSMenuItem *settings=[[NSMenuItem alloc] initWithTitle:@"settings" action:@selector(showSettings) keyEquivalent:@""];
    NSMenuItem *exit=[[NSMenuItem alloc] initWithTitle:@"exit" action:@selector(exitApp) keyEquivalent:@""];
    [menu addItem:show];
    [menu addItem:settings];
    [menu addItem:exit];
    [show release];
    [settings release];
    [exit release];
    [statusItem setMenu:menu];
    [statusItem setHighlightMode:YES];
    [statusItem retain];
    
}

#pragma mark - Actions
-(void)showSettings
{
//    LEOPanelController *panelController=[[LEOPanelController alloc] init];
//    [panelController showPanelView:self];
    LEOPanelController *panel=[[LEOPanelController alloc] initWithWindowNibName:@"LEOPanelController"];
    [panel showWindow:self];
    
}

-(void)showFinder
{
    BOOL result=[self prepareLoad];
    if (result==NO) {
        return;
    }
    if (url==nil || [url isEqualToString:@""]) {
        return;
    }
    NSMutableString *source=[[NSMutableString alloc] initWithFormat:@"mount volume \"%@\"",url];
    if (username!=nil) {
        [source appendFormat:@" as user name \"%@\"",username];
    }
    if (password!=nil) {
        [source appendFormat:@" with password \"%@\"",password];
    }
    [source appendFormat:
     @"\ntell application \"Finder\""
     @"\nactivate"
     @"\n open (\"/Volumes/%@\" as POSIX file)"
     @"\nend tell",
     [url lastPathComponent]];
    NSAppleScript *as=[[NSAppleScript alloc] initWithSource:source];
    NSDictionary *error=nil;
    [as executeAndReturnError:&error];
    [as release];
}


-(BOOL)prepareLoad
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    url=[defaults valueForKey:@"httpServer"];
    username=[defaults valueForKey:@"userName"];
    password=[defaults valueForKey:@"password"];
    if (url==nil || [self isEmptyString:url]) {
        NSAlert *alert=[NSAlert alertWithMessageText:@"提示：还没有设置服务器信息" defaultButton:@"去设置" alternateButton:@"取消" otherButton:nil informativeTextWithFormat:@"现在肿么办？"];
        NSInteger result=[alert runModal];
        if (result==NSAlertDefaultReturn) {
            [self showSettings];
            return NO;
        } else if (result==NSAlertAlternateReturn) {
            NSLog(@"cancel");
            return NO;
        }
    }
    return YES;
}

-(void)ejectFinder
{
    if (url!=nil && [self isEmptyString:url]) {
        NSMutableString *source=[[NSMutableString alloc] initWithFormat:
                                 @"tell application \"Finder\""
                                 @"\n eject \"%@\""
                                 @"\nend tell",
                                 [url lastPathComponent]];
        NSAppleScript *as=[[NSAppleScript alloc] initWithSource:source];
        NSDictionary *error=nil;
        [as executeAndReturnError:&error];
        [as release];
    }
}

-(void)exitApp
{
    NSLog(@"exit");
    [[NSApplication sharedApplication] terminate:self];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    NSLog(@"terminate");
    [self ejectFinder];
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
