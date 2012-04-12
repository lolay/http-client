/**
 * @file FileDataPart.h
 * HttpClient
 *
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

/**
 * FileDataPart represents a file to be uploaded as part of a MultipartMethod.
 */
@interface FileDataPart : NSObject <Part> {
	NSString * name;
	NSString* fileName;
	bool compressFile;
	NSData* fileData;
}

/**
 * Create a new FilePart object
 * @param inFileData The data of the file to be uploaded
 * @param paramName The parameter name to assign to the file
 * @param compressFile Whether the file should be compressed.  If true, the file is compressed as a gzip file
 * @return A pointer to the new FilePart object, which will autorelease
 */
+ (FileDataPart*) filePartWithData:(NSData*)inFileData withName:(NSString*)paramName withFileName:(NSString*) inFileName compressFile:(bool)compress;

/**
 * Create a new FilePart object
 * @param inFileData The data of the file to be uploaded
 * @param paramName The parameter name to assign to the file
 * @param compressFile Whether the file should be compressed.  If true, the file is compressed as a gzip file
 * @return A pointer to the new object
 */
- (id) initWithData:(NSData*)inFileData withName:(NSString*)paramName withFileName:(NSString*) inFileName compressFile:(bool)compress;

@end
