Func Standard_LoadGUI()
	; Required prior to making new tabs
	$frmAttackConfig = GUICreate("Attack config panel", 410, 410, -1, -1, $WS_BORDER + $WS_POPUP, $WS_EX_MDICHILD, $frmBot)
	Opt('GUIResizeMode', 802)
	GUISetState(@SW_HIDE, $frmAttackConfig)
	_WinMoved(0, 0, 0, 0)
	GUISwitch($frmAttackConfig)

	$tabStrat = GUICtrlCreateTab(10, 10, 415, 550)
	; ---------------------------------------------------------------------------
	$pageSearch = GUICtrlCreateTabItem("Search Settings")
	$DeadConditions = GUICtrlCreateGroup("Dead Base Conditions", 18, 40, 397, 135)
	Global $chkDeadActivate = GUICtrlCreateCheckbox("Activate", 30, 60, 90, 17)
	GUICtrlSetOnEvent($chkDeadActivate, "Standard_chkDeadActivate")
	$lblDeadConditions = GUICtrlCreateLabel("Search for full collectors bases and ALL selected conditions", 120, 60, 380, 20)
	Global $chkDeadGE = GUICtrlCreateCheckbox("Min Resources:", 30, 83, 100, 17)
	$lblDeadMinGold = GUICtrlCreateLabel("Gold: ", 140, 85, 28, 17)
	Global $txtDeadMinGold = GUICtrlCreateInput("50000", 170, 80, 50, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 6)
	Global $cmbDead = GUICtrlCreateCombo("", 240, 80, 45, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "And|Or", "And")
	$lblDeadMinElixir = GUICtrlCreateLabel("Elixir: ", 300, 85, 28, 17)
	Global $txtDeadMinElixir = GUICtrlCreateInput("50000", 330, 80, 50, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 6)
	Global $chkDeadMeetDE = GUICtrlCreateCheckbox("Min Dark Elixir:", 30, 113, 95, 17)
	Global $txtDeadMinDarkElixir = GUICtrlCreateInput("0", 130, 110, 60, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 6)
	Global $chkDeadMeetTrophy = GUICtrlCreateCheckbox("Min Trophies:", 225, 113, 95, 17)
	Global $txtDeadMinTrophy = GUICtrlCreateInput("0", 325, 110, 60, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	Global $chkDeadMeetTH = GUICtrlCreateCheckbox("Max TH Level:", 30, 143, 95, 17)
	Global $cmbDeadTH = GUICtrlCreateCombo("", 130, 140, 60, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "4-6|7|8|9|10", "4-6")
	Global $chkDeadMeetTHO = GUICtrlCreateCheckbox("TH Outside", 225, 143, 70, 17)
	GUICtrlSetTip(-1, "Townhall must be on outer edges of base")
	Global $chkDeadSnipe = GUICtrlCreateCheckbox("Snipe", 315, 143, 50, 17)
	GUICtrlSetTip(-1, "If checked, will attack exterior townhall of dead base regardless of other settings")
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
	$AnyConditions = GUICtrlCreateGroup("Live Base Conditions", 18, 180, 397, 130)
	Global $chkAnyActivate = GUICtrlCreateCheckbox("Activate", 30, 200, 90, 17)
	GUICtrlSetOnEvent($chkAnyActivate, "Standard_chkAnyActivate")
	$lblAnyConditions = GUICtrlCreateLabel("Search for any bases and ALL selected conditions", 120, 200, 380, 20)
	Global $chkMeetGE = GUICtrlCreateCheckbox("Min Resources: ", 30, 223, 100, 17)
	GUICtrlSetState(-1, $GUI_CHECKED)
	$lblMinGold = GUICtrlCreateLabel("Gold:", 140, 225, 28, 17)
	Global $txtMinGold = GUICtrlCreateInput("80000", 170, 220, 50, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 6)
	Global $cmbAny = GUICtrlCreateCombo("", 240, 220, 45, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "And|Or", "And")
	$lblMinElixir = GUICtrlCreateLabel("Elixir:", 300, 225, 28, 17)
	Global $txtMinElixir = GUICtrlCreateInput("80000", 330, 220, 50, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 6)
	Global $chkMeetDE = GUICtrlCreateCheckbox("Min Dark Elixir:", 30, 253, 95, 17)
	Global $txtMinDarkElixir = GUICtrlCreateInput("0", 130, 250, 60, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 6)
	Global $chkMeetTrophy = GUICtrlCreateCheckbox("Min Trophies:", 225, 253, 95, 17)
	Global $txtMinTrophy = GUICtrlCreateInput("0", 325, 250, 60, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	Global $chkMeetTH = GUICtrlCreateCheckbox("Max TH Level:", 30, 283, 95, 17)
	Global $cmbTH = GUICtrlCreateCombo("", 130, 280, 60, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "4-6|7|8|9|10", "4-6")
	Global $chkMeetTHO = GUICtrlCreateCheckbox("TH Outside", 225, 283, 70, 17)
	GUICtrlSetTip(-1, "Townhall must be on outer edges of base")
	Global $chkSnipe = GUICtrlCreateCheckbox("Snipe", 315, 283, 50, 17)
	GUICtrlSetTip(-1, "If checked, will attack exterior townhall of live base regardless of other settings")
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
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	Global $btnSearchMode = GUICtrlCreateButton("Search Mode", 20, 527, 393, 25)
	GUICtrlSetOnEvent(-1, "Standard_btnSearchMode")
	GUICtrlSetTip(-1, "Does not attack. Searches for base that meets conditions.")
	GUICtrlSetState($btnSearchMode, $GUI_DISABLE)

	; ---------------------------------------------------------------------------
	$pageAttack = GUICtrlCreateTabItem("Attack Method")

	$DeadDeploySettings = GUICtrlCreateGroup("Dead Base Deploy Settings", 15, 40, 390, 123)
	Global $cmbDeadDeploy = GUICtrlCreateCombo("", 30, 55, 360, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Attack on a single side, penetrates through base|Attack on two sides, penetrates through base|Attack on three sides, gets outer and some inside of base|Attack on all sides equally, gets most of outer base|Mixed mode: limited on 4 sides then focus on 1 side", "Attack on all sides equally, gets most of outer base")
	Global $cmbDeadAlgorithm = GUICtrlCreateCombo("", 30, 85, 360, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Archers|Barbarians|Goblins|Barbarians + Archers|Barb + Arch + Goblin + Giant|Barb + Arch + Giant|Barb + Arch + Goblin|Barb + Arch + Goblin + Giant + Wallbreakers|Use Barracks|Use All Troops", "Use All Troops") ;"Archers|Barbarians|Goblins|Barbarians + Archers|Barb + Arch + Goblin + Giant|Barb + Arch + Giant|Barb + Arch + Goblin|Barb + Arch + Goblin + Giant + Wallbreakers|Use Barracks"
	Global $chkDeadUseKing = GUICtrlCreateCheckbox("Attack with King", 30, 115, 150, 17)
	Global $chkDeadUseQueen = GUICtrlCreateCheckbox("Attack with Queen", 200, 115, 105, 17)
	Global $chkDeadUseClanCastle = GUICtrlCreateCheckbox("Attack with Clan Castle troops", 30, 135, 160, 17)
	Global $cmbDeadAttackTH = GUICtrlCreateCombo("", 200, 135, 190, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Don't attack TH|Limited TH attack|Full TH attack")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$AnyDeploySettings = GUICtrlCreateGroup("Other Base Deploy Settings", 15, 164, 390, 123)
	Global $cmbDeploy = GUICtrlCreateCombo("", 30, 182, 360, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Attack on a single side, penetrates through base|Attack on two sides, penetrates through base|Attack on three sides, gets outer and some inside of base|Attack on all sides equally, gets most of outer base|Mixed mode: limited on 4 sides then focus on 1 side", "Attack on all sides equally, gets most of outer base")
	Global $cmbAlgorithm = GUICtrlCreateCombo("", 30, 212, 360, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Archers|Barbarians|Goblins|Barbarians + Archers|Barb + Arch + Goblin + Giant|Barb + Arch + Giant|Barb + Arch + Goblin|Barb + Arch + Goblin + Giant + Wallbreakers|Use Barracks|Use All Troops", "Use All Troops") ;"Archers|Barbarians|Goblins|Barbarians + Archers|Barb + Arch + Goblin + Giant|Barb + Arch + Giant|Barb + Arch + Goblin|Barb + Arch + Goblin + Giant + Wallbreakers|Use Barracks"
	Global $chkUseKing = GUICtrlCreateCheckbox("Attack with King", 30, 240, 97, 17)
	Global $chkUseQueen = GUICtrlCreateCheckbox("Attack with Queen", 200, 240, 105, 17)
	Global $chkUseClanCastle = GUICtrlCreateCheckbox("Attack with Clan Castle troops", 30, 260, 160, 17)
	Global $cmbAttackTH = GUICtrlCreateCombo("", 200, 260, 190, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Don't attack TH|Limited TH attack|Full TH attack")

	$AnyDeploySettings = GUICtrlCreateGroup("Hero Activation", 15, 288, 390, 73)
	$lblKingSkill = GUICtrlCreateLabel("King Skill Activation:", 30, 309, 110, 17)
	GUICtrlSetTip(-1, "Set delay timing for King skill")
	Global $txtKingSkill = GUICtrlCreateInput("10", 140, 304, 31, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	$lblQueenSkill = GUICtrlCreateLabel("Queen Skill Activation:", 30, 334, 110, 17)
	GUICtrlSetTip(-1, "Set delay timing for Queen skill")
	Global $txtQueenSkill = GUICtrlCreateInput("10", 140, 329, 31, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlCreateGroup("", -99, -99, 1, 1)


	; ---------------------------------------------------------------------------
	$pageTroops = GUICtrlCreateTabItem("Troop Training")

	$Barracks = GUICtrlCreateGroup("Troops", 20, 40, 185, 194)
	$lblBarbarians = GUICtrlCreateLabel("Barbarians :", 30, 68, 60, 17)
	$lblArchers = GUICtrlCreateLabel("Archers :", 30, 93, 46, 17)
	$lblGoblins = GUICtrlCreateLabel("Goblins :", 30, 118, 45, 17)
	$lblRaidcap = GUICtrlCreateLabel("Raid Capacity :", 30, 168, 95, 17)
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
	GUICtrlSetData(-1, "Archers|Barbarians|Goblins|B.Arch|B.A.G.G.|B.A.Giant|B.A.Goblin|B.A.G.G.Wall|Use Barracks|Custom Troops", "Use Barracks") ;"Archers|Barbarians|Goblins|B.Arch|B.A.G.G.|B.A.Giant|B.A.Goblin|B.A.G.G.Wall|Use Barracks|Custom Troops"
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$OtherTroops = GUICtrlCreateGroup("Other Troops", 210, 40, 185, 70)
	$lblGiants = GUICtrlCreateLabel("Number of Giants:", 215, 59, 89, 17)
	$lblWallBreakers = GUICtrlCreateLabel("Number of Wall Breakers:", 215, 84, 125, 17)
	Global $txtNumGiants = GUICtrlCreateInput("4", 340, 56, 46, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
	GUICtrlSetState(-1, $GUI_DISABLE)
	Global $txtNumWallbreakers = GUICtrlCreateInput("4", 340, 81, 46, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
	GUICtrlSetState(-1, $GUI_DISABLE)

	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$BarrackGroup = GUICtrlCreateGroup("Barracks", 210, 112, 185, 122)
	$lblBarrack1 = GUICtrlCreateLabel("Barrack 1:", 220, 137, 53, 17)
	$lblBarrack2 = GUICtrlCreateLabel("Barrack 2:", 220, 162, 53, 17)
	$lblBarrack3 = GUICtrlCreateLabel("Barrack 3:", 220, 187, 53, 17)
	$lblBarrack4 = GUICtrlCreateLabel("Barrack 4:", 220, 212, 53, 17)
	Global $cmbBarrack1 = GUICtrlCreateCombo("", 275, 130, 110, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Barbarians|Archers|Giants|Goblins|W.Breaker|Balloon(Training Only)|Wizard(Training Only)|Healer(Training Only)|Dragon(Training Only)|Pekka(Training Only)|Nothing", "Barbarians")
	Global $cmbBarrack2 = GUICtrlCreateCombo("", 275, 155, 110, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Barbarians|Archers|Giants|Goblins|W.Breaker|Balloon(Training Only)|Wizard(Training Only)|Healer(Training Only)|Dragon(Training Only)|Pekka(Training Only)|Nothing", "Archers")
	Global $cmbBarrack3 = GUICtrlCreateCombo("", 275, 180, 110, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Barbarians|Archers|Giants|Goblins|W.Breaker|Balloon(Training Only)|Wizard(Training Only)|Healer(Training Only)|Dragon(Training Only)|Pekka(Training Only)|Nothing", "Archers")
	Global $cmbBarrack4 = GUICtrlCreateCombo("", 275, 205, 110, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Barbarians|Archers|Giants|Goblins|W.Breaker|Balloon(Training Only)|Wizard(Training Only)|Healer(Training Only)|Dragon(Training Only)|Pekka(Training Only)|Nothing", "Goblins")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$BarrackCTGroup = GUICtrlCreateGroup("Custom Troop 2 / Not Available", 20, 234, 375, 121)
	$lblBarrackJOE1 = GUICtrlCreateLabel("Barrack 1 :", 30, 253, 53, 17)
	$lblBarrackJOE2 = GUICtrlCreateLabel("Barrack 2 :", 30, 278, 53, 17)
	$lblBarrackJOE3 = GUICtrlCreateLabel("Barrack 3 :", 30, 303, 53, 17)
	$lblBarrackJOE4 = GUICtrlCreateLabel("Barrack 4 :", 30, 328, 53, 17)
	$lblBarrackBK1 = GUICtrlCreateLabel("the rest", 237, 253, 35, 17)
	$lblBarrackBK2 = GUICtrlCreateLabel("the rest", 237, 278, 35, 17)
	$lblBarrackBK3 = GUICtrlCreateLabel("the rest", 237, 303, 35, 17)
	$lblBarrackBK4 = GUICtrlCreateLabel("the rest", 237, 328, 35, 17)

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

	Global $cmbBarrackFT1 = GUICtrlCreateCombo("", 130, 250, 95, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Barbarians|Archers|Giants|Goblins|W.Breaker|Nothing", "Giants")
	GUICtrlSetState(-1, $GUI_DISABLE)
	Global $cmbBarrackFT2 = GUICtrlCreateCombo("", 130, 275, 95, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Barbarians|Archers|Giants|Goblins|W.Breaker|Nothing", "W.Breaker")
	GUICtrlSetState(-1, $GUI_DISABLE)
	Global $cmbBarrackFT3 = GUICtrlCreateCombo("", 130, 300, 95, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Barbarians|Archers|Giants|Goblins|W.Breaker|Nothing", "Giants")
	GUICtrlSetState(-1, $GUI_DISABLE)
	Global $cmbBarrackFT4 = GUICtrlCreateCombo("", 130, 325, 95, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Barbarians|Archers|Giants|Goblins|W.Breaker|Nothing", "W.Breaker")
	GUICtrlSetState(-1, $GUI_DISABLE)

	Global $cmbBarrackBK1 = GUICtrlCreateCombo("", 285, 250, 95, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Barbarians|Archers|Giants|Goblins|W.Breaker|Nothing", "Barbarians")
	GUICtrlSetState(-1, $GUI_DISABLE)
	Global $cmbBarrackBK2 = GUICtrlCreateCombo("", 285, 275, 95, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Barbarians|Archers|Giants|Goblins|W.Breaker|Nothing", "Archers")
	GUICtrlSetState(-1, $GUI_DISABLE)
	Global $cmbBarrackBK3 = GUICtrlCreateCombo("", 285, 300, 95, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Barbarians|Archers|Giants|Goblins|W.Breaker|Nothing", "Barbarians")
	GUICtrlSetState(-1, $GUI_DISABLE)
	Global $cmbBarrackBK4 = GUICtrlCreateCombo("", 285, 325, 95, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Barbarians|Archers|Giants|Goblins|W.Breaker|Nothing", "Archers")
	GUICtrlSetState(-1, $GUI_DISABLE)

	$DarkBarracks = GUICtrlCreateGroup("Dark Barracks", 20, 357, 375, 75)
	$lblDarkBarrack1 = GUICtrlCreateLabel("Barrack 1:", 30, 375, 53, 17)
	$lblDarkBarrack2 = GUICtrlCreateLabel("Barrack 2:", 30, 405, 53, 17)
	Global $txtDarkBarrack1 = GUICtrlCreateInput("5", 90, 375, 31, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetLimit(-1, 2)
	Global $txtDarkBarrack2 = GUICtrlCreateInput("5", 90, 405, 31, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetLimit(-1, 2)
	Global $cmbDarkBarrack1 = GUICtrlCreateCombo("", 130, 375, 100, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetData(-1, "Minions|Hogs|Valkyries|Nothing", "Minions")
	Global $cmbDarkBarrack2 = GUICtrlCreateCombo("", 130, 405, 100, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetData(-1, "Minions|Hogs|Valkyries|Nothing", "Minions")
	Global $txtDarkBarrack1Next = GUICtrlCreateInput("5", 250, 375, 31, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetLimit(-1, 2)
	Global $txtDarkBarrack2Next = GUICtrlCreateInput("5", 250, 405, 31, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetLimit(-1, 2)
	Global $cmbDarkBarrack1Next = GUICtrlCreateCombo("", 290, 375, 100, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetData(-1, "Minions|Hogs|Valkyries|Nothing", "Minions")
	Global $cmbDarkBarrack2Next = GUICtrlCreateCombo("", 290, 405, 100, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetData(-1, "Minions|Hogs|Valkyries|Nothing", "Minions")

	GUICtrlCreateGroup("", -99, -99, 1, 1)

	; ---------------------------------------------------------------------------
	$pageSpells = GUICtrlCreateTabItem("Spells")

	$lblDEAccuracy = GUICtrlCreateGroup("Spell Factory", 20, 40, 375, 74)
	Global $chkMakeSpells = GUICtrlCreateCheckbox("Make spells", 30, 60, 97, 17)
	GUICtrlSetOnEvent($chkMakeSpells, "Standard_chkMakeSpells")
	GUICtrlSetState(-1, $GUI_UNCHECKED)
	$lblSpellCreate = GUICtrlCreateLabel("Spell to keep full:", 30, 87, 90, 17)
	GUICtrlSetTip(-1, "Set to the spell you want made")
	Global $cmbSpellCreate = GUICtrlCreateCombo("", 125, 83, 85, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Lightning|Healing|Rage|Jump|Freeze", "Lightning")

	$lblDEZap = GUICtrlCreateGroup("DE zapping", 20, 124, 375, 154)
	$lblDENukeLimit = GUICtrlCreateLabel("Zap with spell if DE greater than:", 30, 144, 170, 17)
	Global $txtDENukeLimit = GUICtrlCreateInput("2000", 197, 144, 51, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	Global $chkNukeOnly = GUICtrlCreateCheckbox("Allow zap only behavior", 30, 184, 180, 17)
	Global $chkNukeOnlyWithFullArmy = GUICtrlCreateCheckbox("Only search base for zapping with full army", 30, 204, 250, 17)
	GUICtrlSetState(-1, $GUI_UNCHECKED)
	GUICtrlSetTip(-1, "If spell factory is full, will search for a camp to hit and run the DE storage")
	Global $chkNukeAttacking = GUICtrlCreateCheckbox("Zap DE if already attacking", 30, 231, 180, 17)
	GUICtrlSetOnEvent($chkNukeAttacking, "Standard_chkNukeAttacking")
	GUICtrlSetState(-1, $GUI_UNCHECKED)
	GUICtrlSetTip(-1, "Will zap DE storage during attack if you have more than number of spells below")
	$lblSpellNumber = GUICtrlCreateLabel("Number of spells needed:", 30, 254, 170, 17)
	Global $txtSpellNumber = GUICtrlCreateInput("3", 200, 250, 51, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))

	$lblDEAccuracy = GUICtrlCreateGroup("DE Storage Accuracy", 20, 288, 375, 67)
	Global $rdoMaybeSkip = GUICtrlCreateRadio("Possible skips", 30, 308, 120, 17)
	GUICtrlSetTip(-1, "Less reliable search, but won't misidentify something else as DE storage")
	GUICtrlSetState(-1, $GUI_CHECKED)
	Global $rdoFalsePositive = GUICtrlCreateRadio("Possibly mislocated", 30, 328, 120, 17)
	GUICtrlSetTip(-1, "It's going to find a damn DE storage, even if it means nuking something else on accident")
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	GUICtrlCreateTabItem("")

	Standard_LoadConfig()

	Global $PluginEvents[3][3]
	$PluginEvents[0][0]=2
	$PluginEvents[1][0]=$cmbTroopComp
	$PluginEvents[1][1]=1
	$PluginEvents[1][2]="_cmbTroopComp"
	$PluginEvents[2][0]=$cmbSpellCreate
	$PluginEvents[2][1]=1
	$PluginEvents[2][2]="_cmbSpellCreate"

	Return $pageSearch
EndFunc
