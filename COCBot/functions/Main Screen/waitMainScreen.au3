;Waits 5 minutes for the pixel of mainscreen to be located, checks for obstacles every 2 seconds.
;After five minutes, will try to restart bluestacks.

Func waitMainScreen() ;Waits for main screen to popup
	If ($ichkForceBS) = 1 Then
		WinActivate($HWnD)
	EndIf
	SetLog("Waiting for Main Screen", $COLOR_ORANGE)
	For $i = 0 To 150 ;150*2000 = 5 Minutes
		_CaptureRegion()
		If Not _ColorCheck(_GetPixelColor(284, 28), Hex(0x41B1CD, 6), 20) Then ;Checks for Main Screen
			If _Sleep(2000) Then Return
			If checkObstacles() Then $i = 0 ;See if there is anything in the way of mainscreen
		Else
			Return
		EndIf
	Next

	SetLog("Unable to load Clash Of Clans, Restarting...", $COLOR_RED)
	Local $RestartApp = StringReplace(_WinAPI_GetProcessFileName(WinGetProcess($Title)), "Frontend", "Restart")
	Run($RestartApp & " Android")
	If _Sleep(10000) Then Return

	Do
		If _Sleep(5000) Then Return
	Until ControlGetHandle($Title, "", "BlueStacksApp1") <> 0
EndFunc   ;==>waitMainScreen
