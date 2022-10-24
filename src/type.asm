db 100; define byte
dw 0xaa55; define word ,little endian
dd 0x12345678; define doubleword



;binary
dd 11110000b
dd 1111_0000b
dd 0b11110000
dd 0b1111_0000

;hex
dw 55aah
dw 0x55aa

;string
db "hello, world", 0, 12 ,123
