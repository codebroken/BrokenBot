;Function needed by all strategies


;Check Out of Sync or Disconnection, if detected, bump speedBump by 0.5 seconds
Func ChkDisconnection()
	Local $disconnected = False
	_CaptureRegion()
	Local $dummyX = 0
	Local $dummyY = 0
	If _ImageSearch(@ScriptDir & "\images\Client.bmp", 1, $dummyX, $dummyY, 50) = 1 Then
		If $dummyX > 290 And $dummyX < 310 And $dummyY > 325 And $dummyY < 340 Then
			$disconnected = True
			$speedBump += 500
			If $speedBump > 5000 Then
				$speedBump = 5000
				SetLog("Out of sync! Already searching slowly, not changing anything.", $COLOR_RED)
			Else
				SetLog("Out of sync! Slowing search speed by 0.5 secs.", $COLOR_RED)
			EndIf
		EndIf
	EndIf
	If _ImageSearch(@ScriptDir & "\images\Lost.bmp", 1, $dummyX, $dummyY, 50) = 1 Then
		If $dummyX > 320 and $dummyX < 350 and $dummyY > 330 and $dummyY < 350 Then
			$disconnected = True
			$speedBump += 500
			If $speedBump > 5000 Then
				$speedBump=5000
				SetLog("Lost Connection! Already searching slowly, not changing anything.", $COLOR_RED)
			Else
				SetLog("Lost Connection! Slowing search speed by 0.5 secs.", $COLOR_RED)
			EndIf
		EndIf
	EndIf
	Return $disconnected
EndFunc