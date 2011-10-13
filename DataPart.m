//
//  DataPart.m
//  Where
//
//  Created by Bardia Dejban on 10/1/10.
//  Copyright 2010 Lolay, Inc. All rights reserved.
//

#import "DataPart.h"

@implementation DataPart

- (id) initWithParameter:(NSData*)valueData withName:(NSString*)valueKey {
	self = [super init];
	
	if (self != nil) {
		key = valueKey;
		value = valueData;
	}
	
	return self;
}

+(DataPart*) dataPartWithParameter:(NSData*)valueData withName:(NSString*)valueKey {
	return [[DataPart alloc] initWithParameter:valueData withName:valueKey];
}

- (void)appendData:(NSMutableData*)outputData {
	[outputData appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n"] dataUsingEncoding:encoding]];
	[outputData appendData:[[NSString stringWithString:@"Content-Transfer-Encoding: binary\r\n"] dataUsingEncoding:encoding]];
	[outputData appendData:[[NSString stringWithFormat:@"Content-ID: <%@>\r\n\r\n",key] dataUsingEncoding:encoding]];
	[outputData appendData:[NSData dataWithData:value]];
	[outputData appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:encoding]];
}

@end
