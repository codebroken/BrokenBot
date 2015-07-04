Func runBot() ;Bot that runs everything in order
	Local $AttackType
	While 1
		If TimerDiff($hUpdateTimer) > (1000 * 60 * 60 * 12) Then
			checkupdate()
		EndIf

		; Configuration and cleanup
		$Restart = False
		LootLogCleanup(100)
		SaveConfig()
		readConfig()
		applyConfig()
		$strPlugInInUse = IniRead($dirStrat & GUICtrlRead($lstStrategies) & ".ini", "plugin", "name", "")

		;Check attack mode
		chkNoAttack()
		If StatusCheck(True, True, 3) Then Return

		; Collect stats
		VillageReport()
		If StatusCheck() Then Return

		CheckCostPerSearch()
		If StatusCheck() Then Return

		clearField()
		If StatusCheck() Then Return

		If $Checkrearm Then
			ReArm()
			$Checkrearm = False
		EndIf
		If StatusCheck() Then Return

		DonateCC()
		If StatusCheck() Then Return

		RequestCC()
		If StatusCheck() Then Return

		BoostAllBuilding()
		If StatusCheck() Then Return

		collectResources()
		If StatusCheck() Then Return

		Laboratory()
		If StatusCheck() Then Return

		UpgradeBuilding()
		If StatusCheck() Then Return

		UpgradeWall()
		If StatusCheck() Then Return

		If $PushBulletEnabled = 1 And $PushBulletchatlog = 1 Then
			ReadChatLog(Not $ChatInitialized)
		EndIf
		If StatusCheck() Then Return

		Switch $CurrentMode
			Case $modeNormal
				Idle($strPlugInInUse)
				If StatusCheck() Then Return

				If DropTrophy() Then ContinueLoop
				If StatusCheck() Then Return False

				Call($strPlugInInUse & "_PrepNextBattle")

				While True
					If StatusCheck() Then Return

					If Not Call($strPlugInInUse & "_miniReadyCheck") Then ExitLoop

					If PrepareSearch() Then
						$AttackType = Call($strPlugInInUse & "_Search")
						If BotStopped(False) Then Return
						If $AttackType = -1 Then
							$SearchFailed = True
							ContinueLoop
						EndIf

						Call($strPlugInInUse & "_PrepareAttack", False, $AttackType)
						If BotStopped(False) Then Return

						SetLog(GetLangText("msgBeginAttack"))
						Call($strPlugInInUse & "_Attack", $AttackType)
						If BotStopped(False) Then Return

						ReturnHome($TakeLootSnapShot)
						If StatusCheck() Then Return
					Else
						If _ColorCheck(_GetPixelColor(820, 15), Hex(0xF88288, 6), 20) Then Click(820, 15) ;Click Red X
						If StatusCheck() Then Return
						ContinueLoop
					EndIf
					ExitLoop
				WEnd
			Case $modeDonateTrain
				$fullarmy = Donate_CheckArmyCamp()
				If StatusCheck() Then Return False

				If Not $fullarmy Then Donate_Train()
				If StatusCheck() Then Return False

				If _Sleep(5000) Then Return
			Case $modeDonate
				If _Sleep(5000) Then Return
				; Why is this even a mode?
			Case $modeExperience
				Experience()
		EndSwitch

		_BumpMouse()
	WEnd
EndFunc   ;==>runBot

Func Idle($Plugin) ;Sequence that runs until Full Army
	Local $TimeIdle = 0 ;In Seconds
	Local $hTimer = TimerInit()
	Local $prevCamp = 0
	Local $hTroopTimer = TimerInit()
	Local $TimeSinceTroop = 0
	While Not Call($Plugin & "_ReadyCheck", $TimeSinceTroop)
		If StatusCheck() Then Return
		SetLog(GetLangText("msgWaitingFull"), $COLOR_PURPLE)
		If $iCollectCounter > $COLLECTATCOUNT Then ; This is prevent from collecting all the time which isn't needed anyway
			collectResources()
			If StatusCheck() Then Return
			$iCollectCounter = 0
		EndIf
		$iCollectCounter += 1
		DonateCC()
		If StatusCheck() Then Return
		_BumpMouse()
		$TimeIdle = Round(TimerDiff($hTimer) / 1000, 2) ;In Seconds
		If $CurCamp <> $prevCamp Then
			$prevCamp = $CurCamp
			$hTroopTimer = TimerInit()
		EndIf
		If $CurCamp = 0 Or $CurCamp = "" Then $hTroopTimer = TimerInit() ; Not a good fix, but will stop errors for people whose troop size can't be read for now
		$TimeSinceTroop = TimerDiff($hTroopTimer) / 1000
		SetLog(GetLangText("msgTimeIdle") & Floor(Floor($TimeIdle / 60) / 60) & GetLangText("msgTimeIdleHours") & Floor(Mod(Floor($TimeIdle / 60), 60)) & GetLangText("msgTimeIdleMin") & Floor(Mod($TimeIdle, 60)) & GetLangText("msgTimeIdleSec"), $COLOR_ORANGE)
		If _Sleep(30000) Then ExitLoop
	WEnd
EndFunc   ;==>Idle

