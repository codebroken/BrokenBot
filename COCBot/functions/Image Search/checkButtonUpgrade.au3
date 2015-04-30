Global $checkUpgradelogic
Global $Building[5]

$Building[0] = @ScriptDir & "\images\Building\upgrade.bmp"
$Building[1] = @ScriptDir & "\images\Building\upgrade1.bmp"
$Building[2] = @ScriptDir & "\images\Building\upgrade2.bmp"
$Building[3] = @ScriptDir & "\images\Building\upgrade3.bmp"
$Building[4] = @ScriptDir & "\images\Building\okay.bmp"
Global $BuildLoc
Global $Tolerance2

Func checkButtonUpgrade()
	Switch _GUICtrlComboBox_GetCurSel($cmbTolerance)
		Case 0
			$Tolerance2 = 55
		Case 1
			$Tolerance2 = 35
		Case 2
			$Tolerance2 = 100
	EndSwitch
	#cs
		If _Sleep(500) Then Return
		_CaptureRegion()
		For $i = 0 To 4
		; Getting TH Location
		If $THLocation = 1 Then
		Return $THText[$i]
		EndIf
		Next
		If $THLocation = 0 Then Return "-"
	#ce
	If _Sleep(500) Then Return
	For $i = 0 To 4
		_CaptureRegion()
		;	$WallLoc = _ImageSearch($Building[$icmbWalls], 1, $WallX, $WallY, $Tolerance2) ; Getting Wall Location
		$BuildLoc = _ImageSearch($Building[$i], 1, $txtUpgradeX1, $txtUpgradeY1, $Tolerance2) ; Getting Button upgrade Location

		SetLog("Upgrading...", $COLOR_ORANGE)
		$checkUpgradelogic = True
		Return True

	Next
	$checkUpgradelogic = False
	SetLog("Cannot find Button Upgrade, Skip upgrade...", $COLOR_RED)
	Return False
EndFunc   ;==>checkButtonUpgrade
