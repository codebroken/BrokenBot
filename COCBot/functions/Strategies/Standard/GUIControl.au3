Func Standard_btnSearchMode()
	;While 1
		GUICtrlSetState($btnStart, $GUI_HIDE)
		GUICtrlSetState($btnStop, $GUI_SHOW)

		GUICtrlSetState($btnLocateBarracks, $GUI_DISABLE)
		GUICtrlSetState($btnLocateDarkBarracks, $GUI_DISABLE)
		GUICtrlSetState($btnSearchMode, $GUI_DISABLE)
		GUICtrlSetState($cmbTroopComp, $GUI_DISABLE)
		GUICtrlSetState($chkBackground, $GUI_DISABLE)
		;GUICtrlSetState($btnLocateCollectors, $GUI_DISABLE)
		
		DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $frmAttackConfig, "int", 500, "long", $slideIn)
		GUISetState(@SW_HIDE, $frmAttackConfig)
		_GUICtrlTab_SetCurSel($tabMain,0)
		
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
				SetLog(GetLangText("msgPleaseRestart"), $COLOR_ORANGE)
				_Sleep(3000)
				$MsgRet = MsgBox(BitOR($MB_OKCANCEL, $MB_SYSTEMMODAL), GetLangText("boxRestart"), GetLangText("boxRestart2") & @CRLF & GetLangText("boxRestart3"), 10)
				If $MsgRet <> $IDOK Then
					btnStop()
					Return
				EndIf
			EndIf
			
			
			WinActivate($Title)

			SetLog(GetLangText("msgWelcome") & $sBotTitle & "!~~~~", $COLOR_PURPLE)
			SetLog($Compiled & GetLangText("msgRunningOn") & @OSArch & " OS", $COLOR_GREEN)
			SetLog(GetLangText("msgStarting"), $COLOR_ORANGE)
		EndIf

		$fullArmy = True
		PrepareSearch()
		
		Standard_Search()

		GUICtrlSetState($btnStart, $GUI_SHOW)
		GUICtrlSetState($btnStop, $GUI_HIDE)

		GUICtrlSetState($btnLocateBarracks, $GUI_ENABLE)
		GUICtrlSetState($btnLocateDarkBarracks, $GUI_ENABLE)
		GUICtrlSetState($btnSearchMode, $GUI_ENABLE)
		GUICtrlSetState($cmbTroopComp, $GUI_ENABLE)
		GUICtrlSetState($chkBackground, $GUI_ENABLE)
		;GUICtrlSetState($btnLocateCollectors, $GUI_ENABLE)
		;ExitLoop
	;WEnd
EndFunc   ;==>Standard_btnSearchMode

Func Standard_chkDeadActivate()
	If IsChecked($chkDeadActivate) Then
		GUICtrlSetState($chkDeadKingAvail, $GUI_ENABLE)
		GUICtrlSetState($chkDeadQueenAvail, $GUI_ENABLE)
		GUICtrlSetState($chkDeadGE, $GUI_ENABLE)
		GUICtrlSetState($txtDeadMinGold, $GUI_ENABLE)
		GUICtrlSetState($cmbDead, $GUI_ENABLE)
		GUICtrlSetState($txtDeadMinElixir, $GUI_ENABLE)
		GUICtrlSetState($chkDeadMeetDE, $GUI_ENABLE)
		GUICtrlSetState($txtDeadMinDarkElixir, $GUI_ENABLE)
		GUICtrlSetState($chkDeadMeetTrophy, $GUI_ENABLE)
		GUICtrlSetState($txtDeadMinTrophy, $GUI_ENABLE)
		GUICtrlSetState($chkDeadMeetTH, $GUI_ENABLE)
		GUICtrlSetState($cmbDeadTH, $GUI_ENABLE)
		GUICtrlSetState($chkDeadMeetTHO, $GUI_ENABLE)
		GUICtrlSetState($chkDeadSnipe, $GUI_ENABLE)
		GUICtrlSetState($btnSearchMode, $GUI_ENABLE)
	Else
		GUICtrlSetState($chkDeadKingAvail, $GUI_DISABLE)
		GUICtrlSetState($chkDeadQueenAvail, $GUI_DISABLE)
		GUICtrlSetState($chkDeadGE, $GUI_DISABLE)
		GUICtrlSetState($txtDeadMinGold, $GUI_DISABLE)
		GUICtrlSetState($cmbDead, $GUI_DISABLE)
		GUICtrlSetState($txtDeadMinElixir, $GUI_DISABLE)
		GUICtrlSetState($chkDeadMeetDE, $GUI_DISABLE)
		GUICtrlSetState($txtDeadMinDarkElixir, $GUI_DISABLE)
		GUICtrlSetState($chkDeadMeetTrophy, $GUI_DISABLE)
		GUICtrlSetState($txtDeadMinTrophy, $GUI_DISABLE)
		GUICtrlSetState($chkDeadMeetTH, $GUI_DISABLE)
		GUICtrlSetState($cmbDeadTH, $GUI_DISABLE)
		GUICtrlSetState($chkDeadMeetTHO, $GUI_DISABLE)
		GUICtrlSetState($chkDeadSnipe, $GUI_DISABLE)
		If Not IsChecked($chkAnyActivate) Then
			GUICtrlSetState($btnSearchMode, $GUI_DISABLE)
		EndIf
	EndIf
