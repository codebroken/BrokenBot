;This function checks whether the pixel, located in the eyes of the builder in mainscreen, is available
;If it is not available, it calls checkObstacles and also waitMainScreen.

Func checkMainScreen($Check = False, $maxDelay = 1) ;Checks if in main screen
	If $Check = True Then SetLog("Trying to locate Main Screen", $COLOR_BLUE)
	_WinAPI_EmptyWorkingSet(WinGetProcess($Title)) ; Reduce BlueStacks Memory Usage

	If Not _WaitForColor(284, 28, Hex(0x41B1CD, 6), 20, $maxDelay) Then
		While _ColorCheck(_GetPixelColor(284, 28), Hex(0x41B1CD, 6), 20) = False
			$HWnD = WinGetHandle($Title)
			If Not checkObstacles() Then
				Click(126, 700, 1, 500)
				Local $RunApp = StringReplace(_WinAPI_GetProcessFileName(WinGetProcess($Title)), "Frontend", "RunApp")
				Run($RunApp & " Android com.supercell.clashofclans com.supercell.clashofclans.GameApp")
			EndIf
			If _Sleep(3000) Then Return False
			waitMainScreen()
		WEnd
	EndIf
	If $Check = True Then SetLog("Main Screen Located", $COLOR_BLUE)
	If Not ZoomOut() Then
		SetLog("Failed to zoom out", $COLOR_BLUE)
		Return False
	Else
		Return True
	EndIf

EndFunc   ;==>checkMainScreen
