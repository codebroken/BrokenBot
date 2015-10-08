Func Standard_LoadConfig()
	$configFile = $dirStrat & GUICtrlRead($lstStrategies) & ".ini"
	;Search Settings------------------------------------------------------------------------
	If IniRead($configFile, "search", "DeadActivate", "0") = 1 Then
		GUICtrlSetState($chkDeadActivate, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDeadActivate, $GUI_UNCHECKED)
	EndIf
	If IniRead($configFile, "search", "AnyActivate", "0") = 1 Then
		GUICtrlSetState($chkAnyActivate, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkAnyActivate, $GUI_UNCHECKED)
	EndIf
	GUICtrlSetData($txtDeadMinGold, IniRead($configFile, "search", "searchDeadGold", "50000"))
	GUICtrlSetData($txtDeadMinElixir, IniRead($configFile, "search", "searchDeadElixir", "50000"))
	GUICtrlSetData($txtDeadMinDarkElixir, IniRead($configFile, "search", "searchDeadDark", "0"))
	GUICtrlSetData($txtDeadMinTrophy, IniRead($configFile, "search", "searchDeadTrophy", "0"))
	GUICtrlSetData($txtMinGold, IniRead($configFile, "search", "searchGold", "80000"))
	GUICtrlSetData($txtMinElixir, IniRead($configFile, "search", "searchElixir", "80000"))
	GUICtrlSetData($txtMinDarkElixir, IniRead($configFile, "search", "searchDark", "0"))
	GUICtrlSetData($txtMinTrophy, IniRead($configFile, "search", "searchTrophy", "0"))
	_GUICtrlComboBox_SetCurSel($cmbAny, IniRead($configFile, "search", "AnyAndOr", "0"))
	_GUICtrlComboBox_SetCurSel($cmbDead, IniRead($configFile, "search", "DeadAndOr", "0"))


	If IniRead($configFile, "search", "conditionDeadKingAvail", "0") = 1 Then
		GUICtrlSetState($chkDeadKingAvail, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDeadKingAvail, $GUI_UNCHECKED)
	EndIf

	If IniRead($configFile, "search", "conditionDeadQueenAvail", "0") = 1 Then
		GUICtrlSetState($chkDeadQueenAvail, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDeadQueenAvail, $GUI_UNCHECKED)
	EndIf

	If IniRead($configFile, "search", "conditionDeadGoldElixir", "0") = 1 Then
		GUICtrlSetState($chkDeadGE, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDeadGE, $GUI_UNCHECKED)
	EndIf

	If IniRead($configFile, "search", "conditionDeadDark", "0") = 1 Then
		GUICtrlSetState($chkDeadMeetDE, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDeadMeetDE, $GUI_UNCHECKED)
	EndIf

	If IniRead($configFile, "search", "conditionDeadTrophy", "0") = 1 Then
		GUICtrlSetState($chkDeadMeetTrophy, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDeadMeetTrophy, $GUI_UNCHECKED)
	EndIf

	If IniRead($configFile, "search", "conditionDeadTHLevel", "0") = 1 Then
		GUICtrlSetState($chkDeadMeetTH, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDeadMeetTH, $GUI_UNCHECKED)
	EndIf

	If IniRead($configFile, "search", "conditionDeadTHOutside", "0") = 1 Then
		GUICtrlSetState($chkDeadMeetTHO, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDeadMeetTHO, $GUI_UNCHECKED)
	EndIf

	If IniRead($configFile, "search", "conditionKingAvail", "0") = 1 Then
		GUICtrlSetState($chkKingAvail, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkKingAvail, $GUI_UNCHECKED)
	EndIf

	If IniRead($configFile, "search", "conditionQueenAvail", "0") = 1 Then
		GUICtrlSetState($chkQueenAvail, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkQueenAvail, $GUI_UNCHECKED)
	EndIf

	If IniRead($configFile, "search", "conditionGoldElixir", "0") = 1 Then
		GUICtrlSetState($chkMeetGE, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkMeetGE, $GUI_UNCHECKED)
	EndIf

	If IniRead($configFile, "search", "conditionDark", "0") = 1 Then
		GUICtrlSetState($chkMeetDE, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkMeetDE, $GUI_UNCHECKED)
	EndIf

	If IniRead($configFile, "search", "conditionTrophy", "0") = 1 Then
		GUICtrlSetState($chkMeetTrophy, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkMeetTrophy, $GUI_UNCHECKED)
	EndIf

	If IniRead($configFile, "search", "conditionTHLevel", "0") = 1 Then
		GUICtrlSetState($chkMeetTH, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkMeetTH, $GUI_UNCHECKED)
	EndIf

	If IniRead($configFile, "search", "conditionTHOutside", "0") = 1 Then
		GUICtrlSetState($chkMeetTHO, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkMeetTHO, $GUI_UNCHECKED)
	EndIf

	If IniRead($configFile, "search", "conditionDeadSnipe", "0") = 1 Then
		GUICtrlSetState($chkDeadSnipe, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDeadSnipe, $GUI_UNCHECKED)
	EndIf

	If IniRead($configFile, "search", "conditionSnipe", "0") = 1 Then
		GUICtrlSetState($chkSnipe, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkSnipe, $GUI_UNCHECKED)
	EndIf

	_GUICtrlComboBox_SetCurSel($cmbTH, IniRead($configFile, "search", "AnyTHLvl", "0"))
	_GUICtrlComboBox_SetCurSel($cmbDeadTH, IniRead($configFile, "search", "DeadTHLvl", "0"))

	Standard_chkDeadActivate()
	Standard_chkAnyActivate()

	;Search reduction settings inside search tab
	GUICtrlSetData($txtRedNumOfSerach, IniRead($configFile, "search", "RedutionNumOfSerach", "30"))
	GUICtrlSetData($txtRedGoldPercent, IniRead($configFile, "search", "ReductionGoldPercent", "5"))
	GUICtrlSetData($txtRedElixirPercent, IniRead($configFile, "search", "ReductionElixirPercent", "5"))
	GUICtrlSetData($txtRedDEPercent, IniRead($configFile, "search", "ReductionDEPercent", "5"))
	GUICtrlSetData($txtRedTrophyPercent, IniRead($configFile, "search", "ReductionTrophyPercent", "5"))
	GUICtrlSetData($txtRedNukePercent, IniRead($configFile, "search", "ReductionNukePercent", "5"))

	;Attack Settings-------------------------------------------------------------------------
	_GUICtrlComboBox_SetCurSel($cmbDeadDeploy, IniRead($configFile, "attack", "deploy-dead", "0"))
	_GUICtrlComboBox_SetCurSel($cmbDeadAlgorithm, IniRead($configFile, "attack", "algorithm-dead", "0"))

	If IniRead($configFile, "attack", "king-dead", "0") = 1 Then
		GUICtrlSetState($chkDeadUseKing, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDeadUseKing, $GUI_UNCHECKED)
	EndIf

	If IniRead($configFile, "attack", "queen-dead", "0") = 1 Then
		GUICtrlSetState($chkDeadUseQueen, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDeadUseQueen, $GUI_UNCHECKED)
	EndIf

	If IniRead($configFile, "attack", "use-cc-dead", "0") = 1 Then
		GUICtrlSetState($chkDeadUseClanCastle, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDeadUseClanCastle, $GUI_UNCHECKED)
	EndIf

	_GUICtrlComboBox_SetCurSel($cmbDeadAttackTH, IniRead($configFile, "attack", "townhall-dead", "0"))

	_GUICtrlComboBox_SetCurSel($cmbDeploy, IniRead($configFile, "attack", "deploy", "0"))
	_GUICtrlComboBox_SetCurSel($cmbAlgorithm, IniRead($configFile, "attack", "algorithm", "0"))

	If IniRead($configFile, "attack", "king-all", "0") = 1 Then
		GUICtrlSetState($chkUseKing, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkUseKing, $GUI_UNCHECKED)
	EndIf

	If IniRead($configFile, "attack", "queen-all", "0") = 1 Then
		GUICtrlSetState($chkUseQueen, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkUseQueen, $GUI_UNCHECKED)
	EndIf

	If IniRead($configFile, "attack", "use-cc", "0") = 1 Then
		GUICtrlSetState($chkUseClanCastle, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkUseClanCastle, $GUI_UNCHECKED)
	EndIf

	_GUICtrlComboBox_SetCurSel($cmbAttackTH, IniRead($configFile, "attack", "townhall", "0"))

	GUICtrlSetData($txtKingSkill, IniRead($configFile, "attack", "kingskilldelay", "10"))
	GUICtrlSetData($txtQueenSkill, IniRead($configFile, "attack", "queenskilldelay", "10"))
	
	If IniRead($configFile, "attack", "colatk-gold", "1") = 1 Then
		GUICtrlSetState($chkColAtkGold, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkColAtkGold, $GUI_UNCHECKED)
	EndIf
	
	If IniRead($configFile, "attack", "colatk-elixir", "1") = 1 Then
		GUICtrlSetState($chkColAtkElix, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkColAtkElix, $GUI_UNCHECKED)
	EndIf
	
	If IniRead($configFile, "attack", "colatk-DE", "1") = 1 Then
		GUICtrlSetState($chkColAtkDE, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkColAtkDE, $GUI_UNCHECKED)
	EndIf
	
	If IniRead($configFile, "attack", "focusatk-IgnoreCenter", "0") = 1 Then
		GUICtrlSetState($chkFocusedIgnoreCenter, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkFocusedIgnoreCenter, $GUI_UNCHECKED)
	EndIf
	
	Standard_cmbCollectorAttack()
	
	_GUICtrlComboBox_SetCurSel($cmbFocusedBuilding, IniRead($configFile, "attack", "focatck-focus", "1"))
	
	Standard_cmbFocusedAttack()
	
	Standard_cmbCheckEnableTHAttack()
	
	Standard_cmbCheckEnableTHAttackDead()

	;Troop Settings--------------------------------------------------------------------------
	_GUICtrlComboBox_SetCurSel($cmbTroopComp, IniRead($configFile, "troop", "composition", "0"))
	_GUICtrlComboBox_SetCurSel($cmbRaidcap, IniRead($configFile, "troop", "raidcapacity", "9"))
	GUICtrlSetData($txtBarbarians, IniRead($configFile, "troop", "barbarian", "0"))
	GUICtrlSetData($txtArchers, IniRead($configFile, "troop", "archer", "0"))
	GUICtrlSetData($txtNumGiants, IniRead($configFile, "troop", "giant", "0"))
	GUICtrlSetData($txtGoblins, IniRead($configFile, "troop", "goblin", "0"))
	GUICtrlSetData($txtNumWallbreakers, IniRead($configFile, "troop", "WB", "0"))
	Standard_SetComboTroopComp()

	_GUICtrlComboBox_SetCurSel($cmbBarrack1, IniRead($configFile, "troop", "troop1", "0"))
	_GUICtrlComboBox_SetCurSel($cmbBarrack2, IniRead($configFile, "troop", "troop2", "0"))
	_GUICtrlComboBox_SetCurSel($cmbBarrack3, IniRead($configFile, "troop", "troop3", "0"))
	_GUICtrlComboBox_SetCurSel($cmbBarrack4, IniRead($configFile, "troop", "troop4", "0"))
	;Dark Troops---------------------------------------------
 	;_GUICtrlComboBox_SetCurSel($cmbDarkBarrack1, $DarkBarrackTroop[0])
 	;_GUICtrlComboBox_SetCurSel($cmbDarkBarrack2, $DarkBarrackTroop[1])
	_GUICtrlComboBox_SetCurSel($cmbDarkBarrack1, IniRead($configFile, "other", "Darktroop1", "0"))
 	_GUICtrlComboBox_SetCurSel($cmbDarkBarrack2, IniRead($configFile, "other", "Darktroop2", "0"))
 	GUICtrlSetData($txtDarkBarrack1, IniRead($configFile, "other", "DarkRax1", "0"))
 	GUICtrlSetData($txtDarkBarrack2, IniRead($configFile, "other", "DarkRax2", "0"))
	
	$DarkBarrackTroop[0] = _GUICtrlComboBox_GetCurSel($cmbDarkBarrack1)
	$DarkBarrackTroop[1] = _GUICtrlComboBox_GetCurSel($cmbDarkBarrack2)
	
	_GUICtrlComboBox_SetCurSel($cmbDarkBarrack1Next, IniRead($configFile, "other", "Darktroop1Next", "0"))
 	_GUICtrlComboBox_SetCurSel($cmbDarkBarrack2Next, IniRead($configFile, "other", "Darktroop2Next", "0"))
 	GUICtrlSetData($txtDarkBarrack1Next, IniRead($configFile, "other", "DarkRax1Next", "0"))
 	GUICtrlSetData($txtDarkBarrack2Next, IniRead($configFile, "other", "DarkRax2Next", "0"))

	;Spell Settings--------------------------------------------------------------------------
	If IniRead($configFile, "spells", "chkMakeSpells", "0") = 1 Then
		GUICtrlSetState($chkMakeSpells, $GUI_CHECKED)
		GUICtrlSetState($cmbSpellCreate, $GUI_ENABLE)
		GUICtrlSetState($txtDENukeLimit, $GUI_ENABLE)
		GUICtrlSetState($txtSpellNumber, $GUI_ENABLE)
		GUICtrlSetState($chkNukeAttacking, $GUI_ENABLE)
		GUICtrlSetState($chkNukeOnly, $GUI_ENABLE)
		GUICtrlSetState($chkNukeOnlyWithFullArmy, $GUI_ENABLE)
	Else
		GUICtrlSetState($chkMakeSpells, $GUI_UNCHECKED)
		GUICtrlSetState($cmbSpellCreate, $GUI_DISABLE)
		GUICtrlSetState($txtDENukeLimit, $GUI_DISABLE)
		GUICtrlSetState($txtSpellNumber, $GUI_DISABLE)
		GUICtrlSetState($chkNukeAttacking, $GUI_DISABLE)
		GUICtrlSetState($chkNukeOnly, $GUI_DISABLE)
		GUICtrlSetState($chkNukeOnlyWithFullArmy, $GUI_DISABLE)
	EndIf
	_GUICtrlComboBox_SetCurSel($cmbSpellCreate, IniRead($configFile, "spells", "spellname", "0"))
	GUICtrlSetData($txtDENukeLimit, IniRead($configFile, "spells", "nukelimit", "2000"))
	GUICtrlSetData($txtSpellNumber, IniRead($configFile, "spells", "spellnumber", "3"))
	If IniRead($configFile, "spells", "chkNukeAttacking", "0") = 1 Then
		GUICtrlSetState($chkNukeAttacking, $GUI_CHECKED)
		GUICtrlSetState($txtSpellNumber, $GUI_ENABLE)
	Else
		GUICtrlSetState($chkNukeAttacking, $GUI_UNCHECKED)
		GUICtrlSetState($txtSpellNumber, $GUI_DISABLE)
	EndIf
	If IniRead($configFile, "spells", "chkNukeOnly", "0") = 1 Then
		GUICtrlSetState($chkNukeOnly, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkNukeOnly, $GUI_UNCHECKED)
	EndIf
	If IniRead($configFile, "spells", "chkNukeOnlyWithFullArmy", "0") = 1 Then
		GUICtrlSetState($chkNukeOnlyWithFullArmy, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkNukeOnlyWithFullArmy, $GUI_UNCHECKED)
	EndIf

