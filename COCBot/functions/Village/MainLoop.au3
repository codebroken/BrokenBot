Func runBot() ;Bot that runs everything in order
	Local $AttackType
	While 1
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

		Collect()
		If StatusCheck() Then Return

		UpgradeBuilding()
		If StatusCheck() Then Return

		UpgradeWall()
		If StatusCheck() Then Return

		Switch $CurrentMode
			Case $modeNormal
				Idle($strPlugInInUse)
				If StatusCheck() Then Return

				Call($strPlugInInUse & "_PrepNextBattle")

				While True
					If StatusCheck() Then Return
					If PrepareSearch() Then
						$AttackType = Call($strPlugInInUse & "_Search")
						If BotStopped(False) Then Return
						If $AttackType = -1 Then ContinueLoop

						Call($strPlugInInUse & "_PrepareAttack", $AttackType)
						If BotStopped(False) Then Return

						SetLog("======Beginning Attack======")
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
			Case $modeDonate
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
	While Not Call($Plugin & "_ReadyCheck")
		If StatusCheck() Then Return
		SetLog("~~~Waiting for full army~~~", $COLOR_PURPLE)
		If $iCollectCounter > $COLLECTATCOUNT Then ; This is prevent from collecting all the time which isn't needed anyway
			Collect()
			If StatusCheck() Then Return
			$iCollectCounter = 0
		EndIf
		$iCollectCounter += 1
		DonateCC()
		If StatusCheck() Then Return
		_BumpMouse()
		$TimeIdle = Round(TimerDiff($hTimer) / 1000, 2) ;In Seconds
		SetLog("Time Idle: " & Floor(Floor($TimeIdle / 60) / 60) & " hours " & Floor(Mod(Floor($TimeIdle / 60), 60)) & " minutes " & Floor(Mod($TimeIdle, 60)) & " seconds", $COLOR_ORANGE)
		If _Sleep(30000) Then ExitLoop
	WEnd
EndFunc   ;==>Idle

