#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <FileConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <GUIEdit.au3>
#include <GUIComboBox.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
#include <WinAPIProc.au3>
#include <ScreenCapture.au3>
#include <Date.au3>
#include <Misc.au3>
#include <File.au3>
#include <TrayConstants.au3>
#include <GUIMenu.au3>
#include <ColorConstants.au3>
#include <GDIPlus.au3>
#include <GuiRichEdit.au3>
#include <GuiTab.au3>
#include <GuiListBox.au3>

Global Const $COLOR_ORANGE = 0xFFA500

Global $Compiled
If @Compiled Then
	$Compiled = "Executable"
Else
	$Compiled = "Au3 Script"
EndIf

Global $hBitmap; Image for pixel functions
Global $hHBitmap; Handle Image for pixel functions
Global $hAttackBitmap
Global $Pen

Global $Title = "BlueStacks App Player" ; Name of the Window
Global $HWnD = WinGetHandle($Title) ;Handle for Bluestacks window

Global $config = @ScriptDir & "\config\default.ini"
Global $dirLogs = @ScriptDir & "\logs\"
Global $dirLoots = @ScriptDir & "\Loots\"
Global $dirAttack = @ScriptDir & "\Attacks\"
Global $dirDebug = @ScriptDir & "\Debug\"
Global $dirAllTowns = @ScriptDir & "\AllTowns\"
Global $dirConfigs = @ScriptDir & "\config\"
Global $dirStrat = @ScriptDir & "\strategies\"

