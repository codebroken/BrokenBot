; Improved attack algorithm, using Barbarians, Archers, Goblins, Giants and Wallbreakers as they are available
; Create by Fast French, edited by safar46

Func Wave_Sleep($type)
	Switch $type
		Case 0
			$delay = (_GUICtrlComboBox_GetCurSel($cmbUnitDelay) + 1) * 20 ;Random Gaussian is always positive, compensate for that
		Case 1
			$delay = (_GUICtrlComboBox_GetCurSel($cmbWaveDelay) + 1) * 200
	EndSwitch
	$delay = _Random_Gaussian($delay, $delay / 6)
	If $delay < 1 Then $delay = 1
	While TimerDiff($hWaveTimer) < $delay
		If _Sleep(1, False) Then Return True
	WEnd
	$hWaveTimer = TimerInit()
	Return False
EndFunc   ;==>Wave_Sleep

; Old mecanism, not used anymore
Func Standard_OldDropTroop($troup, $position, $nbperspot)
	SelectDropTroupe($troup) ;Select Troop
	If _Sleep(100) Then Return
	For $i = 0 To 4
		Click($position[$i][0], $position[$i][1], $nbperspot, 0, 1)
		If _Sleep(50) Then Return
	Next
EndFunc   ;==>Standard_OldDropTroop

; improved function, that avoids to only drop on 5 discret drop points :
Func Standard_DropOnEdge($troop, $edge, $number, $slotsPerEdge = 0, $edge2 = -1, $x = -1, $Center = 1)
	$BufferDist = _Random_Gaussian(20, 6)
	If $BufferDist < 2 Then $BufferDist = 2

	If $number = 0 Then Return
	SelectDropTroupe($troop) ;Select Troop
	If _Sleep(100) Then Return
	If $slotsPerEdge = 0 Or $number < $slotsPerEdge Then $slotsPerEdge = $number
	If $number = 1 Or $slotsPerEdge = 1 Then ; Drop on a random point per edge => centered on the middle
		$Clickx = Round(_Random_Gaussian(((($edge[4][0] - $edge[0][0]) / 2) + $edge[0][0]), (($edge[4][0] - $edge[0][0]) / 7)))
		$Clicky = Round((($edge[4][1] - $edge[0][1]) / ($edge[4][0] - $edge[0][0])) * ($Clickx - $edge[0][0])) + $edge[0][1]
		Click($Clickx, $Clicky, $number, 0, $Center, $BufferDist)
		If $edge2 <> -1 Then
			If Wave_Sleep(1) Then Return
			$Clickx = Round(_Random_Gaussian(((($edge2[4][0] - $edge2[0][0]) / 2) + $edge2[0][0]), (($edge2[4][0] - $edge2[0][0]) / 7)))
			$Clicky = Round((($edge2[4][1] - $edge2[0][1]) / ($edge2[4][0] - $edge2[0][0])) * ($Clickx - $edge2[0][0])) + $edge2[0][1]
			Click($Clickx, $Clicky, $number, 0, $Center, $BufferDist)
		EndIf
	ElseIf $slotsPerEdge = 2 Then ; Drop on 2 randomly spaced points per edge
		Local $half = Ceiling($number / 2)
		$Clickx = Round(_Random_Gaussian(((($edge[4][0] - $edge[0][0]) / 3) + $edge[0][0]), (($edge[4][0] - $edge[0][0]) / 10)))
		$Clicky = Round((($edge[4][1] - $edge[0][1]) / ($edge[4][0] - $edge[0][0])) * ($Clickx - $edge[0][0])) + $edge[0][1]
		Click($Clickx, $Clicky, $half, 0, $Center, $BufferDist)
		If GUICtrlRead($sldAcc) < 100 Then
			If Wave_Sleep(0) Then Return
		EndIf
		$Clickx = Round(_Random_Gaussian(((($edge[4][0] - $edge[0][0]) * 2 / 3) + $edge[0][0]), (($edge[4][0] - $edge[0][0]) / 10)))
		$Clicky = Round((($edge[4][1] - $edge[0][1]) / ($edge[4][0] - $edge[0][0])) * ($Clickx - $edge[0][0])) + $edge[0][1]
		Click($Clickx, $Clicky, $number - $half, 0, $Center, $BufferDist)
		If $edge2 <> -1 Then
			If Wave_Sleep(1) Then Return
			$Clickx = Round(_Random_Gaussian(((($edge2[4][0] - $edge2[0][0]) / 3) + $edge2[0][0]), (($edge2[4][0] - $edge2[0][0]) / 10)))
			$Clicky = Round((($edge2[4][1] - $edge2[0][1]) / ($edge2[4][0] - $edge2[0][0])) * ($Clickx - $edge2[0][0])) + $edge2[0][1]
			Click($Clickx, $Clicky, $half, 0, $Center, $BufferDist)
			If GUICtrlRead($sldAcc) < 100 Then
				If Wave_Sleep(0) Then Return
			EndIf
			$Clickx = Round(_Random_Gaussian(((($edge2[4][0] - $edge2[0][0]) * 2 / 3) + $edge2[0][0]), (($edge2[4][0] - $edge2[0][0]) / 10)))
			$Clicky = Round((($edge2[4][1] - $edge2[0][1]) / ($edge2[4][0] - $edge2[0][0])) * ($Clickx - $edge2[0][0])) + $edge2[0][1]
			Click($Clickx, $Clicky, $number - $half, 0, $Center, $BufferDist)
		EndIf
	Else
		If ($slotsPerEdge = $number) And ($slotsPerEdge > 10) Then
			$slotsPerEdge = Int($number / Random(1.8, 2.8))
			If $slotsPerEdge < 9 Then $slotsPerEdge = Random(9, 11, 1)
		EndIf
		Local $minX = $edge[0][0]
		Local $maxX = $edge[4][0]
		Local $minY = $edge[0][1]
		Local $maxY = $edge[4][1]
		If $edge2 <> -1 Then
			Local $minX2 = $edge2[0][0]
			Local $maxX2 = $edge2[4][0]
			Local $minY2 = $edge2[0][1]
			Local $maxY2 = $edge2[4][1]
		EndIf
		Local $nbTroopsGoneDec = 0
		Local $nbTroopsGoneRound = 0
		Local $nbTroopPerRound = $number / $slotsPerEdge
		For $i = 0 To $slotsPerEdge - 1
			$nbTroopsGoneDec += $nbTroopPerRound
			Local $posX = $minX + (($maxX - $minX) * $i) / ($slotsPerEdge - 1)
			Local $posY = $minY + (($maxY - $minY) * $i) / ($slotsPerEdge - 1)
			; Randomize the drop points a bit more
			$posX = Round(_Random_Gaussian($posX, 3))
			$posY = Round(_Random_Gaussian($posY, 3))
			Click($posX, $posY, Ceiling($nbTroopsGoneDec - $nbTroopsGoneRound), 0, $Center, $BufferDist)
			$nbTroopsGoneRound += Ceiling($nbTroopsGoneDec - $nbTroopsGoneRound)
			If GUICtrlRead($sldAcc) < 100 Then
				If Wave_Sleep(0) Then Return
			EndIf
		Next
		If $edge2 <> -1 Then
			If Wave_Sleep(1) Then Return
			Local $nbTroopsGoneDec = 0
			Local $nbTroopsGoneRound = 0
			Local $nbTroopPerRound = $number / $slotsPerEdge
			For $i = 0 To $slotsPerEdge - 1
				$nbTroopsGoneDec += $nbTroopPerRound
				Local $posX2 = $maxX2 - (($maxX2 - $minX2) * $i) / ($slotsPerEdge - 1)
				Local $posY2 = $maxY2 - (($maxY2 - $minY2) * $i) / ($slotsPerEdge - 1)
				; Randomize the drop points a bit more
				$posX2 = Round(_Random_Gaussian($posX2, 3))
				$posY2 = Round(_Random_Gaussian($posY2, 3))
				Click($posX2, $posY2, Ceiling($nbTroopsGoneDec - $nbTroopsGoneRound), 0, $Center, $BufferDist)
				$nbTroopsGoneRound += Ceiling($nbTroopsGoneDec - $nbTroopsGoneRound)
				If GUICtrlRead($sldAcc) < 100 Then
					If Wave_Sleep(0) Then Return
				EndIf
			Next
		EndIf
	EndIf
EndFunc   ;==>Standard_DropOnEdge

