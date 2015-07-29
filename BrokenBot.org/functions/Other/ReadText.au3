Global Enum $textChat = 1, $textMainScreen, $textVillageSearch, $textReturnHome, $textWindows, $textWindowTitles, $textChatUser, $textDeployNumber
Global $textConstants[9][2] = [[0, ""], [10, "chatlog"], [12, "mainscreen"], [12, "villagesearch"], [16, "returnhome"], [10, "smallwindow"], [16, "smallwindowtitle"], [10, "chatuser"], [13, "deploynumber"]]

Func ReadText($x, $y, $width, $type, $leftaligned = 1, $reversed = 0)
	$height = $textConstants[$type][0]
	$name = $textConstants[$type][1]
	$Result = CallHelper("0 0 860 720 BrokenBotReadText " & $x & " " & $y & " " & $width & " " & $height & " " & $type & " " & $leftaligned & " " & $reversed, 3)
	If $Result = $DLLFailed or $Result = $DLLTimeout or $Result = $DLLNegative Then
		SetLog(GetLangText("msgDLLError"), $COLOR_RED)
		Return -1
	ElseIf $Result = $DLLLicense Then
		SetLog(GetLangText("msgLicense"), $COLOR_RED)
		Return -1
	Else
		Return $Result
	EndIf
EndFunc
