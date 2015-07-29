;Will detect how much gold per search
Func CheckCostPerSearch()

	If $SearchCost = 0 Then
		SetLog(GetLangText("msgCheckGold"), $COLOR_GREEN)

		If $TownHallPos[0] = "" Then
			If Not LocateTownHall() Then Return
			SaveConfig()
		EndIf

		ClickP($TopLeftClient, 2, 250); Click away twice with 250ms delay
		StatusCheck()

		Click($TownHallPos[0], $TownHallPos[1])
		$Location = _WaitForPixel(240, 581, 484, 583, Hex(0x4084B8, 6), 6, 2)

		If Not IsArray($Location) Then
			SetLog(GetLangText("msgFailedTH"), $COLOR_RED)
			Return
		Else
			Click($Location[0], $Location[1])
			If Not _WaitForColor(698, 160, Hex(0xD80408, 6), 16, 2) Then
				SetLog(GetLangText("msgFailedTH"), $COLOR_RED)
				ClickP($TopLeftClient, 2, 250)
				Return
			Else
				$MenuBar = StringStripWS(ReadText(175, 138, 500, $textWindowTitles),3)
				$THLevel = Number(StringRegExpReplace(StringRight($MenuBar, 25),"[^0-9]",""))
				If $THLevel = "1" Then
					$SearchCost = 10
				ElseIf $THLevel = "2" Then
					$SearchCost = 50
				ElseIf $THLevel = "3" Then
					$SearchCost = 75
				ElseIf $THLevel = "4" Then
					$SearchCost = 110
				ElseIf $THLevel = "5" Then
					$SearchCost = 170
				ElseIf $THLevel = "6" Then
					$SearchCost = 250
				ElseIf $THLevel = "7" Then
					$SearchCost = 380
				ElseIf $THLevel = "8" Then
					$SearchCost = 580
				ElseIf $THLevel = "9" Then
					$SearchCost = 750
				ElseIf $THLevel = "10" Then
					$SearchCost = 1000
				EndIf

				SetLog(GetLangText("msgTHLevel") & $THLevel & GetLangText("msgGoldCPS") & $SearchCost, $COLOR_GREEN)
			EndIf
		EndIf
		ClickP($TopLeftClient, 2, 250); Click away twice with 250ms delay
	EndIf

EndFunc   ;==>CheckCostPerSearch
