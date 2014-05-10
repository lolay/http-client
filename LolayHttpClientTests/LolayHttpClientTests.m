//
//  LolayHttpClientTests.m
//  LolayHttpClientTests
//
//  Created by Bruce Johnson on 5/10/14.
//  Copyright (c) 2014 Lolay. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BasicMethod.h"

@interface LolayHttpClientTests : XCTestCase

@property (nonatomic, readwrite, strong) BasicMethod *basicMethod;

@end

@implementation LolayHttpClientTests

- (void)setUp
{
    [super setUp];
	self.basicMethod = [[BasicMethod alloc] init];
	[self.basicMethod addParameter: @"Key" withName: @"Value"];
}

- (void)tearDown
{
	self.basicMethod = nil;
    [super tearDown];
}

- (void)testHttpClient
{
	XCTAssertNotNil(self.basicMethod.parameters, @"Basic Method Parameters Nil value.");
}

@end
