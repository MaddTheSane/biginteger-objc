//
//  BigInteger_MacOSX_Framework_Tests.m
//  BigInteger-MacOSX Framework Tests
//
//  Created by C.W. Betts on 3/2/15.
//  Copyright (c) 2015 Æquans. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <BigInteger/BigInteger.h>
#import <XCTest/XCTest.h>

@interface BigInteger_UnitTesting : XCTestCase

@end

@implementation BigInteger_UnitTesting

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//--------------------------------------------------------------
// Tests initialisation and conversion functions.
//--------------------------------------------------------------

- (void)testInit
{
	BigInteger    * bi, * bj;
	uint8_t			buf[8];
	
	bi = [[BigInteger alloc] initWithInt32:0];
	bj = [[BigInteger alloc] initWithString:@"0" radix:10];
	XCTAssert([[bi description] isEqualToString:@"00"]);
	XCTAssert([[bi toRadix:10] isEqualToString:@"0"]);
	XCTAssert([[bi toRadix:16] isEqualToString:@"0"]);
	XCTAssert([bi intValue] == 0);
	XCTAssert([bi longValue] == 0ll);
	XCTAssert([bi compare:bj] == NSOrderedSame);
	XCTAssert([bi hash] == [bj hash]);
	XCTAssert([bi sign] == 0);
	XCTAssert([bi isZero]);
	
	bi = [[BigInteger alloc] initWithInt32:1];
	bj = [[BigInteger alloc] initWithString:@"1" radix:10];
	XCTAssert([[bi description] isEqualToString:@"01"]);
	XCTAssert([[bi toRadix:10] isEqualToString:@"1"]);
	XCTAssert([[bi toRadix:16] isEqualToString:@"1"]);
	XCTAssert([bi intValue] == 1);
	XCTAssert([bi longValue] == 1ll);
	XCTAssert([bi compare:bj] == NSOrderedSame);
	XCTAssert([bi hash] == [bj hash]);
	XCTAssert(![bi isZero]);
	
	bi = [[BigInteger alloc] initWithInt32:-1];
	bj = [[BigInteger alloc] initWithString:@"-1" radix:10];
	XCTAssert([[bi description] isEqualToString:@"- 01"]);
	XCTAssert([[bi toRadix:10] isEqualToString:@"-1"]);
	XCTAssert([[bi toRadix:16] isEqualToString:@"-1"]);
	XCTAssert([bi intValue] == -1);
	XCTAssert([bi longValue] == -1ll);
	XCTAssert([bi compare:bj] == NSOrderedSame);
	XCTAssert([bi hash] == [bj hash]);
	XCTAssert([bi sign] == -1);
	XCTAssert(![bi isZero]);
	
	bi = [[BigInteger alloc] initWithInt32:1234567890];
	bj = [[BigInteger alloc] initWithString:@"42410440203" radix:7];
	XCTAssert([[bi description] isEqualToString:@"49 96 02 D2"]);
	XCTAssert([[bi toRadix:10] isEqualToString:@"1234567890"]);
	XCTAssert([[bi toRadix:16] isEqualToString:@"499602D2"]);
	XCTAssert([bi intValue] == 1234567890);
	XCTAssert([bi longValue] == 1234567890ll);
	XCTAssert([bi compare:bj] == NSOrderedSame);
	XCTAssert([bi hash] == [bj hash]);
	XCTAssert([bi sign] == 1);
	XCTAssert(![bi isZero]);
	
	bi = [[BigInteger alloc] initWithInt32:-1234567890];
	bj = [[BigInteger alloc] initWithString:@"-42410440203" radix:7];
	XCTAssert([[bi description] isEqualToString:@"- 49 96 02 D2"]);
	XCTAssert([[bi toRadix:10] isEqualToString:@"-1234567890"]);
	XCTAssert([[bi toRadix:16] isEqualToString:@"-499602D2"]);
	XCTAssert([bi intValue] == -1234567890);
	XCTAssert([bi longValue] == -1234567890ll);
	XCTAssert([bi compare:bj] == NSOrderedSame);
	XCTAssert([bi hash] == [bj hash]);
	XCTAssert([bi sign] == -1);
	XCTAssert(![bi isZero]);
	
	bi = [[BigInteger alloc] initWithUnsignedInt32:3147483647];
	bj = [[BigInteger alloc] initWithString:@"CM7DNKM" radix:25];
	XCTAssert([[bi description] isEqualToString:@"BB 9A C9 FF"]);
	XCTAssert([[bi toRadix:10] isEqualToString:@"3147483647"]);
	XCTAssert([[bi toRadix:13] isEqualToString:@"3B2111C79"]);
	XCTAssert([bi longValue] == 3147483647ll);
	XCTAssert([bi compare:bj] == NSOrderedSame);
	XCTAssert([bi hash] == [bj hash]);
	XCTAssert([bi sign] == 1);
	XCTAssert(![bi isZero]);
	
	bi = [[BigInteger alloc] initWithInt32:INT32_MIN];
	XCTAssert([[bi description] isEqualToString:@"- 80 00 00 00"]);
	XCTAssert([bi intValue] == INT32_MIN);
	
	bi = [[BigInteger alloc] initWithInt32:INT32_MAX];
	XCTAssert([[bi description] isEqualToString:@"7F FF FF FF"]);
	XCTAssert([bi intValue] == INT32_MAX);
	
	bi = [[BigInteger alloc] initWithInt32:-9876543];
	bj = [bi copy];
	XCTAssert([bi compare:bj] == NSOrderedSame);
	bj = [[BigInteger alloc] initWithBigInteger:bi];
	XCTAssert([bi compare:bj] == NSOrderedSame);
	
	bi = [[BigInteger alloc] initWithString:@"9990454997" radix:10];
	XCTAssert([bi longValue] == 9990454997ll);
	XCTAssert([[bi description] isEqualToString:@"02 53 7A 3E D5"]);
	XCTAssert([[bi toRadix:2] isEqualToString:@"1001010011011110100011111011010101"]);
	XCTAssert([[bi toRadix:3] isEqualToString:@"221210020210200211202"]);
	XCTAssert([[bi toRadix:4] isEqualToString:@"21103132203323111"]);
	XCTAssert([[bi toRadix:5] isEqualToString:@"130430024024442"]);
	XCTAssert([[bi toRadix:6] isEqualToString:@"4331202042245"]);
	XCTAssert([[bi toRadix:7] isEqualToString:@"502400315645"]);
	XCTAssert([[bi toRadix:8] isEqualToString:@"112336437325"]);
	XCTAssert([[bi toRadix:9] isEqualToString:@"27706720752"]);
	XCTAssert([[bi toRadix:10] isEqualToString:@"9990454997"]);
	XCTAssert([[bi toRadix:11] isEqualToString:@"4267395786"]);
	XCTAssert([[bi toRadix:12] isEqualToString:@"1B29949385"]);
	XCTAssert([[bi toRadix:13] isEqualToString:@"C32A27A43"]);
	XCTAssert([[bi toRadix:14] isEqualToString:@"6AAB9A525"]);
	XCTAssert([[bi toRadix:15] isEqualToString:@"3D7124C32"]);
	XCTAssert([[bi toRadix:16] isEqualToString:@"2537A3ED5"]);
	XCTAssert([[bi toRadix:20] isEqualToString:@"7G206H9H"]);
	XCTAssert([[bi toRadix:36] isEqualToString:@"4L824ET"]);
	[bi getBytes:buf length:8];
	XCTAssert(memcmp(buf, "\xD5\x3E\x7A\x53\x02\x00\x00\x00", 8) == 0);
	
	XCTAssert([[[BigInteger bigintWithString:@"1001010011011110100011111011010101" radix:2] description] isEqualToString:@"02 53 7A 3E D5"]);
	XCTAssert([[[BigInteger bigintWithString:@"221210020210200211202" radix:3] description] isEqualToString:@"02 53 7A 3E D5"]);
	XCTAssert([[[BigInteger bigintWithString:@"21103132203323111" radix:4] description] isEqualToString:@"02 53 7A 3E D5"]);
	XCTAssert([[[BigInteger bigintWithString:@"130430024024442" radix:5] description] isEqualToString:@"02 53 7A 3E D5"]);
	XCTAssert([[[BigInteger bigintWithString:@"4331202042245" radix:6] description] isEqualToString:@"02 53 7A 3E D5"]);
	XCTAssert([[[BigInteger bigintWithString:@"502400315645" radix:7] description] isEqualToString:@"02 53 7A 3E D5"]);
	XCTAssert([[[BigInteger bigintWithString:@"112336437325" radix:8] description] isEqualToString:@"02 53 7A 3E D5"]);
	XCTAssert([[[BigInteger bigintWithString:@"27706720752" radix:9] description] isEqualToString:@"02 53 7A 3E D5"]);
	XCTAssert([[[BigInteger bigintWithString:@"9990454997" radix:10] description] isEqualToString:@"02 53 7A 3E D5"]);
	XCTAssert([[[BigInteger bigintWithString:@"4267395786" radix:11] description] isEqualToString:@"02 53 7A 3E D5"]);
	XCTAssert([[[BigInteger bigintWithString:@"1B29949385" radix:12] description] isEqualToString:@"02 53 7A 3E D5"]);
	XCTAssert([[[BigInteger bigintWithString:@"C32A27A43" radix:13] description] isEqualToString:@"02 53 7A 3E D5"]);
	XCTAssert([[[BigInteger bigintWithString:@"6AAB9A525" radix:14] description] isEqualToString:@"02 53 7A 3E D5"]);
	XCTAssert([[[BigInteger bigintWithString:@"3D7124C32" radix:15] description] isEqualToString:@"02 53 7A 3E D5"]);
	XCTAssert([[[BigInteger bigintWithString:@"2537A3ED5" radix:16] description] isEqualToString:@"02 53 7A 3E D5"]);
	XCTAssert([[[BigInteger bigintWithString:@"7G206H9H" radix:20] description] isEqualToString:@"02 53 7A 3E D5"]);
	XCTAssert([[[BigInteger bigintWithString:@"4L824ET" radix:36] description] isEqualToString:@"02 53 7A 3E D5"]);
}

