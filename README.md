# ByteRunLengthCoder

ByteRunLengthCoder is a Swift library to perform run-length encoding and decoding on data. It provides efficient and easy-to-use methods for compressing and decompressing data.

## Usage

First, import the `ByteRunLengthCoder` module in your Swift file:

```swift
import ByteRunLengthCoder
```

You can use the `encode` and `decode` methods to perform run-length encoding and decoding respectively:

```swift
let input: [UInt8] = [0x01, 0x02, 0x02, 0x03, 0x03, 0x03, 0x04, 0x04, 0x04, 0x04, 0x05, 0x05, 0x05, 0x05, 0x05]
let encoded = ByteRunLengthCoder.encode(data: input)
// encoded == [0x02, 0x01, 0x02, 0x02, 0x80, 0x03, 0x81, 0x04, 0x82, 0x05]

let decoded = ByteRunLengthCoder.decode(data: encoded)
// decoded == [0x01, 0x02, 0x02, 0x03, 0x03, 0x03, 0x04, 0x04, 0x04, 0x04, 0x05, 0x05, 0x05, 0x05, 0x05]
```

## Conversion Extensions

ByteRunLengthCoder also includes convenience extensions for [UInt8] arrays to convert to and from Data and NSData:

```swift
let data: Data = Data([1, 1, 1, 2, 2, 3])
let byteArr = [UInt8](data: data)
let backToData = byteArr.toData()

let nsdata: NSData = NSData(bytes: [1, 1, 1, 2, 2, 3], length: 6)
let byteArrFromNSData = [UInt8](nsdata: nsdata)
let backToNSData = byteArrFromNSData.toNSData()
```

## Unit Tests

ByteRunLengthCoder includes unit tests for the encode and decode functions. Run these tests to ensure the library functions as expected:

```swift
let test = ByteRunLengthCoderTests()
test.testEncode()
test.testDecode()
```

## License

This project is licensed under the MIT License.