Func Standard_DropOnEdges($troop, $nbSides, $number, $slotsPerEdge = 0, $miniEdge = False)
	If $nbSides = 0 Or $number = 1 Then
		Standard_OldDropTroop($troop, $Edges[0], $number);
		Return
	EndIf
	If $nbSides < -1 Then Return
	Local $nbTroopsLeft = $number
	If Not $miniEdge Then
		If $nbSides = 4 Then
			For $i = 0 To $nbSides - 3
				Local $nbTroopsPerEdge = Round($nbTroopsLeft / ($nbSides - $i * 2))
				Standard_DropOnEdge($troop, $Edges[$i], $nbTroopsPerEdge, $slotsPerEdge, $Edges[$i + 2], $i)
				$nbTroopsLeft -= $nbTroopsPerEdge * 2
			Next
			Return
		EndIf
		For $i = 0 To $nbSides - 1
			If $nbSides = 1 Or ($nbSides = 3 And $i = 2) Then
				Local $nbTroopsPerEdge = Round($nbTroopsLeft / ($nbSides - $i))
				Standard_DropOnEdge($troop, $Edges[$i], $nbTroopsPerEdge, $slotsPerEdge)
				$nbTroopsLeft -= $nbTroopsPerEdge
			ElseIf ($nbSides = 2 And $i = 0) Or ($nbSides = 3 And $i <> 1) Then
				Local $nbTroopsPerEdge = Round($nbTroopsLeft / ($nbSides - $i * 2))
				Standard_DropOnEdge($troop, $Edges[$i + 3], $nbTroopsPerEdge, $slotsPerEdge, $Edges[$i + 1])
				$nbTroopsLeft -= $nbTroopsPerEdge * 2
			EndIf
		Next
	Else
		Switch $THquadrant
			Case 1
				Local $edgeA[5][2] = [[$FurthestTopLeft[0][0], $FurthestTopLeft[0][1]], [0, 0], [0, 0], [0, 0], [Round(($FurthestTopLeft[4][0] - $FurthestTopLeft[0][0]) / _Random_Gaussian(4.5, .25)) + $FurthestTopLeft[0][0], Round(($FurthestTopLeft[4][1] - $FurthestTopLeft[0][1]) / _Random_Gaussian(4.5, .25)) + $FurthestTopLeft[0][1]]]
				Local $edgeB[5][2] = [[$FurthestBottomLeft[0][0], $FurthestBottomLeft[0][1]], [0, 0], [0, 0], [0, 0], [Round(($FurthestBottomLeft[4][0] - $FurthestBottomLeft[0][0]) / _Random_Gaussian(4.5, .25)) + $FurthestBottomLeft[0][0], Round(($FurthestBottomLeft[4][1] - $FurthestBottomLeft[0][1]) / _Random_Gaussian(4.5, .25)) + $FurthestBottomLeft[0][1]]]
				$nbSides = 2
			Case 2
				$m = (537 - 238) / (535 - 128)
				$m2 = (9 - 314) / (430 - 28)
				$b = $THy - ($m * $THx)
				$b2 = 314 - ($m2 * 28)
				$CenterX = ($b - $b2) / ($m2 - $m)
				$LeftX = Round(_Random_Gaussian($CenterX - 20, 3))
				$RightX = Round(_Random_Gaussian($CenterX + 20, 3))
				If $LeftX < $FurthestTopLeft[0][0] Then $LeftX = $FurthestTopLeft[0][0]
				If $RightX > $FurthestTopLeft[4][0] Then $RightX = $FurthestTopLeft[4][0]
				$LeftY = Round($m2 * $LeftX + $b2)
				$RightY = Round($m2 * $RightX + $b2)
				Local $edgeA[5][2] = [[$LeftX, $LeftY], [0, 0], [0, 0], [0, 0], [$RightX, $RightY]]
				Local $edgeB = -1
				$nbSides = 1
			Case 3
				Local $edgeA[5][2] = [[$FurthestTopLeft[4][0], $FurthestTopLeft[4][1]], [0, 0], [0, 0], [0, 0], [$FurthestTopLeft[4][0] - Round(($FurthestTopLeft[4][0] - $FurthestTopLeft[0][0]) / _Random_Gaussian(4.5, .25)), $FurthestTopLeft[4][1] - Round(($FurthestTopLeft[4][1] - $FurthestTopLeft[0][1]) / _Random_Gaussian(4.5, .25))]]
				Local $edgeB[5][2] = [[$FurthestTopRight[0][0], $FurthestTopRight[0][1]], [0, 0], [0, 0], [0, 0], [Round(($FurthestTopRight[4][0] - $FurthestTopRight[0][0]) / _Random_Gaussian(4.5, .25)) + $FurthestTopRight[0][0], Round(($FurthestTopRight[4][1] - $FurthestTopRight[0][1]) / _Random_Gaussian(4.5, .25)) + $FurthestTopRight[0][1]]]
				$nbSides = 2
			Case 4
				$m = (85 - 388) / (527 - 130)
				$m2 = (612 - 314) / (440 - 28)
				$b = $THy - ($m * $THx)
				$b2 = 314 - ($m2 * 28)
				$CenterX = ($b - $b2) / ($m2 - $m)
				$LeftX = Round(_Random_Gaussian($CenterX - 20, 3))
				$RightX = Round(_Random_Gaussian($CenterX + 20, 3))
				If $LeftX < $FurthestBottomLeft[0][0] Then $LeftX = $FurthestBottomLeft[0][0]
				If $RightX > (.75 * ($FurthestBottomLeft[4][0] - $FurthestBottomLeft[0][0])) + $FurthestBottomLeft[0][0] Then $RightX = Round((.75 * ($FurthestBottomLeft[4][0] - $FurthestBottomLeft[0][0])) + $FurthestBottomLeft[0][0])
				$LeftY = Round($m2 * $LeftX + $b2)
				$RightY = Round($m2 * $RightX + $b2)
				Local $edgeA[5][2] = [[$LeftX, $LeftY], [0, 0], [0, 0], [0, 0], [$RightX, $RightY]]
				Local $edgeB = -1
				$nbSides = 1
			Case 6
				$m = (85 - 388) / (527 - 130)
				$m2 = (313 - 9) / (820 - 430)
				$b = $THy - ($m * $THx)
				$b2 = 9 - ($m2 * 430)
				$CenterX = ($b - $b2) / ($m2 - $m)
				$LeftX = Round(_Random_Gaussian($CenterX - 20, 3))
				$RightX = Round(_Random_Gaussian($CenterX + 20, 3))
				If $LeftX < $FurthestTopRight[0][0] Then $LeftX = $FurthestTopRight[0][0]
				If $RightX > $FurthestTopRight[4][0] Then $RightX = $FurthestTopRight[4][0]
				$LeftY = Round($m2 * $LeftX + $b2)
				$RightY = Round($m2 * $RightX + $b2)
				Local $edgeA[5][2] = [[$LeftX, $LeftY], [0, 0], [0, 0], [0, 0], [$RightX, $RightY]]
				Local $edgeB = -1
				$nbSides = 1
			Case 7
				Local $edgeA[5][2] = [[Round(($FurthestBottomRight[4][0] - $FurthestBottomRight[0][0]) / 3.5) + $FurthestBottomRight[0][0], Round(($FurthestBottomRight[4][1] - $FurthestBottomRight[0][1]) / 3.5) + $FurthestBottomRight[0][1]], [0, 0], [0, 0], [0, 0], [Round(($FurthestBottomRight[4][0] - $FurthestBottomRight[0][0]) / 4) + $FurthestBottomRight[0][0], Round(($FurthestBottomRight[4][1] - $FurthestBottomRight[0][1]) / 4) + $FurthestBottomRight[0][1]]]
				Local $edgeB[5][2] = [[$FurthestBottomLeft[4][0] - Round(($FurthestBottomLeft[4][0] - $FurthestBottomLeft[0][0]) / 3.5), $FurthestBottomLeft[4][1] - Round(($FurthestBottomLeft[4][1] - $FurthestBottomLeft[0][1]) / 3.5)], [0, 0], [0, 0], [0, 0], [$FurthestBottomLeft[4][0] - Round(($FurthestBottomLeft[4][0] - $FurthestBottomLeft[0][0]) / 4), $FurthestBottomLeft[4][1] - Round(($FurthestBottomLeft[4][1] - $FurthestBottomLeft[0][1]) / 4)]]
				$nbSides = 2
			Case 8
				$m = (537 - 238) / (535 - 128)
				$m2 = (9 - 314) / (430 - 28)
				If $m = $m2 Then $m2 = $m2 + 0.00000001
				$b = $THy - ($m * $THx)
				$b2 = 612 - ($m2 * 440)
				$CenterX = ($b - $b2) / ($m2 - $m)
				$LeftX = Round(_Random_Gaussian($CenterX - 20, 3))
				$RightX = Round(_Random_Gaussian($CenterX + 20, 3))
				If $LeftX < ((.25 * ($FurthestBottomRight[4][0] - $FurthestBottomRight[0][0])) + $FurthestBottomRight[0][0]) Then $LeftX = Round(((.25 * ($FurthestBottomRight[4][0] - $FurthestBottomRight[0][0])) + $FurthestBottomRight[0][0]))
				If $RightX > $FurthestBottomRight[4][0] Then $RightX = $FurthestBottomRight[4][0]
				$LeftY = Round($m2 * $LeftX + $b2)
				$RightY = Round($m2 * $RightX + $b2)
				Local $edgeA[5][2] = [[$LeftX, $LeftY], [0, 0], [0, 0], [0, 0], [$RightX, $RightY]]
				Local $edgeB = -1
				$nbSides = 1
			Case 9
				Local $edgeA[5][2] = [[$FurthestTopRight[4][0], $FurthestTopRight[4][1]], [0, 0], [0, 0], [0, 0], [$FurthestTopRight[4][0] - Round(($FurthestTopRight[4][0] - $FurthestTopRight[0][0]) / _Random_Gaussian(4.5, .25)), $FurthestTopRight[4][1] - Round(($FurthestTopRight[4][1] - $FurthestTopRight[0][1]) / _Random_Gaussian(4.5, .25))]]
				Local $edgeB[5][2] = [[$FurthestBottomRight[4][0], $FurthestBottomRight[4][1]], [0, 0], [0, 0], [0, 0], [$FurthestBottomRight[4][0] - Round(($FurthestBottomRight[4][0] - $FurthestBottomRight[0][0]) / _Random_Gaussian(4.5, .25)), $FurthestBottomRight[4][1] - Round(($FurthestBottomRight[4][1] - $FurthestBottomRight[0][1]) / _Random_Gaussian(4.5, .25))]]
				$nbSides = 2
			Case Else
				Return
		EndSwitch
		$edgeA[2][0] = Round(($edgeA[0][0] + $edgeA[4][0]) / 2)
		$edgeA[2][1] = Round(($edgeA[0][1] + $edgeA[4][1]) / 2)
		$edgeA[1][0] = Round(($edgeA[0][0] + $edgeA[2][0]) / 2)
		$edgeA[1][1] = Round(($edgeA[0][1] + $edgeA[2][1]) / 2)
		$edgeA[3][0] = Round(($edgeA[2][0] + $edgeA[4][0]) / 2)
		$edgeA[3][1] = Round(($edgeA[2][1] + $edgeA[4][1]) / 2)
		If $edgeB <> -1 Then
			$edgeB[2][0] = Round(($edgeB[0][0] + $edgeB[4][0]) / 2)
			$edgeB[2][1] = Round(($edgeB[0][1] + $edgeB[4][1]) / 2)
			$edgeB[1][0] = Round(($edgeB[0][0] + $edgeB[2][0]) / 2)
			$edgeB[1][1] = Round(($edgeB[0][1] + $edgeB[2][1]) / 2)
			$edgeB[3][0] = Round(($edgeB[2][0] + $edgeB[4][0]) / 2)
			$edgeB[3][1] = Round(($edgeB[2][1] + $edgeB[4][1]) / 2)
		EndIf
		If $nbSides = 1 Then
			Standard_DropOnEdge($troop, $edgeA, $nbTroopsLeft, $slotsPerEdge, -1, -1, $AimTH)
			$nbTroopsLeft = 0
		Else
			$nbTroopsPerEdge = Round($nbTroopsLeft / 2)
			Standard_DropOnEdge($troop, $edgeA, $nbTroopsPerEdge, $slotsPerEdge, $edgeB, -1, $AimTH)
		EndIf
	EndIf
EndFunc   ;==>Standard_DropOnEdges

Func Standard_LaunchTroop($troopKind, $nbSides, $waveNb, $maxWaveNb, $slotsPerEdge = 0, $miniEdge = False)
	Local $troop = -1
	Local $troopNb = 0
	Local $name = ""
	For $i = 0 To 8 ; identify the position of this kind of troop
		If $atkTroops[$i][0] = $troopKind Then
			$troop = $i
			$troopNb = Ceiling($atkTroops[$i][1] / $maxWaveNb)
			Local $plural = 0
			If $troopNb > 1 Then $plural = 1
			$name = NameOfTroop($troopKind, $plural)
		EndIf
	Next

	If ($troop = -1) Or ($troopNb = 0) Then
		Return False; nothing to do => skip this wave
	EndIf

	Local $waveName = "first"
	If $waveNb = 2 Then $waveName = "second"
	If $waveNb = 3 Then $waveName = "third"
	If $maxWaveNb = 1 Then $waveName = "only"
	If $waveNb = 0 Then $waveName = "last"
	SetLog(GetLangText("msgDropping") & $waveName & GetLangText("msgWaveOf") & $troopNb & " " & $name, $COLOR_BLUE)
	Standard_DropOnEdges($troop, $nbSides, $troopNb, $slotsPerEdge, $miniEdge)
	Return True
EndFunc   ;==>Standard_LaunchTroop