//--------------------------------------------------------------
// Tests archiving and unarchiving.
//--------------------------------------------------------------

- (void)testArchiver
{
	static uint8_t	test[] =
	{
		0x62, 0x70, 0x6C, 0x69, 0x73, 0x74, 0x30, 0x30, 0xD4, 0x01, 0x02, 0x03, 0x04, 0x05, 0x0C, 0x0E,
		0x0F, 0x54, 0x24, 0x74, 0x6F, 0x70, 0x58, 0x24, 0x6F, 0x62, 0x6A, 0x65, 0x63, 0x74, 0x73, 0x58,
		0x24, 0x76, 0x65, 0x72, 0x73, 0x69, 0x6F, 0x6E, 0x59, 0x24, 0x61, 0x72, 0x63, 0x68, 0x69, 0x76,
		0x65, 0x72, 0xD3, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x56, 0x64, 0x69, 0x67, 0x69, 0x74, 0x73,
		0x54, 0x73, 0x69, 0x67, 0x6E, 0x56, 0x6C, 0x65, 0x6E, 0x67, 0x74, 0x68, 0x44, 0xD2, 0x02, 0x96,
		0x49, 0x08, 0x10, 0x04, 0xA1, 0x0D, 0x55, 0x24, 0x6E, 0x75, 0x6C, 0x6C, 0x12, 0x00, 0x01, 0x86,
		0xA0, 0x5F, 0x10, 0x0F, 0x4E, 0x53, 0x4B, 0x65, 0x79, 0x65, 0x64, 0x41, 0x72, 0x63, 0x68, 0x69,
		0x76, 0x65, 0x72, 0x08, 0x11, 0x16, 0x1F, 0x28, 0x32, 0x39, 0x40, 0x45, 0x4C, 0x51, 0x52, 0x54,
		0x56, 0x5C, 0x61, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x73
	};
	
	NSKeyedArchiver		* arch;
	NSKeyedUnarchiver	* unarch;
	NSMutableData		* data;
	BigInteger			* r;
	
	data = [[NSMutableData alloc] initWithCapacity:100];
	arch = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
	[arch encodeObject:[BigInteger bigintWithInt32:0] forKey:@"r1"];
	[arch encodeObject:[BigInteger bigintWithInt32:-1] forKey:@"r2"];
	[arch encodeObject:[BigInteger bigintWithInt32:0x123] forKey:@"r3"];
	[arch encodeObject:[BigInteger bigintWithInt32:0x1234] forKey:@"r4"];
	[arch encodeObject:[BigInteger bigintWithInt32:0x12345] forKey:@"r5"];
	[arch encodeObject:[BigInteger bigintWithInt32:0x123456] forKey:@"r6"];
	[arch encodeObject:[BigInteger bigintWithInt32:0x1234567] forKey:@"r7"];
	[arch encodeObject:[BigInteger bigintWithInt32:0x12345678] forKey:@"r8"];
	[arch finishEncoding];
	unarch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
	XCTAssert([[unarch decodeObjectForKey:@"r1"] intValue] == 0);
	XCTAssert([[unarch decodeObjectForKey:@"r2"] intValue] == -1);
	XCTAssert([[unarch decodeObjectForKey:@"r3"] intValue] == 0x123);
	XCTAssert([[unarch decodeObjectForKey:@"r4"] intValue] == 0x1234);
	XCTAssert([[unarch decodeObjectForKey:@"r5"] intValue] == 0x12345);
	XCTAssert([[unarch decodeObjectForKey:@"r6"] intValue] == 0x123456);
	XCTAssert([[unarch decodeObjectForKey:@"r7"] intValue] == 0x1234567);
	XCTAssert([[unarch decodeObjectForKey:@"r8"] intValue] == 0x12345678);
	
	data = [[NSMutableData alloc] initWithBytes:test length:sizeof(test)];
	unarch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
	r = [[BigInteger alloc] initWithCoder:unarch];
	XCTAssert([r intValue] == 1234567890);
}

