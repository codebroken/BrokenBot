;==============================================================================================================
;==============================================================================================================
;===Color Variation============================================================================================
;--------------------------------------------------------------------------------------------------------------
;Checks if the color components exceed $sVari and returns true if they are below $sVari.
;--------------------------------------------------------------------------------------------------------------

Func _ColorCheck($nColor1, $nColor2, $sVari = 5)
	Local $Red1, $Red2, $Blue1, $Blue2, $Green1, $Green2

	$Red1 = Dec(StringMid(String($nColor1), 1, 2))
	$Blue1 = Dec(StringMid(String($nColor1), 3, 2))
	$Green1 = Dec(StringMid(String($nColor1), 5, 2))

	$Red2 = Dec(StringMid(String($nColor2), 1, 2))
	$Blue2 = Dec(StringMid(String($nColor2), 3, 2))
	$Green2 = Dec(StringMid(String($nColor2), 5, 2))

	If Abs($Blue1 - $Blue2) > $sVari Then Return False
	If Abs($Green1 - $Green2) > $sVari Then Return False
	If Abs($Red1 - $Red2) > $sVari Then Return False
	Return True
EndFunc   ;==>_ColorCheck

; CheckPixel : takes an array[4] as a parameter, [x, y, color, tolerance]
Func CheckPixel($tab)
	If _ColorCheck(_GetPixelColor($tab[0], $tab[1]), Hex($tab[2], 6), $tab[3]) Then
		Return True
	Else
		SetLog("Location- X:"&$tab[0] & " Y:" & $tab[1], $COLOR_RED)
		SetLog("Wanted:" & _GetPixelColor($tab[0], $tab[1]), $COLOR_RED)
		SetLog("Got:" & Hex($tab[2], 6), $COLOR_RED)
		SetLog("Variance:" & $tab[3], $COLOR_RED)
		Return False
	EndIf
EndFunc   ;==>CheckPixel