Func Standard_Attack($AttackMethod = 1)

	_CaptureRegion()
	$hAttackBitmap = _GDIPlus_BitmapCloneArea($hBitmap, 0, 0, 860, 720, _GDIPlus_ImageGetPixelFormat($hBitmap))
	$Buffer = _GDIPlus_ImageGetGraphicsContext($hAttackBitmap)
	If $DebugMode = 1 And $Hide = False Then ActivateOverlay()
	$BufferAvailable = True

	SeekEdges()

	$FasterExit = False

	If $AttackMethod = 2 Then
		; Nuke the DE
		SetLog(GetLangText("msgNuking"), $COLOR_BLUE)
		Standard_DropNukes()
		If _Sleep(4000) Then Return
		$FasterExit = True
	Else
		$King = -1
		$Queen = -1
		$CC = -1
		$Barb = -1
		$Arch = -1
		$Giant = -1
		$WB = -1
		$Gob = -1
		$Hog = -1
		$Minion = -1
		$Valk = -1
		$LSpell = -1
		$SpellQty = 0
		$KingWasHere = False
		$QueenWasHere = False
		For $i = 0 To 8
			If $atkTroops[$i][0] = $eBarbarian Then
				$Barb = $i
			ElseIf $atkTroops[$i][0] = $eArcher Then
				$Arch = $i
			ElseIf $atkTroops[$i][0] = $eGiant Then
				$Giant = $i
			ElseIf $atkTroops[$i][0] = $eWallbreaker Then
				$WB = $i
			ElseIf $atkTroops[$i][0] = $eGoblin Then
				$Gob = $i
			ElseIf $atkTroops[$i][0] = $eHog Then
				$Hog = $i
			ElseIf $atkTroops[$i][0] = $eMinion Then
				$Minion = $i
			ElseIf $atkTroops[$i][0] = $eValkyrie Then
				$Valk = $i
			ElseIf $atkTroops[$i][0] = $eCastle Then
				$CC = $i
			ElseIf $atkTroops[$i][0] = $eKing Then
				$King = $i
				$KingWasHere = True
			ElseIf $atkTroops[$i][0] = $eQueen Then
				$Queen = $i
				$QueenWasHere = True
			ElseIf $atkTroops[$i][0] = $eLSpell Then
				$LSpell = $i
				$SpellQty = $atkTroops[$i][1]
			EndIf
		Next
		$KingPowerCollector = False
		$QueenPowerCollector = False
		$KingUsedSnipe = False
		$QueenUsedSnipe = False
		$KingPowerSnipe = False
		$QueenPowerSnipe = False
		Local $CollectorDeployOrder[11] = [$Giant, $Hog, $Valk, $WB, $Barb, $Arch, $Gob, $Minion, $King, $Queen, $CC]
		Local $SnipeWaveMax = 6
		Local $SnipeWaveSizes[5] = [5, 5, 15, 15, 15]
		Local $SnipeWaves[6][11] = [[-1, -1, -1, -1, $Barb, $Arch, -1, -1, -1, -1, -1], _
				[-1, -1, -1, -1, $Barb, $Arch, -1, -1, -1, -1, -1], _
				[$Giant, -1, -1, $WB, $Barb, $Arch, -1, -1, -1, -1, -1], _
				[$Giant, $Hog, -1, $WB, $Barb, $Arch, -1, $Minion, -1, -1, -1], _
				[$Giant, $Hog, $Valk, $WB, $Barb, $Arch, -1, $Minion, -1, -1, -1], _
				[$Giant, $Hog, $Valk, $WB, $Barb, $Arch, $Gob, $Minion, $King, $Queen, $CC]]
		Local $SnipeDeployOrder[11] = [$Giant, $Hog, $Valk, $WB, $Barb, $Arch, $Gob, $Minion, $King, $Queen, $CC]

		Local $nbSides = 0
		Local $mixedMode = False
		Local $collectorMode = False
		Local $EarlyExit = False

		$attackTH = ($AttackMethod = 0) ? _GUICtrlComboBox_GetCurSel($cmbDeadAttackTH) : _GUICtrlComboBox_GetCurSel($cmbAttackTH)
		Local $OuterQuad
		$OuterQuad = False
		If $THquadrant >= 1 And $THquadrant <= 4 Then $OuterQuad = True
		If $THquadrant >= 6 And $THquadrant <= 9 Then $OuterQuad = True
		If $AttackMethod = 3 Then
			SetLog(GetLangText("msgSnipeMode"))
		ElseIf ($OuterQuad And $attackTH = 2) Then
			SetLog(GetLangText("msgAttackingTH"))
			$nbSides = -1
		Else
			If $AttackMethod = 0 Then
				Switch _GUICtrlComboBox_GetCurSel($cmbDeadDeploy)
					Case 0 ;Single sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
						SetLog(GetLangText("msgSingleSide"))
						$nbSides = 1
					Case 1 ;Two sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
						SetLog(GetLangText("msgTwoSides"))
						$nbSides = 2
					Case 2 ;Three sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
						SetLog(GetLangText("msgThreeSides"))
						$nbSides = 3
					Case 3 ;Four sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
						SetLog(GetLangText("msgAllSides"))
						$nbSides = 4
					Case 4
						SetLog(GetLangText("msgMixedMode"))
						$nbSides = 4
						$mixedMode = True
					Case 5
						SetLog(GetLangText("msgCollectorMode"))
						$collectorMode = True
					Case 6
						SetLog(GetLangText("msgCollectorMode"))
						SetLog(GetLangText("msgCollectorSave"))
						$collectorMode = True
						$EarlyExit = True
				EndSwitch
			Else
				Switch _GUICtrlComboBox_GetCurSel($cmbDeploy)
					Case 0 ;Single sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
						SetLog(GetLangText("msgSingleSide"))
						$nbSides = 1
					Case 1 ;Two sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
						SetLog(GetLangText("msgTwoSides"))
						$nbSides = 2
					Case 2 ;Three sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
						SetLog(GetLangText("msgThreeSides"))
						$nbSides = 3
					Case 3 ;Four sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
						SetLog(GetLangText("msgAllSides"))
						$nbSides = 4
					Case 4
						SetLog(GetLangText("msgMixedMode"))
						$nbSides = 4
						$mixedMode = True
					Case 5
						SetLog(GetLangText("msgCollectorMode"))
						$collectorMode = True
					Case 6
						SetLog(GetLangText("msgCollectorMode"))
						SetLog(GetLangText("msgCollectorSave"))
						$collectorMode = True
						$EarlyExit = True
				EndSwitch
			EndIf
			If ($OuterQuad And $attackTH = 1 And Not $collectorMode) Then SetLog(GetLangText("msgLimitedTH"))
		EndIf

		If $AttackMethod = 3 Then
			; Snipe mode
			; Make our curve
			Local $DropCurve[240][2]
			$AngleTrue = PolarCoord($THx, $THy, $BaseCenter[0], $BaseCenter[1])
