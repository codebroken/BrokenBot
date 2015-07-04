;Red border finding
Global $Grid[43][43][3]
$Grid[0][0][0] = 35
$Grid[0][0][1] = 314
$Grid[42][0][0] = 429
$Grid[42][0][1] = 610
$Grid[0][42][0] = 429
$Grid[0][42][1] = 18
$Grid[42][42][0] = 824
$Grid[42][42][1] = 314
For $i = 1 To 41
	$Grid[$i][0][0] = ($Grid[$i - 1][0][0] + (($Grid[42][0][0] - $Grid[0][0][0]) / 42))
	$Grid[$i][0][1] = ($Grid[$i - 1][0][1] + (($Grid[42][0][1] - $Grid[0][0][1]) / 42))
	$Grid[$i][42][0] = ($Grid[$i - 1][42][0] + (($Grid[42][42][0] - $Grid[0][42][0]) / 42))
	$Grid[$i][42][1] = ($Grid[$i - 1][42][1] + (($Grid[42][42][1] - $Grid[0][42][1]) / 42))
Next
For $i = 0 To 42
	For $j = 1 To 41
		$Grid[$i][$j][0] = ($Grid[$i][0][0] + $j * (($Grid[$i][42][0] - $Grid[$i][0][0]) / 42))
		$Grid[$i][$j][1] = ($Grid[$i][0][1] + $j * (($Grid[$i][42][1] - $Grid[$i][0][1]) / 42))
	Next
Next
For $j = 0 To 42
	For $i = 0 To 42
		$Grid[$j][$i][0] = Round($Grid[$j][$i][0])
		$Grid[$j][$i][1] = Round($Grid[$j][$i][1])
	Next
Next
$AimCenter = 1
$AimTH = 2
$AimPoint = 3

