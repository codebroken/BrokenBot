;Checks if your Elixir Storages are maxed out

Func isDarkElixirFull()
	_CaptureRegion()
	;-----------------------------------------------------------------------------
	If _ColorCheck(_GetPixelColor(707, 128), Hex(0x000000, 6), 6) Then ;Hex is black
		If _ColorCheck(_GetPixelColor(708, 128), Hex(0x1A0026, 6), 20) Then ;Hex if color of dark elixir
			SetLog(GetLangText("msgDarkElixirFull"), $COLOR_GREEN)
			Return True
		EndIf
	EndIf

	Return False
EndFunc   ;==>isElixirFull