;~ 			$AngleA = PolarCoord($THx - 16, $THy + 16, $BaseCenter[0], $BaseCenter[1])
;~ 			$AngleB = PolarCoord($THx + 16, $THy - 16, $BaseCenter[0], $BaseCenter[1])
;~ 			$AngleC = PolarCoord($THx + 16, $THy + 16, $BaseCenter[0], $BaseCenter[1])
;~ 			$AngleD = PolarCoord($THx - 16, $THy - 16, $BaseCenter[0], $BaseCenter[1])
;~ 			$DiffAB = SmallerAngleBetween($AngleA[1], $AngleB[1])
;~ 			$DiffAC = SmallerAngleBetween($AngleA[1], $AngleC[1])
;~ 			$DiffAD = SmallerAngleBetween($AngleA[1], $AngleD[1])
;~ 			$DiffBC = SmallerAngleBetween($AngleB[1], $AngleC[1])
;~ 			$DiffBD = SmallerAngleBetween($AngleB[1], $AngleD[1])
;~ 			$DiffCD = SmallerAngleBetween($AngleC[1], $AngleD[1])
;~ 			$BiggestAngle = 0
;~ 			If $DiffAB > $BiggestAngle Then $BiggestAngle = $DiffAB
;~ 			If $DiffAC > $BiggestAngle Then $BiggestAngle = $DiffAC
;~ 			If $DiffAD > $BiggestAngle Then $BiggestAngle = $DiffAD
;~ 			If $DiffBC > $BiggestAngle Then $BiggestAngle = $DiffBC
;~ 			If $DiffBD > $BiggestAngle Then $BiggestAngle = $DiffBD
;~ 			If $DiffCD > $BiggestAngle Then $BiggestAngle = $DiffCD
;~ 			$curveLimits = $BiggestAngle
			$curveLimits = _Random_Gaussian(0.5236, 0.12)
			$direction = ((Random(0, 1, 1) - .5) * 2)
			$steppingangle = $AngleTrue[1] - (($curveLimits / 2) * $direction)
			; Make the curve of points
			For $step = 0 To 239
				$DeltaPos = CartCoord(860, $steppingangle)
				$DropCurve[$step][0] = $THx + $DeltaPos[0]
				$DropCurve[$step][1] = $THy + $DeltaPos[1]
				$steppingangle = $steppingangle + (($curveLimits / 240) * $direction)
			Next
			For $step = 0 To 239
				FixDropCurvePos($DropCurve, $step, $THx, $THy)
			Next
			For $step = 0 To 238
				OverlayLine($DropCurve[$step][0], $DropCurve[$step][1], $DropCurve[$step + 1][0], $DropCurve[$step + 1][1], 0xFF0000FF, 2)
			Next
			OverlayLine($DropCurve[0][0], $DropCurve[0][1], $THx, $THy, 0xFF0000FF, 2)
			OverlayLine($DropCurve[239][0], $DropCurve[239][1], $THx, $THy, 0xFF0000FF, 2)

			; Assign waves of troops
			Local $TroopBins[$SnipeWaveMax][9]
			For $Waves = 0 To $SnipeWaveMax - 1
				For $troop = 0 To 8
					$TroopBins[$Waves][$troop] = 0
				Next
				If $Waves < ($SnipeWaveMax - 1) Then
					$TroopsAdded = 0
					$TroopsLeft = True
					While ($TroopsAdded < $SnipeWaveSizes[$Waves]) And $TroopsLeft
						For $WaveTroop = 0 to 10
							If $SnipeWaves[$Waves][$WaveTroop] > -1 Then
								If $atkTroops[$SnipeWaves[$Waves][$WaveTroop]][1] > 0 Then
									$TroopBins[$Waves][$SnipeWaves[$Waves][$WaveTroop]] += 1
									$atkTroops[$SnipeWaves[$Waves][$WaveTroop]][1] -= 1
									$TroopsAdded += 1
									If $TroopsAdded = $SnipeWaveSizes[$Waves] Then ExitLoop
								EndIf
							EndIf
						Next
						For $NumCheck = 0 to 8
							If $atkTroops[$NumCheck][1] = 1 Then $TroopsLeft = True
						Next
					WEnd
				Else
					For $WaveTroop = 0 to 10
						If $SnipeWaves[$Waves][$WaveTroop] > -1 Then
							If $atkTroops[$SnipeWaves[$Waves][$WaveTroop]][1] > 0 Then
								$TroopBins[$Waves][$SnipeWaves[$Waves][$WaveTroop]] += $atkTroops[$SnipeWaves[$Waves][$WaveTroop]][1]
								$atkTroops[$SnipeWaves[$Waves][$WaveTroop]][1] = 0
							EndIf
						EndIf
					Next
				EndIf
			Next

			$KingUsedSnipe = False
			$QueenUsedSnipe = False
			$AllDone = False
			$Wave = 0
			While Not $AllDone
				; Deploy next wave of troops
				Do
					$AllGone = True
					For $SnipeTroop In $SnipeDeployOrder
						If $SnipeTroop > -1 Then
							If $TroopBins[$Wave][$SnipeTroop] > 0 Then
								Switch $SnipeTroop
									Case $King
										$hHeroTimer = TimerInit()
										$KingUsedSnipe = True
									Case $Queen
										$hHeroTimer = TimerInit()
										$QueenUsedSnipe = True
								EndSwitch

								If Wave_Sleep(1) Then Return
								SelectDropTroupe($SnipeTroop)

								_CaptureRegion()
								If _ColorCheck(_GetPixelColor(714, 538), Hex(0xC0C8C0, 6), 30) Then ExitLoop(3)

								; Random wave distance
								$BufferDist = _Random_Gaussian(20, 6)
								If $BufferDist < 2 Then $BufferDist = 2

								If $TroopBins[$Wave][$SnipeTroop] = 1 Then
									; Only a single unit, drop in middle
									$Clickx = Round(_Random_Gaussian($DropCurve[119][0], 3))
									$Clicky = Round(_Random_Gaussian($DropCurve[119][1], 3))
									RedLineDeploy($Clickx, $Clicky, 1, 0, $AimPoint, $BufferDist, $THx, $THy)
									$TroopBins[$Wave][$SnipeTroop] -= 1
								ElseIf $TroopBins[$Wave][$SnipeTroop] = 2 Then
									; Drop 2 units
									$Clickx = Round(_Random_Gaussian($DropCurve[89][0], 3))
									$Clicky = Round(_Random_Gaussian($DropCurve[89][1], 3))
									RedLineDeploy($Clickx, $Clicky, 1, 0, $AimPoint, $BufferDist, $THx, $THy)
									If Wave_Sleep(0) Then Return
									$Clickx = Round(_Random_Gaussian($DropCurve[149][0], 3))
									$Clicky = Round(_Random_Gaussian($DropCurve[149][1], 3))
									RedLineDeploy($Clickx, $Clicky, 1, 0, $AimPoint, $BufferDist, $THx, $THy)
									$TroopBins[$Wave][$SnipeTroop] -= 2
								Else
									; Many troops so spread out, deploy in waves
									$WaveMax = 5
									$WaveSize = $TroopBins[$Wave][$SnipeTroop]
									If $WaveSize > $WaveMax Then $WaveSize = $WaveMax
									For $TroopCount = 1 To $WaveSize
										_CaptureRegion()
										If _ColorCheck(_GetPixelColor(714, 538), Hex(0xC0C8C0, 6), 30) Then ExitLoop(4)
										$curvepoint = Floor((($TroopCount - 1) / ($WaveSize - 1)) * 239)
										$Clickx = Round(_Random_Gaussian($DropCurve[$curvepoint][0], 3))
										$Clicky = Round(_Random_Gaussian($DropCurve[$curvepoint][1], 3))
										RedLineDeploy($Clickx, $Clicky, 1, 0, $AimPoint, $BufferDist, $THx, $THy)
										If Wave_Sleep(0) Then Return
									Next
									$TroopBins[$Wave][$SnipeTroop] -= $WaveSize
									If $TroopBins[$Wave][$SnipeTroop] > 0 Then $AllGone = False
								EndIf
							EndIf
						EndIf

						; All this looping around takes a while, so check for hero activation
						If $KingUsedSnipe And Not $KingPowerSnipe And TimerDiff($hHeroTimer) > 3000 Then
							If GUICtrlRead($txtKingSkill) = 0 Then
								_CaptureRegion()
								If (checkHealth($King) Or (TimerDiff($hHeroTimer) / 1000) > 60) Then
									SetLog(GetLangText("msgActivateKing"), $COLOR_AQUA)
									SelectDropTroupe($King)
									$KingPowerSnipe = True
								EndIf
							Else
								If ((TimerDiff($hHeroTimer) / 1000) > Number(GUICtrlRead($txtKingSkill))) Then
									SetLog(GetLangText("msgActivateKing"), $COLOR_BLUE)
									SelectDropTroupe($King)
									$KingPowerSnipe = True
								EndIf
							EndIf
						EndIf
						If $QueenUsedSnipe And Not $QueenPowerSnipe And TimerDiff($hHeroTimer) > 3000 Then
							If GUICtrlRead($txtQueenSkill) = 0 Then
								_CaptureRegion()
								If (checkHealth($Queen) Or (TimerDiff($hHeroTimer) / 1000) > 60) Then
									SetLog(GetLangText("msgActivateQueen"), $COLOR_AQUA)
									SelectDropTroupe($Queen)
									$QueenPowerSnipe = True
								EndIf
							Else
								If ((TimerDiff($hHeroTimer) / 1000) > Number(GUICtrlRead($txtQueenSkill))) Then
									SetLog(GetLangText("msgActivateQueen"), $COLOR_BLUE)
									SelectDropTroupe($Queen)
									$QueenPowerSnipe = True
								EndIf
							EndIf
						EndIf
					Next
				Until $AllGone

				; Wait until income stopped, 45 seconds have passed, or we have a star
				SetLog(GetLangText("msgSnipeWaveWait"))
				$incomecheck = 0
				$incomestopped = False
				$WaveTimer = TimerInit()
				Do
					If $incomecheck = 0 Then $origresources = GetResources(2)
					If _Sleep(100) Then Return
					If $KingUsedSnipe And Not $KingPowerSnipe And TimerDiff($hHeroTimer) > 3000 Then
						If GUICtrlRead($txtKingSkill) = 0 Then
							_CaptureRegion()
							If (checkHealth($King) Or (TimerDiff($hHeroTimer) / 1000) > 60) Then
								SetLog(GetLangText("msgActivateKing"), $COLOR_AQUA)
								SelectDropTroupe($King)
								$KingPowerSnipe = True
							EndIf
						Else
							If ((TimerDiff($hHeroTimer) / 1000) > Number(GUICtrlRead($txtKingSkill))) Then
								SetLog(GetLangText("msgActivateKing"), $COLOR_BLUE)
								SelectDropTroupe($King)
								$KingPowerSnipe = True
							EndIf
						EndIf
					EndIf
					If $QueenUsedSnipe And Not $QueenPowerSnipe And TimerDiff($hHeroTimer) > 3000 Then
						If GUICtrlRead($txtQueenSkill) = 0 Then
							_CaptureRegion()
							If (checkHealth($Queen) Or (TimerDiff($hHeroTimer) / 1000) > 60) Then
								SetLog(GetLangText("msgActivateQueen"), $COLOR_AQUA)
								SelectDropTroupe($Queen)
								$QueenPowerSnipe = True
							EndIf
						Else
							If ((TimerDiff($hHeroTimer) / 1000) > Number(GUICtrlRead($txtQueenSkill))) Then
								SetLog(GetLangText("msgActivateQueen"), $COLOR_BLUE)
								SelectDropTroupe($Queen)
								$QueenPowerSnipe = True
							EndIf
						EndIf
					EndIf
					$incomecheck += 1
					If $incomecheck = 25 Then
						$incomecheck = 0
						$compresources = GetResources(2)
						If $origresources[2] = $compresources[2] And $origresources[3] = $compresources[3] Then $incomestopped = True
					EndIf
					_CaptureRegion()
					If _ColorCheck(_GetPixelColor(714, 538), Hex(0xC0C8C0, 6), 30) Then $AllDone = True
				Until $incomestopped Or (TimerDiff($WaveTimer) > 45000) Or $AllDone

				$Wave += 1
				If $Wave = $SnipeWaveMax Then $AllDone = True
			WEnd
			SetLog(GetLangText("msgSnipeAttackDone"))
		ElseIf $collectorMode Then
			; Collect red line data even if it is turned off

			$RedLineWasOff = False
			If GUICtrlRead($sldAcc) = 100 Then
				$RedLineWasOff = True
				GUICtrlSetData($sldAcc, 90)
				SeekEdges()
			EndIf

			; Find all the collectors
			SetLog(GetLangText("msgFindColl"))
			_CaptureRegion(0, 0, 860, 720, False, True)
			Local $AllCollectors[18][7]
			; 0 = type
			; 1 = X
			; 2 = Y
			; 3 = Angle
			; 4 = Deployed
			; 5 = Still standing
			; 6 = Deploy Timer
			Local $CollectorCount = 0
			$hDll = DllOpen(@ScriptDir & "\BrokenBot.org\BrokenBot32.dll")
			For $collector = 14 To 16
				$res = Null
				$res = ""
				$expRet = ""
				$hCheckHBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap)
				$max = ($collector = 16) ? (3) : (7)
				$res = DllCall($hDll, "str", "BrokenBotMatchBuilding", "ptr", $hCheckHBitmap, "int", $collector, "int", 3, "int", $max, "int", 1, "int", (IsChecked($chkSpeedBoost) ? (1) : (0)))
				If IsArray($res) Then
					If $res[0] = -2 Then
						SetLog(GetLangText("msgLicense"), $COLOR_RED)
					ElseIf $res[0] <> -1 And StringLen($res[0]) > 2 Then
						$expRet = StringSplit($res[0], "|", 2)
						If $DebugMode = 1 Then SetLog($expRet[0] & " " & (($collector = 14) ? (GetLangText("msgColGM")) : (($collector = 15) ? (GetLangText("msgColElix")) : (GetLangText("msgColDE")))))
						$i = 0
						While $i < $expRet[0]
							If ($i * 6 + 2) <= UBound($expRet) Then
								$AllCollectors[$CollectorCount][0] = $collector
								$AllCollectors[$CollectorCount][1] = $expRet[$i * 6 + 1]
								$AllCollectors[$CollectorCount][2] = $expRet[$i * 6 + 2]
								$AllCollectors[$CollectorCount][4] = False
								$AllCollectors[$CollectorCount][5] = True
								$AllCollectors[$CollectorCount][6] = -1
								$CollectorCount += 1
								If $DebugMode = 1 Then SetLog((($collector = 14) ? (GetLangText("msgColGM")) : (($collector = 15) ? (GetLangText("msgColElix")) : (GetLangText("msgColDE")))) & " (" & $expRet[$i * 6 + 1] & ", " & $expRet[$i * 6 + 2] & ")")
							EndIf
							$i += 1
						WEnd
					EndIf
				EndIf
			Next
			_WinAPI_DeleteObject($hCheckHBitmap)
			DllClose($hDll)
			; Find a good location to drop troops at
			; Function will reduce $CollectorCount for those that are deemed too far away to attempt attacking
			$OutsideCollector = 125
			If $CollectorCount > 0 Then
				SetLog(GetLangText("msgFoundCol") & $CollectorCount)
				SetLog(GetLangText("msgFindPos"))
				Standard_RemoveInsideCollectors($CollectorCount, $AllCollectors, $OutsideCollector)
			EndIf

			If $CollectorCount = 0 Then
				; Finding collectors failed
				; Fall back to attacking on 4 sides
				SetLog(GetLangText("msgFindColFailed"))
				If ($OuterQuad And $attackTH = 1) Then SetLog(GetLangText("msgLimitedTH"))
				$collectorMode = False
				$nbSides = 4
			Else
				SetLog(GetLangText("msgRemainCol") & $CollectorCount)
				; Randomly spread out troops to each collector
				Local $TroopBins[$CollectorCount][9]
				For $collector = 0 To $CollectorCount - 1
					OverlayCircle($AllCollectors[$collector][1], $AllCollectors[$collector][2], 20, 0xFF00FF00, 3)
					If $DebugMode = 1 Then SetLog((($AllCollectors[$collector][0] = 14) ? (GetLangText("msgColGM")) : (($AllCollectors[$collector][0] = 15) ? (GetLangText("msgColElix")) : (GetLangText("msgColDE")))) & " (" & $AllCollectors[$collector][1] & ", " & $AllCollectors[$collector][2] & ")")
					For $troop = 0 To 8
						$TroopBins[$collector][$troop] = 0
					Next
				Next
				For $troop = 0 To 8
					For $drop = 1 To $atkTroops[$troop][1]
						$TroopBins[Random(0, $CollectorCount - 1, 1)][$troop] += 1
					Next
				Next

				; Sort collectors
				For $collector = 0 To $CollectorCount - 1
					$Coord = PolarCoord($AllCollectors[$collector][1], $AllCollectors[$collector][2], $BaseCenter[0], $BaseCenter[1])
					$AllCollectors[$collector][3] = $Coord[1]
				Next
				_ArraySort($AllCollectors, Random(0, 1, 1), 0, $CollectorCount - 1, 3)

				; Drop at each collector in sequence
				$hHeroTimer = ""
				$collector = Random(1, $CollectorCount, 1) - 1
				$firstcollector = -1
				Local $DropCurve[240][2]
				$ExitOkay = False
				$KingUsedCol = False
				$QueenUsedCol = False
				Do
					If $firstcollector = -1 Then
						$GoodCollector = True
						$firstcollector = $collector
					Else
						If $EarlyExit Then
							$GoodCollector = True
							; If any collectors near this have been deployed recently then skip this one
							If $AllCollectors[$collector][4] Or Not $AllCollectors[$collector][5] Then
								$GoodCollector = False
							Else
								For $check = 0 To $CollectorCount - 1
									If $AllCollectors[$check][4] Then
										$DeltaAngle = Max($AllCollectors[$check][3], $AllCollectors[$collector][3]) - Min($AllCollectors[$check][3], $AllCollectors[$collector][3])
										If $DeltaAngle > $pi Then $DeltaAngle = (2 * $pi) - $DeltaAngle
										If $DeltaAngle < ($pi / 6) And TimerDiff($AllCollectors[$check][6]) < 15000 Then $GoodCollector = False
									EndIf
								Next
							EndIf
						EndIf
					EndIf

					If Not $EarlyExit Or $GoodCollector Then
						; Create a curve to drop along, then we'll have our redline code do the work of getting a good drop point
						; How big will curve be?
						$curveLimits = _Random_Gaussian(0.5236, 0.12)
						$direction = ((Random(0, 1, 1) - .5) * 2)
						$steppingangle = $AllCollectors[$collector][3] - (($curveLimits / 2) * $direction)
						; Make the curve of points
						For $step = 0 To 239
							$DeltaPos = CartCoord(860, $steppingangle)
							$DropCurve[$step][0] = $AllCollectors[$collector][1] + $DeltaPos[0]
							$DropCurve[$step][1] = $AllCollectors[$collector][2] + $DeltaPos[1]
							$steppingangle = $steppingangle + (($curveLimits / 240) * $direction)
						Next
						If $OverlayVisible Then
							For $step = 0 To 239
								FixDropCurvePos($DropCurve, $step, $AllCollectors[$collector][1], $AllCollectors[$collector][2])
							Next
							For $step = 0 To 238
								OverlayLine($DropCurve[$step][0], $DropCurve[$step][1], $DropCurve[$step + 1][0], $DropCurve[$step + 1][1], 0xFF0000FF, 2)
							Next
							OverlayLine($DropCurve[0][0], $DropCurve[0][1], $AllCollectors[$collector][1], $AllCollectors[$collector][2], 0xFF0000FF, 2)
							OverlayLine($DropCurve[239][0], $DropCurve[239][1], $AllCollectors[$collector][1], $AllCollectors[$collector][2], 0xFF0000FF, 2)
						EndIf
						OverlayCircle($AllCollectors[$collector][1], $AllCollectors[$collector][2], 20, 0xFFFFFF99, 3)

						Do
							$AllGone = True
							For $ColTroop In $CollectorDeployOrder
								If $ColTroop > -1 Then
									If $TroopBins[$collector][$ColTroop] > 0 Then
										Switch $ColTroop
											Case $King
												Local $useKing = ($AttackMethod = 0) ? (IsChecked($chkDeadUseKing) ? (1) : (0)) : (IsChecked($chkUseKing) ? (1) : (0))
												If $useKing = 1 Then
													$hHeroTimer = TimerInit()
													$KingUsedCol = True
												Else
													ContinueLoop
												EndIf
											Case $Queen
												Local $useQueen = ($AttackMethod = 0) ? (IsChecked($chkDeadUseQueen) ? (1) : (0)) : (IsChecked($chkUseQueen) ? (1) : (0))
												If $useQueen = 1 Then
													$hHeroTimer = TimerInit()
													$QueenUsedCol = True
												Else
													ContinueLoop
												EndIf
											Case $CC
												Local $useCastle = ($AttackMethod = 0) ? (IsChecked($chkDeadUseClanCastle) ? (1) : (0)) : (IsChecked($chkUseClanCastle) ? (1) : (0))
												If $useCastle = 0 Then ContinueLoop
										EndSwitch

										If Wave_Sleep(1) Then Return
										SelectDropTroupe($ColTroop)

										; Random wave distance
										$BufferDist = _Random_Gaussian(20, 6)
										If $BufferDist < 2 Then $BufferDist = 2

										If $TroopBins[$collector][$ColTroop] = 1 Then
											; Only a single unit, drop in middle
											FixDropCurvePos($DropCurve, 119, $AllCollectors[$collector][1], $AllCollectors[$collector][2])
											$Clickx = Round(_Random_Gaussian($DropCurve[119][0], 3))
											$Clicky = Round(_Random_Gaussian($DropCurve[119][1], 3))
											RedLineDeploy($Clickx, $Clicky, 1, 0, $AimPoint, $BufferDist, $AllCollectors[$collector][1], $AllCollectors[$collector][2])
											$TroopBins[$collector][$ColTroop] -= 1
										ElseIf $TroopBins[$collector][$ColTroop] = 2 Then
											; Drop 2 units
											FixDropCurvePos($DropCurve, 89, $AllCollectors[$collector][1], $AllCollectors[$collector][2])
											FixDropCurvePos($DropCurve, 149, $AllCollectors[$collector][1], $AllCollectors[$collector][2])
											$Clickx = Round(_Random_Gaussian($DropCurve[89][0], 3))
											$Clicky = Round(_Random_Gaussian($DropCurve[89][1], 3))
											RedLineDeploy($Clickx, $Clicky, 1, 0, $AimPoint, $BufferDist, $AllCollectors[$collector][1], $AllCollectors[$collector][2])
											If Wave_Sleep(0) Then Return
											$Clickx = Round(_Random_Gaussian($DropCurve[149][0], 3))
											$Clicky = Round(_Random_Gaussian($DropCurve[149][1], 3))
											RedLineDeploy($Clickx, $Clicky, 1, 0, $AimPoint, $BufferDist, $AllCollectors[$collector][1], $AllCollectors[$collector][2])
											$TroopBins[$collector][$ColTroop] -= 2
										Else
											; Many troops so spread out, deploy in waves
											$WaveMax = 5
											$WaveSize = $TroopBins[$collector][$ColTroop]
											If $WaveSize > $WaveMax Then $WaveSize = $WaveMax
											For $TroopCount = 1 To $WaveSize
												$curvepoint = Floor((($TroopCount - 1) / ($WaveSize - 1)) * 239)
												FixDropCurvePos($DropCurve, $curvepoint, $AllCollectors[$collector][1], $AllCollectors[$collector][2])
												$Clickx = Round(_Random_Gaussian($DropCurve[$curvepoint][0], 3))
												$Clicky = Round(_Random_Gaussian($DropCurve[$curvepoint][1], 3))
												RedLineDeploy($Clickx, $Clicky, 1, 0, $AimPoint, $BufferDist, $AllCollectors[$collector][1], $AllCollectors[$collector][2])
												If Wave_Sleep(0) Then Return
											Next
											$TroopBins[$collector][$ColTroop] -= $WaveSize
											If $TroopBins[$collector][$ColTroop] > 0 Then $AllGone = False
										EndIf
									EndIf
								EndIf

								; All this looping around takes a while, so check for hero activation
								If $KingUsedCol And Not $KingPowerCollector And TimerDiff($hHeroTimer) > 3000 Then
									If GUICtrlRead($txtKingSkill) = 0 Then
										_CaptureRegion()
										If (checkHealth($King) Or (TimerDiff($hHeroTimer) / 1000) > 60) Then
											SetLog(GetLangText("msgActivateKing"), $COLOR_AQUA)
											SelectDropTroupe($King)
											$KingPowerCollector = True
										EndIf
									Else
										If ((TimerDiff($hHeroTimer) / 1000) > Number(GUICtrlRead($txtKingSkill))) Then
											SetLog(GetLangText("msgActivateKing"), $COLOR_BLUE)
											SelectDropTroupe($King)
											$KingPowerCollector = True
										EndIf
									EndIf
								EndIf
								If $QueenUsedCol And Not $QueenPowerCollector And TimerDiff($hHeroTimer) > 3000 Then
									If GUICtrlRead($txtQueenSkill) = 0 Then
										_CaptureRegion()
										If (checkHealth($Queen) Or (TimerDiff($hHeroTimer) / 1000) > 60) Then
											SetLog(GetLangText("msgActivateQueen"), $COLOR_AQUA)
											SelectDropTroupe($Queen)
											$QueenPowerCollector = True
										EndIf
									Else
										If ((TimerDiff($hHeroTimer) / 1000) > Number(GUICtrlRead($txtQueenSkill))) Then
											SetLog(GetLangText("msgActivateQueen"), $COLOR_BLUE)
											SelectDropTroupe($Queen)
											$QueenPowerCollector = True
										EndIf
									EndIf
								EndIf
							Next
						Until $AllGone
						$AllCollectors[$collector][4] = True
						$AllCollectors[$collector][6] = TimerInit()
					EndIf
					$collector += 1
					If $collector = $CollectorCount Then $collector = 0
					If $collector = $firstcollector Then $ExitOkay = True
					If $EarlyExit And $ExitOkay Then
						; Even if we haven't deployed troops there yet, if the collector is gone then skip it

						; First wait until income stops
						SetLog(GetLangText("msgRoundDoneIncomeWait"))
						$incomecheck = 0
						$incomestopped = False
						Do
							If $incomecheck = 0 Then $origresources = GetResources(2)
							If _Sleep(100) Then Return
							; All this looping around takes a while, so check for hero activation
							If $KingUsedCol And Not $KingPowerCollector And TimerDiff($hHeroTimer) > 3000 Then
								If GUICtrlRead($txtKingSkill) = 0 Then
									_CaptureRegion()
									If (checkHealth($King) Or (TimerDiff($hHeroTimer) / 1000) > 60) Then
										SetLog(GetLangText("msgActivateKing"), $COLOR_AQUA)
										SelectDropTroupe($King)
										$KingPowerCollector = True
									EndIf
								Else
									If ((TimerDiff($hHeroTimer) / 1000) > Number(GUICtrlRead($txtKingSkill))) Then
										SetLog(GetLangText("msgActivateKing"), $COLOR_BLUE)
										SelectDropTroupe($King)
										$KingPowerCollector = True
									EndIf
								EndIf
							EndIf
							If $QueenUsedCol And Not $QueenPowerCollector And TimerDiff($hHeroTimer) > 3000 Then
								If GUICtrlRead($txtQueenSkill) = 0 Then
									_CaptureRegion()
									If (checkHealth($Queen) Or (TimerDiff($hHeroTimer) / 1000) > 60) Then
										SetLog(GetLangText("msgActivateQueen"), $COLOR_AQUA)
										SelectDropTroupe($Queen)
										$QueenPowerCollector = True
									EndIf
								Else
									If ((TimerDiff($hHeroTimer) / 1000) > Number(GUICtrlRead($txtQueenSkill))) Then
										SetLog(GetLangText("msgActivateQueen"), $COLOR_BLUE)
										SelectDropTroupe($Queen)
										$QueenPowerCollector = True
									EndIf
								EndIf
							EndIf
							$incomecheck += 1
							If $incomecheck = 25 Then
								$incomecheck = 0
								$compresources = GetResources(2)
								If $origresources[2] = $compresources[2] And $origresources[3] = $compresources[3] And $origresources[4] = $compresources[4] Then $incomestopped = True
							EndIf
						Until $incomestopped

						For $check = 0 To $CollectorCount - 1
							$AllCollectors[$check][5] = False
						Next
						SetLog(GetLangText("msgRecheckCollectors"))
						_CaptureRegion(0, 0, 860, 720, False, True)
						$hDll = DllOpen(@ScriptDir & "\BrokenBot.org\BrokenBot32.dll")
						For $recheck = 14 To 16
							$res = Null
							$res = ""
							$expRet = ""
							$hCheckHBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap)
							$max = ($recheck = 16) ? (3) : (7)
							$res = DllCall($hDll, "str", "BrokenBotMatchBuilding", "ptr", $hCheckHBitmap, "int", $recheck, "int", 3, "int", $max, "int", 1, "int", (IsChecked($chkSpeedBoost) ? (1) : (0)))
							If IsArray($res) Then
								If $res[0] = -2 Then
									SetLog(GetLangText("msgLicense"), $COLOR_RED)
								ElseIf $res[0] <> -1 And StringLen($res[0]) > 2 Then
									$expRet = StringSplit($res[0], "|", 2)
									If $DebugMode = 1 Then SetLog($expRet[0] & " " & (($recheck = 14) ? (GetLangText("msgColGM")) : (($recheck = 15) ? (GetLangText("msgColElix")) : (GetLangText("msgColDE")))))
									$i = 0
									While $i < $expRet[0]
										If ($i * 6 + 2) <= UBound($expRet) Then
											For $check = 0 To $CollectorCount - 1
												If Abs($AllCollectors[$check][1] - $expRet[$i * 6 + 1]) < 5 And Abs($AllCollectors[$check][2] - $expRet[$i * 6 + 2]) < 5 Then $AllCollectors[$check][5] = True
											Next
											If $DebugMode = 1 Then SetLog((($recheck = 14) ? (GetLangText("msgColGM")) : (($recheck = 15) ? (GetLangText("msgColElix")) : (GetLangText("msgColDE")))) & " (" & $expRet[$i * 6 + 1] & ", " & $expRet[$i * 6 + 2] & ")")
										EndIf
										$i += 1
									WEnd
								EndIf
							EndIf
							; All this looping around takes a while, so check for hero activation
							If $KingUsedCol And Not $KingPowerCollector And TimerDiff($hHeroTimer) > 3000 Then
								If GUICtrlRead($txtKingSkill) = 0 Then
									_CaptureRegion()
									If (checkHealth($King) Or (TimerDiff($hHeroTimer) / 1000) > 60) Then
										SetLog(GetLangText("msgActivateKing"), $COLOR_AQUA)
										SelectDropTroupe($King)
										$KingPowerCollector = True
									EndIf
								Else
									If ((TimerDiff($hHeroTimer) / 1000) > Number(GUICtrlRead($txtKingSkill))) Then
										SetLog(GetLangText("msgActivateKing"), $COLOR_BLUE)
										SelectDropTroupe($King)
										$KingPowerCollector = True
									EndIf
								EndIf
							EndIf
							If $QueenUsedCol And Not $QueenPowerCollector And TimerDiff($hHeroTimer) > 3000 Then
								If GUICtrlRead($txtQueenSkill) = 0 Then
									_CaptureRegion()
									If (checkHealth($Queen) Or (TimerDiff($hHeroTimer) / 1000) > 60) Then
										SetLog(GetLangText("msgActivateQueen"), $COLOR_AQUA)
										SelectDropTroupe($Queen)
										$QueenPowerCollector = True
									EndIf
								Else
									If ((TimerDiff($hHeroTimer) / 1000) > Number(GUICtrlRead($txtQueenSkill))) Then
										SetLog(GetLangText("msgActivateQueen"), $COLOR_BLUE)
										SelectDropTroupe($Queen)
										$QueenPowerCollector = True
									EndIf
								EndIf
							EndIf
						Next
						_WinAPI_DeleteObject($hCheckHBitmap)
						DllClose($hDll)

						; If a collector is still standing, but has been deployed, take troops from one that is gone if possible
						For $check = 0 To $CollectorCount - 1
							If $AllCollectors[$check][5] = False Then OverlayCircle($AllCollectors[$check][1], $AllCollectors[$check][2], 20, 0xFF778899, 3)
