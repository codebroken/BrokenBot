Global Const $DLLTimeout = -9
Global Const $DLLFailed = -4
Global Const $DLLLicense = -2
Global Const $DLLNegative = -1

Func CallHelper($Command, $Timeout = 30)
	RegWrite("HKEY_CURRENT_USER\Software\BrokenBot", "Transfer", "REG_SZ", $DLLTimeout)

	If StringInStr($Command, "BrokenBotRedLineCheck") Then
		$FullCommand = '""' & @ScriptDir & "\BrokenBot.org\BrokenBotHelper.exe" & '""'
		$FullCommand &= " 1 "
		$FullCommand &= (IsChecked($chkBackground) ? ( "1" ) : ( "0")) & " "
		$FullCommand &= $Command
	ElseIf StringInStr($Command, "BrokenBotReadText") Then
		$FullCommand = '""' & @ScriptDir & "\BrokenBot.org\BrokenBotHelper.exe" & '""'
		$FullCommand &= " 2 "
		$FullCommand &= (IsChecked($chkBackground) ? ( "1" ) : ( "0")) & " "
		$FullCommand &= $Command
	Else
		$FullCommand = '""' & @ScriptDir & "\BrokenBot.org\BrokenBotHelper.exe" & '""'
		$FullCommand &= " 3 "
		$FullCommand &= (IsChecked($chkBackground) ? ( "1" ) : ( "0")) & " "
		$FullCommand &= $Command & " "
		$FullCommand &= (IsChecked($chkSpeedBoost) ? ( "1" ) : ( "0" ))
	EndIf

	Run(@ComSpec & " /c " & $FullCommand, "", @SW_HIDE)

	$index = 0
	While (RegRead("HKEY_CURRENT_USER\Software\BrokenBot", "Transfer") = $DLLTimeout) and $index < ($Timeout * 100)
		Sleep(10)
		$index += 1
	WEnd

	$res = StringStripWS(RegRead("HKEY_CURRENT_USER\Software\BrokenBot", "Transfer"), 3)
	Return $res
EndFunc