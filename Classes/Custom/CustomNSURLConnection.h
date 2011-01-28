//
//  CustomNSURLConnection.h
//  DownloadBackground
//
//  Created by Franco Carbonaro on 28/01/11.
//  Copyright 2011 Finger Tips. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CustomNSURLConnection : NSURLConnection {
	NSString *_stringTag;
}

@property (nonatomic, retain) NSString *stringTag;

@end