;~ 							If $AllCollectors[$check][4] = True And $AllCollectors[$check][5] = True Then
;~ 								For $findavailable = 0 To $CollectorCount - 1
;~ 									If $AllCollectors[$findavailable][4] = False And $AllCollectors[$findavailable][5] = False Then
;~ 										; We found a collector that hasn't deployed yet but already destroyed
;~ 										For $MoveTroop = 0 To 8
;~ 											$TroopBins[$check][$MoveTroop] = $TroopBins[$findavailable][$MoveTroop]
;~ 										Next
;~ 										OverlayCircle($AllCollectors[$check][1], $AllCollectors[$check][2], 20, 0xFF00FF00, 3)
;~ 										$AllCollectors[$check][4] = False
;~ 										$AllCollectors[$findavailable][4] = True
;~ 										ExitLoop
;~ 									EndIf
;~ 								Next
;~ 							EndIf
						Next

						For $check = 0 To $CollectorCount - 1
							If $AllCollectors[$check][4] = False And $AllCollectors[$check][5] = True Then $ExitOkay = False
						Next
					EndIf
				Until $ExitOkay = True
				SetLog(GetLangText("msgCollectAttackDone"))
			EndIf
			If $RedLineWasOff Then
				GUICtrlSetData($sldAcc, 100)
			EndIf
		EndIf

		; ================================================================================?
		; ========= Here is coded the main attack strategy ===============================
		; ========= Feel free to experiment something else ===============================
		; ================================================================================?
		If Not $collectorMode And $AttackMethod <> 3 Then
			If Standard_LaunchTroop($eGiant, (($mixedMode) ? 1 : $nbSides), 1, 1, 1, ($OuterQuad And $attackTH = 2)) Then
				If Wave_Sleep(1) Then Return
			EndIf
			If Standard_LaunchTroop($eHog, (($mixedMode) ? 1 : $nbSides), 1, 1, 1, ($OuterQuad And $attackTH = 2)) Then
				If Wave_Sleep(1) Then Return
			EndIf
			If Not $mixedMode Then
				If Standard_LaunchTroop($eValkyrie, $nbSides, 1, 1, 1, ($OuterQuad And $attackTH = 2)) Then
					If Wave_Sleep(1) Then Return
				EndIf
			EndIf
			If Standard_LaunchTroop($eBarbarian, $nbSides, 1, 2, 0, ($OuterQuad And $attackTH = 2)) Then
				If Wave_Sleep(1) Then Return
			EndIf
			If Standard_LaunchTroop($eWallbreaker, (($mixedMode) ? 1 : $nbSides), 1, (($mixedMode) ? 3 : 1), 1, ($OuterQuad And $attackTH = 2)) Then
				If Wave_Sleep(1) Then Return
			EndIf
			If Standard_LaunchTroop($eArcher, $nbSides, 1, 2, 0, ($OuterQuad And $attackTH = 2)) Then
				If Wave_Sleep(1) Then Return
			EndIf
			If Standard_LaunchTroop($eBarbarian, (($mixedMode) ? 1 : $nbSides), 2, 2, 0, ($OuterQuad And $attackTH >= 1)) Then
				If Wave_Sleep(1) Then Return
			EndIf
			If Standard_LaunchTroop($eGoblin, $nbSides, 1, 2, 0, ($OuterQuad And $attackTH = 2)) Then
				If Wave_Sleep(1) Then Return
			EndIf
			If $mixedMode Then
				If Standard_LaunchTroop($eWallbreaker, 1, 2, 3, 1) Then
					If _Sleep(Wave_Sleep(1), False) Then Return
				EndIf
			Else
				If Standard_LaunchTroop($eArcher, $nbSides, 2, 2, 0, ($OuterQuad And $attackTH >= 1)) Then
					If Wave_Sleep(1) Then Return
				EndIf
				If Standard_LaunchTroop($eGoblin, $nbSides, 2, 2, 0, ($OuterQuad And $attackTH = 2)) Then
					If Wave_Sleep(1) Then Return
				EndIf
				If Standard_LaunchTroop($eMinion, $nbSides, 1, 1, 0, ($OuterQuad And $attackTH = 2)) Then
					If Wave_Sleep(1) Then Return
				EndIf
			EndIf
			; ================================================================================?

			$hHeroTimer = ""
			; Deploy CC and Heroes behind troops
			If ($OuterQuad And $attackTH = 2) Then
				Switch $THquadrant
					Case 1
						$DropX = $FurthestTopLeft[0][0]
						$DropY = $FurthestTopLeft[0][1]
						Local $DropArray[5][2] = [[$DropX, $DropY], [0, 0], [0, 0], [0, 0], [$DropX, $DropY]]
					Case 2
						$m = (537 - 238) / (535 - 128)
						$m2 = (9 - 314) / (430 - 28)
						$b = $THy - ($m * $THx)
						$b2 = 314 - ($m2 * 28)
						$DropXa = (($b - $b2) / ($m2 - $m)) - 20
						$DropYa = Round($m2 * $DropXa + $b2)
						$DropXb = (($b - $b2) / ($m2 - $m)) + 20
						$DropYb = Round($m2 * $DropXb + $b2)
						Local $DropArray[5][2] = [[$DropXa, $DropYa], [0, 0], [0, 0], [0, 0], [$DropXb, $DropYb]]
					Case 3
						$DropX = $FurthestTopLeft[4][0]
						$DropY = $FurthestTopLeft[4][1]
						Local $DropArray[5][2] = [[$DropX, $DropY], [0, 0], [0, 0], [0, 0], [$DropX, $DropY]]
					Case 4
						$m = (85 - 388) / (527 - 130)
						$m2 = (612 - 314) / (440 - 28)
						$b = $THy - ($m * $THx)
						$b2 = 314 - ($m2 * 28)
						$DropXa = (($b - $b2) / ($m2 - $m)) - 20
						$DropYa = Round($m2 * $DropXa + $b2)
						$DropXb = (($b - $b2) / ($m2 - $m)) + 20
						$DropYb = Round($m2 * $DropXb + $b2)
						Local $DropArray[5][2] = [[$DropXa, $DropYa], [0, 0], [0, 0], [0, 0], [$DropXb, $DropYb]]
					Case 6
						$m = (85 - 388) / (527 - 130)
						$m2 = (612 - 314) / (440 - 28)
						$b = $THy - ($m * $THx)
						$b2 = 9 - ($m2 * 430)
						$DropXa = (($b - $b2) / ($m2 - $m)) - 20
						$DropYa = Round($m2 * $DropXa + $b2)
						$DropXb = (($b - $b2) / ($m2 - $m)) + 20
						$DropYb = Round($m2 * $DropXb + $b2)
						Local $DropArray[5][2] = [[$DropXa, $DropYa], [0, 0], [0, 0], [0, 0], [$DropXb, $DropYb]]
					Case 7
						$DropX = Round(($FurthestBottomRight[4][0] - $FurthestBottomRight[0][0]) / 4) + $FurthestBottomRight[0][0]
						$DropY = Round(($FurthestBottomRight[4][1] - $FurthestBottomRight[0][1]) / 4) + $FurthestBottomRight[0][1]
						Local $DropArray[5][2] = [[$DropX, $DropY], [0, 0], [0, 0], [0, 0], [$DropX, $DropY]]
					Case 8
						$m = (537 - 238) / (535 - 128)
						$m2 = (9 - 314) / (430 - 28)
						$b = $THy - ($m * $THx)
						$b2 = 612 - ($m2 * 440)
						$DropXa = (($b - $b2) / ($m2 - $m)) - 20
						$DropYa = Round($m2 * $DropXa + $b2)
						$DropXb = (($b - $b2) / ($m2 - $m)) + 20
						$DropYb = Round($m2 * $DropXb + $b2)
						Local $DropArray[5][2] = [[$DropXa, $DropYa], [0, 0], [0, 0], [0, 0], [$DropXb, $DropYb]]
					Case 9
						$DropX = $FurthestBottomRight[4][0]
						$DropY = $FurthestBottomRight[4][1]
						Local $DropArray[5][2] = [[$DropX, $DropY], [0, 0], [0, 0], [0, 0], [$DropX, $DropY]]
				EndSwitch
				Standard_dropCC($DropArray, $CC, $AttackMethod, $AimTH)
				If _Sleep(100) Then Return
				If Not $mixedMode Then
					Standard_dropHeroes($DropArray, $King, $Queen, $AttackMethod, $AimTH)
					$hHeroTimer = TimerInit()
				EndIf
			Else
				If $nbSides = 1 Then
					Standard_dropCC($BottomRight, $CC, $AttackMethod)
				Else
					Standard_dropCC($TopLeft, $CC, $AttackMethod)
				EndIf
				If _Sleep(100) Then Return
				If Not $mixedMode Then
					If $nbSides = 1 Then
						Standard_dropHeroes($BottomRight, $King, $Queen, $AttackMethod)
						$hHeroTimer = TimerInit()
					Else
						Standard_dropHeroes($TopLeft, $King, $Queen, $AttackMethod)
						$hHeroTimer = TimerInit()
					EndIf
				EndIf
			EndIf

			If $mixedMode Then
				If Standard_LaunchTroop($eValkyrie, 1, 1, 1, 1, ($OuterQuad And $attackTH = 2)) Then
					If Wave_Sleep(1) Then Return
				EndIf
				If Standard_LaunchTroop($eArcher, 1, 2, 2, 0, ($OuterQuad And $attackTH = 2)) Then
					If Wave_Sleep(1) Then Return
				EndIf
				If Standard_LaunchTroop($eGoblin, 1, 2, 2, 0, ($OuterQuad And $attackTH = 2)) Then
					If Wave_Sleep(1) Then Return
				EndIf
				If Standard_LaunchTroop($eMinion, 1, 1, 1, 0, ($OuterQuad And $attackTH = 2)) Then
					If Wave_Sleep(1) Then Return
				EndIf
				If _Sleep(100) Then Return
				If ($OuterQuad And $attackTH = 2) Then
					Standard_dropHeroes($DropArray, $King, $Queen, $AttackMethod, $AimTH)
					$hHeroTimer = TimerInit()
				Else
					Standard_dropHeroes($BottomRight, $King, $Queen, $AttackMethod)
					$hHeroTimer = TimerInit()
				EndIf
				If Standard_LaunchTroop($eWallbreaker, 1, 3, 3, 1) Then
					If _Sleep(Wave_Sleep(1), False) Then Return
				EndIf
			EndIf
		EndIf

		; Check resources
		If Not $EarlyExit Then
			$Resources = GetResources(1)
		Else
			$Resources = GetResources(2)
		EndIf

		; Nuke DE if desired
		If ($LastAttackDead = "0") And ($SpellQty >= GUICtrlRead($txtSpellNumber)) And Number($Resources[4]) >= Number(GUICtrlRead($txtDENukeLimit)) And IsChecked($chkNukeAttacking) Then
			SetLog(GetLangText("msgNuking"), $COLOR_BLUE)
			Standard_DropNukes()
		EndIf

		If Wave_Sleep(1) Then Return

		If Not $EarlyExit And $AttackMethod <> 3 Then
			SetLog(GetLangText("msgDropLeftover"), $COLOR_BLUE)
			$gone = True
			$loop = 0
			Local $useCastle = ($AttackMethod = 0) ? (IsChecked($chkDeadUseClanCastle) ? (1) : (0)) : (IsChecked($chkUseClanCastle) ? (1) : (0))
			Local $useKing = ($AttackMethod = 0) ? (IsChecked($chkDeadUseKing) ? (1) : (0)) : (IsChecked($chkUseKing) ? (1) : (0))
			Local $useQueen = ($AttackMethod = 0) ? (IsChecked($chkDeadUseQueen) ? (1) : (0)) : (IsChecked($chkUseQueen) ? (1) : (0))
			Do
				$loop += 1
				$gone = True
				If $loop = 1 Then
					Standard_PrepareAttack(True) ;Check remaining quantities
				Else
					Standard_PrepareAttack(True, 1, True)
				EndIf
				For $i = 0 To 8
					If $atkTroops[$i][0] <> -1 Then
						If $atkTroops[$i][0] = $eCastle And $useCastle <> 1 Then ContinueLoop
						If $atkTroops[$i][0] = $eKing And $useKing <> 1 Then ContinueLoop
						If $atkTroops[$i][0] = $eQueen And $useQueen <> 1 Then ContinueLoop
						If $atkTroops[$i][1] > 0 Then $gone = False
					EndIf
				Next
				For $i = $eBarbarian To $eMinion ; lauch all remaining troops
					If $i = $eBarbarian Or $i = $eArcher Or $i = $eMinion Or $i = $eHog Or $i = $eValkyrie Then
						Standard_LaunchTroop($i, (($mixedMode) ? 1 : $nbSides), 0, 1)
					Else
						If $i <> $eLSpell Then Standard_LaunchTroop($i, $nbSides, 0, 1, 2)
					EndIf
				Next
				If _Sleep(500) Then Return
			Until $gone Or $loop > 10

			;Activate KQ's power if deployed
			Local $QueenUsed = ($AttackMethod = 0) ? (IsChecked($chkDeadUseQueen) ? (True) : (False)) : (IsChecked($chkUseQueen) ? (True) : (False))
			If $QueenUsedSnipe Then $QueenUsed = True
			Local $KingUsed = ($AttackMethod = 0) ? (IsChecked($chkDeadUseKing) ? (True) : (False)) : (IsChecked($chkUseKing) ? (True) : (False))
			If $KingUsedSnipe Then $KingUsed = True
			If ($KingUsed And $KingWasHere) Or ($QueenUsed And $QueenWasHere) Then
				$KingGone = True
				$QueenGone = True
				If $KingUsed And $KingWasHere Then $KingGone = False
				If $QueenUsed And $QueenWasHere Then $QueenGone = False
				If $KingPowerCollector Or $KingPowerSnipe Then $KingGone = True
				If $QueenPowerCollector Or $QueenPowerSnipe Then $QueenGone = True
				Do
					If $KingWasHere And TimerDiff($hHeroTimer) > 3000 Then
						If GUICtrlRead($txtKingSkill) = 0 Then
							_CaptureRegion()
							If (checkHealth($King) Or (TimerDiff($hHeroTimer) / 1000) > 60) And Not $KingGone Then
								SetLog(GetLangText("msgActivateKing"), $COLOR_AQUA)
								SelectDropTroupe($King)
								$KingGone = True
							EndIf
						Else
							If ((TimerDiff($hHeroTimer) / 1000) > Number(GUICtrlRead($txtKingSkill))) And Not $KingGone Then
								SetLog(GetLangText("msgActivateKing"), $COLOR_BLUE)
								SelectDropTroupe($King)
								$KingGone = True
							EndIf
						EndIf
					EndIf
					If $QueenWasHere And TimerDiff($hHeroTimer) > 3000 Then
						If GUICtrlRead($txtQueenSkill) = 0 Then
							_CaptureRegion()
							If (checkHealth($Queen) Or (TimerDiff($hHeroTimer) / 1000) > 60) And Not $QueenGone Then
								SetLog(GetLangText("msgActivateQueen"), $COLOR_AQUA)
								SelectDropTroupe($Queen)
								$QueenGone = True
							EndIf
						Else
							If ((TimerDiff($hHeroTimer) / 1000) > Number(GUICtrlRead($txtQueenSkill))) And Not $QueenGone Then
								SetLog(GetLangText("msgActivateQueen"), $COLOR_BLUE)
								SelectDropTroupe($Queen)
								$QueenGone = True
							EndIf
						EndIf
					EndIf
					If _Sleep(250) Then ExitLoop
				Until $KingGone And $QueenGone
			EndIf
			SetLog(GetLangText("msgFinishedWait"), $COLOR_GREEN)
		Else
			; Wait just a few seconds in case we nuked the DE
			If _Sleep(3000) Then Return

			; Use K/Q power if not used yet
			If $AttackMethod <> 3 Then
				Local $QueenUsed = ($AttackMethod = 0) ? (IsChecked($chkDeadUseQueen) ? (True) : (False)) : (IsChecked($chkUseQueen) ? (True) : (False))
				Local $KingUsed = ($AttackMethod = 0) ? (IsChecked($chkDeadUseKing) ? (True) : (False)) : (IsChecked($chkUseKing) ? (True) : (False))
			Else
				Local $QueenUsed = False
				If $QueenUsedSnipe Then $QueenUsed = True
				Local $KingUsed = False
				If $KingUsedSnipe Then $KingUsed = True
			EndIf
			If ($KingUsed And $KingWasHere) Or ($QueenUsed And $QueenWasHere) Then
				$KingGone = False
				$QueenGone = False
				If $KingPowerCollector Or $KingPowerSnipe Then $KingGone = True
				If $QueenPowerCollector Or $QueenPowerSnipe Then $QueenGone = True
				If $KingUsed And Not $KingGone Then
					SelectDropTroupe($King)
				EndIf
				If $QueenUsed And Not $QueenGone Then
					SelectDropTroupe($Queen)
				EndIf
			EndIf

			If $EarlyExit Then $FasterExit = True
		EndIf

	EndIf

	If $TakeAttackSnapShot = 1 Then
		$AttackFile = @YEAR & @MON & @MDAY & @HOUR & @MIN & @SEC & "-TH-" & $THLoc & ((($THquadrant > 0) And ($THquadrant < 10)) ? ("-Q" & $THquadrant) : ("")) & (($AttackMethod = 0) ? ("-Dead-") : ("-Live")) & ".jpg"
		_GDIPlus_ImageSaveToFile($hAttackBitmap, $dirAttack & $AttackFile)
		If _Sleep(500) Then Return
		If $PushBulletEnabled = 1 And $PushBulletattacktype = 1 Then
			_PushFile($AttackFile, "Attacks", "image/jpeg", "Last Raid", $AttackFile)
		EndIf
	EndIf
	$BufferAvailable = False
	_GDIPlus_ImageDispose($hAttackBitmap)
