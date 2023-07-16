```
While there's compressed data:
    Read one byte as an unsigned number N
    If N < 0x80:
        Output the next (N + 1) bytes
    Else:
        Output the next byte (N - 0x80 + 3) times
```
