#include <Constants.au3>

Func handleBarracksError($i) ;Sets the text for the log
	If $i = 0 Then $brerror[0] = True
	If $i = 1 Then $brerror[1] = True
	If $i = 2 Then $brerror[2] = True
	If $i = 3 Then $brerror[3] = True

	If $brerror[0] = True And $brerror[1] = True And $brerror[2] = True And $brerror[3] = True Then
		SetLog(GetLangText("msgRestartBarracks"), $COLOR_RED)
		Local $RestartApp = StringReplace(_WinAPI_GetProcessFileName(WinGetProcess($Title)), "Frontend", "Restart")
		Run($RestartApp & " Android")
		If _Sleep(10000) Then Return
		Do
			If _Sleep(5000) Then Return
		Until ControlGetHandle($Title, "", "BlueStacksApp1") <> 0
	EndIf
EndFunc   ;==>handleBarracksError

Func resetBarracksError()
	$brerror[0] = False
	$brerror[1] = False
	$brerror[2] = False
	$brerror[3] = False
EndFunc   ;==>resetBarracksError
