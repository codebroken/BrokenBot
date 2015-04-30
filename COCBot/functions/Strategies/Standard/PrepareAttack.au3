;Checks the troops when in battle, checks for type, slot, and quantity.
;Saved in $atkTroops[SLOT][TYPE/QUANTITY] variable

Func Standard_PrepareAttack($remaining = False, $AttackMethod = 1) ;Assigns troops
	If $remaining Then
		SetLog("Checking remaining unlaunched troops", $COLOR_ORANGE)
	Else
		SetLog("Preparing to attack", $COLOR_BLUE)
	EndIf
	_CaptureRegion()

	Local $iAlgorithm = ($AttackMethod = 0) ? _GUICtrlComboBox_GetCurSel($cmbDeadAlgorithm) : _GUICtrlComboBox_GetCurSel($cmbAlgorithm)
	For $i = 0 To 8
		Local $troopKind = IdentifyTroopKind($i)
		If $iAlgorithm = 8 Then
			For $x = 0 To 3
				$troopKind = IdentifyTroopKind($i)
				If $troopKind = $eBarbarian And $barrackTroop[$x] = 0 Then
					$atkTroops[$i][0] = $troopKind
					ExitLoop
				ElseIf $troopKind = $eArcher And $barrackTroop[$x] = 1 Then
					$atkTroops[$i][0] = $troopKind
					ExitLoop
				ElseIf $troopKind = $eGiant And $barrackTroop[$x] = 2 Then
					$atkTroops[$i][0] = $troopKind
					ExitLoop
				ElseIf $troopKind = $eGoblin And $barrackTroop[$x] = 3 Then
					$atkTroops[$i][0] = $troopKind
					ExitLoop
				ElseIf $troopKind = $eWallbreaker And $barrackTroop[$x] = 4 Then
					$atkTroops[$i][0] = $troopKind
					ExitLoop
				ElseIf $troopKind = $eMinion And ($DarkBarrackTroop[0] = 0 Or $DarkBarrackTroop[1] = 0) Then
					$atkTroops[$i][0] = $troopKind
					ExitLoop
				ElseIf $troopKind = $eHog And ($DarkBarrackTroop[0] = 1 Or $DarkBarrackTroop[1] = 1) Then
					$atkTroops[$i][0] = $troopKind
					ExitLoop
				ElseIf $troopKind = $eValkyrie And ($DarkBarrackTroop[0] = 2 Or $DarkBarrackTroop[1] = 2) Then
					$atkTroops[$i][0] = $troopKind
					ExitLoop
				ElseIf $troopKind <> $eKing And $troopKind <> $eQueen And $troopKind <> $eCastle And $troopKind <> $eLSpell Then
					$troopKind = -1
				EndIf
			Next
		ElseIf Not $fullarmy Then
			If $troopKind <> $eLSpell Then
				$troopKind = -1
			EndIf
		ElseIf $troopKind <> $eKing And $troopKind <> $eQueen And $troopKind <> $eCastle And $troopKind <> $eLSpell And ($troopKind = $eBarbarian And ($iAlgorithm = 0 Or $iAlgorithm = 2)) Or ($troopKind = $eArcher And ($iAlgorithm = 1 Or $iAlgorithm = 2)) Or ($troopKind = $eGiant And ($iAlgorithm = 0 Or $iAlgorithm = 1 Or $iAlgorithm = 2 Or $iAlgorithm = 3 Or $iAlgorithm = 6)) Or ($troopKind = $eGoblin And ($iAlgorithm = 0 Or $iAlgorithm = 1 Or $iAlgorithm = 3 Or $iAlgorithm = 5)) Or ($troopKind = $eWallbreaker And ($iAlgorithm <> 7 And $iAlgorithm <> 8 And $iAlgorithm <> 9)) Or ($troopKind = $eMinion And ($iAlgorithm <> 8 And $iAlgorithm <> 9)) Or ($troopKind = $eHog And ($iAlgorithm <> 8 And $iAlgorithm <> 9)) Or ($troopKind = $eValkyrie And ($iAlgorithm <> 8 And $iAlgorithm <> 9)) Then
			$troopKind = -1
		EndIf

		If ($troopKind == -1) Then
			$atkTroops[$i][1] = 0
		ElseIf ($troopKind = $eKing) Or ($troopKind = $eQueen) Or ($troopKind = $eCastle) Then
			$atkTroops[$i][1] = 1
		Else
			$atkTroops[$i][1] = ReadTroopQuantity($i)
		EndIf
		$atkTroops[$i][0] = $troopKind

		If $troopKind <> -1 Then SetLog("-" & NameOfTroop($atkTroops[$i][0]) & " " & $atkTroops[$i][1], $COLOR_GREEN)
	Next
EndFunc   ;==>PrepareAttack
