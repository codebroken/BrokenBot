Func _SatSearch($iLeft, $iTop, $iWidth, $iHeight, $satMin, $satMax)
	_CaptureRegion($iLeft, $iTop, $iLeft + $iWidth, $iTop + $iHeight)
	Local $RGB[3]
	For $x = 0 To $iWidth - 1
		For $y = 0 To $iHeight - 1
			$color = _GetPixelColor($x, $y)
			$RGB[0] = Dec(StringMid(String($Color), 1, 2))
			$RGB[1] = Dec(StringMid(String($Color), 3, 2))
			$RGB[2] = Dec(StringMid(String($Color), 5, 2))
			$HSL = RGBtoHSL($RGB)
			If $HSL[1] > $satMin And $HSL[1] < $satMax Then Return True
		Next
	Next
	Return False
EndFunc   ;==>_MultiPixelSearch

Func _HueSearch($iLeft, $iTop, $iWidth, $iHeight, $hueMin, $hueMax)
	_CaptureRegion($iLeft, $iTop, $iLeft + $iWidth, $iTop + $iHeight)
	Local $RGB[3]
	For $x = 0 To $iWidth - 1
		For $y = 0 To $iHeight - 1
			$color = _GetPixelColor($x, $y)
			$RGB[0] = Dec(StringMid(String($Color), 1, 2))
			$RGB[1] = Dec(StringMid(String($Color), 3, 2))
			$RGB[2] = Dec(StringMid(String($Color), 5, 2))
			$HSL = RGBtoHSL($RGB)
			If $HSL[0] > $hueMin And $HSL[0] < $hueMax Then Return True
		Next
	Next
	Return False
EndFunc   ;==>_MultiPixelSearch


Func RGBtoHSL($arColors)
	Const $MaxHSL = 100
	Const $MaxRGB = 255

	If UBound($arColors) <> 3 Or UBound($arColors, 0) <> 1 Then Return SetError(1, 0, 0)

    Local $nH, $nS, $nL
    Local $nR = Number($arColors[0])/$MaxRGB
    Local $nG = Number($arColors[1])/$MaxRGB
    Local $nB = Number($arColors[2])/$MaxRGB

    Local $nMax = $nR
    If $nMax < $nG Then $nMax = $nG
    If $nMax < $nB Then $nMax = $nB

    Local $nMin = $nR
    If $nMin > $nG Then $nMin = $nG
    If $nMin > $nB Then $nMin = $nB

    Local $nMinMaxSum = ($nMax + $nMin)
    Local $nMinMaxDiff = ($nMax - $nMin)

    $nL = $nMinMaxSum/2
    If $nMinMaxDiff = 0 Then
        $nH = 0
        $nS = 0
    Else
        If $nL < 0.5 Then
            $nS = $nMinMaxDiff/$nMinMaxSum
        Else
            $nS = $nMinMaxDiff/(2 - $nMinMaxSum)
        EndIf

        Switch $nMax
            Case $nR
                $nH = ($nG - $nB)/(6 * $nMinMaxDiff)
            Case $nG
                $nH = ($nB - $nR)/(6 * $nMinMaxDiff) + 1/3
            Case $nB
                $nH = ($nR - $nG)/(6 * $nMinMaxDiff) + 2/3
        EndSwitch
        If $nH < 0 Then $nH += 1
        If $nH > 1 Then $nH -= 1
    EndIf

    $arColors[0] = $nH * $MaxHSL
    $arColors[1] = $nS * $MaxHSL
    $arColors[2] = $nL * $MaxHSL

    Return $arColors
EndFunc
