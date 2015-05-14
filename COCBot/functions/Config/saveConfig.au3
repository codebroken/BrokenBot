;Saves all of the GUI values to the config.

Func saveConfig() ;Saves the controls settings to the config
	;---------------------------------------------------------------------------------------
	; Main settings ------------------------------------------------------------------------
	;---------------------------------------------------------------------------------------
	IniWrite($config, "general", "MinTrophy", GUICtrlRead($txtMinimumTrophy))
	IniWrite($config, "general", "MaxTrophy", GUICtrlRead($txtMaxTrophy))
	IniWrite($config, "general", "Command", _GUICtrlComboBox_GetCurSel($cmbBotCommand))
	IniWrite($config, "general", "Cond", _GUICtrlComboBox_GetCurSel($cmbBotCond))
	If IsChecked($chkNoAttack) Then
		IniWrite($config, "general", "NoAttack", 1)
	Else
		IniWrite($config, "general", "NoAttack", 0)
	EndIf
	If IsChecked($chkDonateOnly) Then
		IniWrite($config, "general", "DonateOnly", 1)
	Else
		IniWrite($config, "general", "DonateOnly", 0)
	EndIf
	If IsChecked($chkBotStop) Then
		IniWrite($config, "general", "BotStop", 1)
	Else
		IniWrite($config, "general", "BotStop", 0)
	EndIf
	;---------------------------------------------------------------------------------------
	; Attack settings ----------------------------------------------------------------------
	;---------------------------------------------------------------------------------------
	IniWrite($config, "attack", "UnitD", _GUICtrlComboBox_GetCurSel($cmbUnitDelay))
	IniWrite($config, "attack", "WaveD", _GUICtrlComboBox_GetCurSel($cmbWaveDelay))
	IniWrite($config, "attack", "randomatk", GUICtrlRead($Randomspeedatk))
	;---------------------------------------------------------------------------------------
	; Donate settings ----------------------------------------------------------------------
	;---------------------------------------------------------------------------------------
	If IsChecked($chkRequest) Then
		IniWrite($config, "donate", "chkRequest", 1)
	Else
		IniWrite($config, "donate", "chkRequest", 0)
	EndIf
	If IsChecked($chkDonateAllBarbarians) Then
		IniWrite($config, "donate", "chkDonateAllBarbarians", 1)
	Else
		IniWrite($config, "donate", "chkDonateAllBarbarians", 0)
	EndIf

	If IsChecked($chkDonateAllArchers) Then
		IniWrite($config, "donate", "chkDonateAllArchers", 1)
	Else
		IniWrite($config, "donate", "chkDonateAllArchers", 0)
	EndIf

	If IsChecked($chkDonateAllGiants) Then
		IniWrite($config, "donate", "chkDonateAllGiants", 1)
	Else
		IniWrite($config, "donate", "chkDonateAllGiants", 0)
	EndIf
	If IsChecked($chkDonateBarbarians) Then
		IniWrite($config, "donate", "chkDonateBarbarians", 1)
	Else
		IniWrite($config, "donate", "chkDonateBarbarians", 0)
	EndIf

	If IsChecked($chkDonateArchers) Then
		IniWrite($config, "donate", "chkDonateArchers", 1)
	Else
		IniWrite($config, "donate", "chkDonateArchers", 0)
	EndIf
	If IsChecked($chkDonateGiants) Then
		IniWrite($config, "donate", "chkDonateGiants", 1)
	Else
		IniWrite($config, "donate", "chkDonateGiants", 0)
	EndIf
	IniWrite($config, "donate", "txtRequest", GUICtrlRead($txtRequest))
	IniWrite($config, "donate", "txtDonateBarbarians", StringReplace(GUICtrlRead($txtDonateBarbarians), @CRLF, "|"))
	IniWrite($config, "donate", "txtDonateArchers", StringReplace(GUICtrlRead($txtDonateArchers), @CRLF, "|"))
	IniWrite($config, "donate", "txtDonateGiants", StringReplace(GUICtrlRead($txtDonateGiants), @CRLF, "|"))

	; Relics below...in save but not read
	If IsChecked($gtfo) Then
		IniWrite($config, "donate", "gtfo", 1)
	Else
		IniWrite($config, "donate", "gtfo", 0)
	EndIf
	IniWrite($config, "donate", "donate1", _GUICtrlComboBox_GetCurSel($cmbDonateBarbarians))
	IniWrite($config, "donate", "donate2", _GUICtrlComboBox_GetCurSel($cmbDonateArchers))
	IniWrite($config, "donate", "donate3", _GUICtrlComboBox_GetCurSel($cmbDonateGiants))
	IniWrite($config, "donate", "amount1", GUICtrlRead($NoOfBarbarians))
	IniWrite($config, "donate", "amount2", GUICtrlRead($NoOfArchers))
	IniWrite($config, "donate", "amount3", GUICtrlRead($NoOfGiants))

	;---------------------------------------------------------------------------------------
	; Upgrade settings ---------------------------------------------------------------------
	;---------------------------------------------------------------------------------------
	If IsChecked($chkWalls) Then
		IniWrite($config, "upgrade", "auto-wall", 1)
	Else
		IniWrite($config, "upgrade", "auto-wall", 0)
	EndIf
	IniWrite($config, "upgrade", "walllvl", _GUICtrlComboBox_GetCurSel($cmbWalls))
	IniWrite($config, "upgrade", "walltolerance", _GUICtrlComboBox_GetCurSel($cmbTolerance))
	If IsChecked($UseGold) Then
		IniWrite($config, "upgrade", "use-storage", 0)
	ElseIf IsChecked($UseElixir) Then
		IniWrite($config, "upgrade", "use-storage", 1)
	ElseIf IsChecked($UseGoldElix) Then
		IniWrite($config, "upgrade", "use-storage", 2)
	EndIf
	IniWrite($config, "upgrade", "minwallgold", GUICtrlRead($txtWallMinGold))
	IniWrite($config, "upgrade", "minwallelixir", GUICtrlRead($txtWallMinElixir))

	; Relics below...in save but not read
	If IsChecked($chkUpgrade1) Then
		IniWrite($config, "upgrade", "auto-upgrade1", 1)
	Else
		IniWrite($config, "upgrade", "auto-upgrade1", 0)
	EndIf
	If IsChecked($chkUpgrade2) Then
		IniWrite($config, "upgrade", "auto-upgrade2", 1)
	Else
		IniWrite($config, "upgrade", "auto-upgrade2", 0)
	EndIf
	If IsChecked($chkUpgrade3) Then
		IniWrite($config, "upgrade", "auto-upgrade3", 1)
	Else
		IniWrite($config, "upgrade", "auto-upgrade3", 0)
	EndIf
	If IsChecked($chkUpgrade4) Then
		IniWrite($config, "upgrade", "auto-upgrade4", 1)
	Else
		IniWrite($config, "upgrade", "auto-upgrade4", 0)
	EndIf
	If IsChecked($chkUpgrade5) Then
		IniWrite($config, "upgrade", "auto-upgrade5", 1)
	Else
		IniWrite($config, "upgrade", "auto-upgrade5", 0)
	EndIf
	If IsChecked($chkUpgrade6) Then
		IniWrite($config, "upgrade", "auto-upgrade6", 1)
	Else
		IniWrite($config, "upgrade", "auto-upgrade6", 0)
	EndIf
	IniWrite($config, "upgrade", "PosX1", GUICtrlRead($txtUpgradeX1))
	IniWrite($config, "upgrade", "PosY2", GUICtrlRead($txtUpgradeY2))
	IniWrite($config, "upgrade", "PosX2", GUICtrlRead($txtUpgradeX2))
	IniWrite($config, "upgrade", "PosY3", GUICtrlRead($txtUpgradeY3))
	IniWrite($config, "upgrade", "PosX3", GUICtrlRead($txtUpgradeX3))
	IniWrite($config, "upgrade", "PosY4", GUICtrlRead($txtUpgradeY4))
	IniWrite($config, "upgrade", "PosX4", GUICtrlRead($txtUpgradeX4))
	IniWrite($config, "upgrade", "PosY5", GUICtrlRead($txtUpgradeY5))
	IniWrite($config, "upgrade", "PosX5", GUICtrlRead($txtUpgradeX5))
	IniWrite($config, "upgrade", "PosY6", GUICtrlRead($txtUpgradeY6))
	IniWrite($config, "upgrade", "PosX6", GUICtrlRead($txtUpgradeX6))

	If IsChecked($chkLab) Then
        IniWrite($config, "upgrade", "auto-uptroops", 1)
    Else
        IniWrite($config, "upgrade", "auto-uptroops", 0)
    EndIf
    IniWrite($config, "upgrade", "troops-name", _GUICtrlComboBox_GetCurSel($cmbLaboratory))
	;---------------------------------------------------------------------------------------
	; Notification settings ----------------------------------------------------------------
	;---------------------------------------------------------------------------------------
	If IsChecked($lblpushbulletenabled) Then
		IniWrite($config, "notification", "pushbullet", 1)
	Else
		IniWrite($config, "notification", "pushbullet", 0)
	EndIf
	If IsChecked($lblvillagereport) Then
		IniWrite($config, "notification", "villagereport", 1)
	Else
		IniWrite($config, "notification", "villagereport", 0)
	EndIf
	If IsChecked($lblmatchfound) Then
		IniWrite($config, "notification", "matchfound", 1)
	Else
		IniWrite($config, "notification", "matchfound", 0)
	EndIf
	If IsChecked($lbllastraid) Then
		IniWrite($config, "notification", "lastraid", 1)
	Else
		IniWrite($config, "notification", "lastraid", 0)
	EndIf
	If IsChecked($lblfreebuilder) Then
		IniWrite($config, "notification", "freebuilder", 1)
	Else
		IniWrite($config, "notification", "freebuilder", 0)
	EndIf
	If IsChecked($lblpushbulletdebug) Then
		IniWrite($config, "notification", "debug", 1)
	Else
		IniWrite($config, "notification", "debug", 0)
	EndIf
	If IsChecked($lblpushbulletremote) Then
		IniWrite($config, "notification", "remote", 1)
	Else
		IniWrite($config, "notification", "remote", 0)
	EndIf
	If IsChecked($lblpushbulletdelete) Then
		IniWrite($config, "notification", "delete", 1)
	Else
		IniWrite($config, "notification", "delete", 0)
	EndIf
	IniWrite($config, "notification", "accounttoken", GUICtrlRead($pushbullettokenvalue))
	If IsChecked($UseJPG) Then
		IniWrite($config, "notification", "lastraidtype", 1)
	Else
		IniWrite($config, "notification", "lastraidtype", 0)
	EndIf
	If IsChecked($UseAttackJPG) Then
		IniWrite($config, "notification", "attackimage", 1)
	Else
		IniWrite($config, "notification", "attackimage", 0)
	EndIf

	;---------------------------------------------------------------------------------------
	; Misc settings ------------------------------------------------------------------------
	;---------------------------------------------------------------------------------------
	IniWrite($config, "misc", "RedLineAcc", GUICtrlRead($sldAcc))
	If IsChecked($chkTakeAttackSS) Then
		IniWrite($config, "misc", "TakeAttackSnapShot", 1)
	Else
		IniWrite($config, "misc", "TakeAttackSnapShot", 0)
	EndIf
	If IsChecked($chkDebug) Then
		IniWrite($config, "misc", "Debug", 1)
	Else
		IniWrite($config, "misc", "Debug", 0)
	EndIf
	If IsChecked($chkCollect) Then
		IniWrite($config, "misc", "Collect", 1)
	Else
		IniWrite($config, "misc", "Collect", 0)
	EndIf
	IniWrite($config, "misc", "capacity", GUICtrlRead($txtCapacity))
	IniWrite($config, "misc", "spellcap", GUICtrlRead($txtSpellCap))
	IniWrite($config, "misc", "reconnectdelay", GUICtrlRead($txtReconnect))
	IniWrite($config, "misc", "returnhomedelay", GUICtrlRead($txtReturnh))
	IniWrite($config, "misc", "searchspd", _GUICtrlComboBox_GetCurSel($cmbSearchsp))
	If IsChecked($chkWideEdge) Then
		IniWrite($config, "misc", "WideEdge", 1)
	Else
		IniWrite($config, "misc", "WideEdge", 0)
	EndIf
	If IsChecked($chkTakeLootSS) Then
		IniWrite($config, "misc", "TakeLootSnapShot", 1)
	Else
		IniWrite($config, "misc", "TakeLootSnapShot", 0)
	EndIf
	If IsChecked($chkTakeTownSS) Then
		IniWrite($config, "misc", "TakeAllTownSnapShot", 1)
	Else
		IniWrite($config, "misc", "TakeAllTownSnapShot", 0)
	EndIf
	If IsChecked($chkAlertSearch) Then
		IniWrite($config, "misc", "AlertBaseFound", 1)
	Else
		IniWrite($config, "misc", "AlertBaseFound", 0)
	EndIf
	If IsChecked($chkTrap) Then
		IniWrite($config, "misc", "chkTrap", 1)
	Else
		IniWrite($config, "misc", "chkTrap", 0)
	EndIf

	;---------------------------------------------------------------------------------------
	; Config settings ----------------------------------------------------------------------
	;---------------------------------------------------------------------------------------
	$array = _GUICtrlComboBox_GetListArray($cmbLanguage)
	IniWrite($config, "config", "language", $array[_GUICtrlComboBox_GetCurSel($cmbLanguage)+1])
	If IsChecked($chkBackground) Then
		IniWrite($config, "config", "Background", 1)
	Else
		IniWrite($config, "config", "Background", 0)
	EndIf
	If IsChecked($chkForceBS) Then
		IniWrite($config, "config", "ForceBS", 1)
	Else
		IniWrite($config, "config", "ForceBS", 0)
	EndIf
	If IsChecked($chkUpdate) Then
		IniWrite($config, "config", "chkUpdate", 1)
	Else
		IniWrite($config, "config", "chkUpdate", 0)
	EndIf

	;---------------------------------------------------------------------------------------
	; Base location settings ---------------------------------------------------------------
	;---------------------------------------------------------------------------------------
	IniWrite($config, "position", "xCCPos", $CCPos[0])
	IniWrite($config, "position", "yCCPos", $CCPos[1])
	Local $frmBotPos = WinGetPos($sBotTitle)
	IniWrite($config, "position", "frmBotPosX", $frmBotPos[0])
	IniWrite($config, "position", "frmBotPosY", $frmBotPos[1])
	IniWrite($config, "position", "xTownHall", $TownHallPos[0])
	IniWrite($config, "position", "yTownHall", $TownHallPos[1])
	IniWrite($config, "position", "xArmy", $ArmyPos[0])
	IniWrite($config, "position", "yArmy", $ArmyPos[1])
	IniWrite($config, "position", "xSpell", $SpellPos[0])
	IniWrite($config, "position", "ySpell", $SpellPos[1])
	IniWrite($config, "position", "xKing", $KingPos[0])
	IniWrite($config, "position", "yKing", $KingPos[1])
	IniWrite($config, "position", "xQueen", $QueenPos[0])
	IniWrite($config, "position", "yQueen", $QueenPos[1])
	For $i = 0 To 1 ;Cover 2 Dark Barracks
		IniWrite($config, "position", "xDarkBarrack" & $i + 1, $DarkBarrackPos[$i][0])
		IniWrite($config, "position", "yDarkBarrack" & $i + 1, $DarkBarrackPos[$i][1])
	Next
	For $i = 0 To 16 ;Covers all Collectors
		IniWrite($config, "position", "xCollector" & $i + 1, $collectorPos[$i][0])
		IniWrite($config, "position", "yCollector" & $i + 1, $collectorPos[$i][1])
	Next
	For $i = 0 To 3 ;Covers all 4 Barracks
		IniWrite($config, "position", "xBarrack" & $i + 1, $barrackPos[$i][0])
		IniWrite($config, "position", "yBarrack" & $i + 1, $barrackPos[$i][1])
	Next
    IniWrite($config, "position", "LabPosX", $LabPos[0])
    IniWrite($config, "position", "LabPosY", $LabPos[1])
EndFunc   ;==>saveConfig
