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
}