//--------------------------------------------------------------
// Tests the comparison functions.
//--------------------------------------------------------------

- (void)testCompare
{
	BigInteger	* samples[9];
	BigInteger	* bi, * bj;
	int			  i, j;
	
	samples[0] = [[BigInteger alloc] initWithString:@"-1234567890123456789" radix:10];
	samples[1] = [[BigInteger alloc] initWithInt32:-2000000];
	samples[2] = [[BigInteger alloc] initWithInt32:-50000];
	samples[3] = [[BigInteger alloc] initWithInt32:-1];
	samples[4] = [[BigInteger alloc] initWithInt32:0];
	samples[5] = [[BigInteger alloc] initWithInt32:1];
	samples[6] = [[BigInteger alloc] initWithInt32:50000];
	samples[7] = [[BigInteger alloc] initWithInt32:2000000];
	samples[8] = [[BigInteger alloc] initWithString:@"1234567890123456789" radix:10];
	
	for (i = 0; i < sizeof(samples) / sizeof(samples[0]); i++)
	{
		bi = samples[i];
		for (j = 0; j < sizeof(samples) / sizeof(samples[0]); j++)
		{
			bj = samples[j];
			if (i < j)
			{
				XCTAssert([bi compare:bj] == NSOrderedAscending);
				XCTAssert([bi hash] != [bj hash]);
				XCTAssert([bi isEqualToBigInteger:bj] == NO);
				XCTAssert([bi isEqual:bj] == NO);
			}
			else if (i > j)
			{
				XCTAssert([bi compare:bj] == NSOrderedDescending);
				XCTAssert([bi hash] != [bj hash]);
				XCTAssert([bi isEqualToBigInteger:bj] == NO);
				XCTAssert([bi isEqual:bj] == NO);
			}
			else
			{
				XCTAssert([bi compare:bj] == NSOrderedSame);
				XCTAssert([bi hash] == [bj hash]);
				XCTAssert([bi isEqualToBigInteger:bj] != NO);
				XCTAssert([bi isEqual:bj] != NO);
			}
		}
	}
	
	for (i = 0; i < sizeof(samples) / sizeof(samples[0]); i++) samples[i] = nil;
}

//--------------------------------------------------------------
// Tests the Sign, Abs, Negate, Odd and Even functions.
//--------------------------------------------------------------

