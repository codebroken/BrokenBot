;Checks whether something is blocking the pixel for mainscreen and tries to unblock
;Returns True when there is something blocking

Func checkObstacles() ;Checks if something is in the way for mainscreen
	Local $x, $y
	_CaptureRegion()
	If _ImageSearchArea($device, 0, 237, 321, 293, 346, $x, $y, 80) Then
		SetLog(GetLangText("msgAnotherDev") & $itxtReconnect & GetLangText("msgAnotherDevMinutes"), $COLOR_RED)
		If _Sleep($itxtReconnect * 60000) Then Return
		$iTimeTroops = 0
		Click(416, 399);Check for "Another device" message
		If _Sleep(6000) Then Return
		$Checkrearm = True
		ZoomOut()
		Return True
	EndIf

	If _ImageSearch($break, 0, $x, $y, 80) Then
		SetLog(GetLangText("msgTakeBreak"), $COLOR_RED)
		If _Sleep(120000) Then Return ; 2 Minutes
		Click(416, 399);Check for "Take a break" message
		$Checkrearm = True
		Return True
	EndIf

	$Message = _PixelSearch(457, 300, 458, 330, Hex(0x33B5E5, 6), 10)
	If IsArray($Message) Then
		Click(416, 399);Check for out of sync or inactivity
		If _Sleep(6000) Then Return
		ZoomOut()
		Return True
	EndIf

	_CaptureRegion()
	If _ColorCheck(_GetPixelColor(235, 209), Hex(0x9E3826, 6), 20) Then
		Click(429, 493);See if village was attacked, clicks Okay
		$Checkrearm = True
		Return True
	EndIf

	If _ColorCheck(_GetPixelColor(284, 28), Hex(0x215B69, 6), 20) Then
		Click(1, 1) ;Click away If things are open
		Return True
	EndIf

	If _ColorCheck(_GetPixelColor(819, 55), Hex(0xD80400, 6), 20) Then
		Click(819, 55) ;Clicks X
		Return True
	EndIf

	If _ColorCheck(_GetPixelColor(822, 48), Hex(0xD80408, 6), 20) Or _ColorCheck(_GetPixelColor(830, 59), Hex(0xD80408, 6), 20) Then
		Click(822, 48) ;Clicks X
		Return True
	EndIf

	If _ColorCheck(_GetPixelColor(331, 330), Hex(0xF0A03B, 6), 20) Then
		Click(331, 330) ;Clicks chat thing
		If _Sleep(1000) Then Return
		Return True
	EndIf

	If _ColorCheck(_GetPixelColor(429, 519), Hex(0xB8E35F, 6), 20) Then
		Click(429, 519) ;If in that victory or defeat scene
		Return True
	EndIf

	If _ColorCheck(_GetPixelColor(71, 530), Hex(0xC00000, 6), 20) Then
		ReturnHome(False, False) ;If End battle is available
		Return True
	EndIf

	$Message = _PixelSearch(19, 565, 104, 580, Hex(0xD9DDCF, 6), 10)
	If IsArray($Message) Then
		Click(67, 602);Check if Return Home button available
		If _Sleep(2000) Then Return
		Return True
	EndIf

	Return False
EndFunc   ;==>checkObstacles
