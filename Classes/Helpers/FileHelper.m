//
//  FileHelper.m
//  DownloadBackground
//
//  Created by Franco Carbonaro on 28/01/11.
//  Copyright 2011 Finger Tips. All rights reserved.
//

#import "FileHelper.h"


@implementation FileHelper

+ (NSString *)documentsDirectoryPathForFile:(NSString *)fileName {
	NSString *documentsDirectoryPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/"];
	NSString *filePath = [documentsDirectoryPath stringByAppendingString:fileName];
	
	return filePath;
}

@end
