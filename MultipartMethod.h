/**
 *  @file MultipartMethod.h
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

#import <Foundation/Foundation.h>
#import "Part.h"
#import "HttpMethod.h"
#import "HttpResponse.h"

/**
 * MultipartMethod represents a multipart form request.  It can hold Part objects
 * @author Scott Slaugh
 * @version 0.5
 */
@interface MultipartMethod : NSObject <HttpMethod> {
	NSMutableArray * methodParts;
	NSMutableDictionary * headers;
	int timeoutInSeconds;
}

@property (readonly, nonatomic, assign) NSUInteger tryCount;
@property(nonatomic, assign) BOOL cancelled;
@property(nonatomic, readonly, strong) NSDate *lastAttemptTime;
@property(nonatomic, readonly, strong) NSDate *initialAttemptTime;

/**
 * Init with an alternative content-type
 * @param contentType The contentType
 */
- (id) initWithContentType:(NSString*)inContentType;

/**
 * This method sets the timeout value
 * @param timeoutValue The timeout, in seconds
 */
- (void)setTimeout:(int)timeoutValue;
- (int)timeout;

/**
 * Add a part to the multipart request.  Order of the parts is not guaranteed.
 * @param newPart A part to be added to the multipart request
 */
- (void)addPart:(id<Part>)newPart;

/**
 * Add string parts to the request using the key/value pairs in the dictionary.  Order of the parts is not guaranteed.
 * @param dict The dictionary to get the key/value pairs from.
 */
- (void)addStringPartsFromDictionary:(NSDictionary*)dict;

/**
 * This method adds a header to be used in any operation.  The order of the headers is not guaranteed
 * @param headerName The name of the header
 * @param headerData The value to correspond to that header
 */
- (void)addHeader:(NSString*)headerData withName:(NSString*)headerName;


@end
