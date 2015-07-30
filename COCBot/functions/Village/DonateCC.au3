;Donates troops

Func DonateCC()
	Global $Troop, $TroopAmount, $ColDist = 1, $RowDist = 0 ; default to archer
	Global $AmountBarbarians = Number(GUICtrlRead($NoOfBarbarians))
	Global $AmountArchers = Number(GUICtrlRead($NoOfArchers))
	Global $AmountGiants = Number(GUICtrlRead($NoOfGiants))

	Global $Donate = IsChecked($chkDonateAllBarbarians) Or IsChecked($chkDonateBarbarians) Or IsChecked($chkDonateAllArchers) Or IsChecked($chkDonateArchers) Or IsChecked($chkDonateAllGiants) Or IsChecked($chkDonateGiants)
	If $Donate = False Then Return
	Local $y = 119
	SetLog(GetLangText("msgDonatingTroops"), $COLOR_BLUE)

	_CaptureRegion()

	Click(1, 1) ;Click Away
	If _ColorCheck(_GetPixelColor(331, 330), Hex(0xF0A03B, 6), 20) = False Then Click(19, 349) ;Clicks chat thing
	If _Sleep(500) Then Return
	Click(189, 24) ; clicking clan tab

	While $Donate
		Local $offColors[3][3] = [[0x000000, 0, -2], [0x262926, 0, 1], [0xF8FCF0, 0, 11]]
		While 1
			If _Sleep(1000) Then ExitLoop
			Global $DonatePixel = _MultiPixelSearch(202, $y, 203, 670, 1, 1, Hex(0x262926, 6), $offColors, 30)
			If IsArray($DonatePixel) Then
				$Donate = False
				If Not (IsChecked($chkDonateAllBarbarians) Or IsChecked($chkDonateAllArchers) Or IsChecked($chkDonateAllGiants)) Then
					_CaptureRegion(0, 0, 435, $DonatePixel[1] + 50)
					Local $String = getString($DonatePixel[1] - 28)
					If $String = "" Then
						$String = getString($DonatePixel[1] - 17)
					Else
						$String = $String & @CRLF & getString($DonatePixel[1] - 17)
					EndIf

					SetLog(GetLangText("msgChatText") & $String, $COLOR_GREEN)

					$Blacklisted = False
					If IsChecked($chkBlacklist) Then
						$blacklist = StringSplit(guictrlread($txtBlacklist), @CRLF)
						If IsArray($blacklist) Then
							For $loop = 1 to $blacklist[0]
								If StringStripWS($blacklist[$loop], 3) <> "" and StringInStr($string, StringStripWS($blacklist[$loop], 3)) Then $Blacklisted = True
							Next
						EndIf
					EndIf

					If $Blacklisted Then
						SetLog(GetLangText("msgBlacklisted"), $COLOR_GREEN)
					Else
						If IsChecked($chkDonateBarbarians) Then
							Local $Barbs = StringSplit(StringStripWS($itxtDonateBarbarians, 3), @CRLF)
							If IsArray($Barbs) Then
								For $i = 1 to $Barbs[0]
									If CheckDonate($Barbs[$i], $String) Then
										$Troop = GUICtrlRead($cmbDonateBarbarians)
										GetTroopCoord()
										DonateTroops($Troop, $ColDist, $RowDist, $AmountBarbarians)
										ExitLoop
									EndIf
								Next
								If $Donate Then
									If _Sleep(500) Then ExitLoop
									$y = $DonatePixel[1] + 10
								EndIf
							Else
								SetLog(GetLangText("msgUnableToRead") & "1" & GetLangText("msgDonateRules"))
								Return
							EndIf
						EndIf
						If IsChecked($chkDonateArchers) Then
							Local $Archers = StringSplit(StringStripWS($itxtDonateArchers, 3), @CRLF)
							If IsArray($Archers) Then
								For $i = 1 To $Archers[0]
									If CheckDonate($Archers[$i], $String) Then
										$Troop = GUICtrlRead($cmbDonateArchers)
										GetTroopCoord()
										DonateTroops($Troop, $ColDist, $RowDist, $AmountArchers)
										ExitLoop
									EndIf
								Next
								If $Donate Then
									If _Sleep(500) Then ExitLoop
									$y = $DonatePixel[1] + 10
								EndIf
							Else
								SetLog(GetLangText("msgUnableToRead") & "2" & GetLangText("msgDonateRules"))
								Return
							EndIf
						EndIf
						If IsChecked($chkDonateGiants) Then
							Local $Giants = StringSplit(StringStripWS($itxtDonateGiants, 3), @CRLF)
							If IsArray($Giants) Then
								For $i = 1 to $Giants[0]
									If CheckDonate($Giants[$i], $String) Then
										$Troop = GUICtrlRead($cmbDonateGiants)
										GetTroopCoord()
										DonateTroops($Troop, $ColDist, $RowDist, $AmountGiants)
										ExitLoop
									EndIf
								Next
								If $Donate Then
									If _Sleep(500) Then ExitLoop
									$y = $DonatePixel[1] + 10
								EndIf
							Else
								SetLog(GetLangText("msgUnableToRead") & "3" & GetLangText("msgDonateRules"))
								Return
							EndIf
						EndIf
					EndIf
				Else
					If IsChecked($chkDonateAllBarbarians) Then
						$Troop = GUICtrlRead($cmbDonateBarbarians)
						$TroopAmount = Number(GUICtrlRead($NoOfBarbarians))
					ElseIf IsChecked($chkDonateAllArchers) Then
						$Troop = GUICtrlRead($cmbDonateArchers)
						$TroopAmount = Number(GUICtrlRead($NoOfArchers))
					ElseIf IsChecked($chkDonateAllGiants) Then
						$Troop = GUICtrlRead($cmbDonateGiants)
						$TroopAmount = Number(GUICtrlRead($NoOfGiants))
					EndIf
					GetTroopCoord()
					If $RowDist = -1 or $ColDist = -1 Then
						SetLog(GetLangText("msgUnableToDetermine") & $Troop)
						ExitLoop
					Else
						DonateTroops($Troop, $ColDist, $RowDist, $TroopAmount)
						If $Donate Then
							If _Sleep(500) Then ExitLoop
							$y = $DonatePixel[1] + 10
						EndIf
					EndIf
				EndIf
			Else
				ExitLoop
			EndIf
			If _Sleep(500) Then Return
			Click(1, 1, 1, 2000)
			$y = $DonatePixel[1] + 10
		WEnd
		$DonatePixel = _MultiPixelSearch(202, $y, 203, 670, 1, 1, Hex(0x262926, 6), $offColors, 20)
		Local $Scroll = _PixelSearch(285, 650, 287, 700, Hex(0x97E405, 6), 20)
		$Donate = True
		If IsArray($Scroll) Then
			Click($Scroll[0], $Scroll[1])
			$y = 119
			If _Sleep(700) Then ExitLoop
		ElseIf Not IsArray($DonatePixel) Then
			$Donate = False
		EndIf
	WEnd

	If _Sleep(1000) Then Return
	SetLog(GetLangText("msgFinishedDonating"), $COLOR_BLUE)
	_CaptureRegion()
	If _ColorCheck(_GetPixelColor(331, 330), Hex(0xF0A03B, 6), 20) Then
		Click(331, 330) ;Clicks chat thing
		If _Sleep(500) Then Return
	EndIf

	;------------------------gtfo------------------------;
	If GUICtrlRead($gtfo) = 1 Then
		Local $Scroll, $kick_y, $kicked = 0
		While 1
			Click($CCPos[0], $CCPos[1]) ; click clan castle
			If _Sleep(500) Then Return
			Click(530, 600) ; open clan page
			If _Sleep(5000) Then Return ; wait for it to load
			$Scroll = 0
			While 1
				_CaptureRegion(190, 80, 220, 650)
				If _Sleep(1000) Then ExitLoop
				Local $new = _PixelSearch(200, 80, 210, 650, Hex(0xE73838, 6), 20)
				If IsArray($new) Then
					SetLog("x:" & $new[0] & " y:" & $new[1], $COLOR_RED) ; debuggin purpose
					Click($new[0], $new[1])
					If _Sleep(500) Then ExitLoop
					If $new[1] + 80 > 640 Then
						$kick_y = 640
					Else
						$kick_y = $new[1] + 80
					EndIf
					Click($new[0] + 300, $kick_y) ; kick button, hopefully
					If _Sleep(500) Then ExitLoop
					Click(520, 240)
					If _Sleep(500) Then ExitLoop
					$kicked += 1
					SetLog($kicked & GetLangText("msgKicked"), $COLOR_RED)
					If _Sleep(2000) Then ExitLoop
					ExitLoop
				Else
					ControlSend($Title, "", "", "{CTRLDOWN}{UP}{CTRLUP}") ; scroll down the member list
					SetLog(GetLangText("msgScrollingDown"), $COLOR_RED)
					$Scroll += 1
					If _Sleep(3000) Then ExitLoop
				EndIf
				If $Scroll = 8 Then ExitLoop (2)
			WEnd
		WEnd
		SetLog(GetLangText("msgFinishedKicking"), $COLOR_RED)
	EndIf
	Click(1, 1, 1, 2000)