- (void)testSignAbs
{
	XCTAssert([[BigInteger bigintWithInt32:-1234567] sign] == -1);
	XCTAssert([[BigInteger bigintWithInt32:-1] sign] == -1);
	XCTAssert([[BigInteger bigintWithInt32:0] sign] == 0);
	XCTAssert([[BigInteger bigintWithInt32:1] sign] == 1);
	XCTAssert([[BigInteger bigintWithInt32:1234567] sign] == 1);
	
	XCTAssert([[[BigInteger bigintWithInt32:-1234567] abs] intValue] == 1234567);
	XCTAssert([[[BigInteger bigintWithInt32:-1] abs] intValue] == 1);
	XCTAssert([[[BigInteger bigintWithInt32:0] abs] intValue] == 0);
	XCTAssert([[[BigInteger bigintWithInt32:1] abs] intValue] == 1);
	XCTAssert([[[BigInteger bigintWithInt32:1234567] abs] intValue] == 1234567);
	
	XCTAssert([[[BigInteger bigintWithInt32:-1234567] negate] intValue] == 1234567);
	XCTAssert([[[BigInteger bigintWithInt32:-1] negate] intValue] == 1);
	XCTAssert([[[BigInteger bigintWithInt32:0] negate] intValue] == 0);
	XCTAssert([[[BigInteger bigintWithInt32:1] negate] intValue] == -1);
	XCTAssert([[[BigInteger bigintWithInt32:1234567] negate] intValue] == -1234567);
	
	XCTAssert([[BigInteger bigintWithInt32:0] isOdd] == NO);
	XCTAssert([[BigInteger bigintWithInt32:1] isOdd] == YES);
	XCTAssert([[BigInteger bigintWithInt32:2] isOdd] == NO);
	XCTAssert([[BigInteger bigintWithInt32:3] isOdd] == YES);
	XCTAssert([[BigInteger bigintWithInt32:4] isOdd] == NO);
	XCTAssert([[BigInteger bigintWithInt32:1234565] isOdd] == YES);
	XCTAssert([[BigInteger bigintWithInt32:1234566] isOdd] == NO);
	
	XCTAssert([[BigInteger bigintWithInt32:0] isEven] == YES);
	XCTAssert([[BigInteger bigintWithInt32:1] isEven] == NO);
	XCTAssert([[BigInteger bigintWithInt32:2] isEven] == YES);
	XCTAssert([[BigInteger bigintWithInt32:3] isEven] == NO);
	XCTAssert([[BigInteger bigintWithInt32:4] isEven] == YES);
	XCTAssert([[BigInteger bigintWithInt32:1234565] isEven] == NO);
	XCTAssert([[BigInteger bigintWithInt32:1234566] isEven] == YES);
}

//--------------------------------------------------------------
// Tests the Add, Sub, Mul and MulMod functions.
//--------------------------------------------------------------

- (void)testAddSubMul
{
	BigInteger	  * samples[17];
	BigInteger	  * bi, * bj, * br, * mod;
	int64_t			res;
	int				i, j;
	
	samples[0] = [[BigInteger alloc] initWithInt32:-1234567];
	samples[1] = [[BigInteger alloc] initWithInt32:-65537];
	samples[2] = [[BigInteger alloc] initWithInt32:-65536];
	samples[3] = [[BigInteger alloc] initWithInt32:-65535];
	samples[4] = [[BigInteger alloc] initWithInt32:-23459];
	samples[5] = [[BigInteger alloc] initWithInt32:-17];
	samples[6] = [[BigInteger alloc] initWithInt32:-2];
	samples[7] = [[BigInteger alloc] initWithInt32:-1];
	samples[8] = [[BigInteger alloc] initWithInt32:0];
	samples[9] = [[BigInteger alloc] initWithInt32:1];
	samples[10] = [[BigInteger alloc] initWithInt32:2];
	samples[11] = [[BigInteger alloc] initWithInt32:17];
	samples[12] = [[BigInteger alloc] initWithInt32:23459];
	samples[13] = [[BigInteger alloc] initWithInt32:65535];
	samples[14] = [[BigInteger alloc] initWithInt32:65536];
	samples[15] = [[BigInteger alloc] initWithInt32:65537];
	samples[16] = [[BigInteger alloc] initWithInt32:1234567];
	
	mod = [[BigInteger alloc] initWithInt32:76537];
	
	for (i = 0; i < sizeof(samples) / sizeof(samples[0]); i++)
	{
		bi = samples[i];
		for (j = 0; j < sizeof(samples) / sizeof(samples[0]); j++)
		{
			bj = samples[j];
			
			br = [bi add:bj];
			XCTAssert([br intValue] == [bi intValue] + [bj intValue]);
			
			br = [bi sub:bj];
			XCTAssert([br intValue] == [bi intValue] - [bj intValue]);
			
			br = [bi multiply:bj];
			XCTAssert([br longValue] == [bi longValue] * [bj longValue]);
			
			br = [bi multiply:bj modulo:mod];
			res = ([bi longValue] * [bj longValue]) % [mod longValue];
			if (res < 0) res += [mod longValue];
			XCTAssert([br longValue] == res);
		}
	}
	
	for (i = 0; i < sizeof(samples) / sizeof(samples[0]); i++) samples[i] = nil;
}

//--------------------------------------------------------------
// Tests large multiplications (Karatsuba)
//--------------------------------------------------------------