Func RedLineDeploy($x, $y, $times = 1, $speed = 0, $CenteredOn = 1, $BufferDist = -1, $CenterX = 395, $CenterY = 314, $RandomizeBuffer = 6)
	If $BufferDist - 1 Then $BufferDist = GUICtrlRead($sldAcc) + 10
	If $RandomizeBuffer > 0 Then
		$BufferDist = $BufferDist + _Random_Gaussian($RandomizeBuffer / 2, $RandomizeBuffer / 6.2) ; Randomly distributes buffer zone from $BufferDist to $BufferDist + $RandomizeBuffer
	EndIf
	If $CenteredOn = $AimCenter Then
		$AimX = $BaseCenter[0]
		$AimY = $BaseCenter[1]
	ElseIf $CenteredOn = $AimTH Then
		$AimX = $THx
		$AimY = $THy
	ElseIf $CenteredOn = $AimPoint Then
		$AimX = $CenterX
		$AimY = $CenterY
	Else
		SetLog(GetLangText("msgBadCall"))
		Return
	EndIf
	For $i = 0 To 41
		For $j = 0 To 41
			If ($Grid[$i][$j][2] > 0 And $Grid[$i][$j + 1][2] > 0) Then ; Up and to the right edges
				If (($x < $Grid[$i][$j + 1][0]) And ($Grid[$i][$j][0] < $AimX)) Or (($x > $Grid[$i][$j][0]) And ($Grid[$i][$j + 1][0] > $AimX)) Then
					If (($y < $Grid[$i][$j][1]) And ($Grid[$i][$j + 1][1] < $AimY)) Or (($y > $Grid[$i][$j + 1][1]) And ($Grid[$i][$j][1] > $AimY)) Then
						$A1 = $AimY - $y
						$B1 = $x - $AimX
						$C1 = ($A1 * $x) + ($B1 * $y)
						$A2 = $Grid[$i][$j + 1][1] - $Grid[$i][$j][1]
						$B2 = $Grid[$i][$j][0] - $Grid[$i][$j + 1][0]
						$C2 = ($A2 * $Grid[$i][$j][0]) + ($B2 * $Grid[$i][$j][1])
						If $A1 * $B2 <> $A2 * $B1 Then
							$IntX = ($B2 * $C1 - $B1 * $C2) / ($A1 * $B2 - $A2 * $B1)
							If $Grid[$i][$j][0] < $IntX And $IntX < $Grid[$i][$j + 1][0] Then
								; They cross, so lets make intersection the new aimed point
								$AimX = ($B2 * $C1 - $B1 * $C2) / ($A1 * $B2 - $A2 * $B1)
								$AimY = ($A1 * $C2 - $A2 * $C1) / ($A1 * $B2 - $A2 * $B1)
							EndIf
						EndIf
					EndIf
				EndIf
			EndIf
			If ($Grid[$i][$j][2] > 0 And $Grid[$i + 1][$j][2] > 0) Then ; Down and to the right edges
				If (($x < $Grid[$i + 1][$j][0]) And ($Grid[$i][$j][0] < $AimX)) Or (($x > $Grid[$i][$j][0]) And ($Grid[$i + 1][$j][0] > $AimX)) Then
					If (($y < $Grid[$i + 1][$j][1]) And ($Grid[$i][$j][1] < $AimY)) Or (($y > $Grid[$i][$j][1]) And ($Grid[$i + 1][$j][1] > $AimY)) Then
						$A1 = $AimY - $y
						$B1 = $x - $AimX
						$C1 = ($A1 * $x) + ($B1 * $y)
						$A2 = $Grid[$i + 1][$j][1] - $Grid[$i][$j][1]
						$B2 = $Grid[$i][$j][0] - $Grid[$i + 1][$j][0]
						$C2 = ($A2 * $Grid[$i][$j][0]) + ($B2 * $Grid[$i][$j][1])
						If $A1 * $B2 <> $A2 * $B1 Then
							$IntX = ($B2 * $C1 - $B1 * $C2) / ($A1 * $B2 - $A2 * $B1)
							If $Grid[$i][$j][0] < $IntX And $IntX < $Grid[$i + 1][$j][0] Then
								; They cross, so lets make intersection the new aimed point
								$AimX = ($B2 * $C1 - $B1 * $C2) / ($A1 * $B2 - $A2 * $B1)
								$AimY = ($A1 * $C2 - $A2 * $C1) / ($A1 * $B2 - $A2 * $B1)
							EndIf
						EndIf
					EndIf
				EndIf
			EndIf
		Next
	Next
	$j = 42
	For $i = 0 To 41
		If ($Grid[$i][$j][2] > 0 And $Grid[$i + 1][$j][2] > 0) Then ; Down and to the right edges
			If (($x < $Grid[$i + 1][$j][0]) And ($Grid[$i][$j][0] < $AimX)) Or (($x > $Grid[$i][$j][0]) And ($Grid[$i + 1][$j][0] > $AimX)) Then
				If (($y < $Grid[$i + 1][$j][1]) And ($Grid[$i][$j][1] < $AimY)) Or (($y > $Grid[$i][$j][1]) And ($Grid[$i + 1][$j][1] > $AimY)) Then
					$A1 = $AimY - $y
					$B1 = $x - $AimX
					$C1 = ($A1 * $x) + ($B1 * $y)
					$A2 = $Grid[$i + 1][$j][1] - $Grid[$i][$j][1]
					$B2 = $Grid[$i][$j][0] - $Grid[$i + 1][$j][0]
					$C2 = ($A2 * $Grid[$i][$j][0]) + ($B2 * $Grid[$i][$j][1])
					If $A1 * $B2 <> $A2 * $B1 Then
						$IntX = ($B2 * $C1 - $B1 * $C2) / ($A1 * $B2 - $A2 * $B1)
						If $Grid[$i][$j][0] < $IntX And $IntX < $Grid[$i + 1][$j][0] Then
							; They cross, so lets make intersection the new aimed point
							$AimX = ($B2 * $C1 - $B1 * $C2) / ($A1 * $B2 - $A2 * $B1)
							$AimY = ($A1 * $C2 - $A2 * $C1) / ($A1 * $B2 - $A2 * $B1)
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
	Next
	$i = 42
	For $j = 0 To 41
		If ($Grid[$i][$j][2] > 0 And $Grid[$i][$j + 1][2] > 0) Then ; Up and to the right edges
			If (($x < $Grid[$i][$j + 1][0]) And ($Grid[$i][$j][0] < $AimX)) Or (($x > $Grid[$i][$j][0]) And ($Grid[$i][$j + 1][0] > $AimX)) Then
				If (($y < $Grid[$i][$j][1]) And ($Grid[$i][$j + 1][1] < $AimY)) Or (($y > $Grid[$i][$j + 1][1]) And ($Grid[$i][$j][1] > $AimY)) Then
					$A1 = $AimY - $y
					$B1 = $x - $AimX
					$C1 = ($A1 * $x) + ($B1 * $y)
					$A2 = $Grid[$i][$j + 1][1] - $Grid[$i][$j][1]
					$B2 = $Grid[$i][$j][0] - $Grid[$i][$j + 1][0]
					$C2 = ($A2 * $Grid[$i][$j][0]) + ($B2 * $Grid[$i][$j][1])
					If $A1 * $B2 <> $A2 * $B1 Then
						$IntX = ($B2 * $C1 - $B1 * $C2) / ($A1 * $B2 - $A2 * $B1)
						If $Grid[$i][$j][0] < $IntX And $IntX < $Grid[$i][$j + 1][0] Then
							; They cross, so lets make intersection the new aimed point
							$AimX = ($B2 * $C1 - $B1 * $C2) / ($A1 * $B2 - $A2 * $B1)
							$AimY = ($A1 * $C2 - $A2 * $C1) / ($A1 * $B2 - $A2 * $B1)
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
	Next
	; Now we are sitting right on top of the edge so let's move back a bit
	$m = ($AimY - $y) / ($AimX - $x)
	$Dist = _Random_Gaussian($BufferDist, 2)
	$deltaX = (($Dist ^ 2) / (1 + $m ^ 2)) ^ .5
	If $AimX > $x Then $deltaX = $deltaX * -1
	If Abs($x - $AimX) < Abs($deltaX) Then
		$AimX = Round($x)
		$AimY = Round($y)
	Else
		$AimX = Round($AimX + $deltaX)
		$AimY = Round($AimY + $m * $deltaX)
	EndIf

	If $times <> 1 Then
		For $i = 0 To ($times - 1)
			ControlClick($Title, "", "", "left", "1", Random($AimX - 2, $AimX + 2, 1), Random($AimY - 2, $AimY + 2, 1))
			OverlayX(Random($AimX - 2, $AimX + 2, 1) - 2, Random($AimY - 2, $AimY + 2, 1) - 2, 5, 5, $GlobalColor, 1)
			If Wave_Sleep(0) Then Return
		Next
	Else
		ControlClick($Title, "", "", "left", "1", $AimX, $AimY)
		OverlayX($AimX - 2, $AimY - 2, 5, 5, $GlobalColor, 1)
		If Wave_Sleep(0) Then Return
	EndIf