EndFunc   ;==>DonateCC

Func CheckDonate($String, $clanString) ;Checks if it exact
	$Contains = StringMid($String, 1, 1) & StringMid($String, StringLen($String), 1)
	If $Contains = "[]" Then
		If $clanString = StringMid($String, 2, StringLen($String) - 2) Then
			Return True
		Else
			Return False
		EndIf
	Else
		If StringInStr($clanString, $String, 2) Then
			Return True
		Else
			Return False
		EndIf
	EndIf
EndFunc   ;==>CheckDonate

Func DonateTroops($Troop, $i, $Row, $number)
	Local $x, $y
	If IsArray(_PixelSearch(119, $DonatePixel[1], 204, $DonatePixel[1]+4, Hex(0x262926, 6), 10)) Then
		Click($DonatePixel[0], $DonatePixel[1] + 15)
	Else
		SetLog(GetLangText("msgNoDonateButton"))
	EndIf
	If _Sleep(1000) Then Return
	_CaptureRegion(0, 0, 860, $DonatePixel[1] + 200)
	If $i >= 0 Then $x = 237 + $i * 80
	If $Row = 0 Then
		$y = $DonatePixel[1] - 5
	ElseIf $Row = 1 Then
		$y = $DonatePixel[1] + 91
	Else
		$y = $DonatePixel[1] + 185
	EndIf
	If _ColorCheck(_GetPixelColor($x, $y), Hex(0x507C00, 6), 10) Or _ColorCheck(_GetPixelColor($x, $y - 5), Hex(0x507C00, 6), 10) Then
		SetLog(GetLangText("msgDonating") & $number & " " & $Troop, $COLOR_BLUE)
		If _Sleep(500) Then Return
		; TODO, check available  trrop before donate the amount of number
		Click($x, $y, $number, 50)
		$Donate = True
		update_armycamp($Troop, $number)
	Else
		SetLog(GetLangText("msgNo") & $Troop & GetLangText("msgAvailable"), $COLOR_ORANGE)
		Return
	EndIf
	If _Sleep(500) Then Return
