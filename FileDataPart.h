//
//  Created by Lolay, Inc.
//  Copyright 2011 Lolay, Inc. All rights reserved.
//
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