EndFunc   ;==>Standard_Attack

Func Standard_DropNukes()
	$nLSpell = -1
	$nSpellQty = 0
	For $i = 0 To 8
		If $atkTroops[$i][0] = $eLSpell Then
			$nLSpell = $i
			$nSpellQty = $atkTroops[$i][1]
		EndIf
	Next
	If $nSpellQty > 0 Then
		$hDll = DllOpen(@ScriptDir & "\BrokenBot.org\BrokenBot32.dll")
		_CaptureRegion()
		$res = Null
		$res = ""
		$DEDrills = ""
		$hCheckHBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap)
		$res = DllCall($hDll, "str", "BrokenBotMatchBuilding", "ptr", $hCheckHBitmap, "int", 16, "int", 3, "int", 3, "int", 1, "int", (IsChecked($chkSpeedBoost) ? (1) : (0)))
		If IsArray($res) Then
			If $res[0] = -2 Then
				SetLog(GetLangText("msgLicense"), $COLOR_RED)
			ElseIf $res[0] <> -1 Then
				SelectDropTroupe($nLSpell)
				If _Sleep(200) Then Return
				$DEDrills = StringSplit($res[0], "|", 2)
				$i = 0
				$loops = 0
				While $i < $DEDrills[0]
					If ($nSpellQty <= 0) Or ($loops > 20) Then ExitLoop
					If ($i * 6 + 2) <= UBound($DEDrills) Then
						Click(Round(_Random_Gaussian($DEDrills[$i * 6 + 1], 2)), Round(_Random_Gaussian($DEDrills[$i * 6 + 2], 2)))
						OverlayCircle(Round(_Random_Gaussian($DEDrills[$i * 6 + 1], 2)) - 2, Round(_Random_Gaussian($DEDrills[$i * 6 + 2], 2)) - 2, 4, $GlobalColor, 1)
						If _Sleep(200) Then Return
						$nSpellQty = ReadTroopQuantity($nLSpell)
					Else
						$i = -1
					EndIf
					$i += 1
					$loops += 1
				WEnd
			EndIf
		EndIf
		_WinAPI_DeleteObject($hCheckHBitmap)
		DllClose($hDll)
	EndIf