EndFunc   ;==>RedLineDeploy

Func SeekEdges()
	Local $mH, $mS, $cl, $cr, $ci

	$cl = 1
	$cr = 1
	$ci = 1

	If GUICtrlRead($sldAcc) < 10 Then
		$mH = 65 + GUICtrlRead($sldAcc)
		$mS = 135 - GUICtrlRead($sldAcc)
	ElseIf GUICtrlRead($sldAcc) = 100 Then
		For $i = 0 To 42
			For $j = 0 To 42
				$Grid[$i][$j][2] = 1
			Next
		Next
		Return
	Else
		$mH = 75 + 10 * ((GUICtrlRead($sldAcc) - 10) / 90)
		$mS = 125 - 10 * ((GUICtrlRead($sldAcc) - 10) / 90)
	EndIf

	; Clear edge data
	SetLog(GetLangText("msgAnalyzingBase"), $COLOR_BLUE)
	For $i = 0 To 42
		For $j = 0 To 42
			$Grid[$i][$j][2] = 0
		Next
	Next

	For $loop = 1 To 5
		_CaptureRegion()
		$hCheckHBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap)
		$ret = ""
		$ret = DllCall(@ScriptDir & "\BrokenBot.org\BrokenBot32.dll", "str", "BrokenBotRedLineCheck", "ptr", $hCheckHBitmap, "int", $mH, "int", $mS, "int", $ci, "int", $cl, "int", $cr)
		_WinAPI_DeleteObject($hCheckHBitmap)

		If IsArray($ret) Then
			If $ret[0] = -2 Then
				SetLog(GetLangText("msgLicense"), $COLOR_RED)
				For $i = 0 To 42
					For $j = 0 To 42
						$Grid[$i][$j][2] = 1
					Next
				Next
			Else
				$Array = StringSplit($ret[0], "|", 2)
				For $i = 0 To (43 * 43) - 1
					If $Grid[Floor($i / 43)][Mod($i, 43)][2] = 0 Then
						$Grid[Floor($i / 43)][Mod($i, 43)][2] = $Array[$i]
					EndIf
				Next
			EndIf
		Else
			For $i = 0 To 42
				For $j = 0 To 42
					$Grid[$i][$j][2] = 1
				Next
			Next
		EndIf
		For $i = 0 To 41
			For $j = 0 To 41
				If ($Grid[$i][$j][2] > 0 And $Grid[$i][$j + 1][2] > 0) Then ; Up and to the right edges
					OverlayLine($Grid[$i][$j][0], $Grid[$i][$j][1], $Grid[$i][$j + 1][0], $Grid[$i][$j + 1][1], 0x22C0D9D9, 1)
				EndIf
				If ($Grid[$i][$j][2] > 0 And $Grid[$i + 1][$j][2] > 0) Then ; Down and to the right edges
					OverlayLine($Grid[$i][$j][0], $Grid[$i][$j][1], $Grid[$i + 1][$j][0], $Grid[$i + 1][$j][1], 0x22C0D9D9, 1)
				EndIf
			Next
		Next
		$j = 42
		For $i = 0 To 41
			If ($Grid[$i][$j][2] > 0 And $Grid[$i + 1][$j][2] > 0) Then ; Down and to the right edges
				OverlayLine($Grid[$i][$j][0], $Grid[$i][$j][1], $Grid[$i + 1][$j][0], $Grid[$i + 1][$j][1], 0x22C0D9D9, 1)
			EndIf
		Next
		$i = 42
		For $j = 0 To 41
			If ($Grid[$i][$j][2] > 0 And $Grid[$i][$j + 1][2] > 0) Then ; Up and to the right edges
				OverlayLine($Grid[$i][$j][0], $Grid[$i][$j][1], $Grid[$i][$j + 1][0], $Grid[$i][$j + 1][1], 0x22C0D9D9, 1)
			EndIf
		Next
	Next

	FindCenter()

	SetLog(GetLangText("msgDone"), $COLOR_BLUE)
EndFunc   ;==>SeekEdges

Func FindCenter()

	Local $pointCount = 0
	Local $sumX = 0
	Local $sumY = 0
	For $i = 0 To 42
		For $j = 0 To 42
			If $Grid[$i][$j][2] > 0 Then
				$pointCount += 1
				$sumX += $Grid[$i][$j][0]
				$sumY += $Grid[$i][$j][1]
			EndIf
		Next
	Next
	If $sumX = 0 Then
		$BaseCenter[0] = 395
		$BaseCenter[1] = 314
	Else
		$BaseCenter[0] = Round($sumX / $pointCount)
		$BaseCenter[1] = Round($sumY / $pointCount)
	EndIf

EndFunc   ;==>FindCenter
