/**
 *  @file BasicMethod.h
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
#import "HttpMethod.h"
#import "HttpClientDelegate.h"

/**
 * BasicMethod is a superclass for the various HTTP client methods.  It isn't meant to be instatiated by client classes, and is just used to hold some common functionality in a super-class.
 * @author Scott Slaugh
 * @version 0.5
 */
@interface BasicMethod : NSObject {
	NSMutableDictionary * params;
}

/**
 * This method adds a parameter to be used in a GET or POST operation.  The order of the parameters is not guaranteed
 * @param paramName The name of the parameter
 * @param paramData The value to correspond to that parameter
 */
-(void)addParameter:(NSString*)paramData withName:(NSString*)paramName;

/**
 * This method adds all of the key/value pairs in a NSDictionary as parameters.  The order of the parameters is not guaranteed
 * @param dict The dictiontary to use for adding parameters
 */
-(void)addParametersFromDictionary:(NSDictionary*)dict;

/**
 * This method executes the HttpMethod synchronously, blocking the calling thread
 * @param methodURL The URL to be used to execute the method
 * @param methodType The method type (GET or POST)
 * @param dataInBody Whether the parameters should be sent in the HTTP body, or as part of the URL
 * @param contentType The value to use for the Content-Type field in the header
 * @return A string containing whatever the was sent back after performing the GET or POST
 */
-(HttpResponse*)executeMethodSynchronously:(NSURL*)methodURL methodType:(NSString*)methodType dataInBody:(bool)dataInBody contentType:(NSString*)contentType;

/**
 * This method executes the HttpMethod asynchronously
 * @param methodURL The URL to be used to execute the method
 * @param methodType The method type (GET or POST)
 * @param dataInBody Whether the parameters should be sent in the HTTP body, or as part of the URL
 * @param contentType The value to use for the Content-Type field in the header
 * @param delegate The object to receive HttpClientDelegate methods
 */
-(void)executeMethodAsynchronously:(NSURL*)methodURL methodType:(NSString*)methodType dataInBody:(bool)dataInBody contentType:(NSString*)contentType withDelegate:(id<HttpClientDelegate>)delegate;

@end