EndFunc   ;==>Standard_DropNukes

;Drops Clan Castle troops, given the slot and x, y coordinates.

Func Standard_dropCC($edge, $slot, $AttackMethod = 1, $CenterLoc = 1) ;Drop clan castle
	Local $useCastle = ($AttackMethod = 0) ? (IsChecked($chkDeadUseClanCastle) ? (1) : (0)) : (IsChecked($chkUseClanCastle) ? (1) : (0))
	If $slot <> -1 And $useCastle = 1 Then
		SetLog(GetLangText("msgDroppingCC"), $COLOR_BLUE)
		Click(68 + (72 * $slot), 595)
		If _Sleep(200) Then Return
		$x = Round(_Random_Gaussian(((($edge[4][0] - $edge[0][0]) / 2) + $edge[0][0]), (($edge[4][0] - $edge[0][0]) / 8)))
		$y = Round((($edge[4][1] - $edge[0][1]) / ($edge[4][0] - $edge[0][0])) * ($x - $edge[0][0])) + $edge[0][1]
		Click($x, $y, 1, 0, $CenterLoc)
		_GDIPlus_GraphicsDrawEllipse($Buffer, $x - 4, $y - 4, 8, 8, $pCC)
	EndIf
EndFunc   ;==>Standard_dropCC