EndFunc   ;==>Standard_chkDeadActivate

Func Standard_chkAnyActivate()
	If IsChecked($chkAnyActivate) Then
		GUICtrlSetState($chkKingAvail, $GUI_ENABLE)
		GUICtrlSetState($chkQueenAvail, $GUI_ENABLE)
		GUICtrlSetState($chkMeetGE, $GUI_ENABLE)
		GUICtrlSetState($txtMinGold, $GUI_ENABLE)
		GUICtrlSetState($cmbAny, $GUI_ENABLE)
		GUICtrlSetState($txtMinElixir, $GUI_ENABLE)
		GUICtrlSetState($chkMeetDE, $GUI_ENABLE)
		GUICtrlSetState($txtMinDarkElixir, $GUI_ENABLE)
		GUICtrlSetState($chkMeetTrophy, $GUI_ENABLE)
		GUICtrlSetState($txtMinTrophy, $GUI_ENABLE)
		GUICtrlSetState($chkMeetTH, $GUI_ENABLE)
		GUICtrlSetState($cmbTH, $GUI_ENABLE)
		GUICtrlSetState($chkMeetTHO, $GUI_ENABLE)
		GUICtrlSetState($chkSnipe, $GUI_ENABLE)
		GUICtrlSetState($btnSearchMode, $GUI_ENABLE)
	Else
		GUICtrlSetState($chkKingAvail, $GUI_DISABLE)
		GUICtrlSetState($chkQueenAvail, $GUI_DISABLE)
		GUICtrlSetState($chkMeetGE, $GUI_DISABLE)
		GUICtrlSetState($txtMinGold, $GUI_DISABLE)
		GUICtrlSetState($cmbAny, $GUI_DISABLE)
		GUICtrlSetState($txtMinElixir, $GUI_DISABLE)
		GUICtrlSetState($chkMeetDE, $GUI_DISABLE)
		GUICtrlSetState($txtMinDarkElixir, $GUI_DISABLE)
		GUICtrlSetState($chkMeetTrophy, $GUI_DISABLE)
		GUICtrlSetState($txtMinTrophy, $GUI_DISABLE)
		GUICtrlSetState($chkMeetTH, $GUI_DISABLE)
		GUICtrlSetState($cmbTH, $GUI_DISABLE)
		GUICtrlSetState($chkSnipe, $GUI_DISABLE)
		GUICtrlSetState($chkMeetTHO, $GUI_DISABLE)
		If Not IsChecked($chkDeadActivate) Then
			GUICtrlSetState($btnSearchMode, $GUI_DISABLE)
		EndIf
	EndIf
EndFunc   ;==>Standard_chkAnyActivate

Func Standard_chkMakeSpells()
	If IsChecked($chkMakeSpells) Then
		GUICtrlSetState($cmbSpellCreate, $GUI_ENABLE)
		GUICtrlSetState($txtDENukeLimit, $GUI_ENABLE)
		GUICtrlSetState($txtSpellNumber, $GUI_ENABLE)
		GUICtrlSetState($chkNukeAttacking, $GUI_ENABLE)
		GUICtrlSetState($chkNukeOnly, $GUI_ENABLE)
		GUICtrlSetState($chkNukeOnlyWithFullArmy, $GUI_ENABLE)
	Else
		GUICtrlSetState($cmbSpellCreate, $GUI_DISABLE)
		GUICtrlSetState($txtDENukeLimit, $GUI_DISABLE)
		GUICtrlSetState($txtSpellNumber, $GUI_DISABLE)
		GUICtrlSetState($chkNukeAttacking, $GUI_DISABLE)
		GUICtrlSetState($chkNukeOnly, $GUI_DISABLE)
		GUICtrlSetState($chkNukeOnlyWithFullArmy, $GUI_DISABLE)
	EndIf