EndFunc   ;==>DonateTroops

Func update_armycamp($Troop, $number)
	Switch $Troop
		Case GetLangText("troopNamePlArcher"), GetLangText("troopNameArcher")
			$CurArch += $number
		Case GetLangText("troopNamePlBarbarian"), GetLangText("troopNameBarbarian")
			$CurBarb += $number
		Case GetLangText("troopNamePlGoblin"), GetLangText("troopNameGoblin")
			$CurGoblin += $number
		Case GetLangText("troopNamePlGiant"), GetLangText("troopNameGiant")
			$CurGiant += $number
		Case GetLangText("troopNamePlWallBreaker"), GetLangText("troopNameWallBreaker")
			$CurWB += $number
			;              Case "Balloon"
			;             Case "Hog"
			;              Case "Dragon"
			;              Case "Pekka"
			;              Case "Minion"
			;              Case "Valkyrie"
			;              Case "Witch"
			;              Case "Healer"
			;              Case "Golem"
			;              Case "Lava"
	EndSwitch
EndFunc   ;==>update_armycamp

Func GetTroopCoord()
	Switch $Troop
		Case GetLangText("troopNamePlBarbarian"), GetLangText("troopNameBarbarian"), GetLangText("troopNamePlHealer"), GetLangText("troopNameHealer"), GetLangText("troopDarkPlWitch"), GetLangText("troopDarkWitch")
			$ColDist = 0
		Case GetLangText("troopNamePlArcher"), GetLangText("troopNameArcher"), GetLangText("troopNamePlDragon"), GetLangText("troopNameDragon"), GetLangText("troopDarkPlLavaHound"), GetLangText("troopDarkLavaHound")
			$ColDist = 1
		Case GetLangText("troopNamePlGiant"), GetLangText("troopNameGiant"), GetLangText("troopNamePlPEKKA"), GetLangText("troopNamePEKKA")
			$ColDist = 2
		Case GetLangText("troopNamePlGoblin"), GetLangText("troopNameGoblin"), GetLangText("troopDarkPlMinion"), GetLangText("troopDarkMinion")
			$ColDist = 3
		Case GetLangText("troopNamePlWallBreaker"), GetLangText("troopNameWallBreaker"), GetLangText("troopDarkPlHog"), GetLangText("troopDarkHog")
			$ColDist = 4
		Case GetLangText("troopNamePlBalloon"), GetLangText("troopNameBalloon"), GetLangText("troopDarkPlValkyrie"), GetLangText("troopDarkValkyrie")
			$ColDist = 5
		Case GetLangText("troopNamePlWizard"), GetLangText("troopNameWizard"), GetLangText("troopDarkPlGolem"), GetLangText("troopDarkGolem")
			$ColDist = 6
		Case Else
			$ColDist = -1
	EndSwitch

	Switch $Troop
		Case GetLangText("troopNamePlBarbarian"), GetLangText("troopNameBarbarian"),  GetLangText("troopNamePlArcher"), GetLangText("troopNameArcher"), GetLangText("troopNamePlGiant"), GetLangText("troopNameGiant"), GetLangText("troopNamePlGoblin"), GetLangText("troopNameGoblin"), GetLangText("troopNamePlWallBreaker"), GetLangText("troopNameWallBreaker"), GetLangText("troopNamePlBalloon"), GetLangText("troopNameBalloon"), GetLangText("troopNamePlWizard"), GetLangText("troopNameWizard")
			$RowDist = 0
		Case GetLangText("troopNamePlHealer"), GetLangText("troopNameHealer"), GetLangText("troopNamePlDragon"), GetLangText("troopNameDragon"), GetLangText("troopNamePlPEKKA"), GetLangText("troopNamePEKKA"), GetLangText("troopDarkPlMinion"), GetLangText("troopDarkMinion"), GetLangText("troopDarkPlHog"), GetLangText("troopDarkHog"), GetLangText("troopDarkPlValkyrie"), GetLangText("troopDarkValkyrie"), GetLangText("troopDarkPlGolem"), GetLangText("troopDarkGolem")
			$RowDist = 1
		Case GetLangText("troopDarkPlWitch"), GetLangText("troopDarkWitch"), GetLangText("troopDarkPlLavaHound"), GetLangText("troopDarkLavaHound")
			$RowDist = 2
		Case Else
			$RowDist = -1
	EndSwitch
EndFunc   ;==>GetTroopCoord
