//
//  ed_padAppDelegate.m
//  ed-pad
//
//  Created by dennisli on 6/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "TabBarController.h"
#import "HomeViewController.h"
#import "AboutViewController.h"
#import "NewsViewController.h"
#import "MapscreenViewController.h"
#import "EventsViewController.h"
#import "ScheduleViewController.h"
#import "RidersViewController.h"
#import "PartnersViewController.h"
#import "VideosViewController.h"
#import "SocialViewController.h"

#import <Three20/Three20.h>

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(UIApplication*)application {
    if (TTIsPad()) {
        NSLog(@"This is an iPad device.");
    } else {
        NSLog(@"This is not an iPad device.");
    }

    [NSThread sleepForTimeInterval:2.0];

    TTNavigator* navigator = [TTNavigator navigator];
    [navigator setPersistenceMode:TTNavigatorPersistenceModeAll];

    TTURLMap* map = navigator.URLMap;
    [map from:@"*" toViewController:[TTWebController class]];
    [map from:@"tt://tabbar" toSharedViewController:[TabBarController class]];
    [map from:@"tt://home" toSharedViewController:[HomeViewController class]];
    [map            from: @"tt://settings"
                  parent: @"tt://tarbar"
        toViewController: [AboutViewController class]
                selector: nil
              transition: 0];
    [map            from: @"tt://about"
                  parent: @"tt://tarbar"
        toViewController: [AboutViewController class]
                selector: nil
              transition: 0];

    [map            from: @"tt://home/news"
                  parent: @"tt://home"
        toViewController: [NewsViewController class]
                selector: nil
              transition: 0];
    [map            from: @"tt://home/mapscreen"
                  parent: @"tt://home"
        toViewController: [MapscreenViewController class]
                selector: nil
              transition: 0];
    [map            from: @"tt://home/events"
                  parent: @"tt://home"
        toViewController: [EventsViewController class]
                selector: nil
              transition: 0];
    [map            from: @"tt://home/schedule"
                  parent: @"tt://home"
        toViewController: [ScheduleViewController class]
                selector: nil
              transition: 0];
    [map            from: @"tt://home/riders"
                  parent: @"tt://home"
        toViewController: [RidersViewController class]
                selector: nil
              transition: 0];
    [map            from: @"tt://home/partners"
                  parent: @"tt://home"
        toViewController: [PartnersViewController class]
                selector: nil
              transition: 0];
    [map            from: @"tt://home/videos"
                  parent: @"tt://home"
        toViewController: [VideosViewController class]
                selector: nil
              transition: 0];
    [map            from: @"tt://home/social"
                  parent: @"tt://home"
        toViewController: [SocialViewController class]
                selector: nil
              transition: 0];
    if (![navigator restoreViewControllers]) {
//        [navigator openURLAction:[TTURLAction actionWithURLPath:@"tt://home"]];
        [navigator openURLAction:[TTURLAction actionWithURLPath:@"tt://tabbar"]];
    }
}

- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)URL {
    [[TTNavigator navigator] openURLAction:[TTURLAction actionWithURLPath:URL.absoluteString]];
    return YES;
}

@end
