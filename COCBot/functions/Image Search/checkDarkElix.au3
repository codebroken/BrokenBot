Func checkDarkElix()
	Local $bumpTolerance
	Local $maxTolerance
	If $DESearchMode = 1 Then
		$maxTolerance = 70
		$bumpTolerance = 60
	Else
		$maxTolerance = 100
		$bumpTolerance = 70
	EndIf
	If _Sleep(500) Then Return
	Do
		_CaptureRegion()
		For $i = 1 To 223
			If FileExists(@ScriptDir & "\images\DElix\DE" & String($i) & ".png") Then
				$DarkElixLocation = _ImageSearch(@ScriptDir & "\images\DElix\DE" & String($i) & ".png", 1, $DEx, $DEy, $bumpTolerance) ; Getting DE Location
				If $DarkElixLocation = 1 Then
					If ((((65 - 280) / (367 - 78)) * ($DEx - 78)) + 280 > $DEy) Or ((((277 - 62) / (780 - 481)) * ($DEx - 481)) + 62 > $DEy) Or ((((540 - 343) / (338 - 78)) * ($DEx - 78)) + 343 < $DEy) Or ((((345 - 538) / (780 - 524)) * ($DEx - 524)) + 538 < $DEy) Then
						$DarkElixLocation = 0
						$DEx = 0
						$DEy = 0
					EndIf
				EndIf
				If $DarkElixLocation = 1 Then
					If $DebugMode = 1 Then
						$sPath = $dirDebug & "DataDE.csv"
						If Not FileExists($sPath) Then
							$hFileHandle = FileOpen($sPath, $FO_APPEND + $FO_CREATEPATH)
							FileWriteLine($hFileHandle, "time,i,tolerance")
						Else
							$hFileHandle = FileOpen($sPath, $FO_APPEND)
						EndIf
						FileWriteLine($hFileHandle, @YEAR & "-" & @MON & "-" & @MDAY & "_" & @HOUR & "." & @MIN & "." & @SEC & "," & $i & "," & $bumpTolerance)
						FileClose($hFileHandle)
						$hClone = _GDIPlus_BitmapCloneArea($hBitmap, $DEx - 30, $DEy - 30, 60, 60, _GDIPlus_ImageGetPixelFormat($hBitmap))
						$j = 1
						Do
							If Not FileExists($dirDebug & (($DESearchMode = 1) ? ("") : ("LowACC-")) & "PosDE-" & $i & "-" & $bumpTolerance & " (" & $j & ").jpg") Then ExitLoop
							$j = $j + 1
						Until $j = 1000
						_GDIPlus_ImageSaveToFile($hClone, $dirDebug & (($DESearchMode = 1) ? ("") : ("LowACC-")) & "PosDE-" & $i & "-" & $bumpTolerance & " (" & $j & ").jpg")
						_GDIPlus_ImageDispose($hClone)
					EndIf
					Return True
				EndIf
			EndIf
		Next
		$bumpTolerance += 10
	Until $bumpTolerance > $maxTolerance

	If $DarkElixLocation = 0 Then
		SetLog("No dark elixir storage was found!", $COLOR_RED)
		If $DebugMode = 1 Then _GDIPlus_ImageSaveToFile($hBitmap, $dirDebug & (($DESearchMode = 1) ? ("") : ("LowACC-")) & "NegDE-" & @HOUR & @MIN & @SEC & ".png")
		$DEx = 0
		$DEy = 0
		Return False ; return 0
	EndIf
EndFunc   ;==>checkDarkElix
