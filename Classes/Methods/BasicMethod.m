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

-(id)init {
	self = [super init];
	
	if (self != nil) {
		//Initialize the dictionary used for storing parameters
		params = [[NSMutableDictionary alloc] init];
	}
	
	return self;
}

-(void)addParameter:(NSString*)paramData withName:(NSString*)paramName {
	//Add the parameter to the parameters dictionary
	[params setValue:paramData forKey:paramName];
}

-(void)addParametersFromDictionary:(NSDictionary*)dict {
	for (id key in dict) {
		[params setValue:[dict objectForKey:key] forKey:key];
	}
}

-(void)prepareMethod:(NSURL*)methodURL methodType:(NSString*)methodType dataInBody:(bool)dataInBody contentType:(NSString*)contentType withRequest:(NSMutableURLRequest*)request {
	//Set the destination URL
	[request setURL:methodURL];
	//Set the method type
	[request setHTTPMethod:methodType];
	//Set the content-type
	[request addValue:contentType forHTTPHeaderField:@"Content-Type"];
	
	//Create a data object to hold the body while we're creating it
	NSMutableData * body = [[NSMutableData alloc] init];
	
	//Loop over all the items in the parameters dictionary and add them to the body
	int cCount = 0;
	for (NSString* cKey in params) {
		cCount++;
		//If we've already added at least one data item, we need to add the & character between each new data item
		if (cCount > 1) {
			[body appendData:[@"&" dataUsingEncoding:encoding]];
		}
		
		//Add the parameter
		[body appendData:[[NSString stringWithFormat:@"%@=%@", cKey, [params valueForKey:cKey]] dataUsingEncoding:encoding]];
	}
	
	//Add the body data in either the actual HTTP body or as part of the URL query
	if (dataInBody) { //For post methods, we add the parameters to the body
		[request setHTTPBody:body];
	} //For get methods, we have to add parameters to the url
	else {
		//Get a mutable string so that we can add the parameters to the end as query arguments
		NSMutableString * newURLString = [[NSMutableString alloc] initWithString:[methodURL absoluteString]];
		//Convert the body data into a string
		NSString * bodyString = [[NSString alloc] initWithData:body encoding:encoding];
		//Append the body data as a URL query
		[newURLString appendFormat:@"?%@", bodyString];
		//Create a new URL, escaping characters as necessary
		NSURL * newURL = [NSURL URLWithString:[newURLString stringByAddingPercentEscapesUsingEncoding:encoding]];
		[bodyString release];
		[newURLString release];
		//Set the url request's url to be this new URL with the query appended
		[request setURL:newURL];
	}
	
	[body release];
}

-(HttpResponse*)executeMethodSynchronously:(NSURL*)methodURL methodType:(NSString*)methodType dataInBody:(bool)dataInBody contentType:(NSString*)contentType {
	
	//Create a new URL request object
	NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
	
	[self prepareMethod:methodURL methodType:methodType dataInBody:dataInBody contentType:contentType withRequest:request];
	
	//Execute the HTTP method, saving the return data
	NSHTTPURLResponse * response;
	NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
	
	HttpResponse * responseObject = [[HttpResponse alloc] initWithHttpURLResponse:response withData:returnData];
	
	return [responseObject autorelease];
}

-(void)executeMethodAsynchronously:(NSURL*)methodURL methodType:(NSString*)methodType dataInBody:(bool)dataInBody contentType:(NSString*)contentType withDelegate:(id<HttpClientDelegate,NSObject>)delegate {
	NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
	
	[self prepareMethod:methodURL methodType:methodType dataInBody:dataInBody contentType:contentType withRequest:request];
	
	//Execute the HTTP method
	DelegateMessenger * messenger = [DelegateMessenger delegateMessengerWithDelegate:delegate];
	
	[NSURLConnection connectionWithRequest:request delegate:messenger];
}

@end
