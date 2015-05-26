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

Func RedLineDeploy($x, $y, $times = 1, $speed = 0, $CenteredOn = 1, $BufferDist = -1, $CenterX = 395, $CenterY = 314, $RandomizeBuffer = 6)
	If $BufferDist - 1  Then $BufferDist = GUICtrlRead($sldAcc) + 10
	If $RandomizeBuffer > 0 Then
		$BufferDist = $BufferDist + _Random_Gaussian($RandomizeBuffer/2, $RandomizeBuffer/6.2) ; Randomly distributes buffer zone from $BufferDist to $BufferDist + $RandomizeBuffer
	EndIf
	If $CenteredOn = $AimCenter Then
		$AimX = $CenterX
		$AimY = $CenterY
	ElseIf $CenteredOn = $AimTH Then
		$AimX = $THx
		$AimY = $THy
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
			ControlClick($Title, "", "", "left", "1", Random($AimX-2, $AimX +2, 1), Random($AimY-2, $AimY +2, 1))
			_GDIPlus_GraphicsDrawEllipse($Buffer, $AimX - 2, $AimY - 2, 4, 4, $Pen)
			If _Sleep(Standard_SetSleep(0), False) Then Return
		Next
	Else
		ControlClick($Title, "", "", "left", "1", $AimX, $AimY)
		If _Sleep(Standard_SetSleep(0), False) Then Return
		_GDIPlus_GraphicsDrawEllipse($Buffer, $AimX - 2, $AimY - 2, 4, 4, $Pen)
	EndIf
EndFunc   ;==>RedLineDeploy

Func SeekEdges()
	Local $mH, $mS, $cl, $cr, $ci

	$cl = 1
	$cr = 1
	$ci = 0

	If GUICtrlRead($sldAcc) < 10 Then
		$mH = 65 + GUICtrlRead($sldAcc)
		$mS = 135 - GUICtrlRead($sldAcc)
	ElseIf GUICtrlRead($sldAcc) = 100 Then
		$mH = 1024
		$mS = 8
	Else
		$mH = 75 + 10*((GUICtrlRead($sldAcc)-10)/90)
		$mS = 125 - 10*((GUICtrlRead($sldAcc)-10)/90)
	EndIf

	; Clear edge data
	SetLog(GetLangText("msgAnalyzingBase"), $COLOR_BLUE)
	For $i = 0 To 42
		For $j = 0 To 42
			$Grid[$i][$j][2] = 0
		Next
	Next

	Local $hHBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hAttackBitmap)
	$ret = ""
	$ret = DllCall(@ScriptDir & "\BrokenBot.org\BrokenBot32.dll", "str", "BrokenBotRedLineCheck", "ptr", $hHBitmap, "int", $mH, "int", $mS, "int", $ci, "int", $cl, "int", $cr)
	_WinAPI_DeleteObject($hHBitmap)

	If IsArray($ret) Then
		$Array = StringSplit($ret[0], "|", 2)
		For $i = 0 to (43*43)-1
			$Grid[Floor($i/43)][Mod($i, 43)][2] = $Array[$i]
		Next
	Else
		For $i = 0 To 42
			For $j = 0 To 42
				$Grid[$i][$j][2] = 1
			Next
		Next
	EndIf

	SetLog(GetLangText("msgDone"), $COLOR_BLUE)
EndFunc   ;==>SeekEdges

