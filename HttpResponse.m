/**
 *  @file HttpResponse.m
 *  HttpClient
 *
 *  Copyright (c) 2010 Scott Slaugh, Brigham Young University
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

#import "HttpResponse.h"
#import "Constants.h"

@implementation HttpResponse

@synthesize headerFields = headerFields_;

- (id)initWithHttpURLResponse:(NSHTTPURLResponse*)response withData:(NSData*)data {
	self = [super init];
	
	if (self != nil) {
		responseData = data;
		responseString = nil;
		headerFields = [response allHeaderFields];
		statusCode = [response statusCode];
		url = response.URL;
	}
	
	return self;
}

- (NSData*) responseData {
	return responseData;
}

- (NSString*) responseString {
	if (responseString == nil) {
		responseString = [[NSString alloc] initWithData:responseData encoding:encoding];
	}
	
	return responseString;
}

- (NSString*) HTTPHeaderForKey:(NSString*)key {
	return [headerFields objectForKey:key];
}

- (NSHTTPCookie*) cookieForName:(NSString*) name {
	for (NSHTTPCookie* cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:url]) {
		if ([cookie.name isEqualToString:name]) {
			return cookie;
		}
	}
	
	return nil;
}

- (NSInteger) statusCode {
	return statusCode;
}

@end
