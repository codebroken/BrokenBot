Func checkTownhall()
	$bumpTolerance = 70
	If _Sleep(500) Then Return
	Do
		_CaptureRegion()
		For $i = 1 To 50
			If FileExists(@ScriptDir & "\images\TH\townhall" & String($i) & ".bmp") Then
				$THLocation = _ImageSearch(@ScriptDir & "\images\TH\townhall" & String($i) & ".bmp", 1, $THx, $THy, $bumpTolerance) ; Getting TH Location
				If $THLocation = 1 Then
					If ((((65 - 280) / (367 - 78)) * ($THx - 78)) + 280 > $THy) Or ((((277 - 62) / (780 - 481)) * ($THx - 481)) + 62 > $THy) Or ((((540 - 343) / (338 - 78)) * ($THx - 78)) + 343 < $THy) Or ((((345 - 538) / (780 - 524)) * ($THx - 524)) + 538 < $THy) Then
						$THLocation = 0
						$THx = 0
						$THy = 0
					EndIf
				EndIf
				If $THLocation = 1 Then
					If $DebugMode = 1 Then
						$hClone = _GDIPlus_BitmapCloneArea($hBitmap, $THx - 30, $THy - 30, 60, 60, _GDIPlus_ImageGetPixelFormat($hBitmap))
						$j = 1
						Do
							If Not FileExists($dirDebug & "PosTH-" & $THText[Floor(($i - 1) / 10)] & "-" & $bumpTolerance & "(" & $j & ").jpg") Then ExitLoop
							$j = $j + 1
						Until $j = 1000
						_GDIPlus_ImageSaveToFile($hClone, $dirDebug & "PosTH-" & $THText[Floor(($i - 1) / 10)] & "(" & $j & ").jpg")
						_GDIPlus_ImageDispose($hClone)
					EndIf
					Return $THText[Floor(($i - 1) / 10)]
				EndIf
			EndIf
		Next
		$bumpTolerance += 5
	Until $bumpTolerance > 80
	If $THLocation = 0 Then
		If $DebugMode = 1 Then _GDIPlus_ImageSaveToFile($hBitmap, $dirDebug & "NegTH-" & @HOUR & @MIN & @SEC & ".png")
		Return "-"
	EndIf
EndFunc   ;==>checkTownhall
