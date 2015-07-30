Func getDigitTH(ByRef $x, $y)

     ;Search for digit 10
    Local $c1 = Hex(0x0A0A0A, 6), $c2 = Hex(0x07090A, 6), $c3 = Hex(0x1C1C1C, 6)
    Local $pixel1[3] = [$x + 1, $y + 1, $c1], $pixel2[3] = [$x + 4, $y + 16, $c2], $pixel3[3] = [$x + 19, $y + 9, $c3]
    If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
        Return 10
    EndIf

     ;Search for digit 9
    Local $c1 = Hex(0x060606, 6), $c2 = Hex(0x4F4F4F, 6), $c3 = Hex(0x6F6F6F, 6)
    Local $pixel1[3] = [$x + 6, $y + 6, $c1], $pixel2[3] = [$x + 4, $y + 11, $c2], $pixel3[3] = [$x + 8, $y + 16, $c3]
    If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
        Return 9
    EndIf

     ;Search for digit 8
    Local $c1 = Hex(0x050505, 6), $c2 = Hex(0x060606, 6), $c3 = Hex(0x6A6A6A, 6)
    Local $pixel1[3] = [$x + 6, $y + 4, $c1], $pixel2[3] = [$x + 6, $y + 10, $c2], $pixel3[3] = [$x + 1, $y + 8, $c3]
    If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
        Return 8
    EndIf

    ;Search for digit 7
    Local $c1 = Hex(0x6E6E6E, 6), $c2 = Hex(0x202020, 6), $c3 = Hex(0x6E6E6E, 6)
    Local $pixel1[3] = [$x + 8, $y + 10, $c1], $pixel2[3] = [$x + 5, $y + 4, $c2], $pixel3[3] = [$x + 10, $y + 6, $c3]
    If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
        Return 7
    EndIf

    ;Search for digit 6
    Local $c1 = Hex(0xC7C7C7, 6), $c2 = Hex(0x757575, 6), $c3 = Hex(0x969696, 6)
    Local $pixel1[3] = [$x + 6, $y + 4, $c1], $pixel2[3] = [$x + 5, $y + 11, $c2], $pixel3[3] = [$x + 2, $y + 15, $c3]
    If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
        Return 6
    EndIf

    ;Search for digit 5
    Local $c1 = Hex(0xAFAFAF, 6), $c2 = Hex(0xBFBFBF, 6), $c3 = Hex(0x7F7F7F, 6)
    Local $pixel1[3] = [$x + 6, $y + 4, $c1], $pixel2[3] = [$x + 2, $y + 13, $c2], $pixel3[3] = [$x + 10, $y + 4, $c3]
    If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
        Return 5
    EndIf

    ;Search for digit 4
    Local $c1 = Hex(0x181818, 6), $c2 = Hex(0x080808, 6), $c3 = Hex(0x0E0E0E, 6)
    Local $pixel1[3] = [$x + 3, $y + 3, $c1], $pixel2[3] = [$x + 7, $y + 8, $c2], $pixel3[3] = [$x + 7, $y + 13, $c3]
    If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
        Return 4
    EndIf

    ;Search for digit 3
    Local $c1 = Hex(0xA6A6A6, 6), $c2 = Hex(0x909090, 6), $c3 = Hex(0x212121, 6)
    Local $pixel1[3] = [$x + 6, $y + 5, $c1], $pixel2[3] = [$x + 9, $y + 7, $c2], $pixel3[3] = [$x + 6, $y + 11, $c3]
    If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
        Return 3
    EndIf

    ;Search for digit 2
    Local $c1 = Hex(0x777777, 6), $c2 = Hex(0x1F1F1F, 6), $c3 = Hex(0x989898, 6)
    Local $pixel1[3] = [$x + 6, $y + 4, $c1], $pixel2[3] = [$x + 6, $y + 11, $c2], $pixel3[3] = [$x + 4, $y + 7, $c3]
    If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
        Return 2
    EndIf

    ;Search for digit 1
    ;Local $c1 = Hex(0x383838, 6), $c2 = Hex(0x171615, 6), $c3 = Hex(0x060606, 6)
    ;Local $pixel1[3] = [$x + 1, $y + 1, $c1], $pixel2[3] = [$x + 1, $y + 16, $c2], $pixel3[3] = [$x + 4, $y + 16, $c3]
    ;If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
    ;    Return 1
    ;EndIf

    Return ""
EndFunc   ;==>getDigitTH
