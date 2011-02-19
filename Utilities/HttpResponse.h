/**
 *  @file HttpResponse.h
 *  HttpClient
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

#import <Foundation/Foundation.h>


/**
 * The HttpResponse object is used for holding information about the result of a HTTP operation
 * @author Scott Slaugh
 * @version 0.5
 */
@interface HttpResponse : NSObject {
	NSData * responseData;
	NSString * responseString;
	NSDictionary * headerFields;
	NSInteger statusCode;
}

/**
 * The NSDictionary object which holds the response header fields
 */
@property (readonly) NSDictionary * headerFields;

/**
 * Create a HttpResponse object, populating it with the specified data and response object
 * @param response The HTTP respone to use to populate this response
 * @param data The data returned by the HTTP method
 */
-(id)initWithHttpURLResponse:(NSHTTPURLResponse*)response withData:(NSData*)data;

/**
 * Get the data that was returned after exectuing the method
 * @return The data that was returned after executing the HTTP method
 */
-(NSData*) responseData;

/**
 * Get the data that was returned after exectuing the method, formatted as a string
 * @return A string representing the data returned by the HTTP method
 */
-(NSString*) responseString;

/**
 * Get one of the HTTP headers from the response sent after executing a HTTP method
 * @param The name of the HTTP header field you want
 * @return The requested key, or nil if the requested key couldn't be found
 */
-(NSString*) HTTPHeaderForKey:(NSString*)key;

/**
 * Get the response code sent back after executing the HTTP method
 * @return The response code
 */
-(NSInteger) statusCode;

@end
