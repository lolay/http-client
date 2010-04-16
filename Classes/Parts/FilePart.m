/**
 * @file FilePart.m
 * HttpClient
 *
 *  Copyright (c) 2010 Scott Slaugh, Brigham Young University
 *   
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *  
 *  The above copyright notice and this permission notice shall be included in
 *  all copies or substantial portions of the Software.
 *   
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *  THE SOFTWARE.
 *
 */

#import "FilePart.h"
#import "HttpClientGzipUtility.h"
#import "Constants.h"

@implementation FilePart

-(id) initWithFile:(NSURL*)fileURL withName: (NSString*)paramName compressFile:(bool)compress {
	self = [super init];
	
	if (self != nil) {
		name = [paramName retain];
		file = [fileURL retain];
		compressFile = compress;
		
	}
	
	return self;
}

+(FilePart*) filePartWithFile:(NSURL*)fileURL withName: (NSString*)paramName compressFile:(bool)compress {
	return [[[FilePart alloc] initWithFile:fileURL withName:paramName compressFile:compress] autorelease];
}

-(void)appendData:(NSMutableData*)outputData {
	
	NSString * fileName = [[[file absoluteString] componentsSeparatedByString:@"/"] lastObject];
	
	//Get the file data
	NSData * fileData;
	
	if (compressFile) {
		NSData * tempFileData = [NSData dataWithContentsOfURL:file];
		fileData = [[HttpClientGzipUtility gzipData:tempFileData] retain];
		
		if (fileData == nil) {
			NSLog(@"Compressed data is nil!");
		}
		else {
			fileName = [fileName stringByAppendingString:@".gz"];
		}
	}
	else {
		fileData = [NSData dataWithContentsOfURL:file];
	}
	
	[outputData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", name, fileName] dataUsingEncoding:encoding]];
	[outputData appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n"] dataUsingEncoding:encoding]];
	[outputData appendData:[[NSString stringWithString:@"Content-Transfer-Encoding: binary\r\n\r\n"] dataUsingEncoding:encoding]];
	[outputData appendData:[NSData dataWithData:fileData]];
	[outputData appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:encoding]];
}

-(void) dealloc {
	if (name != nil)
		[name release];
	
	if (file != nil)
		[name release];
	
	[super dealloc];
}

@end
