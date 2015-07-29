Func Pause()
	Local $count = 0
	While GUICtrlRead($btnPause) = "Resume"
		$count += 1
		If _Sleep(100) Then Return True
		If Mod($count, 600) = 0 Then _BumpMouse()
	WEnd
	Return False
EndFunc   ;==>Pause
