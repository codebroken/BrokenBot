Func getDigitTH(ByRef $x, $y)

	Local $c1 = Hex(0xFDFDFD, 6), $c2 = Hex(0x030303, 6), $c3 = Hex(0x2C2A29, 6)
	Local $pixel1[3] = [$x + 1, $y + 1, $c1], $pixel2[3] = [$x + 1, $y + 16, $c2], $pixel3[3] = [$x + 20, $y + 9, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
		Return 10
	EndIf

	Local $c1 = Hex(0x010101, 6), $c2 = Hex(0x3E3E3E, 6), $c3 = Hex(0xB7B7B7, 6)
	Local $pixel1[3] = [$x + 6, $y + 5, $c1], $pixel2[3] = [$x + 4, $y + 10, $c2], $pixel3[3] = [$x + 8, $y + 15, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
		Return 9
	EndIf

	Local $c1 = Hex(0x020202, 6), $c2 = Hex(0x1E1E1E, 6), $c3 = Hex(0x6B6B6B, 6)
	Local $pixel1[3] = [$x + 6, $y + 4, $c1], $pixel2[3] = [$x + 6, $y + 10, $c2], $pixel3[3] = [$x + 2, $y + 8, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
		Return 8
	EndIf

	Local $c1 = Hex(0x6E6E6E, 6), $c2 = Hex(0x4F4F4F, 6), $c3 = Hex(0x6E6E6E, 6)
	Local $pixel1[3] = [$x + 8, $y + 10, $c1], $pixel2[3] = [$x + 5, $y + 4, $c2], $pixel3[3] = [$x + 10, $y + 6, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
		Return 7
	Else
		SetLog("If your townhall is level 7, post this to BrokenBot.org:")
		SetLog("Pixel1: " & _GetPixelColor($pixel1[0], $pixel1[1]))
		SetLog("Pixel2: " & _GetPixelColor($pixel2[0], $pixel2[1]))
		SetLog("Pixel3: " & _GetPixelColor($pixel3[0], $pixel3[1]))
	EndIf

	Local $c1 = Hex(0xC7C7C7, 6), $c2 = Hex(0x757575, 6), $c3 = Hex(0x969696, 6)
	Local $pixel1[3] = [$x + 6, $y + 4, $c1], $pixel2[3] = [$x + 5, $y + 11, $c2], $pixel3[3] = [$x + 2, $y + 15, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
		Return 6
	Else
		SetLog("If your townhall is level 6, post this to BrokenBot.org:")
		SetLog("Pixel1: " & _GetPixelColor($pixel1[0], $pixel1[1]))
		SetLog("Pixel2: " & _GetPixelColor($pixel2[0], $pixel2[1]))
		SetLog("Pixel3: " & _GetPixelColor($pixel3[0], $pixel3[1]))
	EndIf

	Local $c1 = Hex(0xAFAFAF, 6), $c2 = Hex(0xBFBFBF, 6), $c3 = Hex(0x7F7F7F, 6)
	Local $pixel1[3] = [$x + 6, $y + 4, $c1], $pixel2[3] = [$x + 2, $y + 13, $c2], $pixel3[3] = [$x + 10, $y + 4, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
		Return 5
	Else
		SetLog("If your townhall is level 5, post this to BrokenBot.org:")
		SetLog("Pixel1: " & _GetPixelColor($pixel1[0], $pixel1[1]))
		SetLog("Pixel2: " & _GetPixelColor($pixel2[0], $pixel2[1]))
		SetLog("Pixel3: " & _GetPixelColor($pixel3[0], $pixel3[1]))
	EndIf

	Local $c1 = Hex(0x686460, 6), $c2 = Hex(0x686460, 6), $c3 = Hex(0x524F4B, 6)
	Local $pixel1[3] = [$x + 3, $y + 3, $c1], $pixel2[3] = [$x + 7, $y + 8, $c2], $pixel3[3] = [$x + 7, $y + 13, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
		Return 4
	EndIf

	Local $c1 = Hex(0x686460, 6), $c2 = Hex(0x686460, 6), $c3 = Hex(0x66625E, 6)
	Local $pixel1[3] = [$x + 6, $y + 5, $c1], $pixel2[3] = [$x + 9, $y + 7, $c2], $pixel3[3] = [$x + 6, $y + 11, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
		Return 3
	EndIf

	Local $c1 = Hex(0x777777, 6), $c2 = Hex(0x1F1F1F, 6), $c3 = Hex(0x989898, 6)
	Local $pixel1[3] = [$x + 6, $y + 4, $c1], $pixel2[3] = [$x + 6, $y + 11, $c2], $pixel3[3] = [$x + 4, $y + 7, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
		Return 2
	Else
		SetLog("If your townhall is level 2, post this to BrokenBot.org:")
		SetLog("Pixel1: " & _GetPixelColor($pixel1[0], $pixel1[1]))
		SetLog("Pixel2: " & _GetPixelColor($pixel2[0], $pixel2[1]))
		SetLog("Pixel3: " & _GetPixelColor($pixel3[0], $pixel3[1]))
	EndIf

	Return ""
EndFunc   ;==>getDigitTH
