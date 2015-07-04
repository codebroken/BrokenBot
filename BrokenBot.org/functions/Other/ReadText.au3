Global Enum $textChat = 1, $textMainScreen, $textVillageSearch, $textReturnHome, $textWindows, $textWindowTitles, $textChatUser, $textDeployNumber
Global $textConstants[9][2] = [[0, ""], [10, "chatlog"], [12, "mainscreen"], [12, "villagesearch"], [16, "returnhome"], [10, "smallwindow"], [16, "smallwindowtitle"], [10, "chatuser"], [13, "deploynumber"]]

Func ReadText($x, $y, $width, $type, $leftaligned = 1, $reversed = 0)
	$height = $textConstants[$type][0]
	$name = $textConstants[$type][1]
;~ 	SetLog("Reading text type: " & $name & " at " & $x & ", " & $y & " width: " & $width & " left aligned: " & $leftaligned & " reversed: " & $reversed)
	_CaptureRegion()
	$hClone = _GDIPlus_BitmapCloneArea($hBitmap, $x, $y, $width, $height, _GDIPlus_ImageGetPixelFormat($hBitmap))
	If @error Then SetLog("Failed to properly clone the text area.")
	$hSendHBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hClone)
	If @error Then SetLog("Failed to make HBitmap")
	$Result = DllCall(@ScriptDir & "\BrokenBot.org\BrokenBot32.dll", "str", "BrokenBotReadText", "ptr", $hSendHBitmap, "int", $type, "int", $leftaligned, "int", $reversed)
	If @error Then SetLog("DLL Call failure: " & @error)
	_WinAPI_DeleteObject($hSendHBitmap)
	If IsArray($Result) Then
		If $Result[0] = -1 Then
			SetLog(GetLangText("msgDLLError") & " UNKNOWN TEXT TYPE", $COLOR_RED)
			Return -1
		ElseIf $Result[0] = -2 Then
			SetLog(GetLangText("msgLicense"), $COLOR_RED)
			Return -1
		Else
;~ 			SetLog("Returned data: " & $Result[0])
			Return $Result[0]
		EndIf
	Else
		SetLog(GetLangText("msgDLLError"), $COLOR_RED)
		Return -1
	EndIf

EndFunc
