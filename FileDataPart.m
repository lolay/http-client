/**
 * @file FileDataPart.h
 * HttpClient
 *
 *  Copyright (c) 2012 Lolay, Inc.
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
#import "FileDataPart.h"
#import "HttpClientGzipUtility.h"
#import "Constants.h"
#import "LolayHttpClientGlobals.h"

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
			DLog(@"Compressed data is nil!");
		}
	}
	else {
		appendFileData = fileData;
		appendFileName = fileName;
	}
	
	[outputData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", name, appendFileName] dataUsingEncoding:encoding]];
	[outputData appendData:[@"Content-Type: application/octet-stream\r\n" dataUsingEncoding:encoding]];
	[outputData appendData:[@"Content-Transfer-Encoding: binary\r\n\r\n" dataUsingEncoding:encoding]];
	[outputData appendData:[NSData dataWithData:appendFileData]];
	[outputData appendData:[@"\r\n" dataUsingEncoding:encoding]];
}

@end
