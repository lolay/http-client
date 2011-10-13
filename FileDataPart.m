//
//  Created by Lolay, Inc.
//  Copyright 2011 Lolay, Inc. All rights reserved.
//
#import "FileDataPart.h"
#import "HttpClientGzipUtility.h"
#import "Constants.h"

@implementation FileDataPart

- (id) initWithData:(NSData*)inFileData withName:(NSString*)paramName withFileName:(NSString*) inFileName compressFile:(bool)compress {
	self = [super init];
	
	if (self != nil) {
		name = paramName;
		fileData = inFileData;
		fileName = inFileName;
		compressFile = compress;
	}
	
	return self;
}

+ (FileDataPart*) filePartWithData:(NSData*)inFileData withName:(NSString*)paramName withFileName:(NSString*) inFileName compressFile:(bool)compress {
	return [[FileDataPart alloc] initWithData:inFileData withName:paramName withFileName:inFileName compressFile:compress];
}

- (void)appendData:(NSMutableData*)outputData {
	NSData * appendFileData;
	NSString* appendFileName;
	
	if (compressFile) {
		appendFileData = [HttpClientGzipUtility gzipData:fileData];
		appendFileName = [fileName stringByAppendingString:@".gz"];
		
		if (appendFileData == nil) {
			NSLog(@"Compressed data is nil!");
		}
	}
	else {
		appendFileData = fileData;
		appendFileName = fileName;
	}
	
	[outputData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", name, appendFileName] dataUsingEncoding:encoding]];
	[outputData appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n"] dataUsingEncoding:encoding]];
	[outputData appendData:[[NSString stringWithString:@"Content-Transfer-Encoding: binary\r\n\r\n"] dataUsingEncoding:encoding]];
	[outputData appendData:[NSData dataWithData:appendFileData]];
	[outputData appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:encoding]];
}

@end
