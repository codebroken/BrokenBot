;Goes into a match, breaks shield if it has to
; Returns True if successful, otherwise False after 10 failed attempts
Func PrepareSearch() ;Click attack button and find match button, will break shield

	Click(60, 614);Click Attack Button
	SetLog(GetLangText("msgSearchingMatch"))
	If _WaitForColorArea(287, 494, 5, 5, Hex(0xEEAC28, 6), 50) Then
		Click(217, 510);Click Find a Match Button
		; Is shield active?
		If _WaitForColorArea(513, 416, 5, 5, Hex(0x5DAC10, 6), 50, 1) Then
			Click(513, 416)
		EndIf
		If _WaitForColorArea(23, 523, 25, 10, Hex(0xEE5056, 6), 50, 10) Then Return True
	Else
		;Something is wrong here, restart bluestack
		restartBlueStack()
	EndIf
	Return False
EndFunc   ;==>PrepareSearch
