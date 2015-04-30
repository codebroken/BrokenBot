;Red border finding
Global $numEdges = 81
Global $EdgeColors[81][3] = [[218, 116, 44], [207, 97, 37], [199, 104, 41], [201, 119, 45], [193, 130, 47], _
		[203, 134, 55], [208, 138, 55], [211, 143, 59], [196, 128, 50], [195, 159, 38], [199, 143, 57], _
		[173, 124, 50], [214, 108, 40], [193, 101, 38], [211, 111, 44], [203, 112, 42], [123, 73, 26], _
		[143, 89, 31], [157, 100, 41], [180, 116, 45], [133, 82, 32], [125, 65, 20], [172, 117, 48], _
		[120, 92, 36], [106, 76, 30], [159, 105, 42], [172, 103, 40], [193, 124, 44], [189, 119, 46], _
		[206, 155, 64], [190, 137, 46], [187, 138, 56], [192, 155, 58], [203, 131, 47], [196, 147, 52], _
		[199, 140, 53], [193, 135, 52], [195, 159, 58], [196, 128, 50], [193, 136, 53], [211, 143, 59], _
		[203, 131, 47], [215, 142, 50], [205, 145, 53], [187, 129, 53], [151, 85, 34], [154, 75, 26], _
		[168, 80, 32], [105, 68, 20], [172, 117, 46], [193, 119, 47], [192, 111, 45], [126, 88, 34], _
		[165, 88, 29], [158, 71, 25], [166, 91, 34], [127, 59, 23], [212, 119, 47], [206, 119, 42], _
		[211, 119, 45], [200, 112, 41], [202, 108, 40], [180, 113, 39], [211, 119, 45], [202, 127, 49], _
		[168, 126, 46], [126, 50, 16], [165, 81, 27], [163, 74, 26], [207, 129, 53], [183, 129, 44], _
		[196, 139, 52], [180, 126, 48], [156, 81, 31], [142, 77, 28], [160, 104, 37], _
		[157, 83, 29], [128, 71, 25], [157, 80, 37], [158, 93, 33], [198, 115, 43]]
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
$EdgeLevel = 1
$AimCenter = 1
$AimTH = 2