EndFunc   ;==>Standard_chkMakeSpells

Func Standard_chkNukeAttacking()
	If IsChecked($chkNukeAttacking) Then
		GUICtrlSetState($txtSpellNumber, $GUI_ENABLE)
	Else
		GUICtrlSetState($txtSpellNumber, $GUI_DISABLE)
	EndIf
EndFunc   ;==>Standard_chkNukeAttacking

Func Standard_cmbSpellCreate()
	If _GUICtrlComboBox_GetCurSel($cmbSpellCreate) <> 0 Then
		GUICtrlSetState($txtDENukeLimit, $GUI_DISABLE)
		GUICtrlSetState($txtSpellNumber, $GUI_DISABLE)
		GUICtrlSetState($chkNukeAttacking, $GUI_DISABLE + $GUI_UNCHECKED)
		GUICtrlSetState($chkNukeOnly, $GUI_DISABLE + $GUI_UNCHECKED)
		GUICtrlSetState($chkNukeOnlyWithFullArmy, $GUI_DISABLE + $GUI_UNCHECKED)
	Else
		GUICtrlSetState($txtDENukeLimit, $GUI_ENABLE)
		GUICtrlSetState($txtSpellNumber, $GUI_ENABLE)
		GUICtrlSetState($chkNukeAttacking, $GUI_ENABLE)
		GUICtrlSetState($chkNukeOnly, $GUI_ENABLE)
		GUICtrlSetState($chkNukeOnlyWithFullArmy, $GUI_ENABLE)
	EndIf
EndFunc   ;==>Standard_cmbSpellCreate

Func Standard_cmbTroopComp()
	If _GUICtrlComboBox_GetCurSel($cmbTroopComp) <> $prevTroopComp Then
		$prevTroopComp = _GUICtrlComboBox_GetCurSel($cmbTroopComp)
		$ArmyComp = 0
		$CurArch = 1
		$CurBarb = 1
		$CurGoblin = 1
		$CurGiant = 1
		$CurWB = 1
		Standard_SetComboTroopComp()
		_GUICtrlComboBox_SetCurSel($cmbAlgorithm, $prevTroopComp)
		_GUICtrlComboBox_SetCurSel($cmbDeadAlgorithm, $prevTroopComp)
	EndIf
EndFunc   ;==>Standard_cmbTroopComp

