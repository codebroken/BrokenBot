;Checks the troops when in battle, checks for type, slot, and quantity.
;Saved in $atkTroops[SLOT][TYPE/QUANTITY] variable

Func Standard_PrepareAttack($remaining = False, $AttackMethod = 1) ;Assigns troops
	If $remaining Then
		SetLog(GetLangText("msgCheckingRem"), $COLOR_ORANGE)
	Else
		SetLog(GetLangText("msgPreparingAtt"), $COLOR_BLUE)
	EndIf
	_CaptureRegion()

	Local $iAlgorithm = ($AttackMethod = 0) ? _GUICtrlComboBox_GetCurSel($cmbDeadAlgorithm) : _GUICtrlComboBox_GetCurSel($cmbAlgorithm)
	Local $BarrackControl
	For $i = 0 To 8
		Local $troopKind = IdentifyTroopKind($i)
		Switch $iAlgorithm
			Case 0
				; Archers only
				If $troopKind <> $eArcher And $troopKind <> $eKing And $troopKind <> $eQueen And $troopKind <> $eCastle And $troopKind <> $eLSpell Then
					If Not $remaining Then
						If NameOfTroop($troopKind) <> "Unknown" Then SetLog(GetLangText("msgIgnoring") & NameOfTroop($troopKind))
					EndIf
					$troopKind = -1
				EndIf
			Case 1
				; Barbarians only
				If $troopKind <> $eBarbarian And $troopKind <> $eKing And $troopKind <> $eQueen And $troopKind <> $eCastle And $troopKind <> $eLSpell Then
					If Not $remaining Then
						If NameOfTroop($troopKind) <> "Unknown" Then SetLog(GetLangText("msgIgnoring") & NameOfTroop($troopKind))
					EndIf
					$troopKind = -1
				EndIf
			Case 2
				; Goblins only
				If $troopKind <> $eGoblin And $troopKind <> $eKing And $troopKind <> $eQueen And $troopKind <> $eCastle And $troopKind <> $eLSpell Then
					If Not $remaining Then
						If NameOfTroop($troopKind) <> "Unknown" Then SetLog(GetLangText("msgIgnoring") & NameOfTroop($troopKind))
					EndIf
					$troopKind = -1
				EndIf
			Case 3
				; Barch
				If $troopKind <> $eBarbarian And $troopKind <> $eArcher And $troopKind <> $eKing And $troopKind <> $eQueen And $troopKind <> $eCastle And $troopKind <> $eLSpell Then
					If Not $remaining Then
						If NameOfTroop($troopKind) <> "Unknown" Then SetLog(GetLangText("msgIgnoring") & NameOfTroop($troopKind))
					EndIf
					$troopKind = -1
				EndIf
			Case 4
				; BAGG
				If $troopKind <> $eBarbarian And $troopKind <> $eArcher And $troopKind <> $eGiant And $troopKind <> $eGoblin And $troopKind <> $eKing And $troopKind <> $eQueen And $troopKind <> $eCastle And $troopKind <> $eLSpell Then
					If Not $remaining Then
						If NameOfTroop($troopKind) <> "Unknown" Then SetLog(GetLangText("msgIgnoring") & NameOfTroop($troopKind))
					EndIf
					$troopKind = -1
				EndIf
			Case 5
				; BAGiant
				If $troopKind <> $eBarbarian And $troopKind <> $eArcher And $troopKind <> $eGiant And $troopKind <> $eKing And $troopKind <> $eQueen And $troopKind <> $eCastle And $troopKind <> $eLSpell Then
					If Not $remaining Then
						If NameOfTroop($troopKind) <> "Unknown" Then SetLog(GetLangText("msgIgnoring") & NameOfTroop($troopKind))
					EndIf
					$troopKind = -1
				EndIf
			Case 6
				; BAGob
				If $troopKind <> $eBarbarian And $troopKind <> $eArcher And $troopKind <> $eGoblin And $troopKind <> $eKing And $troopKind <> $eQueen And $troopKind <> $eCastle And $troopKind <> $eLSpell Then
					If Not $remaining Then
						If NameOfTroop($troopKind) <> "Unknown" Then SetLog(GetLangText("msgIgnoring") & NameOfTroop($troopKind))
					EndIf
					$troopKind = -1
				EndIf
			Case 7
				; BAGGWB
				If $troopKind <> $eBarbarian And $troopKind <> $eArcher And $troopKind <> $eGiant And $troopKind <> $eGoblin And $troopKind <> $eWallbreaker And $troopKind <> $eKing And $troopKind <> $eQueen And $troopKind <> $eCastle And $troopKind <> $eLSpell Then
					If Not $remaining Then
						If NameOfTroop($troopKind) <> "Unknown" Then SetLog(GetLangText("msgIgnoring") & NameOfTroop($troopKind))
					EndIf
					$troopKind = -1
				EndIf
			Case 8
				For $x = 0 To 3
					Switch $x
						Case 0
							$BarrackControl = $cmbBarrack1
						Case 1
							$BarrackControl = $cmbBarrack2
						Case 2
							$BarrackControl = $cmbBarrack3
						Case 3
							$BarrackControl = $cmbBarrack4
					EndSwitch
					$troopKind = IdentifyTroopKind($i)
					If $troopKind = $eBarbarian And _GUICtrlComboBox_GetCurSel($BarrackControl) = 0 Then
						$atkTroops[$i][0] = $troopKind
						ExitLoop
					ElseIf $troopKind = $eArcher And _GUICtrlComboBox_GetCurSel($BarrackControl) = 1 Then
						$atkTroops[$i][0] = $troopKind
						ExitLoop
					ElseIf $troopKind = $eGiant And _GUICtrlComboBox_GetCurSel($BarrackControl) = 2 Then
						$atkTroops[$i][0] = $troopKind
						ExitLoop
					ElseIf $troopKind = $eGoblin And _GUICtrlComboBox_GetCurSel($BarrackControl) = 3 Then
						$atkTroops[$i][0] = $troopKind
						ExitLoop
					ElseIf $troopKind = $eWallbreaker And _GUICtrlComboBox_GetCurSel($BarrackControl) = 4 Then
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
						If Not $remaining Then
							If NameOfTroop($troopKind) <> "Unknown" Then SetLog(GetLangText("msgIgnoring") & NameOfTroop($troopKind))
						EndIf
						$troopKind = -1
					EndIf
				Next
		EndSwitch

		Local $useCastle = ($AttackMethod = 0) ? (IsChecked($chkDeadUseClanCastle) ? (True) : (False)) : (IsChecked($chkUseClanCastle) ? (True) : (False))
		Local $useKing = ($AttackMethod = 0) ? (IsChecked($chkDeadUseKing) ? (True) : (False)) : (IsChecked($chkUseKing) ? (True) : (False))
		Local $useQueen = ($AttackMethod = 0) ? (IsChecked($chkDeadUseQueen) ? (True) : (False)) : (IsChecked($chkUseQueen) ? (True) : (False))

		If Not $useCastle and $troopKind = $eCastle Then $troopKind = -1
		If Not $useKing and $troopKind = $eKing Then $troopKind = -1
		If Not $useQueen and $troopKind = $eQueen Then $troopKind = -1
		If $remaining and $troopKind = $eLSpell Then $troopKind = -1

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
EndFunc   ;==>Standard_PrepareAttack
