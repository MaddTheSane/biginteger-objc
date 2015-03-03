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


//--------------------------------------------------------------
// The BigInteger class.
//--------------------------------------------------------------

@interface BigInteger : NSObject <NSCopying, NSCoding>

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

@property (readonly, copy) NSString *description;
- (NSString *)toRadix:(int)radix;
- (void)getBytes:(uint8_t *)bytes length:(int)length;
@property (readonly) int32_t intValue;
@property (readonly) int64_t longValue;
@property (readonly) NSInteger integerValue;

- (NSComparisonResult)compare:(BigInteger *)bigint;
- (BOOL)isEqualToBigInteger:(BigInteger *)bigint;
- (BOOL)isEqual:(id)object;
- (NSUInteger)hash;

- (int)sign;
- (instancetype)abs;
- (instancetype)negate;
@property (readonly, getter=isEven) BOOL even;
@property (readonly, getter=isOdd) BOOL odd;
@property (readonly, getter=isZero) BOOL zero;

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

@property (readonly) int bitCount;
- (instancetype)bitwiseNotUsingWidth:(int)count;
- (instancetype)bitwiseAnd:(BigInteger *)x;
- (instancetype)bitwiseOr:(BigInteger *)x;
- (instancetype)bitwiseXor:(BigInteger *)x;

- (instancetype)greatestCommonDivisor:(BigInteger *)bigint;
- (instancetype)inverseModulo:(BigInteger *)mod;

@property (readonly, getter=isProbablePrime) BOOL probablePrime;
- (instancetype)nextProbablePrime;

@end

//--------------------------------------------------------------

#endif

//========================================================================