;Will drop heroes in a specific coordinates, only if slot is not -1
;Only drops when option is clicked.

Func Standard_dropHeroes($edge, $KingSlot = -1, $QueenSlot = -1, $AttackMethod = 1, $CenterLoc = 1) ;Drops for king and queen
	While 1

		Local $useKing = ($AttackMethod = 0) ? (IsChecked($chkDeadUseKing) ? (1) : (0)) : (IsChecked($chkUseKing) ? (1) : (0))
		Local $useQueen = ($AttackMethod = 0) ? (IsChecked($chkDeadUseQueen) ? (1) : (0)) : (IsChecked($chkUseQueen) ? (1) : (0))

		If $KingSlot <> -1 And $useKing = 1 Then
			SetLog(GetLangText("msgDroppingKing"), $COLOR_BLUE)
			Click(68 + (72 * $KingSlot), 595) ;Select King
			If _Sleep(200) Then Return
			$x = Round(_Random_Gaussian(((($edge[4][0] - $edge[0][0]) / 2) + $edge[0][0]), (($edge[4][0] - $edge[0][0]) / 8)))
			$y = Round((($edge[4][1] - $edge[0][1]) / ($edge[4][0] - $edge[0][0])) * ($x - $edge[0][0])) + $edge[0][1]
			Click($x, $y, 1, 0, $CenterLoc)
			_GDIPlus_GraphicsDrawEllipse($Buffer, $x - 6, $y - 6, 12, 12, $pKing)
			$checkKPower = True
		EndIf

		If _Sleep(Wave_Sleep(1)) Then ExitLoop

		If $QueenSlot <> -1 And $useQueen = 1 Then
			SetLog(GetLangText("msgDroppingQueen"), $COLOR_BLUE)
			Click(68 + (72 * $QueenSlot), 595) ;Select Queen
			If _Sleep(200) Then Return
			$x = Round(_Random_Gaussian(((($edge[4][0] - $edge[0][0]) / 2) + $edge[0][0]), (($edge[4][0] - $edge[0][0]) / 8)))
			$y = Round((($edge[4][1] - $edge[0][1]) / ($edge[4][0] - $edge[0][0])) * ($x - $edge[0][0])) + $edge[0][1]
			Click($x, $y, 1, 0, $CenterLoc)
			_GDIPlus_GraphicsDrawEllipse($Buffer, $x - 5, $y - 5, 10, 10, $pQueen)
			$checkQPower = True
		EndIf

		ExitLoop
	WEnd
EndFunc   ;==>Standard_dropHeroes

Func checkHealth($troop)
	If isColorBetween(_GetPixelColor(68 + (72 * $troop), 572), Hex(0x18BD02, 6), Hex(0x4AD505, 6)) Then
		Return False
	EndIf
	Return True
EndFunc   ;==>checkHealth

Func isColorBetween($nColor1, $nColorLow, $nColorHigh)
	Local $Red1, $Red2, $Red3, $Blue1, $Blue2, $Blue3, $Green1, $Green2, $Green3

	$Red1 = Dec(StringMid(String($nColor1), 1, 2))
	$Blue1 = Dec(StringMid(String($nColor1), 3, 2))
	$Green1 = Dec(StringMid(String($nColor1), 5, 2))

	$Red2 = Dec(StringMid(String($nColorLow), 1, 2))
	$Blue2 = Dec(StringMid(String($nColorLow), 3, 2))
	$Green2 = Dec(StringMid(String($nColorLow), 5, 2))

	$Red3 = Dec(StringMid(String($nColorHigh), 1, 2))
	$Blue3 = Dec(StringMid(String($nColorHigh), 3, 2))
	$Green3 = Dec(StringMid(String($nColorHigh), 5, 2))

	If $Red1 < $Red2 Or $Red1 > $Red3 Then Return False
	If $Green1 < $Green2 Or $Green1 > $Green3 Then Return False
	If $Blue1 < $Blue2 Or $Blue1 > $Blue3 Then Return False

	Return True
EndFunc   ;==>isColorBetween

Func FixDropCurvePos(ByRef $arCurve, $index, $x, $y)
	; If they are outside of bounds of base then move them back in
	For $rotate = 0 To 3
		Switch $rotate
			Case 0
				If SegmentIntersect($arCurve[$index][0], $arCurve[$index][1], $x, $y, $FurthestTopLeft[0][0], $FurthestTopLeft[0][1], $FurthestTopLeft[4][0], $FurthestTopLeft[4][1]) Then
					$BetterSpot = FindIntersection($arCurve[$index][0], $arCurve[$index][1], $x, $y, $FurthestTopLeft[0][0], $FurthestTopLeft[0][1], $FurthestTopLeft[4][0], $FurthestTopLeft[4][1])
					$arCurve[$index][0] = $BetterSpot[0]
					$arCurve[$index][1] = $BetterSpot[1]
					ExitLoop
				EndIf
			Case 1
				If SegmentIntersect($arCurve[$index][0], $arCurve[$index][1], $x, $y, $FurthestTopRight[0][0], $FurthestTopRight[0][1], $FurthestTopRight[4][0], $FurthestTopRight[4][1]) Then
					$BetterSpot = FindIntersection($arCurve[$index][0], $arCurve[$index][1], $x, $y, $FurthestTopRight[0][0], $FurthestTopRight[0][1], $FurthestTopRight[4][0], $FurthestTopRight[4][1])
					$arCurve[$index][0] = $BetterSpot[0]
					$arCurve[$index][1] = $BetterSpot[1]
					ExitLoop
				EndIf
			Case 2
				If SegmentIntersect($arCurve[$index][0], $arCurve[$index][1], $x, $y, $FurthestBottomLeft[0][0], $FurthestBottomLeft[0][1], $FurthestBottomLeft[4][0], $FurthestBottomLeft[4][1]) Then
					$BetterSpot = FindIntersection($arCurve[$index][0], $arCurve[$index][1], $x, $y, $FurthestBottomLeft[0][0], $FurthestBottomLeft[0][1], $FurthestBottomLeft[4][0], $FurthestBottomLeft[4][1])
					$arCurve[$index][0] = $BetterSpot[0]
					$arCurve[$index][1] = $BetterSpot[1]
					ExitLoop
				EndIf
			Case 3
				If SegmentIntersect($arCurve[$index][0], $arCurve[$index][1], $x, $y, $FurthestBottomRight[0][0], $FurthestBottomRight[0][1], $FurthestBottomRight[4][0], $FurthestBottomRight[4][1]) Then
					$BetterSpot = FindIntersection($arCurve[$index][0], $arCurve[$index][1], $x, $y, $FurthestBottomRight[0][0], $FurthestBottomRight[0][1], $FurthestBottomRight[4][0], $FurthestBottomRight[4][1])
					$arCurve[$index][0] = $BetterSpot[0]
					$arCurve[$index][1] = $BetterSpot[1]
					ExitLoop
				EndIf
		EndSwitch
	Next
	; Move points that are too low up
	If $arCurve[$index][1] > 538 Then
		$arCurve[$index][1] = 538
		If $arCurve[$index][0] <= 402 Then
			$GetPoint = GetPointDist(342, 538, 402, 538)
			$NewPoint = $GetPoint[1]
			$NewPoint -= 5
			If $NewPoint < 342 Then $NewPoint = 342
			If $NewPoint < $arCurve[$index][0] Then $arCurve[$index][0] = $NewPoint
		Else
			$GetPoint = GetPointDist(518, 538, 402, 538)
			$NewPoint = $GetPoint[1]
			$NewPoint += 5
			If $NewPoint > 518 Then $NewPoint = 518
			If $NewPoint > $arCurve[$index][0] Then $arCurve[$index][0] = $NewPoint
		EndIf
	EndIf
EndFunc   ;==>FixDropCurvePos
