/**
 * @file DataPart.h
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

#import "DataPart.h"

@implementation DataPart

- (id) initWithParameter:(NSData*)valueData withName:(NSString*)valueKey {
	self = [super init];
	
	if (self != nil) {
		key = valueKey;
		value = valueData;
	}
	
	return self;
}

+(DataPart*) dataPartWithParameter:(NSData*)valueData withName:(NSString*)valueKey {
	return [[DataPart alloc] initWithParameter:valueData withName:valueKey];
}

- (void)appendData:(NSMutableData*)outputData {
	[outputData appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n"] dataUsingEncoding:encoding]];
	[outputData appendData:[[NSString stringWithString:@"Content-Transfer-Encoding: binary\r\n"] dataUsingEncoding:encoding]];
	[outputData appendData:[[NSString stringWithFormat:@"Content-ID: <%@>\r\n\r\n",key] dataUsingEncoding:encoding]];
	[outputData appendData:[NSData dataWithData:value]];
	[outputData appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:encoding]];
}

@end
