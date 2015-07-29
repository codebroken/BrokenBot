;Uses the getGold,getElixir... functions and uses CompareResources until it meets conditions.
;Will wait ten seconds until getGold returns a value other than "", if longer than 10 seconds - calls checkNextButton
;-clicks next if checkNextButton returns true, otherwise will restart the bot.

Func GetResources($MidAttack = 0) ;Reads resources
	Local $RetVal[6]
	Local $i = 0
	Local $x = 0
	Local $txtDead = "Live"

	If $MidAttack = 0 And ChkDisconnection() Then
		SetLog(GetLangText("msgNoNextButton"), $COLOR_RED)
		Return False
	EndIf

	If $MidAttack > 0 Then
		$RetVal[0] = ""
		$RetVal[1] = ""
	Else
		$fdiffReadGold = TimerDiff($hTimerClickNext)
		$RetVal[0] = checkDeadBase()
		If $RetVal[0] Then $txtDead = GetLangText("msgDeadInitial")

		$RetVal[1] = checkTownhall()
		If $RetVal[1] = "-" Then
			$THLoc = "-"
			$THquadrant = "-"
			$THx = 0
			$THy = 0
		Else
			$THquadrant = 0
			If $WideEdge = 1 Then
				If ((((85 - 389) / (528 - 131)) * ($THx - 131)) + 389 > $THy) Then
					$THquadrant = 1
				ElseIf ((((237 - 538) / (723 - 337)) * ($THx - 337)) + 538 > $THy) Then
					$THquadrant = 4
				Else
					$THquadrant = 7
				EndIf
				If ((((388 - 85) / (725 - 330)) * ($THx - 330)) + 85 > $THy) Then
					$THquadrant = $THquadrant + 2
				ElseIf ((((537 - 238) / (535 - 129)) * ($THx - 129)) + 238 > $THy) Then
					$THquadrant = $THquadrant + 1
				EndIf
			Else
				If ((((70 - 374) / (508 - 110)) * ($THx - 110)) + 374 > $THy) Then
					$THquadrant = 1
				ElseIf ((((252 - 552) / (742 - 358)) * ($THx - 358)) + 552 > $THy) Then
					$THquadrant = 4
				Else
					$THquadrant = 7
				EndIf
				If ((((373 - 70) / (744 - 350)) * ($THx - 350)) + 70 > $THy) Then
					$THquadrant = $THquadrant + 2
				ElseIf ((((552 - 253) / (516 - 108)) * ($THx - 108)) + 253 > $THy) Then
					$THquadrant = $THquadrant + 1
				EndIf
			EndIf
			If GUICtrlRead($sldAcc) > -1 Then
				If $THquadrant >= 1 And $THquadrant <= 4 Then $THLoc = "Out"
				If $THquadrant = 5 Then $THLoc = "In"
				If $THquadrant >= 6 And $THquadrant <= 9 Then $THLoc = "Out"
			Else
				; Future implementation...better determination of outside TH
				SeekEdges()
				If CloseToEdge($Thx, $Thy, 80) Then
					$THLoc = "Out"
				Else
					$THLoc = "In"
				EndIf
			EndIf
		EndIf
	EndIf

	$RetVal[2] = ReadText(50, 70, 150, $textVillageSearch)
	$RetVal[3] = ReadText(50, 99, 150, $textVillageSearch)
	If _ColorCheck(_GetPixelColor(38, 136), Hex(0xD3CADA, 6), 40) Then
		$RetVal[4] = ReadText(50, 128, 80, $textVillageSearch)
		$RetVal[5] = ReadText(50, 170, 67, $textVillageSearch)
	Else
		$RetVal[4] = 0
		$RetVal[5] = ReadText(50, 140, 67, $textVillageSearch)
	EndIf

	If $MidAttack = 1 Then
		SetLog(GetLangText("msgMidAttack") & " [" & GetLangText("msgGoldinitial") & "]: " & $RetVal[2] & Tab($RetVal[2], 7) & "[" & GetLangText("msgElixirinitial") & "]: " & $RetVal[3] & Tab($RetVal[3], 7) & "[" & GetLangText("msgDarkElixinitial") & "]: " & $RetVal[4] & Tab($RetVal[4], 4) & "[" & GetLangText("msgTrophyInitial") & "]: " & $RetVal[5] & Tab($RetVal[5], 3) & "[" & GetLangText("msgTHInitial") & "]: " & $RetVal[1] & (($RetVal[1] <> "-") ? ("-Q" & $THquadrant) : ("")) & ", " & $THLoc & ", " & $txtDead, $COLOR_BLUE)
	ElseIf $MidAttack = 0 Then
		$SearchCount += 1 ; Counter for number of searches
		SetLog("(" & $SearchCount & ") [" & GetLangText("msgGoldinitial") & "]: " & $RetVal[2] & Tab($RetVal[2], 7) & "[" & GetLangText("msgElixirinitial") & "]: " & $RetVal[3] & Tab($RetVal[3], 7) & "[" & GetLangText("msgDarkElixinitial") & "]: " & $RetVal[4] & Tab($RetVal[4], 4) & "[" & GetLangText("msgTrophyInitial") & "]: " & $RetVal[5] & Tab($RetVal[5], 3) & "[" & GetLangText("msgTHInitial") & "]: " & $RetVal[1] & (($RetVal[1] <> "-") ? ("-Q" & $THquadrant) : ("")) & ", " & $THLoc & ", " & $txtDead, $COLOR_BLUE)
	EndIf
	Return $RetVal
EndFunc   ;==>GetResources
