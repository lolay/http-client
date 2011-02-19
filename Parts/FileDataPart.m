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
		name = [paramName retain];
		fileData = [inFileData retain];
		fileName = [inFileName retain];
		compressFile = compress;
	}
	
	return self;
}

+ (FileDataPart*) filePartWithData:(NSData*)inFileData withName:(NSString*)paramName withFileName:(NSString*) inFileName compressFile:(bool)compress {
	return [[[FileDataPart alloc] initWithData:inFileData withName:paramName withFileName:inFileName compressFile:compress] autorelease];
}

- (void)appendData:(NSMutableData*)outputData {
	NSData * appendFileData;
	NSString* appendFileName;
	
	if (compressFile) {
		appendFileData = [[HttpClientGzipUtility gzipData:fileData] retain];
		appendFileName = [[fileName stringByAppendingString:@".gz"] retain];
		
		if (appendFileData == nil) {
			NSLog(@"Compressed data is nil!");
		}
	}
	else {
		appendFileData = [fileData retain];
		appendFileName = [fileName retain];
	}
	
	[outputData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", name, appendFileName] dataUsingEncoding:encoding]];
	[outputData appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n"] dataUsingEncoding:encoding]];
	[outputData appendData:[[NSString stringWithString:@"Content-Transfer-Encoding: binary\r\n\r\n"] dataUsingEncoding:encoding]];
	[outputData appendData:[NSData dataWithData:appendFileData]];
	[outputData appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:encoding]];
	
	[appendFileData release];
	[appendFileName release];
}

- (void) dealloc {
	[name release];
	[fileData release];
	[fileName release];
	
	[super dealloc];
}

@end
