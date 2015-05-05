Opt("GUIOnEventMode", 1)
Opt("MouseClickDelay", 10)
Opt("MouseClickDownDelay", 10)
Opt("TrayMenuMode", 3)

_GDIPlus_Startup()

Global Const $64Bit = StringInStr(@OSArch, "64") > 0
Global Const $DEFAULT_HEIGHT = 720
Global Const $DEFAULT_WIDTH = 860
Global $Initiate = 0
Global Const $REGISTRY_KEY_DIRECTORY = "HKEY_LOCAL_MACHINE\SOFTWARE\BlueStacks\Guests\Android\FrameBuffer\0"

Func GUIControl($hWind, $iMsg, $wParam, $lParam)
	Local $nNotifyCode = BitShift($wParam, 16)
	Local $nID = BitAND($wParam, 0x0000FFFF)
	Local $hCtrl = $lParam
	#forceref $hWind, $iMsg, $wParam, $lParam

	If @error Then Return
	If $hWind <> $frmAttackConfig Then
		Switch $iMsg
			Case 273
				Switch $nID
					Case $GUI_EVENT_CLOSE
						SetLog("Exiting !!!", $COLOR_ORANGE)
						_GDIPlus_Shutdown()
						_GUICtrlRichEdit_Destroy($txtLog)
						SaveConfig()
						Exit
					Case $btnStop
						btnStop()
					Case $btnAtkNow
						btnAtkNow()
					Case $btnHide
						btnHide()
					Case $btnPause
						btnPause()
					Case $chkRequest
						chkRequest()
					Case $tabMain
						tabMain()
					Case $Randomspeedatk
						Randomspeedatk()
					Case $chkNoAttack
						If IsChecked($chkNoAttack) Then
							If IsChecked($lblpushbulletenabled) Then
								SetLog("PushBullet is disabled !!!", $COLOR_RED)
							EndIf
							GUICtrlSetState($chkDonateOnly, $GUI_UNCHECKED)
							GUICtrlSetState($expMode, $GUI_UNCHECKED)
							GUICtrlSetState($lblpushbulletenabled, $GUI_UNCHECKED)
							GUICtrlSetState($lblpushbulletenabled, $GUI_DISABLE)
							lblpushbulletenabled()
						Else
							GUICtrlSetState($lblpushbulletenabled, $GUI_ENABLE)
						EndIf
					Case $chkDonateOnly
						If IsChecked($chkDonateOnly) Then
							If IsChecked($lblpushbulletenabled) Then
								SetLog("PushBullet is disabled !!!", $COLOR_RED)
							EndIf
							GUICtrlSetState($chkNoAttack, $GUI_UNCHECKED)
							GUICtrlSetState($expMode, $GUI_UNCHECKED)
							GUICtrlSetState($lblpushbulletenabled, $GUI_UNCHECKED)
							GUICtrlSetState($lblpushbulletenabled, $GUI_DISABLE)
							lblpushbulletenabled()
						Else
							GUICtrlSetState($lblpushbulletenabled, $GUI_ENABLE)
						EndIf
					Case $expMode
						If IsChecked($expMode) Then
							If IsChecked($lblpushbulletenabled) Then
								SetLog("PushBullet is disabled !!!", $COLOR_RED)
							EndIf
							GUICtrlSetState($chkNoAttack, $GUI_UNCHECKED)
							GUICtrlSetState($chkDonateOnly, $GUI_UNCHECKED)
							GUICtrlSetState($lblpushbulletenabled, $GUI_UNCHECKED)
							GUICtrlSetState($lblpushbulletenabled, $GUI_DISABLE)
							lblpushbulletenabled()
						Else
							GUICtrlSetState($lblpushbulletenabled, $GUI_ENABLE)
						EndIf
					Case $chkUpgrade1
						chkUpgrade1()
					Case $chkUpgrade2
						chkUpgrade2()
					Case $chkUpgrade3
						chkUpgrade3()
					Case $chkUpgrade4
						chkUpgrade4()
					Case $chkUpgrade5
						chkUpgrade5()
					Case $chkUpgrade6
						chkUpgrade6()
					Case $UseJPG
						UseJPG()
					Case $UseAttackJPG
						UseAttackJPG()
					Case $lblpushbulletenabled
						lblpushbulletenabled()
					Case $btnGitHub
						ShellExecute("http://http://www.brokenbot.org/forum/index.php?u=/category/support-forums")
					Case $btnCloseBR
						GUISetState(@SW_ENABLE, $frmBot)
						GUISetState(@SW_HIDE, $frmBugReport)
						WinActivate($frmBot)
					Case $imgLogo
						openWebsite()
					Case $btnSaveStrat
						_btnSaveStrat()
					Case $lstStrategies
						If $nNotifyCode = 1 Then _lstStrategies()
					Case 10000
						If _GUICtrlTab_GetCurSel($tabMain) = 0 Then
							ControlShow("", "", $txtLog)
						Else
							ControlHide("", "", $txtLog)
						EndIf
					Case Else
				EndSwitch
			Case 274
				Switch $wParam
					Case 0xf060
						SetLog("Exiting !!!", $COLOR_ORANGE)
						_GDIPlus_Shutdown()
						_GUICtrlRichEdit_Destroy($txtLog)
						SaveConfig()
						Exit
				EndSwitch
		EndSwitch
	Else
		If IsArray($PluginEvents) Then
			For $i = 1 To $PluginEvents[0][0]
				If $nID = $PluginEvents[$i][0] And $nNotifyCode = $PluginEvents[$i][1] Then
					$strPlugInInUse = IniRead($dirStrat & GUICtrlRead($lstStrategies) & ".ini", "plugin", "name", "")
					Call($strPlugInInUse & $PluginEvents[$i][2])
				EndIf
			Next
		EndIf
	EndIf
	Return $GUI_RUNDEFMSG
