;Checks if your Elixir Storages are maxed out

Func isElixirFull()
	_CaptureRegion()
	;-----------------------------------------------------------------------------
	If _ColorCheck(_GetPixelColor(658, 84), Hex(0x000000, 6), 6) Then ;Hex is black
		If _ColorCheck(_GetPixelColor(660, 84), Hex(0xAE1AB3, 6), 6) Then ;Hex if color of elixir (purple)
			SetLog("Elixir Storages is full!", $COLOR_GREEN)
			Return True
		EndIf
	EndIf
	
	Return False
EndFunc   ;==>isElixirFull
