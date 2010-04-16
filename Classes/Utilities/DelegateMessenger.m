/**
 * @file DelegateMessenger.m
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

#import "DelegateMessenger.h"


@implementation DelegateMessenger

-(id)initWithDelegate:(id<HttpClientDelegate,NSObject>)del {
	self = [super init];
	
	if (self != nil) {
		delegate = del;
		receivedData = [[NSMutableData alloc] init];
		lastResponse = nil;
	}
	
	return self;
}

+(id)delegateMessengerWithDelegate:(id<HttpClientDelegate,NSObject>)del {

	DelegateMessenger * messenger = [[DelegateMessenger alloc] initWithDelegate:del];
	
	return [messenger autorelease];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response {
	if (lastResponse != nil) {
		[lastResponse release];
	}
	
	lastResponse = [response retain];

	if ([delegate respondsToSelector:@selector(connectionReceivedResponse:)]) {
		[delegate connectionReceivedResponse:response];
	}
}

- (void)connection:(NSURLConnection *)connectiondidFailWithError:(NSError *)error {
	if ([delegate respondsToSelector:@selector(connectionFailedWithError:)]) {
		[delegate connectionFailedWithError:error];
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	HttpResponse * response = [[HttpResponse alloc] initWithHttpURLResponse:lastResponse withData:receivedData];
	
	if ([delegate respondsToSelector:@selector(connectionFinishedLoading:)]) {
		[delegate connectionFinishedLoading:[response autorelease]];
	}
		
	[receivedData release];
	receivedData = nil;
}

-(void)dealloc {
	if (receivedData != nil) {
		[receivedData release];
	}
	if (lastResponse != nil) {
		[lastResponse release];
	}
	
	[super dealloc];
}

@end