EndFunc   ;==>GUIControl

Func btnStart()
	If BitAND(GUICtrlGetState($btnStart), $GUI_SHOW) Then

		GUICtrlSetState($btnStart, $GUI_HIDE)
		If IsChecked($chkBackground) Then GUICtrlSetState($btnHide, $GUI_ENABLE)
		GUICtrlSetState($btnPause, $GUI_ENABLE)
		GUICtrlSetData($btnPause, "Pause")
		GUICtrlSetState($btnStop, $GUI_SHOW)
		If _GUICtrlTab_GetCurSel($tabMain) = 1 Then
			_btnSaveStrat(GUICtrlRead($lstStrategies))
			DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $frmAttackConfig, "int", 500, "long", $slideIn)
			GUISetState(@SW_HIDE, $frmAttackConfig)
		EndIf
		GUICtrlSetState($pageGeneral, $GUI_SHOW)
		$FirstAttack = True

		CreateLogFile()

		SaveConfig()
		readConfig()
		applyConfig()

		_GUICtrlEdit_SetText($txtLog, "")

		If WinExists($Title) Then
			DisableBS($HWnD, $SC_MINIMIZE)
			DisableBS($HWnD, $SC_CLOSE)
			Initiate()
		Else
			Open()
		EndIf
	EndIf
EndFunc   ;==>btnStart

