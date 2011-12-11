/**
 * @file MultipartMethod.m
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

#import "MultipartMethod.h"
#import "Constants.h"
#import "DelegateMessenger.h"
#import "StringPart.h"

@interface MultipartMethod ()

@property (nonatomic, strong) NSString* contentType;

@end


@implementation MultipartMethod

@synthesize contentType = contentType_;

- (id) init {
	self = [super init];
	
	if (self != nil) {
		methodParts = [[NSMutableArray alloc] init];
		headers = [[NSMutableDictionary alloc] init];
		timeoutInSeconds = 20; // DEFAULT
        self.contentType = @"multipart/mixed; type=*/*";
	}
	
	return self;
}

- (id) initWithContentType:(NSString*)inContentType {
    self = [super init];
    
    if(self != nil) {
		methodParts = [[NSMutableArray alloc] init];
		headers = [[NSMutableDictionary alloc] init];
		timeoutInSeconds = 20; // DEFAULT
        self.contentType = inContentType;
    }
    
    return self;
}


- (void)setTimeout:(int)timeoutValue {
	timeoutInSeconds = timeoutValue;
}

//*****A private method to generate a random boundary string for multipart data*****
- (NSString*)generateBoundary {
	//The characters to use when generating the boundary
	NSString * boundChars = @"-_1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
	
	//Set the seed value for the random number generator
	srandom(time(NULL));
	
	//Get a random number between 30 and 40 for the length of the boundary
	int boundSize = 30 + (random() % 11);
	
	NSMutableString * boundaryString = [[NSMutableString alloc] initWithCapacity:boundSize];
	
	//Create the boundary string with random characters from the character pool
	for (int x = 0; x < boundSize; x++) {
		[boundaryString appendFormat:@"%c", [boundChars characterAtIndex:(random() % [boundChars length])]];
	}
	
	return boundaryString;
}

- (void)addPart:(id<Part>)newPart {
	[methodParts addObject:newPart];
}

- (void)addStringPartsFromDictionary:(NSDictionary*)dict {
	for (id key in dict) {
		StringPart *cPart = [StringPart stringPartWithParameter:[dict objectForKey:key] withName:key];
		[methodParts addObject:cPart];
	}
}

- (void)addHeader:(NSString*)headerData withName:(NSString*)headerName {
	//Add the header to the headers dictionary
	[headers setValue:headerData forKey:headerName];
}

- (void)prepareRequestWithURL:(NSURL*)methodURL withRequest:(NSMutableURLRequest*)urlRequest {
	NSString * boundary = [self generateBoundary];
	NSString * contentType = [NSString stringWithFormat:@"%@; boundary=%@", self.contentType, boundary];
	
	//Set up the request
	[urlRequest setURL:methodURL];
	[urlRequest setHTTPMethod:@"POST"];
	[urlRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
	//Set the timeout
	[urlRequest setTimeoutInterval:timeoutInSeconds];
	
	//Loop over the items in the headers dictionary and add them to the request
	for (NSString* cHeaderKey in headers) {
		[urlRequest addValue:[headers valueForKey:cHeaderKey] forHTTPHeaderField:cHeaderKey];
	}
	
	//Set up the body
	NSMutableData * requestBody = [[NSMutableData alloc] init];
	
	for (int x = 0; x < [methodParts count]; x++) {
		id<Part> cPart = [methodParts objectAtIndex:x];
		[requestBody appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:encoding]];
		[cPart appendData:requestBody];
	}
	
	[requestBody appendData:[[NSString stringWithFormat:@"--%@--\r\n",boundary] dataUsingEncoding:encoding]];
	
	[urlRequest setHTTPBody:requestBody];
}

- (HttpResponse*)executeSynchronouslyAtURL:(NSURL*)methodURL {
	return [self executeSynchronouslyAtURL:methodURL error:NULL];
}
- (HttpResponse*)executeSynchronouslyAtURL:(NSURL*)methodURL error:(NSError**) error {
	NSMutableURLRequest * urlRequest = [[NSMutableURLRequest alloc] init];
	
	[self prepareRequestWithURL:methodURL withRequest:urlRequest];
	
	NSHTTPURLResponse * response;
	NSData *returnData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:error];
	
	HttpResponse * returnResponse = [[HttpResponse alloc] initWithHttpURLResponse:response withData:returnData];
	
	return returnResponse;
}

- (void)executeAsynchronouslyAtURL:(NSURL*)methodURL withDelegate:(id<HttpClientDelegate,NSObject>)delegate {
	
	NSMutableURLRequest * urlRequest = [[NSMutableURLRequest alloc] init];
	
	[self prepareRequestWithURL:methodURL withRequest:urlRequest];
	
	DelegateMessenger * messenger = [DelegateMessenger delegateMessengerWithDelegate:delegate];
		
	[NSURLConnection connectionWithRequest:urlRequest delegate:messenger];
}

@end
