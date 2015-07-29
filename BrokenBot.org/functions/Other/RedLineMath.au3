Func GetPointDist($x, $y, $AimX, $AimY)
	; Finds the distance between somepoint $AimX, $AimY, and the redline outside of it from the perspective of point X, Y
	$OrigX = $AimX
	$OrigY = $AimY
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
	; Now we are sitting right on top of the edge so let's calculate how far we are
	Local $Result[3]
	$Result[0] = ((($AimX - $OrigX) ^ 2) + (($AimY - $OrigY) ^ 2)) ^ 0.5
	$Result[1] = $AimX
	$Result[2] = $AimY
	Return $Result
EndFunc   ;==>GetPointDist

Func CloseToEdge($CompX, $CompY, $Distance)
	$Closest = 860
	For $clock = 0 To 8
		$x = $CompX
		$y = $CompY
		Switch $clock
			Case 0
				$SpotA = FindIntersection($x, $y, $x, $y - 1, $FurthestTopLeft[0][0], $FurthestTopLeft[0][1], $FurthestTopLeft[4][0], $FurthestTopLeft[4][1])
				$SpotB = FindIntersection($x, $y, $x, $y - 1, $FurthestTopRight[0][0], $FurthestTopRight[0][1], $FurthestTopRight[4][0], $FurthestTopRight[4][1])
				If $SpotA[1] > $SpotB[1] Then
					$x = $SpotA[0]
					$y = $SpotA[1]
				Else
					$x = $SpotB[0]
					$y = $SpotB[1]
				EndIf
			Case 1
				$SpotA = FindIntersection($x, $y, $x + 1, $y + (($FurthestTopLeft[4][1] - $FurthestTopLeft[0][1]) / ($FurthestTopLeft[4][0] - $FurthestTopLeft[0][0])), $FurthestTopRight[0][0], $FurthestTopRight[0][1], $FurthestTopRight[4][0], $FurthestTopRight[4][1])
				$x = $SpotA[0]
				$y = $SpotA[1]
			Case 2
				$SpotA = FindIntersection($x, $y, $x + 1, $y, $FurthestBottomRight[0][0], $FurthestBottomRight[0][1], $FurthestBottomRight[4][0], $FurthestBottomRight[4][1])
				$SpotB = FindIntersection($x, $y, $x + 1, $y, $FurthestTopRight[0][0], $FurthestTopRight[0][1], $FurthestTopRight[4][0], $FurthestTopRight[4][1])
				If $SpotA[0] < $SpotB[0] Then
					$x = $SpotA[0]
					$y = $SpotA[1]
				Else
					$x = $SpotB[0]
					$y = $SpotB[1]
				EndIf
			Case 3
				$SpotA = FindIntersection($x, $y, $x + 1, $y + (($FurthestTopRight[4][1] - $FurthestTopRight[0][1]) / ($FurthestTopRight[4][0] - $FurthestTopRight[0][0])), $FurthestBottomRight[0][0], $FurthestBottomRight[0][1], $FurthestBottomRight[4][0], $FurthestBottomRight[4][1])
				$x = $SpotA[0]
				$y = $SpotA[1]
			Case 4
				$SpotA = FindIntersection($x, $y, $x, $y + 1, $FurthestBottomLeft[0][0], $FurthestBottomLeft[0][1], $FurthestBottomLeft[4][0], $FurthestBottomLeft[4][1])
				$SpotB = FindIntersection($x, $y, $x, $y + 1, $FurthestBottomRight[0][0], $FurthestBottomRight[0][1], $FurthestBottomRight[4][0], $FurthestBottomRight[4][1])
				If $SpotA[1] < $SpotB[1] Then
					$x = $SpotA[0]
					$y = $SpotA[1]
				Else
					$x = $SpotB[0]
					$y = $SpotB[1]
				EndIf
			Case 5
				$SpotA = FindIntersection($x, $y, $x + 1, $y + (($FurthestTopLeft[4][1] - $FurthestTopLeft[0][1]) / ($FurthestTopLeft[4][0] - $FurthestTopLeft[0][0])), $FurthestBottomLeft[0][0], $FurthestBottomLeft[0][1], $FurthestBottomLeft[4][0], $FurthestBottomLeft[4][1])
				$x = $SpotA[0]
				$y = $SpotA[1]
			Case 6
				$SpotA = FindIntersection($x, $y, $x - 1, $y, $FurthestTopLeft[0][0], $FurthestTopLeft[0][1], $FurthestTopLeft[4][0], $FurthestTopLeft[4][1])
				$SpotB = FindIntersection($x, $y, $x - 1, $y, $FurthestBottomLeft[0][0], $FurthestBottomLeft[0][1], $FurthestBottomLeft[4][0], $FurthestBottomLeft[4][1])
				If $SpotA[0] > $SpotB[0] Then
					$x = $SpotA[0]
					$y = $SpotA[1]
				Else
					$x = $SpotB[0]
					$y = $SpotB[1]
				EndIf
			Case 7
				$SpotA = FindIntersection($x, $y, $x + 1, $y + (($FurthestTopRight[4][1] - $FurthestTopRight[0][1]) / ($FurthestTopRight[4][0] - $FurthestTopRight[0][0])), $FurthestTopLeft[0][0], $FurthestTopLeft[0][1], $FurthestTopLeft[4][0], $FurthestTopLeft[4][1])
				$x = $SpotA[0]
				$y = $SpotA[1]
		EndSwitch
		$DirectionPt = GetPointDist($x, $y, $CompX, $CompY)
		If $DirectionPt[0] < $Closest And $DirectionPt[0] > 0 Then
			$Closest = $DirectionPt[0]
		EndIf
	Next
	If $Closest < $Distance Then
		Return True
	Else
		Return False
	EndIf
EndFunc
