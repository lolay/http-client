/**
 *  @file PutMethod.h
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

/**
 * The PutMethod implements a HTTP PUT method, which uploads data to a server
 * @author Scott Slaugh
 * @version 0.5
 */
@interface PutMethod : NSObject <HttpMethod> {
	NSData * uploadData;
}

/**
 * Create a PUT request which will upload the speicifed data
 * @param data The data to upload
 */
-(id)initWithData:(NSData*)data;

/**
 * Create a PUT request which will upload the file pointed to by url
 * @param url The file to upload
 */
-(id)initWithContentsOfURL:(NSURL*)url;

@end
