//
//  HomeViewController.m
//  DownloadBackground
//
//  Created by Franco Carbonaro on 28/01/11.
//  Copyright 2011 Finger Tips. All rights reserved.
//

#import "HomeViewController.h"
#import "FileHelper.h"
#import "CustomNSURLConnection.h"

#define kSplashScreen @"splashScreen"
#define kBanner @"banner"

@implementation HomeViewController

#pragma mark -
#pragma mark View lifecycke

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Download background";
	
	
	//splash
	NSString *splashScreenPath = [FileHelper documentsDirectoryPathForFile:@"splashscreen.jpg"];
	
	if ([UIImage imageWithContentsOfFile:splashScreenPath]) {
		UIImage *tempImage = [[UIImage alloc] initWithContentsOfFile:splashScreenPath];
		_splashImageView.image = tempImage;
		[tempImage release];
	}
	else {
		//pegar a imagem do resources
	}
	
	//banner
	NSString *bannerPath = [FileHelper documentsDirectoryPathForFile:@"banner.jpg"];
	
	if ([UIImage imageWithContentsOfFile:bannerPath]) {
		UIImage *tempImage = [[UIImage alloc] initWithContentsOfFile:bannerPath];
		_bannerImageView.image = tempImage;
		[tempImage release];
	}
	else {
		//pegar a imagem do resources
	}
	
//	[self downloadSplashScreenImage:@"http://s.glbimg.com/es/ge/f/300x230/2011/01/27/marcosassuncao_ae62.jpg"];
//	[self downloadBannerImage:@"http://s.glbimg.com/es/ge/f/original/2011/01/27/marcos_ae300.jpg"];
	
}

#pragma mark -
#pragma mark Download

- (void)downloadSplashScreenImage:(NSString *)imageUrl {

	CustomNSURLConnection *urlConnection;
	NSURLRequest *request = [[NSURLRequest alloc]
							 initWithURL: [NSURL URLWithString:imageUrl]
							 cachePolicy: NSURLRequestReloadIgnoringLocalCacheData
							 timeoutInterval: 10
							 ];
    
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
	urlConnection = [[CustomNSURLConnection alloc] initWithRequest:request delegate:self];
	urlConnection.stringTag = kSplashScreen;
	
	[urlConnection release];
}

- (void)downloadBannerImage:(NSString *)imageUrl {
	CustomNSURLConnection *urlConnection;
	NSURLRequest *request = [[NSURLRequest alloc]
							 initWithURL: [NSURL URLWithString:imageUrl]
							 cachePolicy: NSURLRequestReloadIgnoringLocalCacheData
							 timeoutInterval: 10];
    
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
	urlConnection = [[CustomNSURLConnection alloc] initWithRequest:request delegate:self];
	urlConnection.stringTag = kBanner;
	
	[urlConnection release];
	
}

#pragma mark -
#pragma mark NSURLConnection Delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	CustomNSURLConnection *customConnection = (CustomNSURLConnection *)connection;
	
	if ([customConnection.stringTag isEqualToString:kSplashScreen]) {
		_splashData = [NSMutableData new];
	}
    else if ([customConnection.stringTag isEqualToString:kBanner]) {
		_bannerData = [NSMutableData new];
	}

	NSLog(@"didReceiveResponse");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	CustomNSURLConnection *customConnection = (CustomNSURLConnection *)connection;
	
	if ([customConnection.stringTag isEqualToString:kSplashScreen]) {
		[_splashData appendData:data];
	}
	else if ([customConnection.stringTag isEqualToString:kBanner]) {
		[_bannerData appendData:data];
	}	
	
    NSLog(@"didReceiveData");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	CustomNSURLConnection *customConnection = (CustomNSURLConnection *)connection;
	
	if ([customConnection.stringTag isEqualToString:kSplashScreen]) {
		_splashData = nil;
	}
	else if ([customConnection.stringTag isEqualToString:kBanner]) {
		_bannerData = nil;
	}
	
	NSLog(@"didFailWithError");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	CustomNSURLConnection *customConnection = (CustomNSURLConnection *)connection;
	
	if ([customConnection.stringTag isEqualToString:kSplashScreen]) {
		NSString *splashScreenPath = [FileHelper documentsDirectoryPathForFile:@"splashscreen.jpg"];
		[_splashData writeToFile:splashScreenPath atomically:YES];

		_splashImageView.image = [[UIImage alloc] initWithData:_splashData];		
	}
	else if ([customConnection.stringTag isEqualToString:kBanner]) {
		NSString *bannerPath = [FileHelper documentsDirectoryPathForFile:@"banner.jpg"];
		[_bannerData writeToFile:bannerPath atomically:YES];

		_bannerImageView.image = [[UIImage alloc] initWithData:_bannerData];
	}
	
	NSLog(@"connectionDidFinishLoading");
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