- (void)testLargeMul
{
	BigInteger * bi, * bj, * bk, * br, * bs, * bd;
	
	for (int i = 10; i <= 10240; i *= 2)
	{
		@autoreleasepool
		{
			for (int j = 0; j < 200; j++)
			{
				bi = [[BigInteger alloc] initWithRandomNumberOfSize:i exact:YES];
				bj = [[BigInteger alloc] initWithRandomNumberOfSize:i exact:YES];
				bk = [[BigInteger alloc] initWithRandomNumberOfSize:(i >> 1) exact:YES];
				
				br = [bi multiply:bj];
				bs = [bj multiply:bi];
				XCTAssert([br isEqualToBigInteger:bs]);
				bd = [br divide:bi];
				XCTAssert([bd isEqualToBigInteger:bj]);
				
				br = [bi multiply:bk];
				bs = [bk multiply:bi];
				XCTAssert([br isEqualToBigInteger:bs]);
				bd = [br divide:bi];
				XCTAssert([bd isEqualToBigInteger:bk]);
			}
		}
	}
	
	bi = [[BigInteger alloc] initWithString:@"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF" radix:16];
	bj = [[BigInteger alloc] initWithString:@"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF" radix:16];
	br = [bi multiply:bj];
	bs = [bj multiply:bi];
	XCTAssert([br isEqualToBigInteger:bs]);
	XCTAssert([[br toRadix:10] isEqualToString:@"115792089237316195423570985008687907852589419931798687112530834793049593217025"]);
}

//--------------------------------------------------------------
// Tests the ShiftLeft and ShiftRight functions.
//--------------------------------------------------------------

- (void)testShift
{
	static int offset[] = { 1, 5, 16, 32 };
	
	int64_t t1 = 165;
	BigInteger * r1 = [BigInteger bigintWithInt32:(int32_t) t1];
	
	int64_t t2 = -90;
	BigInteger * r2 = [BigInteger bigintWithInt32:(int32_t) t2];
	
	for (int i = 0; i < sizeof(offset) / sizeof(offset[0]); i++)
	{
		int k = offset[i];
		
		t1 <<= k;
		r1 = [r1 shiftLeft:k];
		XCTAssert(t1 == [r1 longValue]);
		
		t2 <<= k;
		r2 = [r2 shiftLeft:k];
		XCTAssert(t2 == [r2 longValue]);
	}
	
	for (int i = 0; i < sizeof(offset) / sizeof(offset[0]); i++)
	{
		int k = offset[i];
		
		t1 >>= k;
		r1 = [r1 shiftRight:k];
		XCTAssert(t1 == [r1 longValue]);
		
		t2 >>= k;
		r2 = [r2 shiftRight:k];
		XCTAssert(t2 == [r2 longValue]);
	}
	
	XCTAssert(t1 == 165);
	XCTAssert(t2 == -90);
	
	XCTAssert([[[BigInteger bigintWithInt32:15] shiftRight:3] intValue] == 1);
	XCTAssert([[[BigInteger bigintWithInt32:15] shiftRight:4] intValue] == 0);
	XCTAssert([[[BigInteger bigintWithInt32:15] shiftRight:5] intValue] == 0);
	XCTAssert([[[BigInteger bigintWithInt32:15] shiftRight:100] intValue] == 0);
}

//--------------------------------------------------------------
// Tests the Divide function.
//--------------------------------------------------------------

- (void)testDivide
{
	BigInteger * samples[15];
	BigInteger * bi, * bj, * bq, * br;
	
	samples[0] = [[BigInteger alloc] initWithInt32:-1114129];
	samples[1] = [[BigInteger alloc] initWithInt32:-65537];
	samples[2] = [[BigInteger alloc] initWithInt32:-65536];
	samples[3] = [[BigInteger alloc] initWithInt32:-23459];
	samples[4] = [[BigInteger alloc] initWithInt32:-17];
	samples[5] = [[BigInteger alloc] initWithInt32:-2];
	samples[6] = [[BigInteger alloc] initWithInt32:-1];
	samples[7] = [[BigInteger alloc] initWithInt32:0];
	samples[8] = [[BigInteger alloc] initWithInt32:1];
	samples[9] = [[BigInteger alloc] initWithInt32:2];
	samples[10] = [[BigInteger alloc] initWithInt32:17];
	samples[11] = [[BigInteger alloc] initWithInt32:23459];
	samples[12] = [[BigInteger alloc] initWithInt32:65536];
	samples[13] = [[BigInteger alloc] initWithInt32:65537];
	samples[14] = [[BigInteger alloc] initWithInt32:1114129];
	
	for (int i = 0; i < sizeof(samples) / sizeof(samples[0]); i++)
	{
		bi = samples[i];
		if ([bi intValue] != 0)
		{
			for (int j = 0; j < sizeof(samples) / sizeof(samples[0]); j++)
			{
				bj = samples[j];
				
				bq = [bj divide:bi remainder:&br];
				XCTAssert([bq intValue] == [bj intValue] / [bi intValue]);
				XCTAssert([br intValue] == [bj intValue] % [bi intValue]);
				
				bq = [bj divide:bi];
				XCTAssert([bq intValue] == [bj intValue] / [bi intValue]);
			}
		}
	}
	
	for (int i = 0; i < sizeof(samples) / sizeof(samples[0]); i++) samples[i] = nil;
}

//--------------------------------------------------------------
// Tests the bitwise operation functions.
//--------------------------------------------------------------

