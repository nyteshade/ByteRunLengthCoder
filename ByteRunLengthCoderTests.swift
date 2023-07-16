//
//  ByteRunLengthCoderTests.swift
//  DMZTests
//
//  Created by Brielle Harrison on 7/16/23.
//

import Foundation
import XCTest
@testable import DMZ

// Unit Test for the ByteRunLengthCoder
class ByteRunLengthCoderTests: XCTestCase {
  
  func testEncode() {
    let input: [UInt8] = [
      0x01, 0x02, 0x02, 0x03, 0x03, 0x03, 0x04, 0x04, 0x04, 0x04, 0x05, 0x05, 0x05, 0x05, 0x05
    ]
    let expectedOutput: [UInt8] = [
      0x02, 0x01, 0x02, 0x02, 0x80, 0x03, 0x81, 0x04, 0x82, 0x05
    ]
    let output = ByteRunLengthCoder.encode(data: input)
    XCTAssertEqual(output, expectedOutput, "The encoded data is incorrect")
  }
  
  func testDecode() {
    let input: [UInt8] = [
      0x02, 0x01, 0x02, 0x02, 0x80, 0x03, 0x81, 0x04, 0x82, 0x05
    ]
    let expectedOutput: [UInt8] = [
      0x01, 0x02, 0x02, 0x03, 0x03, 0x03, 0x04, 0x04, 0x04, 0x04, 0x05, 0x05, 0x05, 0x05, 0x05
    ]
    let output = ByteRunLengthCoder.decode(data: input)
    XCTAssertEqual(output, expectedOutput, "The decoded data is incorrect")
  }
}