EndFunc   ;==>Standard_LoadConfig

Func Standard_SaveConfig($configFile)
	IniWrite($configFile, "plugin", "name", "Standard")
	;Search Settings------------------------------------------------------------------------
	If IsChecked($chkDeadActivate) Then
		IniWrite($configFile, "search", "DeadActivate", 1)
	Else
		IniWrite($configFile, "search", "DeadActivate", 0)
	EndIf
	If IsChecked($chkAnyActivate) Then
		IniWrite($configFile, "search", "AnyActivate", 1)
	Else
		IniWrite($configFile, "search", "AnyActivate", 0)
	EndIf
	IniWrite($configFile, "search", "searchDeadGold", GUICtrlRead($txtDeadMinGold))
	IniWrite($configFile, "search", "searchDeadElixir", GUICtrlRead($txtDeadMinElixir))
	IniWrite($configFile, "search", "searchDeadDark", GUICtrlRead($txtDeadMinDarkElixir))
	IniWrite($configFile, "search", "searchDeadTrophy", GUICtrlRead($txtDeadMinTrophy))
	IniWrite($configFile, "search", "searchGold", GUICtrlRead($txtMinGold))
	IniWrite($configFile, "search", "searchElixir", GUICtrlRead($txtMinElixir))
	IniWrite($configFile, "search", "searchDark", GUICtrlRead($txtMinDarkElixir))
	IniWrite($configFile, "search", "searchTrophy", GUICtrlRead($txtMinTrophy))
	IniWrite($configFile, "search", "AnyAndOr", _GUICtrlComboBox_GetCurSel($cmbAny))
	IniWrite($configFile, "search", "DeadAndOr", _GUICtrlComboBox_GetCurSel($cmbDead))
	IniWrite($configFile, "search", "AnyTHLvl", _GUICtrlComboBox_GetCurSel($cmbTH))
	IniWrite($configFile, "search", "DeadTHLvl", _GUICtrlComboBox_GetCurSel($cmbDeadTH))

	If IsChecked($chkDeadKingAvail) Then
		IniWrite($configFile, "search", "conditionDeadKingAvail", 1)
	Else
		IniWrite($configFile, "search", "conditionDeadKingAvail", 0)
	EndIf

	If IsChecked($chkDeadQueenAvail) Then
		IniWrite($configFile, "search", "conditionDeadQueenAvail", 1)
	Else
		IniWrite($configFile, "search", "conditionDeadQueenAvail", 0)
	EndIf

	If IsChecked($chkDeadGE) Then
		IniWrite($configFile, "search", "conditionDeadGoldElixir", 1)
	Else
		IniWrite($configFile, "search", "conditionDeadGoldElixir", 0)
	EndIf

	If IsChecked($chkDeadMeetDE) Then
		IniWrite($configFile, "search", "conditionDeadDark", 1)
	Else
		IniWrite($configFile, "search", "conditionDeadDark", 0)
	EndIf

	If IsChecked($chkDeadMeetTrophy) Then
		IniWrite($configFile, "search", "conditionDeadTrophy", 1)
	Else
		IniWrite($configFile, "search", "conditionDeadTrophy", 0)
	EndIf

	If IsChecked($chkDeadMeetTH) Then
		IniWrite($configFile, "search", "conditionDeadTHLevel", 1)
	Else
		IniWrite($configFile, "search", "conditionDeadTHLevel", 0)
	EndIf

	If IsChecked($chkDeadMeetTHO) Then
		IniWrite($configFile, "search", "conditionDeadTHOutside", 1)
	Else
		IniWrite($configFile, "search", "conditionDeadTHOutside", 0)
	EndIf

	If IsChecked($chkDeadSnipe) Then
		IniWrite($configFile, "search", "conditionDeadSnipe", 1)
	Else
		IniWrite($configFile, "search", "conditionDeadSnipe", 0)
	EndIf

	If IsChecked($chkKingAvail) Then
		IniWrite($configFile, "search", "conditionKingAvail", 1)
	Else
		IniWrite($configFile, "search", "conditionKingAvail", 0)
	EndIf

	If IsChecked($chkQueenAvail) Then
		IniWrite($configFile, "search", "conditionQueenAvail", 1)
	Else
		IniWrite($configFile, "search", "conditionQueenAvail", 0)
	EndIf

	If IsChecked($chkMeetGE) Then
		IniWrite($configFile, "search", "conditionGoldElixir", 1)
	Else
		IniWrite($configFile, "search", "conditionGoldElixir", 0)
	EndIf

	If IsChecked($chkMeetDE) Then
		IniWrite($configFile, "search", "conditionDark", 1)
	Else
		IniWrite($configFile, "search", "conditionDark", 0)
	EndIf

	If IsChecked($chkMeetTrophy) Then
		IniWrite($configFile, "search", "conditionTrophy", 1)
	Else
		IniWrite($configFile, "search", "conditionTrophy", 0)
	EndIf

	If IsChecked($chkMeetTH) Then
		IniWrite($configFile, "search", "conditionTHLevel", 1)
	Else
		IniWrite($configFile, "search", "conditionTHLevel", 0)
	EndIf

	If IsChecked($chkMeetTHO) Then
		IniWrite($configFile, "search", "conditionTHOutside", 1)
	Else
		IniWrite($configFile, "search", "conditionTHOutside", 0)
	EndIf

	If IsChecked($chkSnipe) Then
		IniWrite($configFile, "search", "conditionSnipe", 1)
	Else
		IniWrite($configFile, "search", "conditionSnipe", 0)
	EndIf
	;Search reduction setting in search tab
	If GUICtrlRead($txtRedNumOfSerach) = 0 Then GUICtrlSetData($txtRedNumOfSerach, 30)
	IniWrite($configFile, "search", "RedutionNumOfSerach", GUICtrlRead($txtRedNumOfSerach))
	IniWrite($configFile, "search", "ReductionGoldPercent", GUICtrlRead($txtRedGoldPercent))
	IniWrite($configFile, "search", "ReductionElixirPercent", GUICtrlRead($txtRedElixirPercent))
	IniWrite($configFile, "search", "ReductionDEPercent", GUICtrlRead($txtRedDEPercent))
	IniWrite($configFile, "search", "ReductionTrophyPercent", GUICtrlRead($txtRedTrophyPercent))
	IniWrite($configFile, "search", "ReductionNukePercent", GUICtrlRead($txtRedNukePercent))

	;Attack Settings-------------------------------------------------------------------------
	IniWrite($configFile, "attack", "deploy-dead", _GUICtrlComboBox_GetCurSel($cmbDeadDeploy))
	IniWrite($configFile, "attack", "algorithm-dead", _GUICtrlComboBox_GetCurSel($cmbDeadAlgorithm))

	If IsChecked($chkDeadUseKing) Then
		IniWrite($configFile, "attack", "king-dead", 1)
	Else
		IniWrite($configFile, "attack", "king-dead", 0)
	EndIf

	If IsChecked($chkDeadUseQueen) Then
		IniWrite($configFile, "attack", "queen-dead", 1)
	Else
		IniWrite($configFile, "attack", "queen-dead", 0)
	EndIf

	If IsChecked($chkDeadUseClanCastle) Then
		IniWrite($configFile, "attack", "use-cc-dead", 1)
	Else
		IniWrite($configFile, "attack", "use-cc-dead", 0)
	EndIf

	IniWrite($configFile, "attack", "townhall-dead", _GUICtrlComboBox_GetCurSel($cmbDeadAttackTH))

	IniWrite($configFile, "attack", "deploy", _GUICtrlComboBox_GetCurSel($cmbDeploy))
	IniWrite($configFile, "attack", "algorithm", _GUICtrlComboBox_GetCurSel($cmbAlgorithm))

	If IsChecked($chkUseKing) Then
		IniWrite($configFile, "attack", "king-all", 1)
	Else
		IniWrite($configFile, "attack", "king-all", 0)
	EndIf

	If IsChecked($chkUseQueen) Then
		IniWrite($configFile, "attack", "queen-all", 1)
	Else
		IniWrite($configFile, "attack", "queen-all", 0)
	EndIf

	If IsChecked($chkUseClanCastle) Then
		IniWrite($configFile, "attack", "use-cc", 1)
	Else
		IniWrite($configFile, "attack", "use-cc", 0)
	EndIf

	IniWrite($configFile, "attack", "townhall", _GUICtrlComboBox_GetCurSel($cmbAttackTH))

	IniWrite($configFile, "attack", "kingskilldelay", GUICtrlRead($txtKingSkill))
	IniWrite($configFile, "attack", "queenskilldelay", GUICtrlRead($txtQueenSkill))
	
	If IsChecked($chkColAtkGold) Then
		IniWrite($configFile, "attack", "colatk-gold", "1") 
	Else
		IniWrite($configFile, "attack", "colatk-gold", "0") 
	EndIf
	
	If IsChecked($chkColAtkElix) Then
		IniWrite($configFile, "attack", "colatk-elixir", "1") 
	Else
		IniWrite($configFile, "attack", "colatk-elixir", "0") 
	EndIf
	
	If IsChecked($chkColAtkDE) Then
		IniWrite($configFile, "attack", "colatk-DE", "1") 
	Else
		IniWrite($configFile, "attack", "colatk-DE", "0") 
	EndIf
	
	If IsChecked($chkFocusedIgnoreCenter) Then
		IniWrite($configFile, "attack", "focusatk-IgnoreCenter", "1") 
	Else
		IniWrite($configFile, "attack", "focusatk-IgnoreCenter", "0") 
	EndIf
	
	IniWrite($configFile, "attack", "focatck-focus", _GUICtrlComboBox_GetCurSel($cmbFocusedBuilding))
	
	;Troop Settings--------------------------------------------------------------------------
	IniWrite($configFile, "troop", "raidcapacity", _GUICtrlComboBox_GetCurSel($cmbRaidcap))
	IniWrite($configFile, "troop", "composition", _GUICtrlComboBox_GetCurSel($cmbTroopComp))
	Switch _GUICtrlComboBox_GetCurSel($cmbTroopComp)
		Case 3
			If (GUICtrlRead($txtBarbarians) + GUICtrlRead($txtArchers)) <> 100 Then
				$newBarb = Round((GUICtrlRead($txtBarbarians) / (GUICtrlRead($txtBarbarians) + GUICtrlRead($txtArchers))) * 100)
				$newArch = 100 - $newBarb
				GUICtrlSetData($txtBarbarians, $newBarb)
				GUICtrlSetData($txtArchers, $newArch)
				SetLog(GetLangText("msgAdjustingB") & $newBarb & GetLangText("msgAdjustingA") & $newArch & "%", $COLOR_RED)
			EndIf
		Case 4
			If (GUICtrlRead($txtBarbarians) + GUICtrlRead($txtArchers) + GUICtrlRead($txtGoblins)) <> 100 Then
				$newBarb = Round((GUICtrlRead($txtBarbarians) / (GUICtrlRead($txtBarbarians) + GUICtrlRead($txtArchers) + GUICtrlRead($txtGoblins))) * 100)
				$newArch = Round((GUICtrlRead($txtArchers) / (GUICtrlRead($txtBarbarians) + GUICtrlRead($txtArchers) + GUICtrlRead($txtGoblins))) * 100)
				$newGob = 100 - $newBarb - $newArch
				GUICtrlSetData($txtBarbarians, $newBarb)
				GUICtrlSetData($txtArchers, $newArch)
				GUICtrlSetData($txtGoblins, $newGob)
				SetLog(GetLangText("msgAdjustingB") & $newBarb & GetLangText("msgAdjustingA") & $newArch & GetLangText("msgAdjustingG") & $newGob & "%", $COLOR_RED)
			EndIf
		Case 5
			If (GUICtrlRead($txtBarbarians) + GUICtrlRead($txtArchers)) <> 100 Then
				$newBarb = Round((GUICtrlRead($txtBarbarians) / (GUICtrlRead($txtBarbarians) + GUICtrlRead($txtArchers))) * 100)
				$newArch = 100 - $newBarb
				GUICtrlSetData($txtBarbarians, $newBarb)
				GUICtrlSetData($txtArchers, $newArch)
				SetLog(GetLangText("msgAdjustingB") & $newBarb & GetLangText("msgAdjustingA") & $newArch & "%", $COLOR_RED)
			EndIf
		Case 6
			If (GUICtrlRead($txtBarbarians) + GUICtrlRead($txtArchers) + GUICtrlRead($txtGoblins)) <> 100 Then
				$newBarb = Round((GUICtrlRead($txtBarbarians) / (GUICtrlRead($txtBarbarians) + GUICtrlRead($txtArchers) + GUICtrlRead($txtGoblins))) * 100)
				$newArch = Round((GUICtrlRead($txtArchers) / (GUICtrlRead($txtBarbarians) + GUICtrlRead($txtArchers) + GUICtrlRead($txtGoblins))) * 100)
				$newGob = 100 - $newBarb - $newArch
				GUICtrlSetData($txtBarbarians, $newBarb)
				GUICtrlSetData($txtArchers, $newArch)
				GUICtrlSetData($txtGoblins, $newGob)
				SetLog(GetLangText("msgAdjustingB") & $newBarb & GetLangText("msgAdjustingA") & $newArch & GetLangText("msgAdjustingG") & $newGob & "%", $COLOR_RED)
			EndIf
		Case 7
			If (GUICtrlRead($txtBarbarians) + GUICtrlRead($txtArchers) + GUICtrlRead($txtGoblins)) <> 100 Then
				$newBarb = Round((GUICtrlRead($txtBarbarians) / (GUICtrlRead($txtBarbarians) + GUICtrlRead($txtArchers) + GUICtrlRead($txtGoblins))) * 100)
				$newArch = Round((GUICtrlRead($txtArchers) / (GUICtrlRead($txtBarbarians) + GUICtrlRead($txtArchers) + GUICtrlRead($txtGoblins))) * 100)
				$newGob = 100 - $newBarb - $newArch
				GUICtrlSetData($txtBarbarians, $newBarb)
				GUICtrlSetData($txtArchers, $newArch)
				GUICtrlSetData($txtGoblins, $newGob)
				SetLog(GetLangText("msgAdjustingB") & $newBarb & GetLangText("msgAdjustingA") & $newArch & GetLangText("msgAdjustingG") & $newGob & "%", $COLOR_RED)
			EndIf
	EndSwitch
	IniWrite($configFile, "troop", "barbarian", GUICtrlRead($txtBarbarians))
	IniWrite($configFile, "troop", "archer", GUICtrlRead($txtArchers))
	IniWrite($configFile, "troop", "goblin", GUICtrlRead($txtGoblins))
	IniWrite($configFile, "troop", "giant", GUICtrlRead($txtNumGiants))
	IniWrite($configFile, "troop", "WB", GUICtrlRead($txtNumWallbreakers))
	IniWrite($configFile, "troop", "troop1", _GUICtrlComboBox_GetCurSel($cmbBarrack1))
	IniWrite($configFile, "troop", "troop2", _GUICtrlComboBox_GetCurSel($cmbBarrack2))
	IniWrite($configFile, "troop", "troop3", _GUICtrlComboBox_GetCurSel($cmbBarrack3))
	IniWrite($configFile, "troop", "troop4", _GUICtrlComboBox_GetCurSel($cmbBarrack4))

	;Dark Barracks
 	IniWrite($configFile, "other", "Darktroop1", _GUICtrlComboBox_GetCurSel($cmbDarkBarrack1))
 	IniWrite($configFile, "other", "Darktroop2", _GUICtrlComboBox_GetCurSel($cmbDarkBarrack2))
 	IniWrite($configFile, "other", "DarkRax1", GUICtrlRead($txtDarkBarrack1))
 	IniWrite($configFile, "other", "DarkRax2", GUICtrlRead($txtDarkBarrack2))
	
	IniWrite($configFile, "other", "Darktroop1Next", _GUICtrlComboBox_GetCurSel($cmbDarkBarrack1Next))
 	IniWrite($configFile, "other", "Darktroop2Next", _GUICtrlComboBox_GetCurSel($cmbDarkBarrack2Next))
 	IniWrite($configFile, "other", "DarkRax1Next", GUICtrlRead($txtDarkBarrack1Next))
 	IniWrite($configFile, "other", "DarkRax2Next", GUICtrlRead($txtDarkBarrack2Next))

	;Spell Settings--------------------------------------------------------------------------
	If IsChecked($chkMakeSpells) Then
		IniWrite($configFile, "spells", "chkMakeSpells", 1)
	Else
		IniWrite($configFile, "spells", "chkMakeSpells", 0)
	EndIf
	IniWrite($configFile, "spells", "spellname", _GUICtrlComboBox_GetCurSel($cmbSpellCreate))
	IniWrite($configFile, "spells", "nukelimit", GUICtrlRead($txtDENukeLimit))
	IniWrite($configFile, "spells", "spellnumber", GUICtrlRead($txtSpellNumber))
	If IsChecked($chkNukeAttacking) Then
		IniWrite($configFile, "spells", "chkNukeAttacking", 1)
	Else
		IniWrite($configFile, "spells", "chkNukeAttacking", 0)
	EndIf
	If IsChecked($chkNukeOnly) Then
		IniWrite($configFile, "spells", "chkNukeOnly", 1)
	Else
		IniWrite($configFile, "spells", "chkNukeOnly", 0)
	EndIf
	If IsChecked($chkNukeOnlyWithFullArmy) Then
		IniWrite($configFile, "spells", "chkNukeOnlyWithFullArmy", 1)
	Else
		IniWrite($configFile, "spells", "chkNukeOnlyWithFullArmy", 0)
	EndIf

EndFunc   ;==>Standard_SaveConfig