Func btnStop()
	If BitAND(GUICtrlGetState($btnStop), $GUI_SHOW) Then
		GUICtrlSetData($btnStart, "Stopping...")
		GUICtrlSetState($btnStart, $GUI_SHOW)
		GUICtrlSetState($btnStart, $GUI_DISABLE)
		GUICtrlSetState($btnPause, $GUI_DISABLE)
		GUICtrlSetData($btnPause, "Pause")
		GUICtrlSetState($btnStop, $GUI_HIDE)
		$Raid = 0
		$PauseBot = False
		$Running = False
		$AttackNow = False
		EnableBS($HWnD, $SC_MINIMIZE)
		EnableBS($HWnD, $SC_CLOSE)
		GUICtrlSetState($btnLocateBarracks, $GUI_ENABLE)
		GUICtrlSetState($btnLocateDarkBarracks, $GUI_ENABLE)
		GUICtrlSetState($btnLocateSFactory, $GUI_ENABLE)
		GUICtrlSetState($btnLocateTownHall, $GUI_ENABLE)
		GUICtrlSetState($btnLocateKingAltar, $GUI_ENABLE)
		GUICtrlSetState($btnLocateQueenAltar, $GUI_ENABLE)
		GUICtrlSetState($btnLocateCamp, $GUI_ENABLE)
		GUICtrlSetState($btnFindWall, $GUI_ENABLE)
		GUICtrlSetState($chkBackground, $GUI_ENABLE)
		GUICtrlSetState($chkNoAttack, $GUI_ENABLE)
		GUICtrlSetState($chkDonateOnly, $GUI_ENABLE)
		GUICtrlSetState($chkForceBS, $GUI_ENABLE)
		GUICtrlSetState($btnLocateClanCastle, $GUI_ENABLE)
		GUICtrlSetState($chkBackground, $GUI_ENABLE)
		GUICtrlSetState($cmbBoostBarracks, $GUI_ENABLE)
		GUICtrlSetState($btnAtkNow, $GUI_DISABLE)
		GUICtrlSetState($btnLoad, $GUI_ENABLE)
		GUICtrlSetState($btnSave, $GUI_ENABLE)
		If _GUICtrlTab_GetCurSel($tabMain) = 1 Then
			GUISetState(@SW_HIDE, $frmAttackConfig)
			DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $frmAttackConfig, "int", 500, "long", $slideOut)
			GUISetState(@SW_SHOW, $frmAttackConfig)
			GUICtrlSetState($DefaultTab, $GUI_SHOW)
		EndIf

		;AdlibUnRegister("SetTime")
		_BlockInputEx(0, "", "", $HWnD)

		FileClose($hLogFileHandle)
		SetLog("BrokenBot has stopped", $COLOR_ORANGE)
		GUICtrlSetState($btnHide, $GUI_DISABLE)
	EndIf
EndFunc   ;==>btnStop

Func btnPause()
	If GUICtrlRead($btnPause) = "Pause" Then
		GUICtrlSetData($btnPause, "Resume")
		If _GUICtrlTab_GetCurSel($tabMain) = 1 Then
			GUISetState(@SW_HIDE, $frmAttackConfig)
			DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $frmAttackConfig, "int", 500, "long", $slideOut)
			GUISetState(@SW_SHOW, $frmAttackConfig)
			GUICtrlSetState($DefaultTab, $GUI_SHOW)
		EndIf
	Else
		GUICtrlSetData($btnPause, "Pause")
		If _GUICtrlTab_GetCurSel($tabMain) = 1 Then
			_btnSaveStrat(GUICtrlRead($lstStrategies))
			DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $frmAttackConfig, "int", 500, "long", $slideIn)
			GUISetState(@SW_HIDE, $frmAttackConfig)
		EndIf
		GUICtrlSetState($pageGeneral, $GUI_SHOW)
	EndIf
EndFunc   ;==>btnPause

Func btnAtkNow()
	$AttackNow = True
	GUICtrlSetState($btnAtkNow, $GUI_DISABLE)
EndFunc   ;==>btnAtkNow

Func btnLocateBarracks()
	$Running = True
	While 1
		ZoomOut()
		LocateBarrack()
		ExitLoop
	WEnd
	$Running = False
EndFunc   ;==>btnLocateBarracks

Func btnLocateDarkBarracks()
	$Running = True
	While 1
		ZoomOut()
		LocateDarkBarrack()
		ExitLoop
	WEnd
	$Running = False
EndFunc   ;==>btnLocateDarkBarracks

Func btnLocateSFactory()
	$Running = True
	While 1
		ZoomOut()
		LocateSpellFactory()
		ExitLoop
	WEnd
	$Running = False
EndFunc   ;==>btnLocateSFactory

Func btnLocateClanCastle()
	$Running = True
	While 1
		ZoomOut()
		LocateClanCastle()
		ExitLoop
	WEnd
	$Running = False
EndFunc   ;==>btnLocateClanCastle

Func btnLocateTownHall()
	$Running = True
	While 1
		ZoomOut()
		LocateTownHall()
		ExitLoop
	WEnd
	$Running = False
EndFunc   ;==>btnLocateTownHall

