;Applies all of the  variable to the GUI

Func applyConfig() ;Applies the data from config to the controls in GUI
	;Donate Settings-------------------------------------------------------------------------
	If $ichkRequest = 1 Then
		GUICtrlSetState($chkRequest, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkRequest, $GUI_UNCHECKED)
	EndIf

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	If $ichkDonateBarbarians = 1 Then
		GUICtrlSetState($chkDonateBarbarians, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateBarbarians, $GUI_UNCHECKED)
	EndIf
	If $ichkDonateAllBarbarians = 1 Then
		GUICtrlSetState($chkDonateAllBarbarians, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateAllBarbarians, $GUI_UNCHECKED)
	EndIf
	;````````````````````````````````````````````````
	If $ichkDonateArchers = 1 Then
		GUICtrlSetState($chkDonateArchers, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateArchers, $GUI_UNCHECKED)
	EndIf
	If $ichkDonateAllArchers = 1 Then
		GUICtrlSetState($chkDonateAllArchers, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateAllArchers, $GUI_UNCHECKED)
	EndIf
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	If $ichkDonateGiants = 1 Then
		GUICtrlSetState($chkDonateGiants, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateGiants, $GUI_UNCHECKED)
	EndIf
	If $ichkDonateAllGiants = 1 Then
		GUICtrlSetState($chkDonateAllGiants, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateAllGiants, $GUI_UNCHECKED)
	EndIf
	If IniRead($config, "donate", "gtfo", "0") = 1 Then
		GUICtrlSetState($gtfo, $GUI_CHECKED)
	Else
		GUICtrlSetState($gtfo, $GUI_UNCHECKED)
	EndIf


	GUICtrlSetData($txtDonateBarbarians, $itxtDonateBarbarians)
	GUICtrlSetData($txtDonateArchers, $itxtDonateArchers)
	GUICtrlSetData($txtDonateGiants, $itxtDonateGiants)

	GUICtrlSetData($txtRequest, $itxtRequest)
	_GUICtrlComboBox_SetCurSel($cmbDonateBarbarians, IniRead($config, "donate", "donate1", "0"))
	_GUICtrlComboBox_SetCurSel($cmbDonateArchers, IniRead($config, "donate", "donate2", "1"))
	_GUICtrlComboBox_SetCurSel($cmbDonateGiants, IniRead($config, "donate", "donate3", "2"))
	GUICtrlSetData($NoOfBarbarians, IniRead($config, "donate", "amount1", 5))
	GUICtrlSetData($NoOfArchers, IniRead($config, "donate", "amount2", 5))
	GUICtrlSetData($NoOfGiants, IniRead($config, "donate", "amount3", 5))
	chkRequest()
	;Other Settings--------------------------------------------------------------------------
	If $ichkWalls = 1 Then
		GUICtrlSetState($chkWalls, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkWalls, $GUI_UNCHECKED)
	EndIf
	_GUICtrlComboBox_SetCurSel($cmbWalls, $icmbWalls)
	_GUICtrlComboBox_SetCurSel($cmbTolerance, $icmbTolerance)

	Switch $iUseStorage
		Case 0
			GUICtrlSetState($UseGold, $GUI_CHECKED)
		Case 1
			GUICtrlSetState($UseElixir, $GUI_CHECKED)
		Case 2
			GUICtrlSetState($UseGoldElix, $GUI_CHECKED)
	EndSwitch

	GUICtrlSetData($txtWallMinGold, $itxtWallMinGold)
	GUICtrlSetData($txtWallMinElixir, $itxtWallMinElixir)

	_GUICtrlComboBox_SetCurSel($cmbUnitDelay, $icmbUnitDelay)
	_GUICtrlComboBox_SetCurSel($cmbWaveDelay, $icmbWaveDelay)

