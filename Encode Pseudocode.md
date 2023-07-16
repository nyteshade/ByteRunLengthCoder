```
function Encode(input data)
  Initialize output as an empty array
  Set index to 0

  While index is less than the count of data
    Initialize sequence as an empty array
    Set count to 0

    // Unique sequence
    While count is less than or equal to 0x7F and index is less than count of data
      If index + 2 is less than count of data and data at index is equal to data at index + 1 and data at index is equal to data at index + 2
        Break the loop  // Start of a repeating sequence
      End If

      Append data at index to sequence
      Increment index
      Increment count
    End While

    If sequence is not empty
      Append (count - 1) to output
      Append all items in sequence to output
    End If

    If index is greater than or equal to count of data
      Break the loop
    End If

    // Repeating sequence
    Set repeatedByte to data at index
    Set count to 0
    While count is less than or equal to 0x7F and index is less than count of data and data at index is equal to repeatedByte
      Increment index
      Increment count
    End While

    If count is greater than or equal to 3
      Append (0x80 + count - 3) to output
      Append repeatedByte to output
    Else  // Less than 3 repeating bytes
      Append (count - 1) to output
      Repeat (count) times
        Append repeatedByte to output
      End Repeat
    End If
  End While

  Return output
End function
```
