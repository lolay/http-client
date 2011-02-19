/**
 *  @file HttpMethod.h
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
 */

#import "HttpResponse.h"
#import "HttpClientDelegate.h"

/**
 * The HttpMethod protocol specifies the commands a HTTP method needs to implement
 * @author Scott Slaugh
 * @version 0.5
 */
@protocol HttpMethod <NSObject>

/**
 * Execute the method at the supplied URL, blocking the current thread until the result is returned
 * @param methodURL The URL to use for executing the method
 * @return A NSString* containing the results of the method execution
 */
-(HttpResponse*)executeSynchronouslyAtURL:(NSURL*)methodURL;

/**
 * Execute the method at the supplied URL.  The current thread continues executing, and results are sent through the delegate methods
 * @param methodURL The URL to use for executing the method
 * @param delegate The object to receive delegate methods for the connection
 */
-(void)executeAsynchronouslyAtURL:(NSURL*)methodURL withDelegate:(id<HttpClientDelegate,NSObject>)delegate;

@end

