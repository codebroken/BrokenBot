;Goes into a match, breaks shield if it has to
; Returns True if successful, otherwise False after 10 failed attempts
Func PrepareSearch() ;Click attack button and find match button, will break shield
	Click(60, 614);Click Attack Button
	SetLog("Searching for match...")
	If _WaitForColor(287, 494, Hex(0xEEAC28, 6), 50) Then
		Click(217, 510);Click Find a Match Button
		; Is shield active?
		If _WaitForColor(513, 416, Hex(0x5DAC10, 6), 50, 1) Then
			Click(513, 416)
		EndIf
		If _WaitForColor(30, 505, Hex(0xE80008, 6), 50, 10) Then Return True
	EndIf
	Return False
EndFunc   ;==>PrepareSearch
