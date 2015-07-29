;==============================================================================================================
;===Get Digit LastRaid=========================================================================================
;--------------------------------------------------------------------------------------------------------------
;Finds pixel color pattern of specific X and Y values, returns digit if pixel color pattern found.
;--------------------------------------------------------------------------------------------------------------

Func getDigitLastRaid(ByRef $x, $y, $type)

	Local $Resource = ""

	While $x <> 440
		$x += 1

		;Check for Negative sign
		If $type = "LastRaidTrophy" Then
			;Done
			;Search for negative sign
			Local $c1 = Hex(0x979797, 6), $c2 = Hex(0x474747, 6), $c3 = Hex(0xFFFFFF, 6)
			Local $pixel1[3] = [$x + 1, $y + 9, $c1], $pixel2[3] = [$x + 5, $y + 13, $c2], $pixel3[3] = [$x + 3, $y + 11, $c3]
			If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
				$x += 5
				$Resource &= "-"
				ContinueLoop
			EndIf
		EndIf

		;Done
		;Search for digit 9
		Local $c1 = Hex(0xA6A6A6, 6), $c2 = Hex(0x414141, 6), $c3 = Hex(0x8F8F8F, 6)
		Local $pixel1[3] = [$x + 6, $y + 5, $c1], $pixel2[3] = [$x + 8, $y + 13, $c2], $pixel3[3] = [$x + 9, $y + 17, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
			$x += 5
			$Resource &= 9
			ContinueLoop
		EndIf

		;Done
		;Search for digit 8
		Local $c1 = Hex(0x575757, 6), $c2 = Hex(0xB7B7B7, 6), $c3 = Hex(0xA7A7A7, 6)
		Local $pixel1[3] = [$x + 7, $y + 4, $c1], $pixel2[3] = [$x + 7, $y + 11, $c2], $pixel3[3] = [$x + 12, $y + 8, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
			$x += 5
			$Resource &= 8
			ContinueLoop
		EndIf

		;Done
		;Search for digit 7
		Local $c1 = Hex(0xB8B8B8, 6), $c2 = Hex(0xC1C1C1, 6), $c3 = Hex(0x808080, 6)
		Local $pixel1[3] = [$x + 11, $y + 1, $c1], $pixel2[3] = [$x + 5, $y + 8, $c2], $pixel3[3] = [$x + 2, $y + 14, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
			$x += 5
			$Resource &= 7
			ContinueLoop
		EndIf

		;Done
		;Search for digit 6
		Local $c1 = Hex(0xB4B4B4, 6), $c2 = Hex(0x7D7D7D, 6), $c3 = Hex(0xB9B9B9, 6)
		Local $pixel1[3] = [$x, $y + 5, $c1], $pixel2[3] = [$x + 5, $y + 6, $c2], $pixel3[3] = [$x + 5, $y + 14, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
			$x += 5
			$Resource &= 6
			ContinueLoop
		EndIf

		;Done
		;Search for digit 5
		Local $c1 = Hex(0x9F9F9F, 6), $c2 = Hex(0xB7B7B7, 6), $c3 = Hex(0x6F6F6F, 6)
		Local $pixel1[3] = [$x + 6, $y + 5, $c1], $pixel2[3] = [$x + 7, $y + 12, $c2], $pixel3[3] = [$x + 9, $y + 17, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
			$x += 5
			$Resource &= 5
			ContinueLoop
		EndIf

		;Done
		;Search for digit 4
		Local $c1 = Hex(0x818181, 6), $c2 = Hex(0x686868, 6), $c3 = Hex(0x979797, 6)
		Local $pixel1[3] = [$x + 10, $y + 1, $c1], $pixel2[3] = [$x + 8, $y + 10, $c2], $pixel3[3] = [$x + 8, $y + 14, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
			$x += 5
			$Resource &= 4
			ContinueLoop
		EndIf

		;Done
		;Search for digit 3
		Local $c1 = Hex(0xB1B1B1, 6), $c2 = Hex(0xCECECE, 6), $c3 = Hex(0x909090, 6)
		Local $pixel1[3] = [$x + 9, $y + 1, $c1], $pixel2[3] = [$x + 7, $y + 6, $c2], $pixel3[3] = [$x + 5, $y + 14, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
			$x += 5
			$Resource &= 3
			ContinueLoop
		EndIf

		;Done
		;Search for digit 2
		Local $c1 = Hex(0x292929, 6), $c2 = Hex(0x464646, 6), $c3 = Hex(0xB8B8B8, 6)
		Local $pixel1[3] = [$x + 7, $y + 6, $c1], $pixel2[3] = [$x + 6, $y + 13, $c2], $pixel3[3] = [$x + 7, $y + 14, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
			$x += 5
			$Resource &= 2
			ContinueLoop
		EndIf

		;Done
		;Search for digit 1
		Local $c1 = Hex(0x888888, 6), $c2 = Hex(0x7B7B7B, 6), $c3 = Hex(0xBFBFBF, 6)
		Local $pixel1[3] = [$x + 5, $y + 1, $c1], $pixel2[3] = [$x + 2, $y + 17, $c2], $pixel3[3] = [$x + 6, $y + 17, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
			$x += 5
			$Resource &= 1
			ContinueLoop
		EndIf

		;Done
		;Search for digit 0
		Local $c1 = Hex(0x9E9E9E, 6), $c2 = Hex(0x8F8F8F, 6), $c3 = Hex(0xD6D6D6, 6)
		Local $pixel1[3] = [$x + 3, $y + 2, $c1], $pixel2[3] = [$x + 10, $y + 6, $c2], $pixel3[3] = [$x + 6, $y + 14, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
			$x += 5
			$Resource &= 0
			ContinueLoop
		EndIf

		;For Dark Elixir, if there is a digit 1 $y set pixel offset
		If $x = 440 And $Resource = "" And $type = "LastRaidDarkElixir" Then
			$x = 330
			$y += 1
		EndIf
	WEnd

	Return $Resource

EndFunc   ;==>getDigitLastRaid