Global $sLogPath ; `Will create a new log file every time the start button is pressed
Global $hLogFileHandle
Global $Restart = False
Global $Running = False
Global $AttackNow = False
Global $AlertBaseFound = False
Global $TakeLootSnapShot = True
Global $TakeAllTownSnapShot = False

Global $TakeAttackSnapShot = 0
Global $DebugMode = 0
Global $shift
Global $ReqText
Global $brerror[4]
$brerror[0] = False
$brerror[1] = False
$brerror[2] = False
$brerror[3] = False
$needzoomout = False

Global $iCollectCounter = 0 ; Collect counter, when reaches $COLLECTATCOUNT, it will collect
Global $COLLECTATCOUNT = 8 ; Run Collect() after this amount of times before actually collect
;---------------------------------------------------------------------------------------------------
Global $BSpos[2] ; Inside BlueStacks positions relative to the screen
;---------------------------------------------------------------------------------------------------
;Search Settings
Global $FixTrain = False
Global $Tolerance1 = 80
Global $THx = 0, $THy = 0
Global $DEx = 0, $DEy = 0
Global $THText[5] ; Text of each Townhall level
$THText[0] = "4-6"
$THText[1] = "7"
$THText[2] = "8"
$THText[3] = "9"
$THText[4] = "10"
Global $SearchCount = 0 ;Number of searches
Global $THaddtiles, $THside, $THi
Global $StratNames = ""
Global $prevSelection = ""
Global $DefaultTab = 0

Global $speedBump = 0
Global $prevTab = 0
Global $slideOut = 0
Global $slideIn = 0

;Troop types
Global Enum $eBarbarian, $eArcher, $eGiant, $eGoblin, $eWallbreaker, $eMinion, $eHog, $eValkyrie, $eKing, $eQueen, $eCastle, $eLSpell

;Attack Settings
; Shift outer corners 1 pixel for more random drop space
Global $TopLeft[5][2] = [[78, 280], [169, 204], [233, 161], [295, 114], [367, 65]]
Global $TopRight[5][2] = [[481, 62], [541, 103], [590, 145], [656, 189], [780, 277]]
Global $BottomLeft[5][2] = [[78, 343], [141, 390], [209, 447], [275, 493], [338, 540]]
Global $BottomRight[5][2] = [[524, 538], [596, 485], [655, 441], [716, 394], [780, 345]]
Global $FurthestTopLeft[5][2] = [[28, 314], [0, 0], [0, 0], [0, 0], [430, 9]]
Global $FurthestTopRight[5][2] = [[430, 9], [0, 0], [0, 0], [0, 0], [820, 313]]
Global $FurthestBottomLeft[5][2] = [[28, 314], [0, 0], [0, 0], [0, 0], [440, 612]]
Global $FurthestBottomRight[5][2] = [[440, 612], [0, 0], [0, 0], [0, 0], [820, 313]]
Global $Edges[4] = [$BottomRight, $TopLeft, $BottomLeft, $TopRight]

Global $atkTroops[9][2] ;9 Slots of troops -  Name, Amount
Global $THLoc
Global $THquadrant

Global $Buffer
Global $pBarbarian, $pArcher, $pGoblin, $pGiant, $pWallB, $pLightning, $pKing, $pQueen, $pCC

Global $King, $Queen, $CC, $Barb, $Arch, $Minion, $Hog, $Valkyrie
Global $LeftTHx, $RightTHx, $BottomTHy, $TopTHy
Global $AtkTroopTH
Global $GetTHLoc


Global $PluginEvents

;Misc Settings
Global $itxtReconnect
Global $itxtReturnh
Global $icmbSearchsp
Global $ichkTrap
Global $itxtKingSkill ;Delay before activating King Skill
Global $itxtQueenSkill ;Delay before activating Queen Skill
Global $WideEdge, $chkWideEdge
Global $ichkAvoidEdge, $chkAvoidEdge
Global $chkCollect, $ichkCollect
Global $icmbUnitDelay
Global $icmbWaveDelay
Global $iRandomspeedatk

;Boosts Settings
Global $BoostAll
Global $remainingBoosts = 0 ;  remaining boost to active during session
Global $boostsEnabled = 1 ; is this function enabled
Global $chkBoostKing
Global $chkBoostQueen
Global $chkBoostRax1
Global $chkBoostRax2
Global $chkBoostRax3
Global $chkBoostRax4
Global $chkBoostSpell
Global $chkBoostDB1
Global $chkBoostDB2

;Donate Settings
Global $CCPos[2] = [-1, -1] ;Position of clan castle

Global $ichkRequest = 0 ;Checkbox for Request box
Global $itxtRequest = "" ;Request textbox

Global $ichkDonateAllBarbarians = 0
Global $ichkDonateBarbarians = 0
Global $itxtDonateBarbarians = ""

Global $ichkDonateAllArchers = 0
Global $ichkDonateArchers = 0
Global $itxtDonateArchers = ""

Global $ichkDonateAllGiants = 0
Global $ichkDonateGiants = 0
Global $itxtDonateGiants = ""

Global $itxtcampCap
Global $itxtspellCap
Global $CurBarb
Global $CurArch
Global $CurGiant
Global $CurGoblin
Global $CurWB
Global $ArmyComp
Global $TownHallPos[2] = [-1, -1] ;Position of TownHall
Global $barrackPos[4][2] ;Positions of each barracks
Global $barrackTroop[10] ;Barrack troop set
Global $ArmyPos[2]
Global $SpellPos[2]
Global $KingPos[2]
Global $QueenPos[2]
Global $BuildPos1[2]
Global $BuildPos2[2]
Global $BuildPos3[2]

;Other Settings
Global $CurMinion, $CurHog, $CurValkyrie
Global $ichkWalls
Global $icmbWalls
Global $iUseStorage
Global $itxtWallMinGold
Global $itxtWallMinElixir
Global $icmbTolerance
Global $itxtReconnect
Global $DarkBarrackPos[2][2]
Global $DarkBarrackTroop[2]
Global $iTimeTroops = 0
Global $iTimeGiant = 120
Global $iTimeWall = 120
Global $iTimeArch = 25
Global $iTimeGoblin = 35
Global $iTimeBarba = 20

;upgrade Settings
Global $ichkUpgrade1
Global $ichkUpgrade2
Global $ichkUpgrade3
Global $ichkUpgrade4
Global $ichkUpgrade5
Global $ichkUpgrade6
Global $itxtUpgradeX1
Global $itxtUpgradeY1
Global $itxtUpgradeX2
Global $itxtUpgradeY2
Global $itxtUpgradeX3
Global $itxtUpgradeY3
Global $itxtUpgradeX4
Global $itxtUpgradeY4
Global $itxtUpgradeX5
Global $itxtUpgradeY5
Global $itxtUpgradeX6
Global $itxtUpgradeY6

Global $txtSpellCap

;General Settings
Global $botPos[2] ; Position of bot used for Hide function
Global $frmBotPosX ; Position X of the GUI
Global $frmBotPosY ; Position Y of the GUI
Global $Hide = False ; If hidden or not

Global $firstrun = True
Global $btnBugRep

Global Enum $modeDonateTrain, $modeDonate, $modeExperience, $modeNormal = 9
Global $CurrentMode = $modeNormal
Global $ichkBotStop, $icmbBotCommand, $icmbBotCond, $icmbHoursStop
Global $MeetCondStop = False
Global $UseTimeStop = -1
Global $TimeToStop = -1

Global $itxtMinTrophy ; Trophy after drop
Global $itxtMaxTrophy ; Max trophy before drop trophy
Global $ichkForceBS = 0
Global $ichkNoAttack = 0, $ichkDonateOnly = 0
Global $collectorPos[17][2] ;Positions of each collectors

Global $break = @ScriptDir & "\images\break.bmp"
Global $device = @ScriptDir & "\images\device.bmp"

Global $GoldCount = 0, $ElixirCount = 0, $DarkCount = 0, $GemCount = 0, $FreeBuilder = 0
Global $GoldGained = 0, $ElixirGained = 0, $DarkGained = 0, $TrophyGained = 0
;Global $GoldGainedOld = 0, $ElixirGainedOld = 0, $DarkGainedOld = 0, $TrophyGainedOld = 0
Global $GoldCountOld = 0, $ElixirCountOld = 0, $DarkCountOld = 0, $TrophyOld = 0
Global $WallUpgrade = 0
Global $resArmy = 0
Global $FirstAttack = True
Global $CurTrophy = 0
Global $sTimer, $hour, $min, $sec
Global $CurCamp, $TotalCamp = 0
Global $NoLeague
Global $FirstStart = True
Global $MidAttack = False
Global $Checkrearm = True
Global $FirstDarkTrain = True

;PushBullet
Global $PushBulletEnabled = 0
Global $PushBullettoken = ""
Global $PushBullettype = 0
Global $PushBulletattacktype = 0
Global $FileName = ""
Global $PushBulletvillagereport = 0
Global $PushBulletmatchfound = 0
Global $PushBulletlastraid = 0
Global $PushBullettotalgain = 0
Global $PushBulletdebug = 0
Global $PushBulletremote = 0
Global $PushBulletdelete = 0
Global $PushBulletfreebuilder = 0
Global $sLogFileName
Global $Raid = 0
Global $buildernotified = False

;GoldCostPerSearch
Global $SearchCost = 0

;Remote Control
Global $sTimerRC
Global $PauseBot = False

;Last Raid
Global $LastRaidGold = 0
Global $LastRaidElixir = 0
Global $LastRaidDarkElixir = 0
Global $LastRaidTrophy = 0

;UpTroops
Global $ichkLab
Global $icmbLaboratory
Global $itxtLabX = -1
Global $itxtLabY = -1
Global $UpBar2X = 175
Global $UpBar2Y = 379
Global $UpArchX = 180
Global $UpArchY = 468
Global $GiantsX = 307
Global $GiantsY = 361
Global $WBreakerX = 373
Global $WBreakerY = 373
Global $WizardX = 489
Global $WizardY = 323
Global $UpHealX = 515
Global $UpHealY = 431
Global $UpDragonX = 591
Global $UpDragonY = 388
Global $UpPekkaX = 612
Global $UpPekkaY = 479
Global $SpellHealX = 527
Global $SpellHealY = 381
Global $SpellLightningX = 549
Global $SpellLightningY = 461
Global $SpellRageX = 650
Global $SpellRageY = 372