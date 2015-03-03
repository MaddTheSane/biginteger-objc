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

#import <Foundation/Foundation.h>

//--------------------------------------------------------------
// Version number.
//--------------------------------------------------------------

#define BIGINT_VERSION			"1.3"
#define BIGINT_VERNUM		   0x0103

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


typedef NS_ENUM(int, BISign) {
	BISignNegative = -1,
	BISignNull = 0,
	BISignPositive = 1
};

//--------------------------------------------------------------
// The BigInteger class.
//--------------------------------------------------------------

@interface BigInteger : NSObject <NSCopying, NSCoding>

- (nonnull instancetype)initWithInt32:(int32_t)x;
- (nonnull instancetype)initWithUnsignedInt32:(uint32_t)x;
- (nonnull instancetype)initWithBigInteger:(BigInteger * __nonnull)bigint;
- (nullable instancetype)initWithString:(NSString * __nonnull)num radix:(int)radix;
- (nonnull instancetype)initWithRandomNumberOfSize:(int)bitcount exact:(BOOL)exact;

+ (nonnull instancetype)bigintWithInt32:(int32_t)x;
+ (nonnull instancetype)bigintWithUnsignedInt32:(uint32_t)x;
+ (nonnull instancetype)bigintWithBigInteger:(BigInteger * __nonnull)bigint;
+ (nullable instancetype)bigintWithString:(NSString * __nonnull)num radix:(int)radix;
+ (nonnull instancetype)bigintWithRandomNumberOfSize:(int)bitcount exact:(BOOL)exact;

@property (readonly, copy, nonnull) NSString *description;
- (nullable NSString *)toRadix:(int)radix;
- (void)getBytes:(uint8_t * __nonnull)bytes length:(int)length;
@property (readonly) int32_t intValue;
@property (readonly) int64_t longValue;
@property (readonly) NSInteger integerValue;

- (NSComparisonResult)compare:(BigInteger * __nonnull)bigint;
- (BOOL)isEqualToBigInteger:(BigInteger * __nonnull)bigint;
- (BOOL)isEqual:(id __nullable)object;
@property (readonly) NSUInteger hash;

@property (readonly) BISign sign;
- (nonnull instancetype)abs;
- (nonnull instancetype)negate;
@property (readonly, getter=isEven) BOOL even;
@property (readonly, getter=isOdd) BOOL odd;
@property (readonly, getter=isZero) BOOL zero;

- (nonnull instancetype)add:(BigInteger * __nonnull)x;
- (nonnull instancetype)sub:(BigInteger * __nonnull)x;
- (nonnull instancetype)multiply:(BigInteger * __nonnull)mul;
- (nonnull instancetype)multiply:(BigInteger * __nonnull)mul modulo:(BigInteger * __nonnull)mod;
- (nonnull instancetype)divide:(BigInteger * __nonnull)div;
- (nonnull instancetype)divide:(BigInteger * __nonnull)div remainder:(BigInteger * __nonnull* __nullable)rem;
- (nonnull instancetype)exp:(uint32_t)exp;
- (nonnull instancetype)exp:(BigInteger * __nonnull)exp modulo:(BigInteger * __nonnull)mod;

- (nonnull instancetype)shiftLeft:(int)count;
- (nonnull instancetype)shiftRight:(int)count;

@property (readonly) int bitCount;
- (nullable instancetype)bitwiseNotUsingWidth:(int)count;
- (nonnull instancetype)bitwiseAnd:(BigInteger * __nonnull)x;
- (nonnull instancetype)bitwiseOr:(BigInteger * __nonnull)x;
- (nonnull instancetype)bitwiseXor:(BigInteger * __nonnull)x;

- (nullable instancetype)greatestCommonDivisor:(BigInteger * __nonnull)bigint;
- (nonnull instancetype)inverseModulo:(BigInteger * __nonnull)mod;

@property (readonly, getter=isProbablePrime) BOOL probablePrime;
- (nonnull instancetype)nextProbablePrime;

@end

//--------------------------------------------------------------

#endif

//========================================================================