Func btnLocateKingAltar()
	$Running = True
	While 1
		ZoomOut()
		LocateKingAltar()
		ExitLoop
	WEnd
	$Running = False
EndFunc   ;==>btnLocateKingAltar

Func btnLocateQueenAltar()
	$Running = True
	While 1
		ZoomOut()
		LocateQueenAltar()
		ExitLoop
	WEnd
	$Running = False
EndFunc   ;==>btnLocateQueenAltar

Func btnLocatelist()
	$Running = True
	ZoomOut()
	LocateBuilding()
	$Running = False
EndFunc   ;==>btnLocatelist
Func btnLocateUp1()
	$Running = True
	While 1
		ZoomOut()
		LocateUpgrade1()
		ExitLoop
	WEnd
	$Running = False
EndFunc   ;==>btnLocateUp1

Func btnLocateUp2()
	$Running = True
	While 1
		ZoomOut()
		LocateUpgrade2()
		ExitLoop
	WEnd
	$Running = False
EndFunc   ;==>btnLocateUp2

Func btnLocateUp3()
	$Running = True
	While 1
		ZoomOut()
		LocateUpgrade3()
		ExitLoop
	WEnd
	$Running = False
EndFunc   ;==>btnLocateUp3
Func btnLocateUp4()
	$Running = True
	While 1
		ZoomOut()
		LocateUpgrade4()
		ExitLoop
	WEnd
	$Running = False
EndFunc   ;==>btnLocateUp4

Func btnLocateUp5()
	$Running = True
	While 1
		ZoomOut()
		LocateUpgrade5()
		ExitLoop
	WEnd
	$Running = False
EndFunc   ;==>btnLocateUp5

Func btnLocateUp6()
	$Running = True
	While 1
		ZoomOut()
		LocateUpgrade6()
		ExitLoop
	WEnd
	$Running = False
EndFunc   ;==>btnLocateUp6

Func btnFindWall()
	$Running = True
	GUICtrlSetState($chkWalls, $GUI_DISABLE)
	GUICtrlSetState($UseGold, $GUI_DISABLE)
	GUICtrlSetState($UseElixir, $GUI_DISABLE)
	GUICtrlSetState($UseGoldElix, $GUI_DISABLE)
	While 1
		SaveConfig()
		readConfig()
		applyConfig()
		ZoomOut()
		FindWall()
		ExitLoop
	WEnd
	GUICtrlSetState($chkWalls, $GUI_ENABLE)
	GUICtrlSetState($UseGold, $GUI_ENABLE)
	GUICtrlSetState($UseElixir, $GUI_ENABLE)
	GUICtrlSetState($UseGoldElix, $GUI_ENABLE)
	$Running = False
EndFunc   ;==>btnFindWall

Func btnLocateCamp()
	$Running = True
	While 1
		ZoomOut()
		Locatecamp()
		ExitLoop
	WEnd
	$Running = False
EndFunc   ;==>btnLocateCamp

Func btnHide()
	If $Hide = False Then
		GUICtrlSetData($btnHide, "Show BS")
		$botPos[0] = WinGetPos($Title)[0]
		$botPos[1] = WinGetPos($Title)[1]
		WinMove($Title, "", -32000, -32000)
		$Hide = True
	Else
		GUICtrlSetData($btnHide, "Hide BS")

		If $botPos[0] = -32000 Then
			WinMove($Title, "", 0, 0)
		Else
			WinMove($Title, "", $botPos[0], $botPos[1])
			WinActivate($Title)
		EndIf
		$Hide = False
	EndIf
EndFunc   ;==>btnHide

Func chkNoAttack()
	If IsChecked($chkNoAttack) Then
		$CurrentMode = $modeDonateTrain
		SetLog("~~~Donate / Train Only Activated~~~", $COLOR_PURPLE)
	ElseIf IsChecked($chkDonateOnly) Then
		If IsChecked($lblpushbulletenabled) Then
			SetLog("PushBullet is disabled !!!", $COLOR_RED)
		EndIf
		$CurrentMode = $modeDonate
		SetLog("~~~Donate Only Activated~~~", $COLOR_PURPLE)
	ElseIf IsChecked($expMode) Then
		If IsChecked($lblpushbulletenabled) Then
			SetLog("PushBullet is disabled !!!", $COLOR_RED)
		EndIf
		$CurrentMode = $modeExperience
		SetLog("~~~Goblin Mode Activated~~~", $COLOR_PURPLE)
	Else
		$CurrentMode = $modeNormal
	EndIf
