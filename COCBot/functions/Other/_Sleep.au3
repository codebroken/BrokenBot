; Pauses exectution for number of milliseconds
; Returns True if bot no longer running

Func _Sleep($iDelay, $iSleep = True)
	Local $iBegin = TimerInit()
	While TimerDiff($iBegin) < $iDelay
		If BitAND(GUICtrlGetState($btnStop), $GUI_HIDE) Then Return True
		If $iSleep = True Then Sleep(50)
	WEnd
	Return False
EndFunc   ;==>_Sleep
