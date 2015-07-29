; Returns True if bot no longer running.
; There are Commands to Shutdown, Sleep, Halt Attack and Halt Training mode

Func BotStopped($CheckLimits = True)
	Local $Stopped = False
	If $CheckLimits Then
		If IsChecked($chkBotStop) Then
			$MeetCondStop = False
			Local $TrophyCount = Number(ReadText(59, 75, 60, $textMainScreen))
			Local $TrophyMax = Number($TrophyCount) > Number($itxtMaxTrophy)
			If $TrophyMax Then
				$Trophy = "Max. Trophy Reached!"
			Else
				$Trophy = ""
			EndIf

			Switch $icmbBotCond
				Case 0
					If isGoldFull() And isElixirFull() And isDarkElixirFull() And $TrophyMax Then $MeetCondStop = True
				Case 1
					If (isGoldFull() And isElixirFull() And isDarkElixirFull()) Or $TrophyMax Then $MeetCondStop = True
				Case 2
					If isGoldFull() And isElixirFull() And isDarkElixirFull() Then $MeetCondStop = True
				Case 3
					If isGoldFull() Or isElixirFull() Or isDarkElixirFull() Then $MeetCondStop = True
				Case 4
					If isDarkElixirFull() Then $MeetCondStop = True
				Case 5
					If isGoldFull() And isElixirFull() And $TrophyMax Then $MeetCondStop = True
				Case 6
					If (isGoldFull() And isElixirFull()) Or $TrophyMax Then $MeetCondStop = True
				Case 7
					If (isGoldFull() Or isElixirFull()) And $TrophyMax Then $MeetCondStop = True
				Case 8
					If isGoldFull() Or isElixirFull() Or $TrophyMax Then $MeetCondStop = True
				Case 9
					If isGoldFull() And isElixirFull() Then $MeetCondStop = True
				Case 10
					If isGoldFull() Or isElixirFull() Then $MeetCondStop = True
				Case 11
					If isGoldFull() And $TrophyMax Then $MeetCondStop = True
				Case 12
					If isElixirFull() And $TrophyMax Then $MeetCondStop = True
				Case 13
					If isGoldFull() Or $TrophyMax Then $MeetCondStop = True
				Case 14
					If isElixirFull() Or $TrophyMax Then $MeetCondStop = True
				Case 15
					If isGoldFull() Then $MeetCondStop = True
				Case 16
					If isElixirFull() Then $MeetCondStop = True
				Case 17
					If $TrophyMax Then $MeetCondStop = True
			EndSwitch

			If $MeetCondStop Then
				If $icmbBotCond <> 4 And $icmbBotCond <> 5 And $icmbBotCond <> 10 And $icmbBotCond <> 11 Then
					If $Trophy <> "" Then SetLog($Trophy, $COLOR_GREEN)
					If _Sleep(500) Then Return
				EndIf
				Switch $icmbBotCommand
					Case 0
						SetLog(GetLangText("msgHaltExp"), $COLOR_BLUE)
						$CurrentMode = $modeExperience ; Switch to exp mode
						If _Sleep(500) Then Return
					Case 1
						SetLog(GetLangText("msgHaltDonate"), $COLOR_BLUE)
						$CurrentMode = $modeDonateTrain ; Halt Attack
						If _Sleep(500) Then Return
					Case 2
						SetLog(GetLangText("msgForceShutdown"), $COLOR_BLUE)
						If _Sleep(500) Then Return
						Shutdown(5) ; Force Shutdown
						btnStop()
					Case 3
						SetLog(GetLangText("msgSleep"), $COLOR_BLUE)
						If _Sleep(500) Then Return
						Shutdown(32) ; Sleep / Stand by
						btnStop()
				EndSwitch
			EndIf
		EndIf
	EndIf
	If BitAND(GUICtrlGetState($btnStop), $GUI_HIDE) Then
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>BotStopped
