;==============================================================================================================
;=== Get Digit Large ==========================================================================================
;--------------------------------------------------------------------------------------------------------------
;Finds pixel color pattern of specific X and Y values, returns digit if pixel color pattern found.
;--------------------------------------------------------------------------------------------------------------

Func getDigitLarge(ByRef $x, $y, $type)
	Local $width = 0

	;Search for digit 0
	$width = 17
	Select
		Case $type = "ReturnHome"
			Local $c1 = Hex(0x484848, 10), $c2 = Hex(0x050505, 10), $c3 = Hex(0x4C4442, 10)
	EndSelect
	Local $pixel1[3] = [$x + 9, $y + 6, $c1], $pixel2[3] = [$x + 9, $y + 9, $c2], $pixel3[3] = [$x + 14, $y + 18, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3, 7) Then
		$x += $width ;Adds to x coordinate to get the next digit
		Return "0"
	Else
		$x -= 1 ;Solves the problem when the spaces between the middle goes from 6 to 5 pixels
		Local $pixel1[3] = [$x + 9, $y + 6, $c1], $pixel2[3] = [$x + 9, $y + 9, $c2], $pixel3[3] = [$x + 14, $y + 18, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 7) Then
			$x += $width ;Changes x coordinate for the next digit.
			Return "0"
		Else
			$x += 2 ;Solves the problem when there is 1 pixel space between a set of numbers
			Local $pixel1[3] = [$x + 9, $y + 6, $c1], $pixel2[3] = [$x + 9, $y + 9, $c2], $pixel3[3] = [$x + 14, $y + 18, $c3]
			If boolPixelSearch($pixel1, $pixel2, $pixel3, 7) Then
				$x += $width
				Return "0"
			Else
				$x -= 1
			EndIf
		EndIf
	EndIf

	;Search for digit 1
	$width = 7
	Select
		Case $type = "ReturnHome"
			Local $c1 = Hex(0x231C24, 10), $c2 = Hex(0x707863, 20), $c3 = Hex(0xCBCBC9, 10)
	EndSelect
	Local $pixel1[3] = [$x + 2, $y + 1, $c1], $pixel2[3] = [$x + 2, $y + 17, $c2], $pixel3[3] = [$x + 6, $y + 17, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3, 7) Then
		$x += $width
		Return 1
	Else
		$x -= 1
		Local $pixel1[3] = [$x + 2, $y + 1, $c1], $pixel2[3] = [$x + 2, $y + 17, $c2], $pixel3[3] = [$x + 6, $y + 17, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 7) Then
			$x += $width
			Return 1
		Else
			$x += 2
			Local $pixel1[3] = [$x + 2, $y + 1, $c1], $pixel2[3] = [$x + 2, $y + 17, $c2], $pixel3[3] = [$x + 6, $y + 17, $c3]
			If boolPixelSearch($pixel1, $pixel2, $pixel3, 7) Then
				$x += $width
				Return 1
			Else
				$x -= 1
			EndIf
		EndIf
	EndIf

	;Search for digit 2
	$width = 13
	Select
		Case $type = "ReturnHome"
			Local $c1 = Hex(0x737C69, 10), $c2 = Hex(0xE2E2E2, 10), $c3 = Hex(0xB8B8B8, 10)
	EndSelect
	Local $pixel1[3] = [$x + 1, $y + 10, $c1], $pixel2[3] = [$x + 5, $y + 8, $c2], $pixel3[3] = [$x + 8, $y + 11, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3, 7) Then
		$x += $width
		Return 2
	Else
		$x -= 1
		Local $pixel1[3] = [$x + 1, $y + 10, $c1], $pixel2[3] = [$x + 5, $y + 8, $c2], $pixel3[3] = [$x + 8, $y + 11, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 7) Then
			$x += $width
			Return 2
		Else
			$x += 2
			Local $pixel1[3] = [$x + 1, $y + 10, $c1], $pixel2[3] = [$x + 5, $y + 8, $c2], $pixel3[3] = [$x + 8, $y + 11, $c3]
			If boolPixelSearch($pixel1, $pixel2, $pixel3, 7) Then
				$x += $width
				Return 2
			Else
				$x -= 1
			EndIf
		EndIf
	EndIf

	;Search for digit 3
	$width = 14
	Select
		Case $type = "ReturnHome"
			Local $c1 = Hex(0xD9D9DB, 10), $c2 = Hex(0x050505, 10), $c3 = Hex(0x4E4F54, 10)
	EndSelect
	Local $pixel1[3] = [$x + 4, $y + 4, $c1], $pixel2[3] = [$x + 5, $y + 11, $c2], $pixel3[3] = [$x + 7, $y + 18, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3, 7) Then
		$x += $width
		Return 3
	Else
		$x -= 1
		Local $pixel1[3] = [$x + 4, $y + 4, $c1], $pixel2[3] = [$x + 5, $y + 11, $c2], $pixel3[3] = [$x + 7, $y + 18, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 7) Then
			$x += $width
			Return 3
		Else
			$x += 2
			Local $pixel1[3] = [$x + 4, $y + 4, $c1], $pixel2[3] = [$x + 5, $y + 11, $c2], $pixel3[3] = [$x + 7, $y + 18, $c3]
			If boolPixelSearch($pixel1, $pixel2, $pixel3, 7) Then
				$x += $width
				Return 3
			Else
				$x -= 1
			EndIf
		EndIf
	EndIf

	;Search for digit 4
	$width = 16
	Select
		Case $type = "ReturnHome"
			Local $c1 = Hex(0x050505, 10), $c2 = Hex(0x050505, 10), $c3 = Hex(0x878684, 10)
	EndSelect
	Local $pixel1[3] = [$x + 3, $y + 4, $c1], $pixel2[3] = [$x + 4, $y + 2, $c2], $pixel3[3] = [$x + 2, $y + 7, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3, 7) Then
		$x += $width
		Return 4
	Else
		$x -= 1
		Local $pixel1[3] = [$x + 3, $y + 4, $c1], $pixel2[3] = [$x + 4, $y + 2, $c2], $pixel3[3] = [$x + 2, $y + 7, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 7) Then
			$x += $width
			Return 4
		Else
			$x += 2
			Local $pixel1[3] = [$x + 3, $y + 4, $c1], $pixel2[3] = [$x + 4, $y + 2, $c2], $pixel3[3] = [$x + 2, $y + 7, $c3]
			If boolPixelSearch($pixel1, $pixel2, $pixel3, 7) Then
				$x += $width
				Return 4
			Else
				$x -= 1
			EndIf
		EndIf
	EndIf

	;Search for digit 5
	$width = 13
	Select
		Case $type = "ReturnHome"
			Local $c1 = Hex(0xA19D9E, 10), $c2 = Hex(0x121210, 10), $c3 = Hex(0xB2B1AD, 10)
	EndSelect
	Local $pixel1[3] = [$x + 6, $y + 5, $c1], $pixel2[3] = [$x + 6, $y + 12, $c2], $pixel3[3] = [$x + 8, $y + 17, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3, 7) Then
		$x += $width
		Return 5
	Else
		$x -= 1
		Local $pixel1[3] = [$x + 6, $y + 5, $c1], $pixel2[3] = [$x + 6, $y + 12, $c2], $pixel3[3] = [$x + 8, $y + 17, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 7) Then
			$x += $width
			Return 5
		Else
			$x += 2
			Local $pixel1[3] = [$x + 6, $y + 5, $c1], $pixel2[3] = [$x + 6, $y + 12, $c2], $pixel3[3] = [$x + 8, $y + 17, $c3]
			If boolPixelSearch($pixel1, $pixel2, $pixel3, 7) Then
				$x += $width
				Return 5
			Else
				$x -= 1
			EndIf
		EndIf
	EndIf

	;Search for digit 6
	$width = 15
	Select
		Case $type = "ReturnHome"
			Local $c1 = Hex(0x000000, 6), $c2 = Hex(0x000000, 6), $c3 = Hex(0x000000, 6)
	EndSelect
	Local $pixel1[3] = [$x + 7, $y + 6, $c1], $pixel2[3] = [$x + 7, $y + 12, $c2], $pixel3[3] = [$x + 11, $y + 7, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3, 7) Then
		$x += $width
		Return 6
	Else
		$x -= 1
		Local $pixel1[3] = [$x + 7, $y + 6, $c1], $pixel2[3] = [$x + 7, $y + 12, $c2], $pixel3[3] = [$x + 11, $y + 7, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 7) Then
			$x += $width
			Return 6
		Else
			$x += 2
			Local $pixel1[3] = [$x + 7, $y + 6, $c1], $pixel2[3] = [$x + 7, $y + 12, $c2], $pixel3[3] = [$x + 11, $y + 7, $c3]
			If boolPixelSearch($pixel1, $pixel2, $pixel3, 7) Then
				$x += $width
				Return 6
			Else
				$x -= 1
			EndIf
		EndIf
	EndIf

	;Search for digit 7
	$width = 13
	Select
		Case $type = "ReturnHome"
			Local $c1 = Hex(0xB1AFB0, 10), $c2 = Hex(0x8A8B83, 10), $c3 = Hex(0xAEACB1, 10)
	EndSelect
	Local $pixel1[3] = [$x + 7, $y + 15, $c1], $pixel2[3] = [$x + 6, $y + 5, $c2], $pixel3[3] = [$x + 10, $y + 9, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3, 7) Then
		$x += $width
		Return 7
	Else
		$x -= 1
		Local $pixel1[3] = [$x + 7, $y + 15, $c1], $pixel2[3] = [$x + 6, $y + 5, $c2], $pixel3[3] = [$x + 10, $y + 9, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 7) Then
			$x += $width
			Return 7
		Else
			$x += 2
			Local $pixel1[3] = [$x + 7, $y + 15, $c1], $pixel2[3] = [$x + 6, $y + 5, $c2], $pixel3[3] = [$x + 10, $y + 9, $c3]
			If boolPixelSearch($pixel1, $pixel2, $pixel3, 7) Then
				$x += $width
				Return 7
			Else
				$x -= 1
			EndIf
		EndIf
	EndIf

	;Search for digit 8
	$width = 16
	Select
		Case $type = "ReturnHome"
			Local $c1 = Hex(0x5B5A5F, 10), $c2 = Hex(0x0E0E18, 10), $c3 = Hex(0x000000, 6)
	EndSelect
	Local $pixel1[3] = [$x + 8, $y + 4, $c1], $pixel2[3] = [$x + 7, $y + 14, $c2], $pixel3[3] = [$x + 2, $y + 9, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3, 7) Then
		$x += $width
		Return 8
	Else
		$x -= 1
		Local $pixel1[3] = [$x + 8, $y + 4, $c1], $pixel2[3] = [$x + 7, $y + 14, $c2], $pixel3[3] = [$x + 2, $y + 9, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 7) Then
			$x += $width
			Return 8
		Else
			$x += 2
			Local $pixel1[3] = [$x + 8, $y + 4, $c1], $pixel2[3] = [$x + 7, $y + 14, $c2], $pixel3[3] = [$x + 2, $y + 9, $c3]
			If boolPixelSearch($pixel1, $pixel2, $pixel3, 7) Then
				$x += $width
				Return 8
			Else
				$x -= 1
			EndIf
		EndIf
	EndIf

	;Search for digit 9
	$width = 14
	Select
		Case $type = "ReturnHome"
			Local $c1 = Hex(0x050505, 6), $c2 = Hex(0x101010, 6), $c3 = Hex(0x121212, 6)
	EndSelect
	Local $pixel1[3] = [$x + 7, $y + 6, $c1], $pixel2[3] = [$x + 7, $y + 12, $c2], $pixel3[3] = [$x + 11, $y + 17, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3, 7) Then
		$x += $width
		Return 9
	Else
		$x -= 1
		Local $pixel1[3] = [$x + 5, $y + 5, $c1], $pixel2[3] = [$x + 5, $y + 9, $c2], $pixel3[3] = [$x + 8, $y + 12, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 7) Then
			$x += $width
			Return 9
		Else
			$x += 2
			Local $pixel1[3] = [$x + 5, $y + 5, $c1], $pixel2[3] = [$x + 5, $y + 9, $c2], $pixel3[3] = [$x + 8, $y + 12, $c3]
			If boolPixelSearch($pixel1, $pixel2, $pixel3, 7) Then
				$x += $width
				Return 9
			Else
				$x -= 1
			EndIf
		EndIf
	EndIf

	Return ""
EndFunc   ;==>getDigitLarge