Func Standard_SetComboTroopComp()
	Local $BarbariansComp = GUICtrlRead($txtBarbarians)
	Local $ArchersComp = GUICtrlRead($txtArchers)
	Local $GoblinsComp = GUICtrlRead($txtGoblins)
	Local $GiantsComp = GUICtrlRead($txtNumGiants)
	Local $WBComp = GUICtrlRead($txtNumWallbreakers)
	Switch _GUICtrlComboBox_GetCurSel($cmbTroopComp)
		Case 0
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			GUICtrlSetState($txtBarbarians, $GUI_DISABLE)
			GUICtrlSetState($txtArchers, $GUI_DISABLE)
			GUICtrlSetState($txtGoblins, $GUI_DISABLE)
			GUICtrlSetState($txtNumGiants, $GUI_DISABLE)
			GUICtrlSetState($txtNumWallbreakers, $GUI_DISABLE)
			GUICtrlSetData($txtBarbarians, "0")
			GUICtrlSetData($txtArchers, "100")
			GUICtrlSetData($txtGoblins, "0")
			GUICtrlSetData($txtNumGiants, "0")
			GUICtrlSetData($txtNumWallbreakers, "0")
		Case 1
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			GUICtrlSetState($txtBarbarians, $GUI_DISABLE)
			GUICtrlSetState($txtArchers, $GUI_DISABLE)
			GUICtrlSetState($txtGoblins, $GUI_DISABLE)
			GUICtrlSetState($txtNumGiants, $GUI_DISABLE)
			GUICtrlSetState($txtNumWallbreakers, $GUI_DISABLE)
			GUICtrlSetData($txtBarbarians, "100")
			GUICtrlSetData($txtArchers, "0")
			GUICtrlSetData($txtGoblins, "0")
			GUICtrlSetData($txtNumGiants, "0")
			GUICtrlSetData($txtNumWallbreakers, "0")
		Case 2
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			GUICtrlSetState($txtBarbarians, $GUI_DISABLE)
			GUICtrlSetState($txtArchers, $GUI_DISABLE)
			GUICtrlSetState($txtGoblins, $GUI_DISABLE)
			GUICtrlSetState($txtNumGiants, $GUI_DISABLE)
			GUICtrlSetState($txtNumWallbreakers, $GUI_DISABLE)
			GUICtrlSetData($txtBarbarians, "0")
			GUICtrlSetData($txtArchers, "0")
			GUICtrlSetData($txtGoblins, "100")
			GUICtrlSetData($txtNumGiants, "0")
			GUICtrlSetData($txtNumWallbreakers, "0")
		Case 3
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			GUICtrlSetState($txtBarbarians, $GUI_ENABLE)
			GUICtrlSetState($txtArchers, $GUI_ENABLE)
			GUICtrlSetState($txtGoblins, $GUI_DISABLE)
			GUICtrlSetState($txtNumGiants, $GUI_DISABLE)
			GUICtrlSetState($txtNumWallbreakers, $GUI_DISABLE)
			GUICtrlSetData($txtBarbarians, $BarbariansComp)
			GUICtrlSetData($txtArchers, $ArchersComp)
			GUICtrlSetData($txtGoblins, "0")
			GUICtrlSetData($txtNumGiants, "0")
			GUICtrlSetData($txtNumWallbreakers, "0")
		Case 4
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			GUICtrlSetState($txtBarbarians, $GUI_ENABLE)
			GUICtrlSetState($txtArchers, $GUI_ENABLE)
			GUICtrlSetState($txtGoblins, $GUI_ENABLE)
			GUICtrlSetState($txtNumGiants, $GUI_ENABLE)
			GUICtrlSetState($txtNumWallbreakers, $GUI_DISABLE)
			GUICtrlSetData($txtBarbarians, $BarbariansComp)
			GUICtrlSetData($txtArchers, $ArchersComp)
			GUICtrlSetData($txtGoblins, $GoblinsComp)
			GUICtrlSetData($txtNumGiants, $GiantsComp)
			GUICtrlSetData($txtNumWallbreakers, "0")
		Case 5
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			GUICtrlSetState($txtBarbarians, $GUI_ENABLE)
			GUICtrlSetState($txtArchers, $GUI_ENABLE)
			GUICtrlSetState($txtGoblins, $GUI_DISABLE)
			GUICtrlSetState($txtNumGiants, $GUI_ENABLE)
			GUICtrlSetState($txtNumWallbreakers, $GUI_DISABLE)
			GUICtrlSetData($txtBarbarians, $BarbariansComp)
			GUICtrlSetData($txtArchers, $ArchersComp)
			GUICtrlSetData($txtGoblins, "0")
			GUICtrlSetData($txtNumGiants, $GiantsComp)
			GUICtrlSetData($txtNumWallbreakers, "0")
		Case 6
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			GUICtrlSetState($txtBarbarians, $GUI_ENABLE)
			GUICtrlSetState($txtArchers, $GUI_ENABLE)
			GUICtrlSetState($txtGoblins, $GUI_ENABLE)
			GUICtrlSetState($txtNumGiants, $GUI_DISABLE)
			GUICtrlSetState($txtNumWallbreakers, $GUI_DISABLE)
			GUICtrlSetData($txtBarbarians, $BarbariansComp)
			GUICtrlSetData($txtArchers, $ArchersComp)
			GUICtrlSetData($txtGoblins, $GoblinsComp)
			GUICtrlSetData($txtNumGiants, "0")
			GUICtrlSetData($txtNumWallbreakers, "0")
		Case 7
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			GUICtrlSetState($txtBarbarians, $GUI_ENABLE)
			GUICtrlSetState($txtArchers, $GUI_ENABLE)
			GUICtrlSetState($txtGoblins, $GUI_ENABLE)
			GUICtrlSetState($txtNumGiants, $GUI_ENABLE)
			GUICtrlSetState($txtNumWallbreakers, $GUI_ENABLE)
			GUICtrlSetData($txtBarbarians, $BarbariansComp)
			GUICtrlSetData($txtArchers, $ArchersComp)
			GUICtrlSetData($txtGoblins, $GoblinsComp)
			GUICtrlSetData($txtNumGiants, $GiantsComp)
			GUICtrlSetData($txtNumWallbreakers, $WBComp)
		Case 8
			GUICtrlSetState($cmbBarrack1, $GUI_ENABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_ENABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_ENABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_ENABLE)
			GUICtrlSetState($txtBarbarians, $GUI_DISABLE)
			GUICtrlSetState($txtArchers, $GUI_DISABLE)
			GUICtrlSetState($txtGoblins, $GUI_DISABLE)
			GUICtrlSetState($txtNumGiants, $GUI_DISABLE)
			GUICtrlSetState($txtNumWallbreakers, $GUI_DISABLE)
		Case 9
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			GUICtrlSetState($txtBarbarians, $GUI_ENABLE)
			GUICtrlSetState($txtArchers, $GUI_ENABLE)
			GUICtrlSetState($txtGoblins, $GUI_ENABLE)
			GUICtrlSetState($txtNumGiants, $GUI_ENABLE)
			GUICtrlSetState($txtNumWallbreakers, $GUI_ENABLE)
			GUICtrlSetData($txtBarbarians, $BarbariansComp)
			GUICtrlSetData($txtArchers, $ArchersComp)
			GUICtrlSetData($txtGoblins, $GoblinsComp)
			GUICtrlSetData($txtNumGiants, $GiantsComp)
			GUICtrlSetData($txtNumWallbreakers, $WBComp)
	EndSwitch
