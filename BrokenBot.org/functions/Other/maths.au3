Global Const $pi = 4 * ATan(1)

Func FindIntersection($Ax1, $Ay1, $Ax2, $Ay2, $Bx1, $By1, $Bx2, $By2)
	$A1 = $Ay2 - $Ay1
	$B1 = $Ax1 - $Ax2
	$C1 = ($A1 * $Ax1) + ($B1 * $Ay1)
	$A2 = $By2 - $By1
	$B2 = $Bx1 - $Bx2
	$C2 = ($A2 * $Bx1) + ($B2 * $By1)
	If $A1 * $B2 <> $A2 * $B1 Then
		Local $Return[2]
		$Return[0] = ($B2 * $C1 - $B1 * $C2) / ($A1 * $B2 - $A2 * $B1)
		$Return[1] = ($A1 * $C2 - $A2 * $C1) / ($A1 * $B2 - $A2 * $B1)
		Return $Return
	Else
		Return -1
	EndIf
EndFunc

Func Max($A, $B)
	If $A > $B Then
		Return $A
	Else
		Return $B
	EndIf
EndFunc

Func Min($A, $B)
	If $A < $B Then
		Return $A
	Else
		Return $B
	EndIf
EndFunc

Func IsBetween($A, $B, $C)
	If $A <= Max($B, $C) And $A >= Min($B, $C) Then Return True
	Return False
EndFunc

Func onSegment($Px, $Py, $Qx, $Qy, $Rx, $Ry)
	If $Qx <= Max($Px, $Rx) And $Qx >= Min($Px, $Rx) And $Qy <= Max($Py, $Ry) And $Qy >= Min($Py, $Ry) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func Orientation($Px, $Py, $Qx, $Qy, $Rx, $Ry)
	$val = ($Qy - $Py) * ($Rx - $Qx) - ($Qx - $Px) * ($Ry - $Qy)
	If $val = 0 Then Return 0
	Return ($val > 0) ? (1) : (2)
EndFunc

Func SegmentIntersect($P1x, $P1y, $P2x, $P2y, $Q1x, $Q1y, $Q2x, $Q2y)
	$O1 = Orientation($P1x, $P1y, $P2x, $P2y, $Q1x, $Q1y)
	$O2 = Orientation($P1x, $P1y, $P2x, $P2y, $Q2x, $Q2y)
	$O3 = Orientation($Q1x, $Q1y, $Q2x, $Q2y, $P1x, $P1y)
	$O4 = Orientation($Q1x, $Q1y, $Q2x, $Q2y, $P2x, $P2y)

	If $O1 <> $O2 And $O3 <> $O4 Then Return True
	If $O1 = 0 And onSegment($P1x, $P1y, $Q1x, $Q1y, $P2x, $P2y) Then Return True
	If $O2 = 0 And onSegment($P1x, $P1y, $Q2x, $Q2y, $P2x, $P2y) Then Return True
	If $O3 = 0 And onSegment($Q1x, $Q1y, $P1x, $P1y, $Q2x, $Q2y) Then Return True
	If $O4 = 0 And onSegment($Q1x, $Q1y, $P2x, $P2y, $Q2x, $Q2y) Then Return True

	Return False
EndFunc

Func PolarCoord($PointX, $PointY, $CentX, $CentY)
	; Returns difference between points in radius and radians
	Local $ReturnCoord[2]
	$xLocation = $PointX - $CentX
	$yLocation = $PointY - $CentY
	Select
		Case $xLocation > 0 And $yLocation >= 0
			$ReturnCoord[1] = ATan($yLocation / $xLocation)
		Case $xLocation > 0 And $yLocation < 0
			$ReturnCoord[1] = ATan($yLocation / $xLocation) + 2 * $pi
		Case $xLocation < 0
			$ReturnCoord[1] = ATan($yLocation / $xLocation) + $pi
		Case $xLocation = 0 And $yLocation > 0
			$ReturnCoord[1] = $pi / 2
		Case $xLocation = 0 And $yLocation < 0
			$ReturnCoord[1] = 3 * $pi / 2
		Case $xLocation = 0 And $yLocation = 0
			$ReturnCoord[1] = 0
	EndSelect
	$ReturnCoord[0] = Sqrt($xLocation ^ 2 + $yLocation ^ 2)
	Return $ReturnCoord
EndFunc

Func CartCoord($Radius, $Radians)
	; Returns X, Y coordinates from polar input
	Local Const $pi = 4 * ATan(1)
	Local $ReturnCoord[2]
	$ReturnCoord[0] = $Radius * Cos($Radians)
	$ReturnCoord[1] = $Radius * Sin($Radians)
	Return $ReturnCoord
EndFunc

Func ToLeft($Xa, $Ya, $Xb, $Yb, $Xc, $Yc)
	; Returns True if Point defined by Xc, Yc is to the left of a line defined by points Xa, Ya and Xb, Yb
    return (($Xb - $Xa)*($Yc - $Ya) - ($Yb - $Ya)*($Xc - $Xa)) > 0
EndFunc

Func SmallerAngleBetween($RadianA, $RadianB)
	; First ensure all angles are between 0 and 2pi
	While $RadianA < 0
		$RadianA += (2 * $pi)
	WEnd
	While $RadianA > (2 * $pi)
		$RadianA -= (2 * $pi)
	WEnd
	While $RadianB < 0
		$RadianB += (2 * $pi)
	WEnd
	While $RadianB > (2 * $pi)
		$RadianB -= (2 * $pi)
	WEnd

	$Diff = $RadianA - $RadianB
	While $Diff < 0
		$Diff += (2 * $pi)
	WEnd
	While $Diff > (2 * $pi)
		$Diff -= (2 * $pi)
	WEnd

	If $Diff > $pi Then
		$Diff = (2 * $pi) - $Diff
	EndIf
	Return $Diff

EndFunc

Func IsAngleBetween($RadianA, $RadianB, $RadianC)
	$AngleMain = SmallerAngleBetween($RadianA, $RadianB)
	$AngleCheck1 = SmallerAngleBetween($RadianA, $RadianC)
	$AngleCheck2 = SmallerAngleBetween($RadianB, $RadianC)
	If $AngleMain > $AngleCheck1 And $AngleMain > $AngleCheck2 Then
		Return True
	Else
		Return False
	EndIf
EndFunc
