/**
 @file LFCGzipUtility.h
 
 Note: The code in this file has been commented so as to be compatible with
 Doxygen, a tool for automatically generating HTML-based documentation from
 source code. See http://www.doxygen.org for more info.
 
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
#import "zlib.h"

/**
 * This class can be used to compress a NSData object using gzip compression
 * @author Clint Harris (www.clintharris.net) (modified by Scott Slaugh)
 */
@interface HttpClientGzipUtility : NSObject
{
	
}

/***************************************************************************//**
 Uses zlib to compress the given data. Note that gzip headers will be added so
 that the data can be easily decompressed using a tool like WinZip, gunzip, etc.
 
 Note: Special thanks to Robbie Hanson of Deusty Designs for sharing sample code
 showing how deflateInit2() can be used to make zlib generate a compressed file
 with gzip headers:
 http://deusty.blogspot.com/2007/07/gzip-compressiondecompression.html
 
 @param pUncompressedData memory buffer of bytes to compress
 @return Compressed data as an NSData object
 */
+(NSData*) gzipData: (NSData*)pUncompressedData;

@end