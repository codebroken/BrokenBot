Func Standard_LoadGUI()
	; Required prior to making new tabs
	$frmAttackConfig = GUICreate("Attack config panel", 410, 410, -1, -1, $WS_BORDER + $WS_POPUP, $WS_EX_MDICHILD, $frmBot)
	Opt('GUIResizeMode', 802)
	GUISetState(@SW_HIDE, $frmAttackConfig)
	_WinMoved(0, 0, 0, 0)
	GUISwitch($frmAttackConfig)

	$tabStrat = GUICtrlCreateTab(10, 10, 415, 550)
	; ---------------------------------------------------------------------------
	$pageSearch = GUICtrlCreateTabItem(GetLangText("pageSearch"))
	$DeadConditions = GUICtrlCreateGroup(GetLangText("DeadConditions"), 18, 40, 397, 135)
	Global $chkDeadActivate = GUICtrlCreateCheckbox(GetLangText("chkActivate"), 30, 60, 90, 17)
	GUICtrlSetOnEvent($chkDeadActivate, "Standard_chkDeadActivate")
	GUICtrlSetTip(-1, GetLangText("lblDeadConditions"))
	;$lblDeadConditions = GUICtrlCreateLabel(GetLangText("lblDeadConditions"), 120, 60, 380, 20)
	Global $chkDeadKingAvail = GUICtrlCreateCheckbox(GetLangText("chkKingAvail"), 130, 60, 120, 17)
	Global $chkDeadQueenAvail = GUICtrlCreateCheckbox(GetLangText("chkQueenAvail"), 260, 60, 120, 17)
	Global $chkDeadGE = GUICtrlCreateCheckbox(GetLangText("chkMeetGE"), 30, 83, 100, 17)
	$lblDeadMinGold = GUICtrlCreateLabel(GetLangText("lblMinGold"), 140, 85, 28, 17)
	Global $txtDeadMinGold = GUICtrlCreateInput("50000", 170, 80, 50, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 6)
	Global $cmbDead = GUICtrlCreateCombo("", 240, 80, 45, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, GetLangText("cmbAndOr")|GetLangText("cmbAnd")|GetLangText("cmbPlus"))
	$lblDeadMinElixir = GUICtrlCreateLabel(GetLangText("lblMinElixir"), 300, 85, 28, 17)
	Global $txtDeadMinElixir = GUICtrlCreateInput("50000", 330, 80, 50, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 6)
	Global $chkDeadMeetDE = GUICtrlCreateCheckbox(GetLangText("chkMeetDE"), 30, 113, 95, 17)
	Global $txtDeadMinDarkElixir = GUICtrlCreateInput("0", 130, 110, 60, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 6)
	Global $chkDeadMeetTrophy = GUICtrlCreateCheckbox(GetLangText("chkMeetTrophy"), 225, 113, 95, 17)
	Global $txtDeadMinTrophy = GUICtrlCreateInput("0", 325, 110, 60, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	Global $chkDeadMeetTH = GUICtrlCreateCheckbox(GetLangText("chkMeetTH"), 30, 143, 95, 17)
	Global $cmbDeadTH = GUICtrlCreateCombo("", 130, 140, 60, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "4-6|7|8|9|10", "4-6")
	Global $chkDeadMeetTHO = GUICtrlCreateCheckbox(GetLangText("chkMeetTHO"), 225, 143, 70, 17)
	GUICtrlSetTip(-1, GetLangText("chkMeetTHOTip"))
	Global $chkDeadSnipe = GUICtrlCreateCheckbox(GetLangText("chkSnipe"), 315, 143, 50, 17)
	GUICtrlSetTip(-1, GetLangText("chkSnipeTip"))
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
	$AnyConditions = GUICtrlCreateGroup(GetLangText("AnyConditions"), 18, 180, 397, 130)
	Global $chkAnyActivate = GUICtrlCreateCheckbox(GetLangText("chkActivate"), 30, 200, 90, 17)
	GUICtrlSetOnEvent($chkAnyActivate, "Standard_chkAnyActivate")
	GUICtrlSetTip(-1, GetLangText("lblAnyConditions"))
	;$lblAnyConditions = GUICtrlCreateLabel(GetLangText("lblAnyConditions"), 120, 200, 380, 20)
	Global $chkKingAvail = GUICtrlCreateCheckbox(GetLangText("chkKingAvail"), 130, 200, 120, 17)
	Global $chkQueenAvail = GUICtrlCreateCheckbox(GetLangText("chkQueenAvail"), 260, 200, 120, 17)
	Global $chkMeetGE = GUICtrlCreateCheckbox(GetLangText("chkMeetGE"), 30, 223, 100, 17)
	GUICtrlSetState(-1, $GUI_CHECKED)
	$lblMinGold = GUICtrlCreateLabel(GetLangText("lblMinGold"), 140, 225, 28, 17)
	Global $txtMinGold = GUICtrlCreateInput("80000", 170, 220, 50, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 6)
	Global $cmbAny = GUICtrlCreateCombo("", 240, 220, 45, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, GetLangText("cmbAndOr"), GetLangText("cmbAnd"))
	$lblMinElixir = GUICtrlCreateLabel(GetLangText("lblMinElixir"), 300, 225, 28, 17)
	Global $txtMinElixir = GUICtrlCreateInput("80000", 330, 220, 50, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 6)
	Global $chkMeetDE = GUICtrlCreateCheckbox(GetLangText("chkMeetDE"), 30, 253, 95, 17)
	Global $txtMinDarkElixir = GUICtrlCreateInput("0", 130, 250, 60, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 6)
	Global $chkMeetTrophy = GUICtrlCreateCheckbox(GetLangText("chkMeetTrophy"), 225, 253, 95, 17)
	Global $txtMinTrophy = GUICtrlCreateInput("0", 325, 250, 60, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	Global $chkMeetTH = GUICtrlCreateCheckbox(GetLangText("chkMeetTH"), 30, 283, 95, 17)
	Global $cmbTH = GUICtrlCreateCombo("", 130, 280, 60, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "4-6|7|8|9|10", "4-6")
	Global $chkMeetTHO = GUICtrlCreateCheckbox(GetLangText("chkMeetTHO"), 225, 283, 70, 17)
	GUICtrlSetTip(-1, GetLangText("chkMeetTHOTip"))
	Global $chkSnipe = GUICtrlCreateCheckbox(GetLangText("chkSnipe"), 315, 283, 50, 17)
	GUICtrlSetTip(-1, GetLangText("chkSnipeTip"))
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
	GUICtrlSetState($chkMeetTHO, $GUI_DISABLE)
	; -- tab search condition reduction
	$RedConditions = GUICtrlCreateGroup(GetLangText("RedConditions"), 18, 315, 397, 150)
	$lblRedNumOfSerach = GUICtrlCreateLabel(GetLangText("lblRedNumOfSerach"), 30, 340, 120, 20)
	Global $txtRedNumOfSerach = GUICtrlCreateInput("30", 160, 340, 50, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 3)
	$lblRedGoldPercent = GUICtrlCreateLabel(GetLangText("lblRedGoldPercent"), 30, 370, 120, 20)
	Global $txtRedGoldPercent = GUICtrlCreateInput("5", 160, 370, 50, 21, BitOR($ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	$lblRedElixirPercent = GUICtrlCreateLabel(GetLangText("lblRedElixirPercent"), 220, 370, 120, 20)
	Global $txtRedElixirPercent = GUICtrlCreateInput("5", 350, 370, 50, 21, BitOR($ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	$lblRedDEPercent = GUICtrlCreateLabel(GetLangText("lblRedDEPercent"), 30, 400, 120, 20)
	Global $txtRedDEPercent = GUICtrlCreateInput("5", 160, 400, 50, 21, BitOR($ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	$lblRedTrophyPercent = GUICtrlCreateLabel(GetLangText("lblRedTrophyPercent"), 220, 400, 120, 20)
	Global $txtRedTrophyPercent = GUICtrlCreateInput("5", 350, 400, 50, 21, BitOR($ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	$lblRedNukePercent = GUICtrlCreateLabel(GetLangText("lblRedNukePercent"), 30, 430, 120, 20)
	Global $txtRedNukePercent = GUICtrlCreateInput("5", 160, 430, 50, 21, BitOR($ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	; -- end of session
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	Global $btnSearchMode = GUICtrlCreateButton(GetLangText("btnSearchMode"), 20, 527, 393, 25)
	GUICtrlSetOnEvent(-1, "Standard_btnSearchMode")
	GUICtrlSetTip(-1, GetLangText("btnSearchModeTip"))
	GUICtrlSetState($btnSearchMode, $GUI_DISABLE)

	; ---------------------------------------------------------------------------
	$pageAttack = GUICtrlCreateTabItem(GetLangText("pageAttack"))

	$DeadDeploySettings = GUICtrlCreateGroup(GetLangText("DeadDeploySettings"), 15, 40, 390, 123)
	Global $cmbDeadDeploy = GUICtrlCreateCombo("", 30, 55, 360, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, GetLangText("cmbDeployMethods") & GetLangText("cmbDeployCollectors"), GetLangText("cmbDeployDefault"))
	Global $cmbDeadAlgorithm = GUICtrlCreateCombo("", 30, 85, 360, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, GetLangText("cmbAlgorithms"), GetLangText("cmbAlgorithmsDefault"))
	Global $chkDeadUseKing = GUICtrlCreateCheckbox(GetLangText("chkUseKing"), 30, 115, 150, 17)
	Global $chkDeadUseQueen = GUICtrlCreateCheckbox(GetLangText("chkUseQueen"), 200, 115, 105, 17)
	Global $chkDeadUseClanCastle = GUICtrlCreateCheckbox(GetLangText("chkUseClanCastle"), 30, 135, 160, 17)
	Global $cmbDeadAttackTH = GUICtrlCreateCombo("", 200, 135, 190, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, GetLangText("cmbAttackTH"))
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$AnyDeploySettings = GUICtrlCreateGroup(GetLangText("AnyDeploySettings"), 15, 164, 390, 123)
	Global $cmbDeploy = GUICtrlCreateCombo("", 30, 182, 360, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, GetLangText("cmbDeployMethods") & GetLangText("cmbDeployCollectors"), GetLangText("cmbDeployDefault"))
	Global $cmbAlgorithm = GUICtrlCreateCombo("", 30, 212, 360, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, GetLangText("cmbAlgorithms"), GetLangText("cmbAlgorithmsDefault"))
	Global $chkUseKing = GUICtrlCreateCheckbox(GetLangText("chkUseKing"), 30, 240, 97, 17)
	Global $chkUseQueen = GUICtrlCreateCheckbox(GetLangText("chkUseQueen"), 200, 240, 105, 17)
	Global $chkUseClanCastle = GUICtrlCreateCheckbox(GetLangText("chkUseClanCastle"), 30, 260, 160, 17)
	Global $cmbAttackTH = GUICtrlCreateCombo("", 200, 260, 190, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, GetLangText("cmbAttackTH"))

	$HeroAct = GUICtrlCreateGroup(GetLangText("HeroAct"), 15, 288, 390, 73)
	$lblKingSkill = GUICtrlCreateLabel(GetLangText("lblKingSkill"), 30, 309, 110, 17)
	GUICtrlSetTip(-1, GetLangText("lblKingSkillTip"))
	Global $txtKingSkill = GUICtrlCreateInput("10", 140, 304, 31, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	$lblQueenSkill = GUICtrlCreateLabel(GetLangText("lblQueenSkill"), 30, 334, 110, 17)
	GUICtrlSetTip(-1, GetLangText("lblQueenSkillTip"))
	$lblheroSkill = GUICtrlCreateLabel(GetLangText("heroSkill"), 191, 304, 160, 20)
	$lblheroSkill2 = GUICtrlCreateLabel(GetLangText("heroSkill2"), 191, 334, 180, 20)
	Global $txtQueenSkill = GUICtrlCreateInput("10", 140, 329, 31, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlCreateGroup("", -99, -99, 1, 1)


	; ---------------------------------------------------------------------------
	$pageTroops = GUICtrlCreateTabItem(GetLangText("pageTroops"))

	$Barracks = GUICtrlCreateGroup(GetLangText("Barracks"), 20, 40, 185, 194)
	$lblBarbarians = GUICtrlCreateLabel(GetLangText("troopNamePlBarbarian") & ":", 30, 68, 60, 17)
	$lblArchers = GUICtrlCreateLabel(GetLangText("troopNamePlArcher") & ":", 30, 93, 46, 17)
	$lblGoblins = GUICtrlCreateLabel(GetLangText("troopNamePlGoblin") & ":", 30, 118, 45, 17)
	$lblRaidcap = GUICtrlCreateLabel(GetLangText("lblRaidCap"), 30, 168, 95, 17)
	Global $cmbRaidcap = GUICtrlCreateCombo("", 120, 165, 56, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "10|20|30|40|50|60|70|80|90|100", "100")
	$lblPercentCapacity = GUICtrlCreateLabel("%", 180, 168, 12, 17)
	Global $txtBarbarians = GUICtrlCreateInput("30", 120, 65, 56, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetState(-1, $GUI_DISABLE)
	Global $txtArchers = GUICtrlCreateInput("60", 120, 90, 56, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetState(-1, $GUI_DISABLE)
	Global $txtGoblins = GUICtrlCreateInput("10", 120, 115, 56, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetState(-1, $GUI_DISABLE)
	$lblPercentBarbarians = GUICtrlCreateLabel("%", 180, 68, 12, 17)
	$lblPercentArchers = GUICtrlCreateLabel("%", 180, 93, 12, 17)
	$lblPercentGoblins = GUICtrlCreateLabel("%", 180, 108, 12, 17)
	Global $cmbTroopComp = GUICtrlCreateCombo("", 40, 200, 156, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, GetLangText("cmbTroopComp"), GetLangText("cmbTroopCompDefault"))
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$OtherTroops = GUICtrlCreateGroup(GetLangText("OtherTroops"), 210, 40, 185, 70)
	$lblGiants = GUICtrlCreateLabel(GetLangText("numberOf") & " " & GetLangText("troopNamePlGiant") & ":", 215, 59, 89, 17)
	$lblWallBreakers = GUICtrlCreateLabel(GetLangText("numberOf") & " " & GetLangText("troopNamePlWallBreaker") & ":", 215, 84, 125, 17)
	Global $txtNumGiants = GUICtrlCreateInput("4", 340, 56, 46, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
	GUICtrlSetState(-1, $GUI_DISABLE)
	Global $txtNumWallbreakers = GUICtrlCreateInput("4", 340, 81, 46, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
	GUICtrlSetState(-1, $GUI_DISABLE)

	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$BarrackGroup = GUICtrlCreateGroup(GetLangText("BarrackGroup"), 210, 112, 185, 122)
	$lblBarrack1 = GUICtrlCreateLabel(GetLangText("chkBoostRax1"), 220, 137, 53, 17)
	$lblBarrack2 = GUICtrlCreateLabel(GetLangText("chkBoostRax2"), 220, 162, 53, 17)
	$lblBarrack3 = GUICtrlCreateLabel(GetLangText("chkBoostRax3"), 220, 187, 53, 17)
	$lblBarrack4 = GUICtrlCreateLabel(GetLangText("chkBoostRax4"), 220, 212, 53, 17)
	$cmbBarrackList = GetLangText("troopNamePlBarbarian") & "|" & GetLangText("troopNamePlArcher") & "|" & GetLangText("troopNamePlGiant") & "|" & GetLangText("troopNamePlGoblin") & "|" & GetLangText("troopNamePlWallBreaker") & "|" & GetLangText("troopNamePlBalloon") & GetLangText("cmbTrainingOnly") & "|" & GetLangText("troopNamePlWizard") & GetLangText("cmbTrainingOnly") & "|" & GetLangText("troopNamePlHealer") & GetLangText("cmbTrainingOnly") & "|" & GetLangText("troopNamePlDragon") & GetLangText("cmbTrainingOnly") & "|" & GetLangText("troopNamePlPEKKA") & GetLangText("cmbTrainingOnly") & "|" & GetLangText("cmbNothing")
	Global $cmbBarrack1 = GUICtrlCreateCombo("", 275, 130, 110, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, $cmbBarrackList, GetLangText("troopNamePlBarbarian"))
	Global $cmbBarrack2 = GUICtrlCreateCombo("", 275, 155, 110, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, $cmbBarrackList, GetLangText("troopNamePlBarbarian"))
	Global $cmbBarrack3 = GUICtrlCreateCombo("", 275, 180, 110, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, $cmbBarrackList, GetLangText("troopNamePlBarbarian"))
	Global $cmbBarrack4 = GUICtrlCreateCombo("", 275, 205, 110, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, $cmbBarrackList, GetLangText("troopNamePlBarbarian"))
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$BarrackCTGroup = GUICtrlCreateGroup(GetLangText("BarrackCTGroup"), 20, 234, 375, 121)
	$lblBarrackJOE1 = GUICtrlCreateLabel(GetLangText("chkBoostRax1"), 30, 253, 53, 17)
	$lblBarrackJOE2 = GUICtrlCreateLabel(GetLangText("chkBoostRax2"), 30, 278, 53, 17)
	$lblBarrackJOE3 = GUICtrlCreateLabel(GetLangText("chkBoostRax3"), 30, 303, 53, 17)
	$lblBarrackJOE4 = GUICtrlCreateLabel(GetLangText("chkBoostRax4"), 30, 328, 53, 17)
	$lblBarrackBK1 = GUICtrlCreateLabel(GetLangText("lblBarrackBK1"), 237, 253, 35, 17)
	$lblBarrackBK2 = GUICtrlCreateLabel(GetLangText("lblBarrackBK1"), 237, 278, 35, 17)
	$lblBarrackBK3 = GUICtrlCreateLabel(GetLangText("lblBarrackBK1"), 237, 303, 35, 17)
	$lblBarrackBK4 = GUICtrlCreateLabel(GetLangText("lblBarrackBK1"), 237, 328, 35, 17)

	Global $txtBarrackJOE1 = GUICtrlCreateInput("2", 90, 250, 31, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetState(-1, $GUI_DISABLE)
	Global $txtBarrackJOE2 = GUICtrlCreateInput("2", 90, 275, 31, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetState(-1, $GUI_DISABLE)
	Global $txtBarrackJOE3 = GUICtrlCreateInput("2", 90, 300, 31, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetState(-1, $GUI_DISABLE)
	Global $txtBarrackJOE4 = GUICtrlCreateInput("2", 90, 325, 31, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetState(-1, $GUI_DISABLE)

	$cmbBarrackShortList = GetLangText("troopNamePlBarbarian") & "|" & GetLangText("troopNamePlArcher") & "|" & GetLangText("troopNamePlGiant") & "|" & GetLangText("troopNamePlGoblin") & "|" & GetLangText("troopNamePlWallBreaker") & "|" & GetLangText("cmbNothing")
	Global $cmbBarrackFT1 = GUICtrlCreateCombo("", 130, 250, 95, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, $cmbBarrackShortList, GetLangText("troopNamePlBarbarian"))
	GUICtrlSetState(-1, $GUI_DISABLE)
	Global $cmbBarrackFT2 = GUICtrlCreateCombo("", 130, 275, 95, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, $cmbBarrackShortList, GetLangText("troopNamePlBarbarian"))
	GUICtrlSetState(-1, $GUI_DISABLE)
	Global $cmbBarrackFT3 = GUICtrlCreateCombo("", 130, 300, 95, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, $cmbBarrackShortList, GetLangText("troopNamePlBarbarian"))
	GUICtrlSetState(-1, $GUI_DISABLE)
	Global $cmbBarrackFT4 = GUICtrlCreateCombo("", 130, 325, 95, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, $cmbBarrackShortList, GetLangText("troopNamePlBarbarian"))
	GUICtrlSetState(-1, $GUI_DISABLE)

	Global $cmbBarrackBK1 = GUICtrlCreateCombo("", 285, 250, 95, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, $cmbBarrackShortList, GetLangText("troopNamePlBarbarian"))
	GUICtrlSetState(-1, $GUI_DISABLE)
	Global $cmbBarrackBK2 = GUICtrlCreateCombo("", 285, 275, 95, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, $cmbBarrackShortList, GetLangText("troopNamePlBarbarian"))
	GUICtrlSetState(-1, $GUI_DISABLE)
	Global $cmbBarrackBK3 = GUICtrlCreateCombo("", 285, 300, 95, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, $cmbBarrackShortList, GetLangText("troopNamePlBarbarian"))
	GUICtrlSetState(-1, $GUI_DISABLE)
	Global $cmbBarrackBK4 = GUICtrlCreateCombo("", 285, 325, 95, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, $cmbBarrackShortList, GetLangText("troopNamePlBarbarian"))
	GUICtrlSetState(-1, $GUI_DISABLE)

;~ 	$DarkBarracks = GUICtrlCreateGroup(GetLangText("DarkBarracks"), 20, 357, 375, 75)
;~ 	$lblDarkBarrack1 = GUICtrlCreateLabel(GetLangText("chkBoostRax1"), 30, 375, 53, 17)
;~ 	$lblDarkBarrack2 = GUICtrlCreateLabel(GetLangText("chkBoostRax2"), 30, 405, 53, 17)
;~ 	$cmbDarkBarrackList = GetLangText("troopDarkPlMinion") & "|" & GetLangText("troopDarkPlHog") & "|" & GetLangText("troopDarkPlValkyrie") & "|" & GetLangText("cmbNothing")
;~ 	Global $txtDarkBarrack1 = GUICtrlCreateInput("5", 90, 375, 31, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
;~ 	GUICtrlSetState(-1, $GUI_DISABLE)
;~ 	GUICtrlSetLimit(-1, 2)
;~ 	Global $txtDarkBarrack2 = GUICtrlCreateInput("5", 90, 405, 31, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
;~ 	GUICtrlSetState(-1, $GUI_DISABLE)
;~ 	GUICtrlSetLimit(-1, 2)
;~ 	Global $cmbDarkBarrack1 = GUICtrlCreateCombo("", 130, 375, 100, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
;~ 	GUICtrlSetState(-1, $GUI_DISABLE)
;~ 	GUICtrlSetData(-1, $cmbDarkBarrackList, GetLangText("troopDarkPlMinion"))
;~ 	Global $cmbDarkBarrack2 = GUICtrlCreateCombo("", 130, 405, 100, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
;~ 	GUICtrlSetState(-1, $GUI_DISABLE)
;~ 	GUICtrlSetData(-1, $cmbDarkBarrackList, GetLangText("troopDarkPlMinion"))
;~ 	Global $txtDarkBarrack1Next = GUICtrlCreateInput("5", 250, 375, 31, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
;~ 	GUICtrlSetState(-1, $GUI_DISABLE)
;~ 	GUICtrlSetLimit(-1, 2)
;~ 	Global $txtDarkBarrack2Next = GUICtrlCreateInput("5", 250, 405, 31, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
;~ 	GUICtrlSetState(-1, $GUI_DISABLE)
;~ 	GUICtrlSetLimit(-1, 2)
;~ 	Global $cmbDarkBarrack1Next = GUICtrlCreateCombo("", 290, 375, 100, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
;~ 	GUICtrlSetState(-1, $GUI_DISABLE)
;~ 	GUICtrlSetData(-1, $cmbDarkBarrackList, GetLangText("troopDarkPlMinion"))
;~ 	Global $cmbDarkBarrack2Next = GUICtrlCreateCombo("", 290, 405, 100, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
;~ 	GUICtrlSetState(-1, $GUI_DISABLE)
;~ 	GUICtrlSetData(-1, $cmbDarkBarrackList, GetLangText("troopDarkPlMinion"))

	GUICtrlCreateGroup("", -99, -99, 1, 1)

	; ---------------------------------------------------------------------------
	$pageSpells = GUICtrlCreateTabItem(GetLangText("pageSpells"))

	$cmbSpellList = GetLangText("spellNameLightning") & "|" & GetLangText("spellNameHealing") & "|" & GetLangText("spellNameRage") & "|" & GetLangText("spellNameJump") & "|" & GetLangText("spellNameFreeze")
	$lblFactory = GUICtrlCreateGroup(GetLangText("lblfactory"), 20, 40, 375, 74)
	Global $chkMakeSpells = GUICtrlCreateCheckbox(GetLangText("chkMakeSpells"), 30, 60, 97, 17)
	GUICtrlSetOnEvent($chkMakeSpells, "Standard_chkMakeSpells")
	GUICtrlSetState(-1, $GUI_UNCHECKED)
	$lblSpellCreate = GUICtrlCreateLabel(GetLangText("lblSpellCreate"), 30, 87, 90, 17)
	GUICtrlSetTip(-1, GetLangText("cmbSpellCreateTip"))
	Global $cmbSpellCreate = GUICtrlCreateCombo("", 125, 83, 85, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, $cmbSpellList, GetLangText("spellNameLightning"))

	$lblDEZap = GUICtrlCreateGroup(GetLangText("lblDEZap"), 20, 124, 375, 154)
	$lblDENukeLimit = GUICtrlCreateLabel(GetLangText("lblDENukeLimit"), 30, 144, 170, 17)
	Global $txtDENukeLimit = GUICtrlCreateInput("2000", 197, 144, 51, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	Global $chkNukeOnly = GUICtrlCreateCheckbox(GetLangText("chkNukeOnly"), 30, 184, 180, 17)
	GUICtrlSetTip(-1, GetLangText("chkNukeOnlyTip"))
	Global $chkNukeOnlyWithFullArmy = GUICtrlCreateCheckbox(GetLangText("chkNukeOnlyWithFullArmy"), 30, 204, 250, 17)
	GUICtrlSetState(-1, $GUI_UNCHECKED)
	Global $chkNukeAttacking = GUICtrlCreateCheckbox(GetLangText("chkNukeAttacking"), 30, 231, 180, 17)
	GUICtrlSetOnEvent($chkNukeAttacking, "Standard_chkNukeAttacking")
	GUICtrlSetState(-1, $GUI_UNCHECKED)
	GUICtrlSetTip(-1, GetLangText("chkNukeAttackingTip"))
	$lblSpellNumber = GUICtrlCreateLabel(GetLangText("lblSpellNumber"), 30, 254, 170, 17)
	Global $txtSpellNumber = GUICtrlCreateInput("3", 200, 250, 51, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))

	GUICtrlCreateGroup("", -99, -99, 1, 1)
	GUICtrlCreateTabItem("")
	Standard_LoadConfig()

	Global $PluginEvents[3][3]
	$PluginEvents[0][0] = 2
	$PluginEvents[1][0] = $cmbTroopComp
	$PluginEvents[1][1] = 1
	$PluginEvents[1][2] = "_cmbTroopComp"
	$PluginEvents[2][0] = $cmbSpellCreate
	$PluginEvents[2][1] = 1
	$PluginEvents[2][2] = "_cmbSpellCreate"

	Return $pageSearch
EndFunc   ;==>Standard_LoadGUI
