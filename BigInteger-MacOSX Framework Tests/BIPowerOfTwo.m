//
//  BIPowerOfTwo.m
//  BigInteger
//
//  Created by C.W. Betts on 3/2/15.
//  Copyright (c) 2015 Æquans. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import <BigInteger/BigInteger.h>
#import "private.h"

@interface BIPowerOfTwo : XCTestCase

@end

@implementation BIPowerOfTwo

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//--------------------------------------------------------------
// Tests the PowerOfTwo internal function.
//--------------------------------------------------------------

- (void)testPowerOfTwo
{
	BIGINT			bn, bm;
	bigint_digit	d;
	
	bm.length = bm.alloc = 1;
	bm.digits = &d;
	d = 17;
	
	for (int i = 0; i < 31; i++)
	{
		bigint_init32(&bn, 1 << i, NO);
		XCTAssert(bigint_is_power_of_two(&bn) == i);
		bigint_shift_left(&bn, &bn, 79);
		XCTAssert(bigint_is_power_of_two(&bn) == i + 79);
		bigint_add_magnitude(&bn, &bn, &bm);
		XCTAssert(bigint_is_power_of_two(&bn) == -1);
		bigint_free(&bn);
		
		bigint_init32(&bn, (1 << i) + 13, NO);
		XCTAssert(bigint_is_power_of_two(&bn) == -1);
		bigint_free(&bn);
	}
}

@end