EndFunc   ;==>chkNoAttack

Func chkRequest()
	If IsChecked($chkRequest) Then
		$ichkRequest = 1
		GUICtrlSetState($txtRequest, $GUI_ENABLE)
	Else
		$ichkRequest = 0
		GUICtrlSetState($txtRequest, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkRequest

Func Randomspeedatk()
	If IsChecked($Randomspeedatk) Then
		$iRandomspeedatk = 1
		GUICtrlSetState($cmbUnitDelay, $GUI_DISABLE)
		GUICtrlSetState($cmbWaveDelay, $GUI_DISABLE)
	Else
		$iRandomspeedatk = 0
		GUICtrlSetState($cmbUnitDelay, $GUI_ENABLE)
		GUICtrlSetState($cmbWaveDelay, $GUI_ENABLE)
	EndIf
EndFunc   ;==>Randomspeedatk

Func tabMain()
	If _GUICtrlTab_GetCurSel($tabMain) = 0 Then
		ControlShow("", "", $txtLog)
	Else
		ControlHide("", "", $txtLog)
	EndIf
	If _GUICtrlTab_GetCurSel($tabMain) = 1 And (BotStopped(False) Or GUICtrlRead($btnPause)="Resume") Then
		GUISetState(@SW_HIDE, $frmAttackConfig)
		DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $frmAttackConfig, "int", 500, "long", $slideOut)
		GUISetState(@SW_SHOW, $frmAttackConfig)
		GUICtrlSetState($DefaultTab, $GUI_SHOW)
	ElseIf $prevTab = 1 And (BotStopped(False) Or GUICtrlRead($btnPause)="Resume") Then
		_btnSaveStrat(GUICtrlRead($lstStrategies))
		DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $frmAttackConfig, "int", 500, "long", $slideIn)
		GUISetState(@SW_HIDE, $frmAttackConfig)
	Else
		GUISetState(@SW_HIDE, $frmAttackConfig)
	EndIf
	$prevTab = _GUICtrlTab_GetCurSel($tabMain)
EndFunc   ;==>tabMain