Func RedLineDeploy($x, $y, $times = 1, $speed = 0, $CenteredOn = 0, $BufferDist = 20)
	If $CenteredOn = $AimCenter Then
		$AimX = Round((($Grid[42][42][0] - $Grid[0][0][0]) / 2) + $Grid[0][0][0])
		$AimY = Round((($Grid[42][42][1] - $Grid[0][0][1]) / 2) + $Grid[0][0][1])
	ElseIf $CenteredOn = $AimTH Then
		$AimX = $THx
		$AimY = $THy
	Else
		SetLog("Bad call, unknown where to center attack")
		Return
	EndIf
	For $i=0 to 41
		For $j=0 to 41
			If ($Grid[$i][$j][2]>0 and $Grid[$i][$j+1][2]>0) Then ; Up and to the right edges
				If (($x < $Grid[$i][$j+1][0]) and ($Grid[$i][$j][0] < $AimX)) Or (($x > $Grid[$i][$j][0]) and ($Grid[$i][$j+1][0] > $AimX)) Then
					If (($y < $Grid[$i][$j][1]) and ($Grid[$i][$j+1][1] < $AimY)) Or (($y > $Grid[$i][$j+1][1]) and ($Grid[$i][$j][1] > $AimY)) Then
						$A1 = $AimY - $y
						$B1 = $x - $AimX
						$C1 = ($A1 * $x) + ($B1 * $y)
						$A2 = $Grid[$i][$j+1][1] - $Grid[$i][$j][1]
						$B2 = $Grid[$i][$j][0] - $Grid[$i][$j+1][0]
						$C2 = ($A2 * $Grid[$i][$j][0]) + ($B2 * $Grid[$i][$j][1])
						If $A1*$B2 <> $A2*$B1 Then
							$IntX = ($B2 * $C1 - $B1 * $C2)/($A1 * $B2 - $A2 * $B1)
							If $Grid[$i][$j][0] < $IntX and $IntX < $Grid[$i][$j+1][0] Then
								; They cross, so lets make intersection the new aimed point
								$AimX = ($B2 * $C1 - $B1 * $C2)/($A1 * $B2 - $A2 * $B1)
								$AimY = ($A1 * $C2 - $A2 * $C1)/($A1 * $B2 - $A2 * $B1)
							EndIf
						EndIf
					EndIf
				EndIf
			EndIf
			If ($Grid[$i][$j][2]>0 and $Grid[$i+1][$j][2]>0) Then ; Down and to the right edges
				If (($x < $Grid[$i+1][$j][0]) and ($Grid[$i][$j][0] < $AimX)) Or (($x > $Grid[$i][$j][0]) and ($Grid[$i+1][$j][0] > $AimX)) Then
					If (($y < $Grid[$i+1][$j][1]) and ($Grid[$i][$j][1] < $AimY)) Or (($y > $Grid[$i][$j][1]) and ($Grid[$i+1][$j][1] > $AimY)) Then
						$A1 = $AimY - $y
						$B1 = $x - $AimX
						$C1 = ($A1 * $x) + ($B1 * $y)
						$A2 = $Grid[$i+1][$j][1] - $Grid[$i][$j][1]
						$B2 = $Grid[$i][$j][0] - $Grid[$i+1][$j][0]
						$C2 = ($A2 * $Grid[$i][$j][0]) + ($B2 * $Grid[$i][$j][1])
						If $A1*$B2 <> $A2*$B1 Then
							$IntX = ($B2 * $C1 - $B1 * $C2)/($A1 * $B2 - $A2 * $B1)
							If $Grid[$i][$j][0] < $IntX and $IntX < $Grid[$i+1][$j][0] Then
								; They cross, so lets make intersection the new aimed point
								$AimX = ($B2 * $C1 - $B1 * $C2)/($A1 * $B2 - $A2 * $B1)
								$AimY = ($A1 * $C2 - $A2 * $C1)/($A1 * $B2 - $A2 * $B1)
							EndIf
						EndIf
					EndIf
				EndIf
			EndIf
		Next
	Next
	$j=42
	For $i=0 to 41
		If ($Grid[$i][$j][2]>0 and $Grid[$i+1][$j][2]>0) Then ; Down and to the right edges
			If (($x < $Grid[$i+1][$j][0]) and ($Grid[$i][$j][0] < $AimX)) Or (($x > $Grid[$i][$j][0]) and ($Grid[$i+1][$j][0] > $AimX)) Then
				If (($y < $Grid[$i+1][$j][1]) and ($Grid[$i][$j][1] < $AimY)) Or (($y > $Grid[$i][$j][1]) and ($Grid[$i+1][$j][1] > $AimY)) Then
					$A1 = $AimY - $y
					$B1 = $x - $AimX
					$C1 = ($A1 * $x) + ($B1 * $y)
					$A2 = $Grid[$i+1][$j][1] - $Grid[$i][$j][1]
					$B2 = $Grid[$i][$j][0] - $Grid[$i+1][$j][0]
					$C2 = ($A2 * $Grid[$i][$j][0]) + ($B2 * $Grid[$i][$j][1])
					If $A1*$B2 <> $A2*$B1 Then
						$IntX = ($B2 * $C1 - $B1 * $C2)/($A1 * $B2 - $A2 * $B1)
						If $Grid[$i][$j][0] < $IntX and $IntX < $Grid[$i+1][$j][0] Then
							; They cross, so lets make intersection the new aimed point
							$AimX = ($B2 * $C1 - $B1 * $C2)/($A1 * $B2 - $A2 * $B1)
							$AimY = ($A1 * $C2 - $A2 * $C1)/($A1 * $B2 - $A2 * $B1)
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
	Next
	$i=42
	For $j=0 to 41
		If ($Grid[$i][$j][2]>0 and $Grid[$i][$j+1][2]>0) Then ; Up and to the right edges
			If (($x < $Grid[$i][$j+1][0]) and ($Grid[$i][$j][0] < $AimX)) Or (($x > $Grid[$i][$j][0]) and ($Grid[$i][$j+1][0] > $AimX)) Then
				If (($y < $Grid[$i][$j][1]) and ($Grid[$i][$j+1][1] < $AimY)) Or (($y > $Grid[$i][$j+1][1]) and ($Grid[$i][$j][1] > $AimY)) Then
					$A1 = $AimY - $y
					$B1 = $x - $AimX
					$C1 = ($A1 * $x) + ($B1 * $y)
					$A2 = $Grid[$i][$j+1][1] - $Grid[$i][$j][1]
					$B2 = $Grid[$i][$j][0] - $Grid[$i][$j+1][0]
					$C2 = ($A2 * $Grid[$i][$j][0]) + ($B2 * $Grid[$i][$j][1])
					If $A1*$B2 <> $A2*$B1 Then
						$IntX = ($B2 * $C1 - $B1 * $C2)/($A1 * $B2 - $A2 * $B1)
						If $Grid[$i][$j][0] < $IntX and $IntX < $Grid[$i][$j+1][0] Then
							; They cross, so lets make intersection the new aimed point
							$AimX = ($B2 * $C1 - $B1 * $C2)/($A1 * $B2 - $A2 * $B1)
							$AimY = ($A1 * $C2 - $A2 * $C1)/($A1 * $B2 - $A2 * $B1)
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
	Next
	; Now we are sitting right on top of the edge so let's move back a bit
	$m = ($AimY - $y)/($AimX - $x)
	$Dist = _Random_Gaussian($BufferDist,2)
	$deltaX = (($Dist^2)/(1+$m^2))^.5
	If $AimX > $x Then $deltaX=$deltaX*-1
	If Abs($x-$AimX) < Abs($deltaX) Then
		$AimX=Round($x)
		$AimY=Round($y)
	Else
		$AimX = Round($AimX + $deltaX)
		$AimY = Round($AimY + $m * $deltaX)
	EndIf
	If $times <> 1 Then
		For $i = 0 To ($times - 1)
			ControlClick($Title, "", "", "left", "1", $AimX, $AimY)
			_GDIPlus_GraphicsDrawEllipse($Buffer, $AimX - 2, $AimY - 2, 4, 4, $Pen)
			If _Sleep($speed, False) Then ExitLoop
		Next
	Else
		ControlClick($Title, "", "", "left", "1", $AimX, $AimY)
		_GDIPlus_GraphicsDrawEllipse($Buffer, $AimX - 2, $AimY - 2, 4, 4, $Pen)
	EndIf
