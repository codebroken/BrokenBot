;Tries to zoom out of the screen until the borders, located at the top of the game (usually black), is located.

Func ZoomOut()
	$i = 0
	_CaptureRegion(0, 0, 860, 2)
	If _GetPixelColor(1, 1) <> Hex(0x000000, 6) And _GetPixelColor(850, 1) <> Hex(0x000000, 6) Then SetLog("Zooming Out", $COLOR_GREEN)
	While (_GetPixelColor(1, 1) <> Hex(0x000000, 6) And _GetPixelColor(850, 1) <> Hex(0x000000, 6)) And $i <= 20
		If _Sleep(600) Then Return
		If ControlSend($Title, "", "", "{DOWN}") Then $i += 1
		_CaptureRegion(0, 0, 860, 2)
	WEnd
	If _GetPixelColor(1, 1) <> Hex(0x000000, 6) And _GetPixelColor(850, 1) <> Hex(0x000000, 6) Then
		Return False
	Else
		Return True
	EndIf
EndFunc   ;==>ZoomOut
