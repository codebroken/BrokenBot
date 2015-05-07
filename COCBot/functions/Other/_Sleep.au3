; Pauses exectution for number of milliseconds
; Returns True if bot no longer running

Func _Sleep($iDelay, $iSleep = True, $ReturnIfStopped = True)
	Local $iBegin = TimerInit()
	While TimerDiff($iBegin) < $iDelay
		If $ReturnIfStopped Then
			If BitAND(GUICtrlGetState($btnStop), $GUI_HIDE) Then Return True
		EndIf
		If _GUICtrlTab_GetCurSel($tabMain) = 0 Then
			ControlShow("", "", $txtLog)
		Else
			ControlHide("", "", $txtLog)
		EndIf
		If $iSleep = True Then Sleep(50)
	WEnd
	Return False
EndFunc   ;==>_Sleep