- (void)testBitwiseOperation
{
	BigInteger	* samples[9] = {0};
	BigInteger	* bi, * bj, * br;
	
	samples[0] = [[BigInteger alloc] initWithInt32:0];
	samples[1] = [[BigInteger alloc] initWithInt32:1];
	samples[2] = [[BigInteger alloc] initWithInt32:2];
	samples[3] = [[BigInteger alloc] initWithInt32:17];
	samples[4] = [[BigInteger alloc] initWithInt32:23459];
	samples[5] = [[BigInteger alloc] initWithInt32:65535];
	samples[6] = [[BigInteger alloc] initWithInt32:65536];
	samples[7] = [[BigInteger alloc] initWithInt32:65537];
	samples[8] = [[BigInteger alloc] initWithInt32:1234567];
	
	XCTAssert([samples[0] bitCount] == 0);
	XCTAssert([samples[1] bitCount] == 1);
	XCTAssert([samples[2] bitCount] == 2);
	XCTAssert([samples[3] bitCount] == 5);
	XCTAssert([samples[4] bitCount] == 15);
	XCTAssert([samples[5] bitCount] == 16);
	XCTAssert([samples[6] bitCount] == 17);
	XCTAssert([samples[7] bitCount] == 17);
	XCTAssert([samples[8] bitCount] == 21);
	
	for (int i = 0; i < sizeof(samples) / sizeof(samples[0]); i++)
	{
		bi = samples[i];
		
		XCTAssert([[bi bitwiseNotUsingWidth:30] longValue] == ((~[bi longValue]) & 0x000000003FFFFFFF));
		XCTAssert([[bi bitwiseNotUsingWidth:32] longValue] == ((~[bi longValue]) & 0x00000000FFFFFFFF));
		XCTAssert([[bi bitwiseNotUsingWidth:48] longValue] == ((~[bi longValue]) & 0x0000FFFFFFFFFFFF));
		
		for (int j = 0; j < sizeof(samples) / sizeof(samples[0]); j++)
		{
			bj = samples[j];
			
			br = [bi bitwiseAnd:bj];
			XCTAssert([br intValue] == ([bi intValue] & [bj intValue]));
			
			br = [bi bitwiseOr:bj];
			XCTAssert([br intValue] == ([bi intValue] | [bj intValue]));
			
			br = [bi bitwiseXor:bj];
			XCTAssert([br intValue] == ([bi intValue] ^ [bj intValue]));
		}
	}
	
	for (int i = 0; i < sizeof(samples) / sizeof(samples[0]); i++) samples[i] = nil;
	
	bi = [[BigInteger alloc] initWithString:@"55555555555555555555555555555F" radix:16];
	bj = [[BigInteger alloc] initWithString:@"000000000000000AAAAAAAAAAAAAAA" radix:16];
	
	XCTAssert([bi bitCount] == 119);
	XCTAssert([bj bitCount] == 60);
	
	XCTAssert([[[bi bitwiseAnd:bj] toRadix:16] isEqualToString:@"A"]);
	XCTAssert([[[bi bitwiseOr:bj] toRadix:16] isEqualToString:@"555555555555555FFFFFFFFFFFFFFF"]);
	XCTAssert([[[bi bitwiseXor:bj] toRadix:16] isEqualToString:@"555555555555555FFFFFFFFFFFFFF5"]);
}

//--------------------------------------------------------------
// Tests the Divide function for powers of two.
//--------------------------------------------------------------

- (void)testRemPow2
{
	BigInteger	* n, * d, * r, * q;
	
	n = [[BigInteger alloc] initWithUnsignedInt32:0xFFFFFFFF];
	
	for (int i = 0; i < 60; i++)
	{
		d = [[BigInteger bigintWithInt32:1] shiftLeft:i];
		q = [n divide:d remainder:&r];
		
		uint64_t t = 0xFFFFFFFF;
		if (![q isZero]) t &= (1ull << i) - 1ull;
		
		XCTAssert([r longValue] == t);
	}
}

//--------------------------------------------------------------
// Tests the Exp and ExpMod functions.
//--------------------------------------------------------------

- (void)testExp
{
	int32_t	val[] = { -3, -2, -1, 1, 3, 4 };
	
	for (int i = 0; i < sizeof(val) / sizeof(val[0]); i++)
	{
		BigInteger * r = [[BigInteger alloc] initWithInt32:val[i]];
		uint64_t t = 1;
		
		for (int j = 0; j < 30; j++)
		{
			XCTAssert([[r exp:j] longValue] == t);
			t = t * [r longValue];
		}
	}
	
	XCTAssert([[[[BigInteger bigintWithInt32:23] exp:20] toRadix:10] isEqualToString:@"1716155831334586342923895201"]);
	XCTAssert([[[BigInteger bigintWithInt32:4] exp:[BigInteger bigintWithInt32:13] modulo:[BigInteger bigintWithInt32:497]] intValue] == 445);
	XCTAssert([[[BigInteger bigintWithInt32:23] exp:[BigInteger bigintWithInt32:20] modulo:[BigInteger bigintWithInt32:29]] intValue] == 24);
	XCTAssert([[[BigInteger bigintWithInt32:-23] exp:[BigInteger bigintWithInt32:20] modulo:[BigInteger bigintWithInt32:29]] intValue] == 24);
	XCTAssert([[[BigInteger bigintWithInt32:23] exp:[BigInteger bigintWithInt32:391] modulo:[BigInteger bigintWithInt32:55]] intValue] == 12);
	XCTAssert([[[BigInteger bigintWithInt32:-23] exp:[BigInteger bigintWithInt32:391] modulo:[BigInteger bigintWithInt32:55]] intValue] == 43);
	XCTAssert([[[BigInteger bigintWithInt32:31] exp:[BigInteger bigintWithInt32:397] modulo:[BigInteger bigintWithInt32:55]] intValue] == 26);
	XCTAssert([[[BigInteger bigintWithInt32:-31] exp:[BigInteger bigintWithInt32:397] modulo:[BigInteger bigintWithInt32:55]] intValue] == 29);
}

