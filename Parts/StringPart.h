/**
 *  @file StringPart.h
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
#import "Part.h"

/**
 * This class represents a String part to be used in a multipart request.
 * @author Scott Slaugh
 * @version 0.5
 */
@interface StringPart : NSObject <Part> {
	NSString * value;
	NSString * name;
}

/**
 * Create a new StringPart object
 * @param valueData The data to be associated with this string part
 * @param valueName The name to use for this string part
 * @return A pointer to the new StringPart object, which will autorelease
 */
+(StringPart*) stringPartWithParameter:(NSString*)valueData withName:(NSString*)valueName;

/**
 * Create a new StringPart object
 * @param valueData The data to be associated with this string part
 * @param valueName The name to use for this string part
 * @return A pointer to the new object
 */
-(id) initWithParameter:(NSString*)valueData withName:(NSString*)valueName;

@end
