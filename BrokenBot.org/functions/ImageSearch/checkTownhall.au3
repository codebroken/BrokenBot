; This code was created for public use by BrokenBot.org and falls under the GPLv3 license.
; This code can be incorporated into open source/non-profit projects free of charge and without consent.
; **NOT FOR COMMERCIAL USE** by any project which includes any part of the code in this sub-directory without express written consent of BrokenBot.org
; You **MAY NOT SOLICIT DONATIONS** from any project which includes any part of the code in this sub-directory without express written consent of BrokenBot.org
;
Func checkTownhall()
	$res = CallHelper("0 0 860 720 BrokenBotMatchBuilding 1 1 1")

	If $res = $DLLFailed or $res = $DLLTimeout Then
		SetLog(GetLangText("msgDLLError"), $COLOR_RED)
		$THx = 0
		$THy = 0
		Return "-" ; return 0
	Else
		If $res = $DLLNegative Then
			; failed to find TH
			If $DebugMode = 1 Then
				_CaptureRegion()
				_GDIPlus_ImageSaveToFile($hBitmap, $dirDebug & "NegTH-" & @HOUR & @MIN & @SEC & ".png")
			EndIf
			$THx = 0
			$THy = 0
			Return "-" ; return 0
		ElseIf $res = $DLLLicense Then
			SetLog(GetLangText("msgLicense"), $COLOR_RED)
		Else
			$res = StringSplit($res, "|", 2)
			$THx = $res[1]
			$THy = $res[2]
			If $DebugMode = 1 Then
				_CaptureRegion()
				$hClone = _GDIPlus_BitmapCloneArea($hBitmap, $THx - 30, $THy - 30, 60, 60, _GDIPlus_ImageGetPixelFormat($hBitmap))
				$j = 1
				Do
					If Not FileExists($dirDebug & "PosTH-x" & $THx & "y" & $THy & " (" & $j & ").jpg") Then ExitLoop
					$j = $j + 1
				Until $j = 1000
				_GDIPlus_ImageSaveToFile($hClone, $dirDebug & "PosTH-x" & $THx & "y" & $THy & " (" & $j & ").jpg")
				_GDIPlus_ImageDispose($hClone)
			EndIf
			If $res[4] < 7 Then
				Return $THText[0]
			Else
				Return $THText[$res[4] - 6]
			EndIf
		EndIf
	EndIf
EndFunc   ;==>checkTownhall