EndFunc

Func SeekEdges()
	; Clear edge data
	SetLog("Analyzing base...", $COLOR_BLUE)
	For $j = 0 To 42
		For $i = 0 To 42
			$Grid[$j][$i][2] = 0
		Next
	Next

	$BitmapData = _GDIPlus_BitmapLockBits($hAttackBitmap, 0, 0, _GDIPlus_ImageGetWidth($hAttackBitmap), _GDIPlus_ImageGetHeight($hAttackBitmap), $GDIP_ILMREAD, $GDIP_PXF32RGB)
	$Stride = DllStructGetData($BitmapData, "Stride")
	$Scan0 = DllStructGetData($BitmapData, "Scan0")
	For $i = 0 To 41
		For $j = 0 To 41
			$YesEdge = False
			$m = ($Grid[$i][$j + 1][1] - $Grid[$i][$j][1]) / ($Grid[$i][$j + 1][0] - $Grid[$i][$j][0])
			For $x = $Grid[$i][$j][0] To $Grid[$i][$j + 1][0]
				$y = Round($m * ($x - $Grid[$i][$j][0]) + $Grid[$i][$j][1])
				$pixel = DllStructCreate("dword", $Scan0 + $y * $Stride + $x * 4)
				If CompareColor(BitShift(BitAND(DllStructGetData($pixel, 1), 0xFF0000), 16), BitShift(BitAND(DllStructGetData($pixel, 1), 0xFF00), 8), BitAND(DllStructGetData($pixel, 1), 0xFF)) Then $YesEdge = True
				If $EdgeLevel > 1 Then
					$pixel = DllStructCreate("dword", $Scan0 + $y * $Stride + ($x - 1) * 4)
					If CompareColor(BitShift(BitAND(DllStructGetData($pixel, 1), 0xFF0000), 16), BitShift(BitAND(DllStructGetData($pixel, 1), 0xFF00), 8), BitAND(DllStructGetData($pixel, 1), 0xFF)) Then $YesEdge = True
					If $EdgeLevel > 2 Then
						$pixel = DllStructCreate("dword", $Scan0 + $y * $Stride + ($x + 1) * 4)
						If CompareColor(BitShift(BitAND(DllStructGetData($pixel, 1), 0xFF0000), 16), BitShift(BitAND(DllStructGetData($pixel, 1), 0xFF00), 8), BitAND(DllStructGetData($pixel, 1), 0xFF)) Then $YesEdge = True
					EndIf
				EndIf
			Next
			If $YesEdge Then
				$Grid[$i][$j][2] = 1
				$Grid[$i][$j+1][2] = 1
			EndIf
			$YesEdge = False
			$m = ($Grid[$i + 1][$j][1] - $Grid[$i][$j][1]) / ($Grid[$i + 1][$j][0] - $Grid[$i][$j][0])
			For $x = $Grid[$i][$j][0] To $Grid[$i + 1][$j][0]
				$y = Round($m * ($x - $Grid[$i][$j][0]) + $Grid[$i][$j][1])
				$pixel = DllStructCreate("dword", $Scan0 + $y * $Stride + $x * 4)
				If CompareColor(BitShift(BitAND(DllStructGetData($pixel, 1), 0xFF0000), 16), BitShift(BitAND(DllStructGetData($pixel, 1), 0xFF00), 8), BitAND(DllStructGetData($pixel, 1), 0xFF)) Then $YesEdge = True
				If $EdgeLevel > 1 Then
					$pixel = DllStructCreate("dword", $Scan0 + $y * $Stride + ($x - 1) * 4)
					If CompareColor(BitShift(BitAND(DllStructGetData($pixel, 1), 0xFF0000), 16), BitShift(BitAND(DllStructGetData($pixel, 1), 0xFF00), 8), BitAND(DllStructGetData($pixel, 1), 0xFF)) Then $YesEdge = True
					If $EdgeLevel > 2 Then
						$pixel = DllStructCreate("dword", $Scan0 + $y * $Stride + ($x + 1) * 4)
						If CompareColor(BitShift(BitAND(DllStructGetData($pixel, 1), 0xFF0000), 16), BitShift(BitAND(DllStructGetData($pixel, 1), 0xFF00), 8), BitAND(DllStructGetData($pixel, 1), 0xFF)) Then $YesEdge = True
					EndIf
				EndIf
			Next
			If $YesEdge Then
				$Grid[$i][$j][2] = 1
				$Grid[$i+1][$j][2] = 1
			EndIf
		Next
	Next
	$i = 42
	For $j = 0 To 41
		$YesEdge = False
		$m = ($Grid[$i][$j + 1][1] - $Grid[$i][$j][1]) / ($Grid[$i][$j + 1][0] - $Grid[$i][$j][0])
		For $x = $Grid[$i][$j][0] To $Grid[$i][$j + 1][0]
			$y = Round($m * ($x - $Grid[$i][$j][0]) + $Grid[$i][$j][1])
			$pixel = DllStructCreate("dword", $Scan0 + $y * $Stride + $x * 4)
			If CompareColor(BitShift(BitAND(DllStructGetData($pixel, 1), 0xFF0000), 16), BitShift(BitAND(DllStructGetData($pixel, 1), 0xFF00), 8), BitAND(DllStructGetData($pixel, 1), 0xFF)) Then $YesEdge = True
			If $EdgeLevel > 1 Then
				$pixel = DllStructCreate("dword", $Scan0 + $y * $Stride + ($x - 1) * 4)
				If CompareColor(BitShift(BitAND(DllStructGetData($pixel, 1), 0xFF0000), 16), BitShift(BitAND(DllStructGetData($pixel, 1), 0xFF00), 8), BitAND(DllStructGetData($pixel, 1), 0xFF)) Then $YesEdge = True
				If $EdgeLevel > 2 Then
					$pixel = DllStructCreate("dword", $Scan0 + $y * $Stride + ($x + 1) * 4)
					If CompareColor(BitShift(BitAND(DllStructGetData($pixel, 1), 0xFF0000), 16), BitShift(BitAND(DllStructGetData($pixel, 1), 0xFF00), 8), BitAND(DllStructGetData($pixel, 1), 0xFF)) Then $YesEdge = True
				EndIf
			EndIf
		Next
		If $YesEdge Then
			$Grid[$i][$j][2] = 1
			$Grid[$i][$j+1][2] = 1
		EndIf
	Next
	$j = 42
	For $i = 0 To 41
		$YesEdge = False
		$m = ($Grid[$i + 1][$j][1] - $Grid[$i][$j][1]) / ($Grid[$i + 1][$j][0] - $Grid[$i][$j][0])
		For $x = $Grid[$i][$j][0] To $Grid[$i + 1][$j][0]
			$y = Round($m * ($x - $Grid[$i][$j][0]) + $Grid[$i][$j][1])
			$pixel = DllStructCreate("dword", $Scan0 + $y * $Stride + $x * 4)
			If CompareColor(BitShift(BitAND(DllStructGetData($pixel, 1), 0xFF0000), 16), BitShift(BitAND(DllStructGetData($pixel, 1), 0xFF00), 8), BitAND(DllStructGetData($pixel, 1), 0xFF)) Then $YesEdge = True
			If $EdgeLevel > 1 Then
				$pixel = DllStructCreate("dword", $Scan0 + $y * $Stride + ($x - 1) * 4)
				If CompareColor(BitShift(BitAND(DllStructGetData($pixel, 1), 0xFF0000), 16), BitShift(BitAND(DllStructGetData($pixel, 1), 0xFF00), 8), BitAND(DllStructGetData($pixel, 1), 0xFF)) Then $YesEdge = True
				If $EdgeLevel > 2 Then
					$pixel = DllStructCreate("dword", $Scan0 + $y * $Stride + ($x + 1) * 4)
					If CompareColor(BitShift(BitAND(DllStructGetData($pixel, 1), 0xFF0000), 16), BitShift(BitAND(DllStructGetData($pixel, 1), 0xFF00), 8), BitAND(DllStructGetData($pixel, 1), 0xFF)) Then $YesEdge = True
				EndIf
			EndIf
		Next
		If $YesEdge Then
			$Grid[$i][$j][2] = 1
			$Grid[$i+1][$j][2] = 1
		EndIf
	Next
	_GDIPlus_BitmapUnlockBits($hAttackBitmap, $BitmapData)

	; Clean it up
	$j = 0
	For $i = 1 to 41
		$Neighbors = 0
		If $Grid[$i-1][$j][2]=1 Then $Neighbors +=1
		If $Grid[$i+1][$j][2]=1 Then $Neighbors +=1
		If $Grid[$i][$j+1][2]=1 Then $Neighbors +=1
		If $Neighbors < 2 Then $Grid[$i][$j][2]=0
	Next
	$i = 0
	For $j = 1 to 41
		$Neighbors = 0
		If $Grid[$i][$j-1][2]=1 Then $Neighbors +=1
		If $Grid[$i][$j+1][2]=1 Then $Neighbors +=1
		If $Grid[$i+1][$j][2]=1 Then $Neighbors +=1
		If $Neighbors < 2 Then $Grid[$i][$j][2]=0
	Next
	For $i =1 to 41
		For $j = 1 to 41
			If $Grid[$i][$j][2]=0 and $Grid[$i+1][$j][2]=1 and $Grid[$i][$j+1][2]=1 and $Grid[$i+1][$j+1][2]=1 Then $Grid[$i][$j][2]=2
			If $Grid[$i][$j][2]=0 and $Grid[$i][$j-1][2]=1 and $Grid[$i+1][$j-1][2]=1 and $Grid[$i+1][$j][2]=1 Then $Grid[$i][$j][2]=2
			If $Grid[$i][$j][2]=0 and $Grid[$i-1][$j][2]=1 and $Grid[$i][$j-1][2]=1 and $Grid[$i-1][$j-1][2]=1 Then $Grid[$i][$j][2]=2
			If $Grid[$i][$j][2]=0 and $Grid[$i-1][$j][2]=1 and $Grid[$i][$j+1][2]=1 and $Grid[$i-1][$j+1][2]=1 Then $Grid[$i][$j][2]=2
			$Neighbors = 0
			If $Grid[$i][$j-1][2]=1 Then $Neighbors +=1
			If $Grid[$i][$j+1][2]=1 Then $Neighbors +=1
			If $Grid[$i-1][$j][2]=1 Then $Neighbors +=1
			If $Grid[$i+1][$j][2]=1 Then $Neighbors +=1
			If $Neighbors < 2 Then $Grid[$i][$j][2]=0
		Next
	Next
	$j = 42
	For $i = 1 to 41
		$Neighbors = 0
		If $Grid[$i-1][$j][2]=1 Then $Neighbors +=1
		If $Grid[$i+1][$j][2]=1 Then $Neighbors +=1
		If $Grid[$i][$j-1][2]=1 Then $Neighbors +=1
		If $Neighbors = 1 Then $Grid[$i][$j][2]=0
	Next
	$i = 42
	For $j = 1 to 41
		$Neighbors = 0
		If $Grid[$i][$j-1][2]=1 Then $Neighbors +=1
		If $Grid[$i][$j+1][2]=1 Then $Neighbors +=1
		If $Grid[$i-1][$j][2]=1 Then $Neighbors +=1
		If $Neighbors = 1 Then $Grid[$i][$j][2]=0
	Next
	SetLog("Done!", $COLOR_BLUE)
EndFunc

Func CompareColor($cRed, $cGreen, $cBlue, $tol = 7)
	For $w = 0 To $numEdges - 1
		If Abs($cRed - $EdgeColors[$w][0]) < $tol Then
			If Abs($cGreen - $EdgeColors[$w][1]) < $tol Then
				If Abs($cBlue - $EdgeColors[$w][2]) < $tol Then
					Return True
				EndIf
			EndIf
		EndIf
	Next
	Return False
EndFunc   ;==>CompareColor