;Lab
    If $ichkLab = 1 Then
        GUICtrlSetState($chkLab, $GUI_CHECKED)
    Else
        GUICtrlSetState($chkLab, $GUI_UNCHECKED)
    EndIf
    _GUICtrlComboBox_SetCurSel($cmbLaboratory, $icmbLaboratory)

	;General Settings--------------------------------------------------------------------------
	If $frmBotPosX <> -32000 Then
		WinMove($sBotTitle, "", $frmBotPosX, $frmBotPosY)
		_WinMoved(0, 0, 0, 0)
	EndIf
	GUISetState(@SW_SHOW, $frmBot)
	GUICtrlSetData($txtMinimumTrophy, $itxtMinTrophy)
	GUICtrlSetData($txtMaxTrophy, $itxtMaxTrophy)
	;Misc Settings--------------------------------------------------------------------------
	If $ichkCollect = 1 Then
		GUICtrlSetState($chkCollect, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkCollect, $GUI_UNCHECKED)
	EndIf
	If $TakeAttackSnapShot = 1 Then
		GUICtrlSetState($chkTakeAttackSS, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkTakeAttackSS, $GUI_UNCHECKED)
	EndIf
	If $DebugMode = 1 Then
		GUICtrlSetState($chkDebug, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDebug, $GUI_UNCHECKED)
	EndIf
	GUICtrlSetData($txtReconnect, $itxtReconnect)
	GUICtrlSetData($txtReturnh, $itxtReturnh)
	_GUICtrlComboBox_SetCurSel($cmbSearchsp, $icmbSearchsp)
	If $ichkTrap = 1 Then
		GUICtrlSetState($chkTrap, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkTrap, $GUI_UNCHECKED)
	EndIf
	If $WideEdge = 1 Then
		GUICtrlSetState($chkWideEdge, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkWideEdge, $GUI_UNCHECKED)
	EndIf

	If $ichkBotStop = 1 Then
		GUICtrlSetState($chkBotStop, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkBotStop, $GUI_UNCHECKED)
	EndIf
	_GUICtrlComboBox_SetCurSel($cmbBotCommand, $icmbBotCommand)
	_GUICtrlComboBox_SetCurSel($cmbBotCond, $icmbBotCond)

	GUICtrlSetData($txtCapacity, $itxtcampCap)
	GUICtrlSetData($txtSpellCap, $itxtspellCap)

	If $TakeLootSnapShot = 1 Then
		GUICtrlSetState($chkTakeLootSS, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkTakeLootSS, $GUI_UNCHECKED)
	EndIf

	If $TakeAllTownSnapShot = 1 Then
		GUICtrlSetState($chkTakeTownSS, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkTakeTownSS, $GUI_UNCHECKED)
	EndIf

	If $AlertBaseFound = 1 Then
		GUICtrlSetState($chkAlertSearch, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkAlertSearch, $GUI_UNCHECKED)
	EndIf

	;Push Bullet
	If $PushBulletEnabled = 1 Then
		GUICtrlSetState($lblpushbulletenabled, $GUI_CHECKED)
	Else
		GUICtrlSetState($lblpushbulletenabled, $GUI_UNCHECKED)
	EndIf

	GUICtrlSetData($pushbullettokenvalue, $PushBullettoken)

	If $PushBulletvillagereport = 1 Then
		GUICtrlSetState($lblvillagereport, $GUI_CHECKED)
	Else
		GUICtrlSetState($lblvillagereport, $GUI_UNCHECKED)
	EndIf

	If $PushBulletmatchfound = 1 Then
		GUICtrlSetState($lblmatchfound, $GUI_CHECKED)
	Else
		GUICtrlSetState($lblmatchfound, $GUI_UNCHECKED)
	EndIf

	If $PushBulletlastraid = 1 Then
		GUICtrlSetState($lbllastraid, $GUI_CHECKED)
	Else
		GUICtrlSetState($lbllastraid, $GUI_UNCHECKED)
	EndIf

	If $PushBulletdebug = 1 Then
		GUICtrlSetState($lblpushbulletdebug, $GUI_CHECKED)
	Else
		GUICtrlSetState($lblpushbulletdebug, $GUI_UNCHECKED)
	EndIf

	If $PushBulletremote = 1 Then
		GUICtrlSetState($lblpushbulletremote, $GUI_CHECKED)
	Else
		GUICtrlSetState($lblpushbulletremote, $GUI_UNCHECKED)
	EndIf

	If $PushBulletdelete = 1 Then
		GUICtrlSetState($lblpushbulletdelete, $GUI_CHECKED)
	Else
		GUICtrlSetState($lblpushbulletdelete, $GUI_UNCHECKED)
	EndIf

	If $PushBulletfreebuilder = 1 Then
		GUICtrlSetState($lblfreebuilder, $GUI_CHECKED)
	Else
		GUICtrlSetState($lblfreebuilder, $GUI_UNCHECKED)
	EndIf

	If $PushBulletdisconnection = 1 Then
		GUICtrlSetState($lbldisconnect, $GUI_CHECKED)
	Else
		GUICtrlSetState($lbldisconnect, $GUI_UNCHECKED)
	EndIf

	If $PushBullettype = 1 Then
		GUICtrlSetState($UseJPG, $GUI_CHECKED)
	Else
		GUICtrlSetState($UseJPG, $GUI_UNCHECKED)
	EndIf

	If $PushBulletattacktype = 1 Then
		GUICtrlSetState($UseAttackJPG, $GUI_CHECKED)
	Else
		GUICtrlSetState($UseAttackJPG, $GUI_UNCHECKED)
	EndIf

	lblpushbulletenabled()

	If $ichkNoAttack = 1 Then
		GUICtrlSetState($chkNoAttack, $GUI_CHECKED)
		GUICtrlSetState($lblpushbulletenabled, $GUI_UNCHECKED)
		GUICtrlSetState($lblpushbulletenabled, $GUI_DISABLE)
		lblpushbulletenabled()
	Else
		GUICtrlSetState($chkNoAttack, $GUI_UNCHECKED)
	EndIf

	If $ichkDonateOnly = 1 Then
		GUICtrlSetState($chkDonateOnly, $GUI_CHECKED)
		GUICtrlSetState($lblpushbulletenabled, $GUI_UNCHECKED)
		GUICtrlSetState($lblpushbulletenabled, $GUI_DISABLE)
		lblpushbulletenabled()
	Else
		GUICtrlSetState($chkDonateOnly, $GUI_UNCHECKED)
	EndIf

EndFunc   ;==>applyConfig
