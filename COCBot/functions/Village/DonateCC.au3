;Donates troops

Func DonateCC()
	Global $Troop, $TroopAmount, $ColDist = 1, $RowDist = 0 ; default to archer
	Global $AmountBarbarians = Number(GUICtrlRead($NoOfBarbarians))
	Global $AmountArchers = Number(GUICtrlRead($NoOfArchers))
	Global $AmountGiants = Number(GUICtrlRead($NoOfGiants))

	Global $Donate = $ichkDonateBarbarians = 1 Or $ichkDonateArchers = 1 Or $ichkDonateGiants = 1 Or $ichkDonateAllBarbarians = 1 Or $ichkDonateAllArchers = 1 Or $ichkDonateAllGiants = 1
	If $Donate = False Then Return
	Local $y = 119
	SetLog("Donating Troops", $COLOR_BLUE)

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
				If ($ichkDonateAllBarbarians = 0 And $ichkDonateAllArchers = 0 And $ichkDonateAllGiants = 0) And ($ichkDonateBarbarians = 1 Or $ichkDonateArchers = 1 Or $ichkDonateGiants = 1) Then
					_CaptureRegion(0, 0, 435, $DonatePixel[1] + 50)
					Local $String = getString($DonatePixel[1] - 28)
					If $String = "" Then
						$String = getString($DonatePixel[1] - 17)
					Else
						$String = $String & @CRLF & getString($DonatePixel[1] - 17)
					EndIf

					SetLog("Chat Text: " & $String, $COLOR_GREEN)

					If $ichkDonateBarbarians = 1 Then
						Local $Barbs = StringSplit($itxtDonateBarbarians, @CRLF)
						For $i = 0 To UBound($Barbs) - 1
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
					EndIf
					If $ichkDonateArchers = 1 Then
						Local $Archers = StringSplit($itxtDonateArchers, @CRLF)
						For $i = 0 To UBound($Archers) - 1
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
					EndIf
					If $ichkDonateGiants = 1 Then
						Local $Giants = StringSplit($itxtDonateGiants, @CRLF)
						For $i = 0 To UBound($Giants) - 1
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
					EndIf
				Else
					Select
						Case $ichkDonateAllBarbarians = 1
							$Troop = GUICtrlRead($cmbDonateBarbarians)
							$TroopAmount = Number(GUICtrlRead($NoOfBarbarians))
						Case $ichkDonateAllArchers = 1
							$Troop = GUICtrlRead($cmbDonateArchers)
							$TroopAmount = Number(GUICtrlRead($NoOfArchers))
						Case $ichkDonateAllGiants = 1
							$Troop = GUICtrlRead($cmbDonateGiants)
							$TroopAmount = Number(GUICtrlRead($NoOfGiants))
					EndSelect
					GetTroopCoord()
					DonateTroops($Troop, $ColDist, $RowDist, $TroopAmount)
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
	SetLog("Finished Donating", $COLOR_BLUE)
	_CaptureRegion()
	If _ColorCheck(_GetPixelColor(331, 330), Hex(0xF0A03B, 6), 20) Then
		Click(331, 330) ;Clicks chat thing
		If _Sleep(500) Then Return
	EndIf

	;------------------------gtfo------------------------;
	If GUICtrlRead($gtfo) = 1 Then
		Local $scroll, $kick_y, $kicked = 0
		While 1
			Click($CCPos[0], $CCPos[1]) ; click clan castle
			If _Sleep(500) Then Return
			Click(530, 600) ; open clan page
			If _Sleep(5000) Then Return ; wait for it to load
			$scroll = 0
			While 1
				_CaptureRegion(190, 80, 220, 650)
				If _Sleep(1000) Then ExitLoop
				Local $new = _PixelSearch(200, 80, 210, 650, Hex(0xE73838, 6), 20)
					If IsArray($new) Then
					SetLog("x:" & $new[0] & " y:" & $new[1], $COLOR_RED) ; debuggin purpose
					Click($new[0], $new[1])
					If _Sleep(500) Then ExitLoop
					If $new[1]+80> 640 Then
						$kick_y = 640
					Else
						$kick_y = $new[1] + 80
					EndIf
					Click($new[0] + 300, $kick_y) ; kick button, hopefully
					If _Sleep(500) Then ExitLoop
					Click(520, 240)
					If _Sleep(500) Then ExitLoop
					$kicked += 1
					SetLog($kicked & " Kicked!", $COLOR_RED)
					If _Sleep(2000) Then ExitLoop
					ExitLoop
				Else
					ControlSend($Title, "", "", "{CTRLDOWN}{UP}{CTRLUP}") ; scroll down the member list
					SetLog("Scrolling down", $COLOR_RED)
					$scroll += 1
					If _Sleep(3000) Then ExitLoop
				EndIf
				If $scroll = 8 Then ExitLoop(2)
			WEnd
		WEnd
	SetLog("Finished kicking", $COLOR_RED)
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
	If _ColorCheck(_GetPixelColor($DonatePixel[0], $DonatePixel[1]), Hex(0x262926, 6), 10) Then Click($DonatePixel[0], $DonatePixel[1] + 11)
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
		SetLog("Donating " & $number & " " & $Troop, $COLOR_BLUE)
		If _Sleep(500) Then Return
		; TODO, check available  trrop before donate the amount of number
		Click($x, $y, $number, 50)
		$Donate = True
		update_armycamp($Troop, $number)
	Else
		SetLog("No " & $Troop & " available for donation.", $COLOR_ORANGE)
		Return
	EndIf
	If _Sleep(500) Then Return
EndFunc   ;==>DonateTroops

Func update_armycamp($Troop, $number)
       Switch $Troop
               Case "Archer"
                       $CurArch += $number
               Case "Barbarian"
                       $CurBarb += $number
               Case "Goblin"
                       $CurGoblin += $number
               Case "Giant"
                       $CurGiant += $number
               Case "WB"
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
EndFunc

Func GetTroopCoord()
	Switch $Troop
		Case "Barbarian", "Healer", "Witch"
			$ColDist = 0
		Case "Archer", "Dragon", "Lava"
			$ColDist = 1
		Case "Giant", "Pekka"
			$ColDist = 2
		Case "Goblin", "Minion"
			$ColDist = 3
		Case "WB", "Hog"
			$ColDist = 4
		Case "Balloon", "Valkyrie"
			$ColDist = 5
		Case "Wizard", "Golem"
			$ColDist = 6
		Case Else
			SetLog("Unable to determine troop ($i) to donate. Shutting down PC...", $COLOR_RED)
			$ColDist = -1
	EndSwitch

	Switch $Troop
		Case "Barbarian", "Archer", "Giant", "Goblin", "WB", "Balloon", "Wizard"
			$RowDist = 0
		Case "Healer", "Dragon", "Pekka", "Minion", "Hog", "Valkyrie", "Golem"
			$RowDist = 1
		Case "Witch", "Lava"
			$RowDist = 2
		Case Else
			SetLog("Unable to determine troop ($row) to donate. Shutting down PC...", $COLOR_RED)
			$RowDist = -1
	EndSwitch
EndFunc   ;==>GetTroopCoord
