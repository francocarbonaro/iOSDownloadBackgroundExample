//
//  DownloadBackgroundAppDelegate.h
//  DownloadBackground
//
//  Created by Franco Carbonaro on 28/01/11.
//  Copyright 2011 Finger Tips. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadBackgroundAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	IBOutlet UINavigationController *_navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