Func btnLoad($configfile)
	Local $sFileOpenDialog = FileOpenDialog("Open config", @ScriptDir & "\", "Config (*.ini;)", $FD_FILEMUSTEXIST)
	If @error Then
		MsgBox($MB_SYSTEMMODAL, "", "Error opening file!")
		FileChangeDir(@ScriptDir)
	Else
		FileChangeDir(@ScriptDir)
		$sFileOpenDialog = StringReplace($sFileOpenDialog, "|", @CRLF)
		$config = $sFileOpenDialog
		readConfig()
		applyConfig()
		saveConfig()
		MsgBox($MB_SYSTEMMODAL, "", "Config loaded successfully!" & @CRLF & $sFileOpenDialog)
		GUICtrlSetData($lblConfig, getfilename($config))
	EndIf
EndFunc   ;==>btnLoad

Func btnSave($configfile)
	Local $sFileSaveDialog = FileSaveDialog("Save current config as..", "::{450D8FBA-AD25-11D0-98A8-0800361B1103}", "Config (*.ini)", $FD_PATHMUSTEXIST)
	If @error Then
		MsgBox($MB_SYSTEMMODAL, "", "Config save failed!")
	Else
		Local $sFileName = StringTrimLeft($sFileSaveDialog, StringInStr($sFileSaveDialog, "\", $STR_NOCASESENSE, -1))

		Local $iExtension = StringInStr($sFileName, ".", $STR_NOCASESENSE)

		If $iExtension Then
			If Not (StringTrimLeft($sFileName, $iExtension - 1) = ".ini") Then $sFileSaveDialog &= ".ini"
		Else
			$sFileSaveDialog &= ".ini"
		EndIf
		$config = $sFileSaveDialog
		saveConfig()
		MsgBox($MB_SYSTEMMODAL, "", "Successfully saved the current configuration!" & @CRLF & $sFileSaveDialog)
		GUICtrlSetData($lblConfig, getfilename($config))
	EndIf
EndFunc   ;==>btnSave

Func chkUpgrade1()
	If IsChecked($chkUpgrade1) Then
		GUICtrlSetState($btnLocateUp1, $GUI_ENABLE)
	Else
		GUICtrlSetState($btnLocateUp1, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkUpgrade1

Func chkUpgrade2()
	If IsChecked($chkUpgrade2) Then
		GUICtrlSetState($btnLocateUp2, $GUI_ENABLE)
	Else
		GUICtrlSetState($btnLocateUp2, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkUpgrade2

Func chkUpgrade3()
	If IsChecked($chkUpgrade3) Then
		GUICtrlSetState($btnLocateUp3, $GUI_ENABLE)
	Else
		GUICtrlSetState($btnLocateUp3, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkUpgrade3

Func chkUpgrade4()
	If IsChecked($chkUpgrade4) Then
		GUICtrlSetState($btnLocateUp4, $GUI_ENABLE)
	Else
		GUICtrlSetState($btnLocateUp4, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkUpgrade4

Func chkUpgrade5()
	If IsChecked($chkUpgrade5) Then
		GUICtrlSetState($btnLocateUp5, $GUI_ENABLE)
	Else
		GUICtrlSetState($btnLocateUp5, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkUpgrade5

Func chkUpgrade6()
	If IsChecked($chkUpgrade6) Then
		GUICtrlSetState($btnLocateUp6, $GUI_ENABLE)
	Else
		GUICtrlSetState($btnLocateUp6, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkUpgrade6

Func UseJPG()
	If IsChecked($UseJPG) And Not IsChecked($chkTakeLootSS) Then
		GUICtrlSetState($chkTakeLootSS, $GUI_CHECKED)
	EndIf
EndFunc   ;==>UseJPG

Func UseAttackJPG()
	If IsChecked($UseAttackJPG) And Not IsChecked($chkTakeAttackSS) Then
		GUICtrlSetState($chkTakeAttackSS, $GUI_CHECKED)
	EndIf
EndFunc   ;==>UseAttackJPG

Func lblpushbulletenabled()
	If IsChecked($lblpushbulletenabled) Then
		GUICtrlSetState($pushbullettokenvalue, $GUI_ENABLE)
		GUICtrlSetState($lblpushbulletdebug, $GUI_ENABLE)
		GUICtrlSetState($lblpushbulletremote, $GUI_ENABLE)
		GUICtrlSetState($lblpushbulletdelete, $GUI_ENABLE)
		GUICtrlSetState($lblvillagereport, $GUI_ENABLE)
		GUICtrlSetState($lblmatchfound, $GUI_ENABLE)
		GUICtrlSetState($lbllastraid, $GUI_ENABLE)
		GUICtrlSetState($UseJPG, $GUI_ENABLE)
	Else
		GUICtrlSetState($pushbullettokenvalue, $GUI_DISABLE)
		GUICtrlSetState($lblpushbulletdebug, $GUI_DISABLE)
		GUICtrlSetState($lblpushbulletremote, $GUI_DISABLE)
		GUICtrlSetState($lblpushbulletdelete, $GUI_DISABLE)
		GUICtrlSetState($lblvillagereport, $GUI_DISABLE)
		GUICtrlSetState($lblmatchfound, $GUI_DISABLE)
		GUICtrlSetState($lbllastraid, $GUI_DISABLE)
		GUICtrlSetState($UseJPG, $GUI_DISABLE)
	EndIf
EndFunc   ;==>lblpushbulletenabled

Func btnBugRep()
	$iLines = _GUICtrlRichEdit_GetLineCount($txtLog)
	$iLines = $iLines - 100
	If $iLines < 1 Then $iLines = 1
	For $dummy = $iLines To _GUICtrlRichEdit_GetLineCount($txtLog)
		If $dummy > $iLines Then
			GUICtrlSetData($inpLog, GUICtrlRead($inpLog) & @CRLF & _GUICtrlRichEdit_GetTextInLine($txtLog, $dummy))
		Else
			GUICtrlSetData($inpLog, _GUICtrlRichEdit_GetTextInLine($txtLog, $dummy))
		EndIf
	Next

	GUICtrlSetData($inpSettings, "")
	$firstLine = True
	If FileExists($config) Then
		$hConfig = FileOpen($config)
		While True
			$strNextLine = FileReadLine($hConfig)
			If @error Then ExitLoop
			If StringInStr($strNextLine, "accounttoken=") Then
				$strNextLine = "accounttoken=REDACTED"
			EndIf
			If Not $firstLine Then
				GUICtrlSetData($inpSettings, GUICtrlRead($inpSettings) & @CRLF & $strNextLine)
			Else
				$firstLine = False
				GUICtrlSetData($inpSettings, $strNextLine)
			EndIf
		WEnd
	Else
		GUICtrlSetData($inpSettings, "No log file found")
	EndIf

	GUISetState(@SW_DISABLE, $frmBot)
	GUISetState(@SW_SHOW, $frmBugReport)
	WinActivate($frmBugReport)

EndFunc   ;==>btnBugRep

Func openWebsite()
	ShellExecute("http://www.brokenbot.org")
EndFunc   ;==>openWebsite

Func _btnRefresh()
	$searchfile = FileFindFirstFile($dirStrat & "*.ini")
	$foundfiles = ""
	While True
		$newfile = FileFindNextFile($searchfile)
		If @error Then ExitLoop
		$strPlugInRead = IniRead($dirStrat & $newfile, "plugin", "name", "")
		$arStrats = StringSplit($StratNames, "|")
		For $i = 1 To $arStrats[0]
			If $arStrats[$i] = $strPlugInRead Then
				$foundfiles = $foundfiles & StringLeft($newfile, StringLen($newfile) - 4) & "|"
				ExitLoop
			EndIf
		Next
	WEnd
	FileClose($searchfile)
	If StringLen($foundfiles) > 0 Then
		$foundfiles = StringLeft($foundfiles, StringLen($foundfiles) - 1)
	EndIf
	GUICtrlSetData($lstStrategies, "")
	GUICtrlSetData($lstStrategies, $foundfiles)
EndFunc   ;==>_btnRefresh

Func _btnSaveStrat($Name = "")
	$strPlugInInUse = IniRead($dirStrat & GUICtrlRead($lstStrategies) & ".ini", "plugin", "name", "")
	If $Name <> "" Then
		SetLOG("Saved: " & $Name)
		Call($strPlugInInUse & "_SaveConfig", $dirStrat & $Name & ".ini")
	Else
		$strNewName = InputBox("New config name", "Please provide a new name for your configuration:", GUICtrlRead($lstStrategies), " M")
		If $strNewName <> "" Then
			If StringRegExp($strNewName, "^[A-Za-z0-9_ -\.]+$", 0) Then
				Call($strPlugInInUse & "_SaveConfig", $dirStrat & $strNewName & ".ini")
				SetLOG("Saved: " & $strNewName)
				_btnRefresh()
				_GUICtrlListBox_SetCurSel($lstStrategies, _GUICtrlListBox_FindString($lstStrategies, $strNewName))
			Else
				MsgBox($MB_ICONERROR, $sBotTitle, "Invalid filename!")
				_btnSaveStrat()
			EndIf
		EndIf
	EndIf
EndFunc   ;==>_btnSaveStrat

Func _lstStrategies()
	If GUICtrlRead($lstStrategies) <> $prevSelection Then
		If $prevSelection <> "" Then _btnSaveStrat($prevSelection)
		GUIDelete($frmAttackConfig)
		$prevSelection = GUICtrlRead($lstStrategies)
		$strPlugInInUse = IniRead($dirStrat & GUICtrlRead($lstStrategies) & ".ini", "plugin", "name", "")
		$DefaultTab = Call($strPlugInInUse & "_LoadGUI")
		If _GUICtrlTab_GetCurSel($tabMain) = 1 Then GUISetState(@SW_SHOW, $frmAttackConfig)
	EndIf
EndFunc   ;==>_lstStrategies

Func btnLab()
	LocateLab()
EndFunc