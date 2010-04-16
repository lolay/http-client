/**
 *  @file HttpClientDelegate.h
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

#import "HttpResponse.h"


/**
 * The HttpClientDelegate protocol defines methods that a receiver can receive when it is a delegate of a HttpClient request<br>
 * All of the methods are optional.
 * @author Scott Slaugh
 * @version 0.5
 */
@protocol HttpClientDelegate

/**
 * This message is sent when the connection receives a response from the web server.<br>
 * This method may be sent multiple times if server redirects occur<br>
 * The URLResponse data from the final server redirect will be placed in the HttpResponse sent to the connectionFinishedLoading message
 * @param response The HTTP response sent back by the server
 */
-(void)connectionReceivedResponse:(NSHTTPURLResponse*)response;

/**
 * This message is sent when the connection fails
 * @param error The error message associated with the failure
 */
-(void)connectionFailedWithError:(NSError*)error;

/**
 * This message is sent when the connection finishes loading<br>
 * The HttpResponse object holds the server response code and header fields from the last redirect the occurred
 * @param result A HttpResponse object which holds the data sent back and the header information from the last server redirect
 */
-(void)connectionFinishedLoading:(HttpResponse*)result;

@end