//--------------------------------------------------------------
// Tests the primality functions.
//--------------------------------------------------------------

- (void)testPrime
{
	static int32_t	primes[] =
	{
		899809363, 899809369, 899809373, 899809451, 899809457, 899809487, 899809523, 899809553,
		899809571, 899809601, 899809633, 899809661, 899809663, 899809679, 899809681, 899809727,
		899809747, 899809777, 899809789, 899809793, 899809819, 899809829, 899809837, 899809843,
		899809853, 899809871, 899809879, 899809901, 899809913, 899809951, 899809997, 899810011,
		899810033, 899810047, 899810059, 899810069, 899810083, 899810089, 899810099, 899810137,
		899810167, 899810269, 899810279, 899810291, 899810333, 899810339, 899810399, 899810407,
		899810411, 899810413, 899810423, 899810447, 899810449, 899810453, 899810467, 899810479,
		899810501, 899810503, 899810507, 899810533, 899810537, 899810567, 899810581, 899810599,
		899810617, 899810633, 899810671, 899810689, 899810729, 899810749, 899810773, 899810777,
		899810789, 899810831, 899810843, 899810909, 899810953, 899810957, 899810971, 899810993,
		899811041, 899811047, 899811049, 899811109, 899811119, 899811127, 899811131, 899811169,
		899811181, 899811191, 899811223, 899811229, 899811247, 899811259, 899811277, 899811281,
		899811307, 899811317, 899811347, 899811361, 899811373, 899811403, 899811433, 899811457,
		899811469, 899811491, 899811511, 899811529, 899811533, 899811553, 899811571, 899811587,
		899811607, 899811617, 899811629, 899811641, 899811643, 899811667, 899811697, 899811719,
		899811743, 899811763, 899811827, 899811833, 899811839, 899811863, 899811877, 899811893,
		899811907, 899811919, 899811923, 899811947, 899811959, 899811961, 899811967, 899811973,
		899812007, 899812021, 899812033, 899812093, 899812099, 899812103, 899812129, 899812153,
		899812163, 899812201, 899812247, 899812253, 899812267, 899812273, 899812289, 899812313,
		899812421, 899812423, 899812427, 899812447, 899812457, 899812477, 899812483, 899812519,
		899812523, 899812547, 899812553, 899812591, 899812597, 899812633, 899812699, 899812709,
		899812723, 899812733, 899812741, 899812751, 899812759, 899812777, 899812787, 899812813,
		899812817, 899812829, 899812871, 899812909, 899812919, 899812943, 899812951, 899812961,
		899812973, 899812981, 899812999, 899813003, 899813021, 899813029, 899813053, 899813069,
		899813093, 899813119, 899813177, 899813197, 899813207, 899813219, 899813221, 899813263,
		899813273, 899813279, 899813297, 899813329, 899813333, 899813353, 899813357, 899813393,
		899813413, 899813441, 899813443, 899813461, 899813477, 899813483, 899813513, 899813531,
		899813539, 899813561, 899813573, 899813599, 899813617, 899813633, 899813737, 899813741,
		899813749, 899813801, 899813861, 899813891, 899813909, 899813917, 899813933, 899813947,
		899813969, 899814007, 899814011, 899814031, 899814043, 899814053, 899814101, 899814161,
		899814163, 899814193, 899814197, 899814247, 899814281, 899814287, 899814299, 899814313,
		899814319, 899814323, 899814341, 899814343, 899814373, 899814397, 899814439, 899814451,
		899814457, 899814481, 899814491, 899814497, 899814541, 899814551, 899814557, 899814569,
	};
	
	BigInteger	* p;
	
	XCTAssert([[BigInteger bigintWithInt32:0] isProbablePrime] == NO);
	XCTAssert([[BigInteger bigintWithInt32:1] isProbablePrime] == NO);
	XCTAssert([[BigInteger bigintWithInt32:2] isProbablePrime] == YES);
	XCTAssert([[BigInteger bigintWithInt32:3] isProbablePrime] == YES);
	XCTAssert([[BigInteger bigintWithInt32:4] isProbablePrime] == NO);
	
	for (int i = 5; i < 10000; i+= 2)
	{
		BOOL prime = YES;
		int n = (int) sqrt(i);
		for (int j = 3; j <= n; j++)
		{
			if ((i % j) == 0)
			{
				prime = NO;
				break;
			}
		}
		
		p = [[BigInteger alloc] initWithInt32:i];
		XCTAssert([p isProbablePrime] == prime);
		
		p = [[BigInteger alloc] initWithInt32:-i];
		XCTAssert([p isProbablePrime] == prime);
	}
	
	for (int i = 1; i < sizeof(primes) / sizeof(primes[0]); i++)
	{
		int32_t lo = primes[i - 1];
		int32_t hi = primes[i];
		
		p = [[BigInteger alloc] initWithInt32:lo];
		XCTAssert([p isProbablePrime] == YES);
		
		p = [[BigInteger alloc] initWithInt32:-lo];
		XCTAssert([p isProbablePrime] == YES);
		
		for (int32_t j = lo + 2; j < hi; j += 2)
		{
			p = [[BigInteger alloc] initWithInt32:j];
			XCTAssert([p isProbablePrime] == NO);
			
			p = [[BigInteger alloc] initWithInt32:-j];
			XCTAssert([p isProbablePrime] == NO);
		}
	}
	
	// Carmichael numbers
	
	XCTAssert([[BigInteger bigintWithString:@"8652633601" radix:10] isProbablePrime] == NO);
	XCTAssert([[BigInteger bigintWithString:@"856666552249" radix:10] isProbablePrime] == NO);
	XCTAssert([[BigInteger bigintWithString:@"906586515073" radix:10] isProbablePrime] == NO);
	XCTAssert([[BigInteger bigintWithString:@"910355497801" radix:10] isProbablePrime] == NO);
	XCTAssert([[BigInteger bigintWithString:@"915245066821" radix:10] isProbablePrime] == NO);
	XCTAssert([[BigInteger bigintWithString:@"923886372817" radix:10] isProbablePrime] == NO);
	XCTAssert([[BigInteger bigintWithString:@"949093499521" radix:10] isProbablePrime] == NO);
	XCTAssert([[BigInteger bigintWithString:@"949631589089" radix:10] isProbablePrime] == NO);
	XCTAssert([[BigInteger bigintWithString:@"957007656001" radix:10] isProbablePrime] == NO);
	XCTAssert([[BigInteger bigintWithString:@"961007056441" radix:10] isProbablePrime] == NO);
	XCTAssert([[BigInteger bigintWithString:@"961809124231" radix:10] isProbablePrime] == NO);
	XCTAssert([[BigInteger bigintWithString:@"975177403201" radix:10] isProbablePrime] == NO);
	XCTAssert([[BigInteger bigintWithString:@"980449623217" radix:10] isProbablePrime] == NO);
	XCTAssert([[BigInteger bigintWithString:@"994788345601" radix:10] isProbablePrime] == NO);
	
	XCTAssert([[[BigInteger bigintWithInt32:920419448] nextProbablePrime] intValue] == 920419469);
	XCTAssert([[[BigInteger bigintWithInt32:-920419448] nextProbablePrime] intValue] == -920419469);
	
	p = [[BigInteger alloc] initWithRandomNumberOfSize:200 exact:YES];
	[p nextProbablePrime];
}

