//========================================================================
// Mac OS X and iOS BigInteger Library
// Copyright (c) 2015, Pascal Levy
// Copyright (c) 2015, C.W. "Madd the Sane" Betts
// Created by C.W. Betts on 3/2/15.
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

import Foundation

public func abs(aNum: BigInteger) -> BigInteger {
	return aNum.abs()
}

public func ==(lhs: BigInteger, rhs: BigInteger) -> Bool {
	return lhs.isEqualToBigInteger(rhs)
}

public func +(lhs: BigInteger, rhs: BigInteger) -> BigInteger {
	return lhs.add(rhs)
}

public func -(lhs: BigInteger, rhs: BigInteger) -> BigInteger {
	return lhs.sub(rhs)
}

public func /(lhs: BigInteger, rhs: BigInteger) -> BigInteger {
	return lhs.divide(rhs)
}

public func *(lhs: BigInteger, rhs: BigInteger) -> BigInteger {
	return lhs.multiply(rhs)
}

public func %(lhs: BigInteger, rhs: BigInteger) -> BigInteger {
	var remainder: BigInteger? = nil
	lhs.divide(rhs, remainder: &remainder)
	return remainder!
}

public func &(lhs: BigInteger, rhs: BigInteger) -> BigInteger {
	return lhs.bitwiseAnd(rhs)
}

public func |(lhs: BigInteger, rhs: BigInteger) -> BigInteger {
	return lhs.bitwiseOr(rhs)
}

public func ^(lhs: BigInteger, rhs: BigInteger) -> BigInteger {
	return lhs.bitwiseOr(rhs)
	
}

public prefix func ~(x: BigInteger) -> BigInteger {
	return x.bitwiseNotUsingWidth(x.bitCount)
}

public prefix func -(theVal: BigInteger) -> BigInteger {
	return theVal.negate()
}

public func <(lhs: BigInteger, rhs: BigInteger) -> Bool {
	let aComp = lhs.compare(rhs)
	return aComp == .OrderedAscending
}


extension BigInteger: Comparable, IntegerLiteralConvertible, Printable, Hashable /*BitwiseOperationsType, IntegerArithmeticType*/ {
	required public convenience init(integerLiteral value: IntegerLiteralType) {
		self.init(int32: Int32(value))
	}
	
	override public var hashValue: Int {
		return Int(hash)
	}
	
	public class var allZeros: BigInteger {
		return BigInteger(int32: 0)
	}
}
