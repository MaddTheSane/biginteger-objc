//
//  BISwiftTesting.swift
//  BigInteger
//
//  Created by C.W. Betts on 3/2/15.
//  Copyright (c) 2015 Æquans. All rights reserved.
//

import Cocoa
import XCTest
import BigInteger

class BISwiftTesting: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

	func testInit() {
		var bi: BigInteger?
		var bj: BigInteger?
		
		var buf = Array<Int8>(count: 8, repeatedValue: 0)
		
		bi = BigInteger(int32: 0)
		bj = BigInteger(string: "0", radix: 10)
		
		XCTAssert(bi!.description == "00")
		
		let bii = BigInteger(int32: 5)
		let bij = BigInteger(int32: -5)
		
		XCTAssert(bii == -bij)
		
	}
	
	func testLargeMultiply() {
		for (var i: Int32 = 10; i <= 10240; i *= 2) {
			autoreleasepool() {
				for j in Int32(0)..<Int32(200) {
					let bi = BigInteger(randomNumberOfSize: i, exact: true)
					let bj = BigInteger(randomNumberOfSize: i, exact: true)
					let bk = BigInteger(randomNumberOfSize: i >> 1, exact: true)
					
					var br = bi * bj
					var bs = bj * bi
					XCTAssert(br == bs)
					var bd = br / bi
					XCTAssert(bd == bj)
					
					br = bi * bk
					bs = bk * bi
					XCTAssert(br == bs)
					bd = br / bi
					XCTAssert(bd == bk)
				}
			}
		}
		var bi = BigInteger(string: "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF", radix: 16)
		var bj = BigInteger(string: "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF", radix: 16)
		if let bi = bi, bj = bj {
			let br = bi * bj
			let bs = bj * bi
			XCTAssert(br == bs)
			if let radix = br.toRadix(10) {
				XCTAssert(radix == "115792089237316195423570985008687907852589419931798687112530834793049593217025")
			} else {
				XCTAssertFalse(false, "Unable to convert to radix.")
			}
		} else {
			XCTAssertFalse(false, "bi and/or bj returned nil, bi: \(bi), br: \(bj)")
		}
	}
}