EndFunc   ;==>Standard_SetComboTroopComp

Func Standard_cmbCollectorAttack()	
	If _GUICtrlComboBox_GetCurSel($cmbDeadDeploy) = 5 Or _GUICtrlComboBox_GetCurSel($cmbDeadDeploy) = 6 Or _GUICtrlComboBox_GetCurSel($cmbDeploy) = 5 Or _GUICtrlComboBox_GetCurSel($cmbDeploy) = 6 Then
		GUICtrlSetState($CollectorAtkSettings, $GUI_ENABLE)
		GUICtrlSetState($lblCollectorAtk, $GUI_ENABLE)
		GUICtrlSetState($chkColAtkGold, $GUI_ENABLE)
		GUICtrlSetState($chkColAtkElix, $GUI_ENABLE)
		GUICtrlSetState($chkColAtkDE, $GUI_ENABLE)
		
	Else
		GUICtrlSetState($CollectorAtkSettings, $GUI_DISABLE)
		GUICtrlSetState($lblCollectorAtk, $GUI_DISABLE)
		GUICtrlSetState($chkColAtkGold, $GUI_DISABLE)
		GUICtrlSetState($chkColAtkElix, $GUI_DISABLE)
		GUICtrlSetState($chkColAtkDE, $GUI_DISABLE)
	EndIf
EndFunc     ;==>Standard_cmbCollectorAttack

Func Standard_cmbFocusedAttack()	
	If _GUICtrlComboBox_GetCurSel($cmbDeadDeploy) = 7 Or _GUICtrlComboBox_GetCurSel($cmbDeploy) = 7 Then
		GUICtrlSetState($FocusedAtkSettings, $GUI_ENABLE)
		GUICtrlSetState($lblFocusedAtk, $GUI_ENABLE)
		GUICtrlSetState($cmbFocusedBuilding, $GUI_ENABLE)
		GUICtrlSetState($chkFocusedIgnoreCenter, $GUI_ENABLE)
	Else
		GUICtrlSetState($FocusedAtkSettings, $GUI_DISABLE)
		GUICtrlSetState($lblFocusedAtk, $GUI_DISABLE)
		GUICtrlSetState($cmbFocusedBuilding, $GUI_DISABLE)
		GUICtrlSetState($chkFocusedIgnoreCenter, $GUI_DISABLE)
		
	EndIf
EndFunc ;==>Standard_cmbFocusedAttack

Func Standard_cmbCheckEnableTHAttackDead()
	If _GUICtrlComboBox_GetCurSel($cmbDeadDeploy) = 5 Or _GUICtrlComboBox_GetCurSel($cmbDeadDeploy) = 6 Or _GUICtrlComboBox_GetCurSel($cmbDeadDeploy) = 7 Then
		_GUICtrlComboBox_SetCurSel($cmbDeadAttackTH, 0)
		GUICtrlSetState($cmbDeadAttackTH, $GUI_DISABLE)
	Else
		GUICtrlSetState($cmbDeadAttackTH, $GUI_ENABLE)
	EndIf

EndFunc   ;==>Standard_cmbCheckEnableTHDeadAttack

Func Standard_cmbCheckEnableTHAttack()
	If _GUICtrlComboBox_GetCurSel($cmbDeploy) = 5 Or _GUICtrlComboBox_GetCurSel($cmbDeploy) = 6 Or _GUICtrlComboBox_GetCurSel($cmbDeploy) = 7 Then
		_GUICtrlComboBox_SetCurSel($cmbAttackTH, 0)
		GUICtrlSetState($cmbAttackTH, $GUI_DISABLE)
	Else
		GUICtrlSetState($cmbAttackTH, $GUI_ENABLE)
	EndIf

EndFunc   ;==>Standard_cmbCheckEnableTHAttack