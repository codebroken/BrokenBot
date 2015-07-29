; Pauses exectution for number of milliseconds
; Returns True if bot no longer running

Func _Sleep($iDelay, $iSleep = True, $ReturnIfStopped = True)
	Local $iBegin = TimerInit()
	Local $count = 0
	While TimerDiff($iBegin) < $iDelay
		If $ReturnIfStopped Then
			If BitAND(GUICtrlGetState($btnStop), $GUI_HIDE) Then Return True
		EndIf
		While GUICtrlRead($btnPause) = "Resume"
			$count += 1
			If Mod($count, 600) = 0 Then _BumpMouse()
			If _GUICtrlTab_GetCurSel($tabMain) = 0 Then
				ControlShow("", "", $txtLog)
			Else
				ControlHide("", "", $txtLog)
			EndIf
			If $iSleep = True Then _ModifiedSleep(50)
		WEnd
		If _GUICtrlTab_GetCurSel($tabMain) = 0 Then
			ControlShow("", "", $txtLog)
		Else
			ControlHide("", "", $txtLog)
		EndIf
		If $iSleep = True Then
			_ModifiedSleep(50)
		Else
			_ModifiedSleep(1)
		EndIf
	WEnd
	Return False
EndFunc   ;==>_Sleep

Func _ModifiedSleep($T)
	DllCall($KernelDLL, "none", "Sleep", "long", $T)
EndFunc ;==>_ModifiedSLeep