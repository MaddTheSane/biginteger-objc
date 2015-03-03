//========================================================================
// Mac OS X and iOS BigInteger Library
// Copyright (c) 2012 - 2015, Pascal Levy
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//========================================================================

#ifndef BIG_INTEGER_H
#define BIG_INTEGER_H

//--------------------------------------------------------------
// Version number.
//--------------------------------------------------------------

#define BIGINT_VERSION			"1.2"
#define BIGINT_VERNUM		   0x0102

//--------------------------------------------------------------
// On 32 bits architectures, a digit is represented by a 16-bit
// value and therefore bigints are expressed in base 65536. On
// 64 bits architectures, a digit is represented by a 32-bit
// value and therefore bigints are expressed in base 4294967296.
//--------------------------------------------------------------

#if __LP64__ || (TARGET_OS_EMBEDDED && !TARGET_OS_IPHONE) || TARGET_OS_WIN32 || NS_BUILD_32_LIKE_64

#define SIZEOF_DIGIT		4				// A convenient definition used in the library for conditional compilation.
typedef uint32_t			bigint_digit;	// A digit on a 64-bit architecture.
typedef uint64_t			bigint_word;	// A double digit on a 64-bit architecture.

#else

#define SIZEOF_DIGIT		2				// A convenient definition used in the library for conditional compilation.
typedef uint16_t			bigint_digit;	// A digit on a 32-bit architecture.
typedef uint32_t			bigint_word;	// A double digit on a 32-bit architecture.

#endif

//--------------------------------------------------------------
// Structure internally used to handle big integers. The 32-bit
// Mac OS X target requires ivars to be declared in the class
// interface below, so we have to keep this in this public
// file. It should move to private.h the day we drop this 32-bit
// target.
//--------------------------------------------------------------

typedef struct _BIGINT
{
	BOOL			sign;					// Sign (NO = positive, YES = negative)
	int				length;					// Number of digits actually used (i.e. log(n))
	int				alloc;					// Number of allocated digits.
	bigint_digit  * digits;					// Array of digits.
}
	BIGINT;

//--------------------------------------------------------------
// The BigInteger class.
//--------------------------------------------------------------

@interface BigInteger : NSObject <NSCopying, NSCoding>
{
	BIGINT bn;
}

- (instancetype)initWithInt32:(int32_t)x;
- (instancetype)initWithUnsignedInt32:(uint32_t)x;
- (instancetype)initWithBigInteger:(BigInteger *)bigint;
- (instancetype)initWithString:(NSString *)num radix:(int)radix;
- (instancetype)initWithRandomNumberOfSize:(int)bitcount exact:(BOOL)exact;

+ (instancetype)bigintWithInt32:(int32_t)x;
+ (instancetype)bigintWithUnsignedInt32:(uint32_t)x;
+ (instancetype)bigintWithBigInteger:(BigInteger *)bigint;
+ (instancetype)bigintWithString:(NSString *)num radix:(int)radix;
+ (instancetype)bigintWithRandomNumberOfSize:(int)bitcount exact:(BOOL)exact;

- (NSString *)description;
- (NSString *)toRadix:(int)radix;
- (void)getBytes:(uint8_t *)bytes length:(int)length;
- (int32_t)intValue;
- (int64_t)longValue;

- (NSComparisonResult)compare:(BigInteger *)bigint;
- (BOOL)isEqualToBigInteger:(BigInteger *)bigint;
- (BOOL)isEqual:(id)object;
- (NSUInteger)hash;

- (int)sign;
- (instancetype)abs;
- (instancetype)negate;
- (BOOL)isEven;
- (BOOL)isOdd;
- (BOOL)isZero;

- (instancetype)add:(BigInteger *)x;
- (instancetype)sub:(BigInteger *)x;
- (instancetype)multiply:(BigInteger *)mul;
- (instancetype)multiply:(BigInteger *)mul modulo:(BigInteger *)mod;
- (instancetype)divide:(BigInteger *)div;
- (instancetype)divide:(BigInteger *)div remainder:(BigInteger **)rem;
- (instancetype)exp:(uint32_t)exp;
- (instancetype)exp:(BigInteger *)exp modulo:(BigInteger *)mod;

- (instancetype)shiftLeft:(int)count;
- (instancetype)shiftRight:(int)count;

- (int)bitCount;
- (instancetype)bitwiseNotUsingWidth:(int)count;
- (instancetype)bitwiseAnd:(BigInteger *)x;
- (instancetype)bitwiseOr:(BigInteger *)x;
- (instancetype)bitwiseXor:(BigInteger *)x;

- (instancetype)greatestCommonDivisor:(BigInteger *)bigint;
- (instancetype)inverseModulo:(BigInteger *)mod;

- (BOOL)isProbablePrime;
- (instancetype)nextProbablePrime;

@end

//--------------------------------------------------------------

#endif

//========================================================================
