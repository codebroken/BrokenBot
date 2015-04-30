;Reads config file and sets variables

Func readConfig() ;Reads config and sets it to the variables
	;---------------------------------------------------------------------------------------
	; Main settings ------------------------------------------------------------------------
	;---------------------------------------------------------------------------------------
	$itxtMinTrophy = IniRead($config, "general", "MinTrophy", "0")
	$itxtMaxTrophy = IniRead($config, "general", "MaxTrophy", "3000")
	$ichkBotStop = IniRead($config, "general", "BotStop", "0")
	$icmbBotCommand = IniRead($config, "general", "Command", "0")
	$icmbBotCond = IniRead($config, "general", "Cond", "0")
	$ichkNoAttack = IniRead($config, "general", "NoAttack", "0")
	$ichkDonateOnly = IniRead($config, "general", "DonateOnly", "0")

	;---------------------------------------------------------------------------------------
	; Attack settings ----------------------------------------------------------------------
	;---------------------------------------------------------------------------------------
	$icmbUnitDelay = IniRead($config, "attack", "UnitD", "0")
	$icmbWaveDelay = IniRead($config, "attack", "WaveD", "0")
	$iRandomspeedatk = IniRead($config, "attack", "randomatk", "0")

	;---------------------------------------------------------------------------------------
	; Donate settings ----------------------------------------------------------------------
	;---------------------------------------------------------------------------------------
	$ichkRequest = IniRead($config, "donate", "chkRequest", "0")
	$itxtRequest = IniRead($config, "donate", "txtRequest", "")
	$ichkDonateBarbarians = IniRead($config, "donate", "chkDonateBarbarians", "0")
	$ichkDonateAllBarbarians = IniRead($config, "donate", "chkDonateAllBarbarians", "0")
	$itxtDonateBarbarians = StringReplace(IniRead($config, "donate", "txtDonateBarbarians", "barbarians|barb|any"), "|", @CRLF)
	$ichkDonateArchers = IniRead($config, "donate", "chkDonateArchers", "0")
	$ichkDonateAllArchers = IniRead($config, "donate", "chkDonateAllArchers", "0")
	$itxtDonateArchers = StringReplace(IniRead($config, "donate", "txtDonateArchers", "archers|arch|any"), "|", @CRLF)
	$ichkDonateGiants = IniRead($config, "donate", "chkDonateGiants", "0")
	$ichkDonateAllGiants = IniRead($config, "donate", "chkDonateAllGiants", "0")
	$itxtDonateGiants = StringReplace(IniRead($config, "donate", "txtDonateGiants", "giants|giant|any"), "|", @CRLF)

	;---------------------------------------------------------------------------------------
	; Upgrade settings ---------------------------------------------------------------------
	;---------------------------------------------------------------------------------------
	$ichkWalls = IniRead($config, "upgrade", "auto-wall", "0")
	$icmbWalls = IniRead($config, "upgrade", "walllvl", "0")
	$iUseStorage = IniRead($config, "upgrade", "use-storage", "0")
	$itxtWallMinGold = IniRead($config, "upgrade", "minwallgold", "0")
	$itxtWallMinElixir = IniRead($config, "upgrade", "minwallelixir", "0")
	$icmbTolerance = IniRead($config, "upgrade", "walltolerance", "0")

	;---------------------------------------------------------------------------------------
	; Notification settings ----------------------------------------------------------------
	;---------------------------------------------------------------------------------------
	$PushBulletEnabled = IniRead($config, "notification", "pushbullet", "0")
	$PushBullettoken = IniRead($config, "notification", "accounttoken", "")
	$PushBullettype = IniRead($config, "notification", "lastraidtype", "0")
	$PushBulletattacktype = IniRead($config, "notification", "attackimage", "0")
	$PushBulletvillagereport = IniRead($config, "notification", "villagereport", "0")
	$PushBulletmatchfound = IniRead($config, "notification", "matchfound", "0")
	$PushBulletlastraid = IniRead($config, "notification", "lastraid", "0")
	$PushBulletdebug = IniRead($config, "notification", "debug", "0")
	$PushBulletremote = IniRead($config, "notification", "remote", "0")
	$PushBulletdelete = IniRead($config, "notification", "delete", "0")
	$PushBulletfreebuilder = IniRead($config, "notification", "freebuilder", "0")

	;---------------------------------------------------------------------------------------
	; Misc settings ------------------------------------------------------------------------
	;---------------------------------------------------------------------------------------
	$AlertBaseFound = IniRead($config, "misc", "AlertBaseFound", "0")
	$TakeAttackSnapShot = IniRead($config, "misc", "TakeAttackSnapShot", "0")
	$TakeLootSnapShot = IniRead($config, "misc", "TakeLootSnapShot", "0")
	$TakeAllTownSnapShot = IniRead($config, "misc", "TakeAllTownSnapShot", "0")
	$DebugMode = IniRead($config, "misc", "Debug", "0")
	$ichkCollect = IniRead($config, "misc", "Collect", "1")
	$itxtReconnect = IniRead($config, "misc", "reconnectdelay", "0")
	$itxtReturnh = IniRead($config, "misc", "returnhomedelay", "0")
	$icmbSearchsp = IniRead($config, "misc", "searchspd", "0")
	$ichkTrap = IniRead($config, "misc", "chkTrap", "0")
	$WideEdge = IniRead($config, "misc", "WideEdge", "0")
	$ichkAvoidEdge = IniRead($config, "misc", "AvoidEdge", "0")
	$itxtcampCap = IniRead($config, "misc", "capacity", "0")
	$itxtspellCap = IniRead($config, "misc", "spellcap", "3")

	;---------------------------------------------------------------------------------------
	; Config settings ----------------------------------------------------------------------
	;---------------------------------------------------------------------------------------
	$ichkBackground = IniRead($config, "config", "Background", "0")
	$ichkForceBS = IniRead($config, "config", "ForceBS", "0")
	$ichkUpdate = IniRead($config, "config", "chkUpdate", "0")

	;---------------------------------------------------------------------------------------
	; Base location settings ---------------------------------------------------------------
	;---------------------------------------------------------------------------------------
	$CCPos[0] = IniRead($config, "position", "xCCPos", "0")
	$CCPos[1] = IniRead($config, "position", "yCCPos", "0")
	$frmBotPosX = IniRead($config, "position", "frmBotPosX", "100")
	$frmBotPosY = IniRead($config, "position", "frmBotPosY", "100")
	$TownHallPos[0] = IniRead($config, "position", "xTownHall", "-1")
	$TownHallPos[1] = IniRead($config, "position", "yTownHall", "-1")
	$ArmyPos[0] = IniRead($config, "position", "xArmy", "0")
	$ArmyPos[1] = IniRead($config, "position", "yArmy", "0")
	$SpellPos[0] = IniRead($config, "position", "xSpell", "-1")
	$SpellPos[1] = IniRead($config, "position", "ySpell", "-1")
	$KingPos[0] = IniRead($config, "position", "xKing", "0")
	$KingPos[1] = IniRead($config, "position", "yKing", "0")
	$QueenPos[0] = IniRead($config, "position", "xQueen", "0")
	$QueenPos[1] = IniRead($config, "position", "yQueen", "0")
	For $i = 0 To 3 ;Covers all 4 Barracks
		$barrackPos[$i][0] = IniRead($config, "position", "xBarrack" & $i + 1, "0")
		$barrackPos[$i][1] = IniRead($config, "position", "yBarrack" & $i + 1, "0")
	Next
	For $i = 0 To 1 ;Cover 2 Dark Barracks
		$DarkBarrackPos[$i][0] = IniRead($config, "position", "xDarkBarrack" & $i + 1, "0")
		$DarkBarrackPos[$i][1] = IniRead($config, "position", "yDarkBarrack" & $i + 1, "0")
	Next
	For $i = 0 To 16 ;Covers all Collectors
		$collectorPos[$i][0] = IniRead($config, "position", "xCollector" & $i + 1, "0")
		$collectorPos[$i][1] = IniRead($config, "position", "yCollector" & $i + 1, "0")
	Next
EndFunc   ;==>readConfig