//--------------------------------------------------------------
// Tests the Euclide's algorithm functions.
//--------------------------------------------------------------

- (void)testEuclide
{
	XCTAssert([[[BigInteger bigintWithInt32:48] greatestCommonDivisor:[BigInteger bigintWithInt32:180]] intValue] == 12);
	XCTAssert([[[BigInteger bigintWithInt32:180] greatestCommonDivisor:[BigInteger bigintWithInt32:48]] intValue] == 12);
	XCTAssert([[BigInteger bigintWithInt32:48] inverseModulo:[BigInteger bigintWithInt32:180]] == nil);
	XCTAssert([[BigInteger bigintWithInt32:180] inverseModulo:[BigInteger bigintWithInt32:48]] == nil);
	
	XCTAssert([[[BigInteger bigintWithInt32:1071] greatestCommonDivisor:[BigInteger bigintWithInt32:462]] intValue] == 21);
	XCTAssert([[[BigInteger bigintWithInt32:462] greatestCommonDivisor:[BigInteger bigintWithInt32:1071]] intValue] == 21);
	XCTAssert([[BigInteger bigintWithInt32:1071] inverseModulo:[BigInteger bigintWithInt32:462]] == nil);
	XCTAssert([[BigInteger bigintWithInt32:462] inverseModulo:[BigInteger bigintWithInt32:1071]] == nil);
	
	XCTAssert([[[BigInteger bigintWithString:@"8959335419" radix:10] greatestCommonDivisor:[BigInteger bigintWithString:@"7995879641" radix:10]] intValue] == 87317);
	XCTAssert([[[BigInteger bigintWithString:@"7995879641" radix:10] greatestCommonDivisor:[BigInteger bigintWithString:@"8959335419" radix:10]] intValue] == 87317);
	XCTAssert([[BigInteger bigintWithString:@"8959335419" radix:10] inverseModulo:[BigInteger bigintWithString:@"7995879641" radix:10]] == nil);
	XCTAssert([[BigInteger bigintWithString:@"7995879641" radix:10] inverseModulo:[BigInteger bigintWithString:@"8959335419" radix:10]] == nil);
	
	XCTAssert([[[BigInteger bigintWithInt32:23] inverseModulo:[BigInteger bigintWithInt32:97]] intValue] == 38);
	XCTAssert([[[BigInteger bigintWithInt32:1234] inverseModulo:[BigInteger bigintWithInt32:103969]] intValue] == 75070);
	XCTAssert([[[BigInteger bigintWithInt32:23456] inverseModulo:[BigInteger bigintWithInt32:104729]] intValue] == 52110);
}

//--------------------------------------------------------------
// Tests the randomize function.
//--------------------------------------------------------------

- (void)testRandom
{
	BigInteger	* r;
	
	for (int i = 8; i < 48; i++)
	{
		int64_t mask = (1ll << (int64_t) i) - 1ll;
		int64_t bit = 1ll << ((int64_t) i - 1ll);
		
		int k = 0;
		int64_t r1 = 0, r2 = 0;
		
		for (int j = 0; j < 50; j++)
		{
			r = [[BigInteger alloc] initWithRandomNumberOfSize:i exact:YES];
			XCTAssert(([r longValue] & bit) != 0);
			r1 |= [r longValue];
			
			r = [[BigInteger alloc] initWithRandomNumberOfSize:i exact:NO];
			if (([r longValue] & bit) != 0) k++;
			r2 |= [r longValue];
		}
		
		XCTAssert(r1 == mask);
		XCTAssert(r2 == mask);
		XCTAssert(k > 10 && k < 40);
	}
}

@end
