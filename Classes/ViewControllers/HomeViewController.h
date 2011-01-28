//
//  HomeViewController.h
//  DownloadBackground
//
//  Created by Franco Carbonaro on 28/01/11.
//  Copyright 2011 Finger Tips. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomeViewController : UIViewController {
	
	IBOutlet UIImageView *_splashImageView;
	IBOutlet UIImageView *_bannerImageView;
	
	NSMutableData *_splashData;
	NSMutableData *_bannerData;
	
}

- (void)downloadSplashScreenImage:(NSString *)imageUrl;
- (void)downloadBannerImage:(NSString *)imageUrl;

@end
