;Checks if your Gold Storages are maxed out

Func isGoldFull()
	_CaptureRegion()
	;-----------------------------------------------------------------------------
	If _ColorCheck(_GetPixelColor(658, 33), Hex(0x000000, 6), 6) Then ;Hex is black
		If _ColorCheck(_GetPixelColor(660, 33), Hex(0xD4B100, 6), 6) Then ;Hex if color of gold (orange)
			SetLog("Gold Storages is full!", $COLOR_GREEN)
			Return True
		EndIf
	EndIf
	
	Return False
EndFunc   ;==>isGoldFull
