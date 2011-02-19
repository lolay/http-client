//
//  DataPart.h
//  Where
//
//  Created by Bardia Dejban on 10/1/10.
//  Copyright 2010 Lolay, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Part.h"
#import "Constants.h"

@interface DataPart : NSObject <Part> {
	NSData* value;
	NSString* key;
}

- (id) initWithParameter:(NSData*)valueData withName:(NSString*)valueKey;

+(DataPart*) dataPartWithParameter:(NSData*)valueData withName:(NSString*)valueKey;


@end
