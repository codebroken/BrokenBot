Func SetTime()
	Local $time = _TicksToTime(Int(TimerDiff($sTimer)), $hour, $min, $sec)
	If _GUICtrlTab_GetCurSel($tabMain) = 10 Then GUICtrlSetData($lblresultruntime, StringFormat("%02i:%02i:%02i", $hour, $min, $sec))
	If IsChecked($lblpushbulletremote) Then
		If StringFormat("%02i", $sec) = "50" Then
			_RemoteControl()
		EndIf
	EndIf
EndFunc   ;==>SetTime

Func Initiate()
	If IsArray(ControlGetPos($Title, "_ctl.Window", "[CLASS:BlueStacksApp; INSTANCE:1]")) Then
		Local $BSsize = [ControlGetPos($Title, "_ctl.Window", "[CLASS:BlueStacksApp; INSTANCE:1]")[2], ControlGetPos($Title, "_ctl.Window", "[CLASS:BlueStacksApp; INSTANCE:1]")[3]]
		Local $fullScreenRegistryData = RegRead($REGISTRY_KEY_DIRECTORY, "FullScreen")
		Local $guestHeightRegistryData = RegRead($REGISTRY_KEY_DIRECTORY, "GuestHeight")
		Local $guestWidthRegistryData = RegRead($REGISTRY_KEY_DIRECTORY, "GuestWidth")
		Local $windowHeightRegistryData = RegRead($REGISTRY_KEY_DIRECTORY, "WindowHeight")
		Local $windowWidthRegistryData = RegRead($REGISTRY_KEY_DIRECTORY, "WindowWidth")

		Local $BSx = ($BSsize[0] > $BSsize[1]) ? $BSsize[0] : $BSsize[1]
		Local $BSy = ($BSsize[0] > $BSsize[1]) ? $BSsize[1] : $BSsize[0]

		$Running = True

		If $BSx <> 860 Or $BSy <> 720 Then
			RegWrite($REGISTRY_KEY_DIRECTORY, "FullScreen", "REG_DWORD", "0")
			RegWrite($REGISTRY_KEY_DIRECTORY, "GuestHeight", "REG_DWORD", $DEFAULT_HEIGHT)
			RegWrite($REGISTRY_KEY_DIRECTORY, "GuestWidth", "REG_DWORD", $DEFAULT_WIDTH)
			RegWrite($REGISTRY_KEY_DIRECTORY, "WindowHeight", "REG_DWORD", $DEFAULT_HEIGHT)
			RegWrite($REGISTRY_KEY_DIRECTORY, "WindowWidth", "REG_DWORD", $DEFAULT_WIDTH)
			SetLog("Please restart your computer for the applied changes to take effect.", $COLOR_ORANGE)
			_Sleep(3000)
			$MsgRet = MsgBox(BitOR($MB_OKCANCEL, $MB_SYSTEMMODAL), "Restart Computer", "Restart your computer for the applied changes to take effect." & @CRLF & "If your BlueStacks is the correct size  (860 x 720), click OK.", 10)
			If $MsgRet <> $IDOK Then
				btnStop()
				Return
			EndIf
		EndIf

		WinActivate($Title)

		SetLog("~~~~Welcome to " & $sBotTitle & "!~~~~", $COLOR_PURPLE)
		SetLog($Compiled & " running on " & @OSArch & " OS", $COLOR_GREEN)
		SetLog("Bot is starting...", $COLOR_ORANGE)

		If IsChecked($lblpushbulletenabled) And IsChecked($lblpushbulletdelete) Then
			_DeletePush()
		EndIf

		$AttackNow = False
		$FirstStart = True
		$Checkrearm = True
		GUICtrlSetState($cmbBoostBarracks, $GUI_DISABLE)
		GUICtrlSetState($btnLocateDarkBarracks, $GUI_DISABLE)
		GUICtrlSetState($btnLocateBarracks, $GUI_DISABLE)
		GUICtrlSetState($btnLocateCamp, $GUI_DISABLE)
		GUICtrlSetState($btnFindWall, $GUI_DISABLE)
		GUICtrlSetState($chkBackground, $GUI_DISABLE)
		GUICtrlSetState($chkNoAttack, $GUI_DISABLE)
		GUICtrlSetState($chkDonateOnly, $GUI_DISABLE)
		GUICtrlSetState($chkForceBS, $GUI_DISABLE)
		GUICtrlSetState($btnLocateTownHall, $GUI_DISABLE)
		GUICtrlSetState($btnLocateKingAltar, $GUI_DISABLE)
		GUICtrlSetState($btnLocateQueenAltar, $GUI_DISABLE)
		GUICtrlSetState($btnLoad, $GUI_DISABLE)
		GUICtrlSetState($btnSave, $GUI_DISABLE)
		GUICtrlSetState($btnLocateClanCastle, $GUI_DISABLE)
		GUICtrlSetState($btnLocateSFactory, $GUI_DISABLE)
		$sTimer = TimerInit()
		AdlibRegister("SetTime", 1000)
		runBot()
		GUICtrlSetState($btnStart, $GUI_ENABLE)
		GUICtrlSetData($btnStart, "Start Bot")
	Else
		SetLog("Not in Game!", $COLOR_RED)
		btnStop()
	EndIf
EndFunc   ;==>Initiate

Func Open()
	If $64Bit Then ;If 64-Bit
		ShellExecute("C:\Program Files (x86)\BlueStacks\HD-StartLauncher.exe")
		SetLog("Starting BlueStacks", $COLOR_GREEN)
		Sleep(290)
		SetLog("Waiting for BlueStacks to initiate...", $COLOR_GREEN)
		Check()
	Else ;If 32-Bit
		ShellExecute("C:\Program Files\BlueStacks\HD-StartLauncher.exe")
		SetLog("Starting BlueStacks", $COLOR_GREEN)
		Sleep(290)
		SetLog("Waiting for BlueStacks to initiate...", $COLOR_GREEN)
		Check()
	EndIf
EndFunc   ;==>Open

Func Check()
	If IsArray(ControlGetPos($Title, "_ctl.Window", "[CLASS:BlueStacksApp; INSTANCE:1]")) Then
		SetLog("BlueStacks Loaded, took " & ($Initiate) & " seconds to begin.", $COLOR_GREEN)
		Initiate()
	Else
		Sleep(1000)
		$Initiate = $Initiate + 1
		Check()
	EndIf
EndFunc   ;==>Check

Func getfilename($psFilename)
	Local $szDrive, $szDir, $szFName, $szExt
	_PathSplit($psFilename, $szDrive, $szDir, $szFName, $szExt)
	Return $szFName & $szExt
EndFunc   ;==>getfilename


