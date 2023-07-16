//
//  ARGBEncode+Decode.swift
//  DMZ
//
//  Created by Brielle Harrison on 7/15/23.
//

import Foundation

public struct ByteRunLengthCoder {
  /// Encodes the given data using run-length encoding
  ///
  /// - Parameter data: The data to encode.
  /// - Returns: The run-length encoded data.
  static func encode(data: [UInt8]) -> [UInt8] {
    var output: [UInt8] = []
    var index = 0

    while index < data.count {
      var sequence: [UInt8] = []
      var count: UInt8 = 0

      // Unique sequence
      while count <= 0x7F && index < data.count {
        if index + 2 < data.count && data[index] == data[index + 1] && data[index] == data[index + 2] {
          // This is a start of a repeating sequence, break the loop
          break
        }

        sequence.append(data[index])
        index += 1
        count += 1
      }

      if !sequence.isEmpty {
        output.append(count - 1)
        output.append(contentsOf: sequence)
      }

      if index >= data.count {
        break
      }

      // Repeating sequence
      let repeatedByte = data[index]
      count = 0
      while count <= 0x7F && index < data.count && data[index] == repeatedByte {
        index += 1
        count += 1
      }

      if count >= 3 {
        output.append(0x80 + count - 3)
        output.append(repeatedByte)
      } else {
        // There are less than 3 repeating bytes. Treat them as a unique sequence
        output.append(count - 1)
        for _ in 0..<count {
          output.append(repeatedByte)
        }
      }
    }

    return output
  }

  /// Decodes the given data using run-length decoding
  ///
  /// - Parameter data: The data to decode.
  /// - Returns: The run-length decoded data.
  static func decode(data: [UInt8]) -> [UInt8] {
    var decodedData = [UInt8]()
    var index = 0
    
    while index < data.count {
      let currentByte = data[index]
      if currentByte < 0x80 {
        let count = Int(currentByte) + 1
        if index + count >= data.count {
          break
        }
        decodedData.append(contentsOf: data[(index + 1)..<(index + 1 + count)])
        index += count + 1
      } else {
        let count = Int(currentByte) - 0x80 + 3
        if index + 1 >= data.count {
          break
        }
        let repeatedByte = data[index + 1]
        decodedData.append(contentsOf: Array(repeating: repeatedByte, count: count))
        index += 2
      }
    }
    
    return decodedData
  }
}

// Convenience Extension for Data and NSData conversions
extension Array where Element == UInt8 {
  init(data: Data) {
    self = Array(data)
  }
  
  init(nsdata: NSData) {
    var byteArr = [UInt8](repeating: 0, count: nsdata.length)
    nsdata.getBytes(&byteArr, length: nsdata.length)
    self = byteArr
  }
  
  func toData() -> Data {
    return Data(self)
  }
  
  func toNSData() -> NSData {
    return NSData(bytes: self, length: self.count)
  }
}
