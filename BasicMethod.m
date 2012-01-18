/**
 *  @file BasicMethod.m
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

#import "BasicMethod.h"
#import "Constants.h"
#import "DelegateMessenger.h"


@implementation BasicMethod

- (id)init {
	self = [super init];
	
	if (self != nil) {
		//Initialize the dictionary used for storing parameters
		params = [[NSMutableDictionary alloc] init];
		headers = [[NSMutableDictionary alloc] init];
		timeoutInSeconds = 60; // DEFAULT
	}
	
	return self;
}

- (void)setTimeout:(int)timeoutValue {
	timeoutInSeconds = timeoutValue;
}

- (NSDictionary*) parameters {
    return params;
}

- (void)addParameter:(NSString*)paramData withName:(NSString*)paramName {
	//Add the parameter to the parameters dictionary
	id existingValue = [params valueForKey:paramName];
	if (existingValue != nil) {
		if ([existingValue isKindOfClass:[NSMutableArray class]]) {
			[(NSMutableArray*)existingValue addObject:paramData];
		} else {
			NSMutableArray* newValue = [[NSMutableArray alloc] init];
			[newValue addObject:existingValue];
			[newValue addObject:paramData];
			[params setValue:newValue forKey:paramName];
		}
	} else {
		[params setValue:paramData forKey:paramName];
	}
}

- (void)addParametersFromDictionary:(NSDictionary*)dict {
	for (id key in dict) {
		[params setValue:[dict objectForKey:key] forKey:key];
	}
}

- (NSDictionary*) headers {
    return headers;
}

- (void)addHeader:(NSString*)headerData withName:(NSString*)headerName {
	//Add the header to the headers dictionary
	[headers setValue:headerData forKey:headerName];
}

- (NSString*) encodeUrl:(NSString*) string {
	if (string == nil) {
		return nil;
	}
	
	NSString *newString = (__bridge_transfer NSString*) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef) string, CFSTR(" "), CFSTR(":/?#[]@!$&'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(encoding));
	newString = [newString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
	if (newString) {
		return newString;
	}
	return @"";
}

- (void)prepareMethod:(NSURL*)methodURL methodType:(NSString*)methodType dataInBody:(bool)dataInBody contentType:(NSString*)contentType withRequest:(NSMutableURLRequest*)request {
	//Set the destination URL
	[request setURL:methodURL];
	//Set the method type
	[request setHTTPMethod:methodType];
	//Set the content-type
	[request addValue:contentType forHTTPHeaderField:@"Content-Type"];
	//Set the timeout
	[request setTimeoutInterval:timeoutInSeconds];
	//Gzip header
	[request addValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
	
	//Create a data object to hold the body while we're creating it
	if (! body) {
		NSMutableData * bodyData = [[NSMutableData alloc] init];
		
		//Loop over all the items in the parameters dictionary and add them to the body
		int cCount = 0;
		for (NSString* cKey in params) {
			cCount++;
			//If we've already added at least one data item, we need to add the & character between each new data item
			if (cCount > 1) {
				[bodyData appendData:[@"&" dataUsingEncoding:encoding]];
			}
			
			//Add the parameter
			if ([[params valueForKey:cKey] isKindOfClass:[NSMutableArray class]]) {
				int pCount = 0;
				for (NSString* arrayValue in (NSMutableArray*)[params valueForKey:cKey]) {
					pCount++;
					if (pCount > 1) {
						[bodyData appendData:[@"&" dataUsingEncoding:encoding]];
					}
					[bodyData appendData:[[NSString stringWithFormat:@"%@=%@", [self encodeUrl:cKey], [self encodeUrl:arrayValue]] dataUsingEncoding:encoding]];
				}
			} else {
				[bodyData appendData:[[NSString stringWithFormat:@"%@=%@", [self encodeUrl:cKey], [self encodeUrl:[params valueForKey:cKey]]] dataUsingEncoding:encoding]];
			}
		}
		body = bodyData;
	}
		
	//Loop over the items in the headers dictionary and add them to the request
	for (NSString* cHeaderKey in headers) {
		[request addValue:[headers valueForKey:cHeaderKey] forHTTPHeaderField:cHeaderKey];
	}
	
	//Add the body data in either the actual HTTP body or as part of the URL query
	if (dataInBody || [body length] > 0) { 
		if ([methodType isEqualToString:@"POST"]|| [methodType isEqualToString:@"PUT"]) {  //For post/put methods, we add the parameters to the body
			[request setHTTPBody:body];
		} else if ([methodType isEqualToString:@"GET"]) { //For get methods, we have to add parameters to the url
			//Get a mutable string so that we can add the parameters to the end as query arguments
			NSMutableString * newURLString = [[NSMutableString alloc] initWithString:[methodURL absoluteString]];
			//Convert the body data into a string
			NSString * bodyString = [[NSString alloc] initWithData:body encoding:encoding];
			//Append the body data as a URL query
			[newURLString appendFormat:@"?%@", bodyString];
			//Create a new URL, escaping characters as necessary
			NSURL * newURL = [NSURL URLWithString:newURLString];
			//Set the url request's url to be this new URL with the query appended
			[request setURL:newURL];			
		}
	} 
}

- (HttpResponse*)executeMethodSynchronously:(NSURL*)methodURL methodType:(NSString*)methodType dataInBody:(bool)dataInBody contentType:(NSString*)contentType error:(NSError**) error {
	
	//Create a new URL request object
	NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
	
	[self prepareMethod:methodURL methodType:methodType dataInBody:dataInBody contentType:contentType withRequest:request];
	
	DLog(@"[BasicMethod executeMethodSynchronously] %@", [request URL]);

	//Execute the HTTP method, saving the return data
	NSHTTPURLResponse * response;
	NSError* errorResponse = nil;
	NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&errorResponse];
	HttpResponse * responseObject = [[HttpResponse alloc] initWithHttpURLResponse:response withData:returnData];
	
	if (errorResponse) {
		NSLog(@"[BasicMethod executeMethodSynchronously] %@ Error was %@", [request URL], errorResponse);
		if (error != NULL) {
			*error = errorResponse;
		}
	}
	
	NSLog(@"[BasicMethod executeMethodSynchronously] %@ Status code was %d", [request URL], [responseObject statusCode]);
	NSLog(@"[BasicMethod executeMethodSynchronously] %@ Result was %@", [request URL], [responseObject responseString]);
	
	return responseObject;
}

- (void)executeMethodAsynchronously:(NSURL*)methodURL methodType:(NSString*)methodType dataInBody:(bool)dataInBody contentType:(NSString*)contentType withDelegate:(id<HttpClientDelegate,NSObject>)delegate {
	NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
	
	[self prepareMethod:methodURL methodType:methodType dataInBody:dataInBody contentType:contentType withRequest:request];

	DLog(@"[BasicMethod executeMethodSynchronously] %@", [request URL]);

	//Execute the HTTP method
	DelegateMessenger * messenger = [DelegateMessenger delegateMessengerWithDelegate:delegate];
	
	[NSURLConnection connectionWithRequest:request delegate:messenger];
}

@end
