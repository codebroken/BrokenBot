Func checkDarkElix()
	_CaptureRegion()
	$sendHBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap)
	$res = DllCall(@ScriptDir & "\BrokenBot.org\BrokenBot32.dll", "str", "BrokenBotMatchBuilding", "ptr", $sendHBitmap, "int", 13, "int", 3, "int", 1, "int", 1)
	_WinAPI_DeleteObject($sendHBitmap)
	If IsArray($res) Then
		If $res[0] = -1 Then
			; failed to find DE
			SetLog(GetLangText("msgNoDEStorage"), $COLOR_RED)
			If $DebugMode = 1 Then _GDIPlus_ImageSaveToFile($hBitmap, $dirDebug & "NegDE-" & @HOUR & @MIN & @SEC & ".png")
			$DEx = 0
			$DEy = 0
			Return False ; return 0
		Else
			$res = StringSplit($res[0], "|", 2)
			$DEx = $res[1]
			$DEy = $res[2]
			If $DebugMode = 1 Then
				$hClone = _GDIPlus_BitmapCloneArea($hBitmap, $DEx - 30, $DEy - 30, 60, 60, _GDIPlus_ImageGetPixelFormat($hBitmap))
				$j = 1
				Do
					If Not FileExists($dirDebug & "PosDE-x" & $DEx & "y" & $DEy & " (" & $j & ").jpg") Then ExitLoop
					$j = $j + 1
				Until $j = 1000
				_GDIPlus_ImageSaveToFile($hClone, $dirDebug & "PosDE-x" & $DEx & "y" & $DEy & " (" & $j & ").jpg")
				_GDIPlus_ImageDispose($hClone)
			EndIf
			Return True
		EndIf
	Else
		SetLog(GetLangText("msgDLLFailure"), $COLOR_RED)
		$DEx = 0
		$DEy = 0
		Return False ; return 0
	EndIf
EndFunc   ;==>checkDarkElix
