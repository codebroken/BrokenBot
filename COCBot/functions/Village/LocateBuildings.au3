
Func LocateBarrack()
	checkMainScreen()
	If Not ZoomOut() Then
		SetLog(GetLangText("msgFailedZoomOut"), $COLOR_BLUE)
		Return False
	EndIf
	SetLog(GetLangText("msgLocatingBarracks"), $COLOR_BLUE)
	Local $MsgBox
	While 1
		While 1
			$MsgBox = MsgBox(6 + 262144, GetLangText("boxBarrack1"), GetLangText("boxBarrack1b"), 0, $frmBot)
			If $MsgBox = 11 Then
				$barrackPos[0][0] = FindPos()[0]
				$barrackPos[0][1] = FindPos()[1]
			ElseIf $MsgBox = 10 Then
				ExitLoop
			Else
				For $i = 0 To 3
					$barrackPos[$i][0] = ""
					$barrackPos[$i][1] = ""
				Next
				ExitLoop (2)
			EndIf
			_Sleep(500)
			$MsgBox = MsgBox(6 + 262144, GetLangText("boxBarrack2"), GetLangText("boxBarrack2b"), 0, $frmBot)
			If $MsgBox = 11 Then
				$barrackPos[1][0] = FindPos()[0]
				$barrackPos[1][1] = FindPos()[1]
			ElseIf $MsgBox = 10 Then
				ExitLoop
			Else
				For $i = 1 To 3
					$barrackPos[$i][0] = ""
					$barrackPos[$i][1] = ""
				Next
				ExitLoop (2)
			EndIf
			_Sleep(500)
			$MsgBox = MsgBox(6 + 262144, GetLangText("boxBarrack3"), GetLangText("boxBarrack3b"), 0, $frmBot)
			If $MsgBox = 11 Then
				$barrackPos[2][0] = FindPos()[0]
				$barrackPos[2][1] = FindPos()[1]
			ElseIf $MsgBox = 10 Then
				ExitLoop
			Else
				For $i = 2 To 3
					$barrackPos[$i][0] = ""
					$barrackPos[$i][1] = ""
				Next
				ExitLoop (2)
			EndIf
			_Sleep(500)
			$MsgBox = MsgBox(6 + 262144, GetLangText("boxBarrack4"), GetLangText("boxBarrack4b"), 0, $frmBot)
			If $MsgBox = 11 Then
				$barrackPos[3][0] = FindPos()[0]
				$barrackPos[3][1] = FindPos()[1]
			ElseIf $MsgBox = 10 Then
				ExitLoop
			Else
				$barrackPos[3][0] = ""
				$barrackPos[3][1] = ""
			EndIf
			_Sleep(500)
			If IsChecked($chkRequest) And $CCPos[0] = "" Then LocateClanCastle()
			ExitLoop (2)
		WEnd
	WEnd
	SaveConfig()
	SetLog(GetLangText("msgLocatingComplete"), $COLOR_BLUE)
	SetLog(GetLangText("msgLocBarrack") & " 1 = " & "(" & $barrackPos[0][0] & "," & $barrackPos[0][1] & ")", $COLOR_GREEN)
	SetLog(GetLangText("msgLocBarrack") & " 2 = " & "(" & $barrackPos[1][0] & "," & $barrackPos[1][1] & ")", $COLOR_GREEN)
	SetLog(GetLangText("msgLocBarrack") & " 3 = " & "(" & $barrackPos[2][0] & "," & $barrackPos[2][1] & ")", $COLOR_GREEN)
	SetLog(GetLangText("msgLocBarrack") & " 4 = " & "(" & $barrackPos[3][0] & "," & $barrackPos[3][1] & ")", $COLOR_GREEN)
EndFunc   ;==>LocateBarrack

Func LocateDarkBarrack()
	checkMainScreen()
	If Not ZoomOut() Then
		SetLog(GetLangText("msgFailedZoomOut"), $COLOR_BLUE)
		Return False
	EndIf
	SetLog(GetLangText("msgLocatingDarkBar"), $COLOR_BLUE)
	Local $MsgBox
	While 1
		While 1
			$MsgBox = MsgBox(6 + 262144, GetLangText("boxDark1"), GetLangText("boxDark1b"), 0, $frmBot)
			If $MsgBox = 11 Then
				$DarkBarrackPos[0][0] = FindPos()[0]
				$DarkBarrackPos[0][1] = FindPos()[1]
			ElseIf $MsgBox = 10 Then
				ExitLoop
			Else
				For $i = 0 To 1
					$DarkBarrackPos[$i][0] = ""
					$DarkBarrackPos[$i][1] = ""
				Next
				ExitLoop (2)
			EndIf
			_Sleep(500)
			$MsgBox = MsgBox(6 + 262144, GetLangText("boxDark2"), GetLangText("boxDark2b"), 0, $frmBot)
			If $MsgBox = 11 Then
				$DarkBarrackPos[1][0] = FindPos()[0]
				$DarkBarrackPos[1][1] = FindPos()[1]
			ElseIf $MsgBox = 10 Then
				ExitLoop
			Else
				For $i = 1 To 1
					$DarkBarrackPos[$i][0] = ""
					$DarkBarrackPos[$i][1] = ""
				Next
				ExitLoop (2)
			EndIf
			ExitLoop (2)
		WEnd
	WEnd
	SaveConfig()
	SetLog(GetLangText("msgLocatingComplete"), $COLOR_BLUE)
	SetLog(GetLangText("msgLocDarkBar") & " 1 = " & "(" & $DarkBarrackPos[0][0] & "," & $DarkBarrackPos[0][1] & ")", $COLOR_GREEN)
	SetLog(GetLangText("msgLocDarkBar") & " 2 = " & "(" & $DarkBarrackPos[1][0] & "," & $DarkBarrackPos[1][1] & ")", $COLOR_GREEN)

EndFunc   ;==>LocateDarkBarrack

Func LocateCamp()
	checkMainScreen()
	If Not ZoomOut() Then
		SetLog(GetLangText("msgFailedZoomOut"), $COLOR_BLUE)
		Return False
	EndIf
	While 1
		$MsgBox = MsgBox(1 + 262144, GetLangText("boxCamp"), GetLangText("boxCampb"), 0, $frmBot)
		If $MsgBox = 1 Then
			$ArmyPos[0] = FindPos()[0]
			$ArmyPos[1] = FindPos()[1]
			SetLog(GetLangText("msgLocArmyCamp") & " =  " & "(" & $ArmyPos[0] & "," & $ArmyPos[1] & ")", $COLOR_GREEN)
		EndIf
		ExitLoop
	WEnd
EndFunc   ;==>LocateCamp

Func LocateClanCastle()
	checkMainScreen()
	If Not ZoomOut() Then
		SetLog(GetLangText("msgFailedZoomOut"), $COLOR_BLUE)
		Return False
	EndIf
	While 1
		$MsgBox = MsgBox(1 + 262144, GetLangText("boxCC"), GetLangText("boxCCb"), 0, $frmBot)
		If $MsgBox = 1 Then
			$CCPos[0] = FindPos()[0]
			$CCPos[1] = FindPos()[1]
			SetLog(GetLangText("msgLocCC") & " =  " & "(" & $CCPos[0] & "," & $CCPos[1] & ")", $COLOR_GREEN)
		EndIf
		ExitLoop
	WEnd
EndFunc   ;==>LocateClanCastle

Func LocateTownHall()
	checkMainScreen()
	If Not ZoomOut() Then
		SetLog(GetLangText("msgFailedZoomOut"), $COLOR_BLUE)
		Return False
	EndIf
	While 1
		$MsgBox = MsgBox(1 + 262144, GetLangText("boxTH"), GetLangText("boxTHb"), 0, $frmBot)
		If $MsgBox = 1 Then
			WinActivate($HWnD)
			$TownHallPos[0] = FindPos()[0]
			$TownHallPos[1] = FindPos()[1]
			SetLog(GetLangText("msgLocTH") & " =  " & "(" & $TownHallPos[0] & "," & $TownHallPos[1] & ")", $COLOR_GREEN)
		EndIf
		ExitLoop
	WEnd
EndFunc   ;==>LocateTownHall

Func LocateKingAltar()
	checkMainScreen()
	If Not ZoomOut() Then
		SetLog(GetLangText("msgFailedZoomOut"), $COLOR_BLUE)
		Return False
	EndIf
	While 1
		$MsgBox = MsgBox(1 + 262144, GetLangText("boxKing"), GetLangText("boxKingb"), 0, $frmBot)
		If $MsgBox = 1 Then
			$KingPos[0] = FindPos()[0]
			$KingPos[1] = FindPos()[1]
			SetLog(GetLangText("msgLocKing") & " =  " & "(" & $KingPos[0] & "," & $KingPos[1] & ")", $COLOR_GREEN)
		EndIf
		ExitLoop
	WEnd
EndFunc   ;==>LocateKingAltar

Func LocateQueenAltar()
	checkMainScreen()
	If Not ZoomOut() Then
		SetLog(GetLangText("msgFailedZoomOut"), $COLOR_BLUE)
		Return False
	EndIf
	While 1
		$MsgBox = MsgBox(1 + 262144, GetLangText("boxQueen"), GetLangText("boxQueenb"), 0, $frmBot)
		If $MsgBox = 1 Then
			$QueenPos[0] = FindPos()[0]
			$QueenPos[1] = FindPos()[1]
			SetLog(GetLangText("msgLocQueen") & " =  " & "(" & $QueenPos[0] & "," & $QueenPos[1] & ")", $COLOR_GREEN)
		EndIf
		ExitLoop
	WEnd
EndFunc   ;==>LocateQueenAltar
Func LocateBuilding()
	checkMainScreen()
	If Not ZoomOut() Then
		SetLog(GetLangText("msgFailedZoomOut"), $COLOR_BLUE)
		Return False
	EndIf
	LocateUpgrade1()
	_Sleep(500)
	LocateUpgrade2()
	_Sleep(500)
	LocateUpgrade3()
	_Sleep(500)
	LocateUpgrade4()
	_Sleep(500)
	LocateUpgrade5()
	_Sleep(500)
	LocateUpgrade6()
	_Sleep(500)

EndFunc   ;==>LocateBuilding
Func LocateUpgrade1()
	checkMainScreen()
	If Not ZoomOut() Then
		SetLog(GetLangText("msgFailedZoomOut"), $COLOR_BLUE)
		Return False
	EndIf
	While 1
		$MsgBox = MsgBox(1 + 262144, GetLangText("boxUpgrade") & " 1", GetLangText("boxUpgradeb"), 0, $frmBot)
		If $MsgBox = 1 Then
			$BuildPos1[0] = FindPos()[0]
			$BuildPos1[1] = FindPos()[1]
			SetLog(GetLangText("msgLocBuilding") & " 1 =  " & "(" & $BuildPos1[0] & "," & $BuildPos1[1] & ")", $COLOR_GREEN)
			GUICtrlSetData($txtUpgradeX1, $BuildPos1[0])
			GUICtrlSetData($txtUpgradeY1, $BuildPos1[1])
		EndIf
		ExitLoop
	WEnd
EndFunc   ;==>LocateUpgrade1

Func LocateUpgrade2()
	checkMainScreen()
	If Not ZoomOut() Then
		SetLog(GetLangText("msgFailedZoomOut"), $COLOR_BLUE)
		Return False
	EndIf
	While 1
		$MsgBox = MsgBox(1 + 262144, GetLangText("boxUpgrade") & " 2", GetLangText("boxUpgradeb"), 0, $frmBot)
		If $MsgBox = 1 Then
			$BuildPos2[0] = FindPos()[0]
			$BuildPos2[1] = FindPos()[1]
			SetLog(GetLangText("msgLocBuilding") & " 2 =  " & "(" & $BuildPos2[0] & "," & $BuildPos2[1] & ")", $COLOR_GREEN)
			GUICtrlSetData($txtUpgradeX2, $BuildPos2[0])
			GUICtrlSetData($txtUpgradeY2, $BuildPos2[1])
		EndIf
		ExitLoop
	WEnd
EndFunc   ;==>LocateUpgrade2

Func LocateUpgrade3()
	checkMainScreen()
	If Not ZoomOut() Then
		SetLog(GetLangText("msgFailedZoomOut"), $COLOR_BLUE)
		Return False
	EndIf
	While 1
		$MsgBox = MsgBox(1 + 262144, GetLangText("boxUpgrade") & " 3", GetLangText("boxUpgradeb"), 0, $frmBot)
		If $MsgBox = 1 Then
			$BuildPos3[0] = FindPos()[0]
			$BuildPos3[1] = FindPos()[1]
			SetLog(GetLangText("msgLocBuilding") & " 3 =  " & "(" & $BuildPos3[0] & "," & $BuildPos3[1] & ")", $COLOR_GREEN)
			GUICtrlSetData($txtUpgradeX3, $BuildPos3[0])
			GUICtrlSetData($txtUpgradeY3, $BuildPos3[1])
		EndIf
		ExitLoop
	WEnd
EndFunc   ;==>LocateUpgrade3

Func LocateUpgrade4()
	checkMainScreen()
	If Not ZoomOut() Then
		SetLog(GetLangText("msgFailedZoomOut"), $COLOR_BLUE)
		Return False
	EndIf
	While 1
		$MsgBox = MsgBox(1 + 262144, GetLangText("boxUpgrade") & " 4", GetLangText("boxUpgradeb"), 0, $frmBot)
		If $MsgBox = 1 Then
			$BuildPos4[0] = FindPos()[0]
			$BuildPos4[1] = FindPos()[1]
			SetLog(GetLangText("msgLocBuilding") & " 4 =  " & "(" & $BuildPos4[0] & "," & $BuildPos4[1] & ")", $COLOR_GREEN)
			GUICtrlSetData($txtUpgradeX4, $BuildPos4[0])
			GUICtrlSetData($txtUpgradeY4, $BuildPos4[1])
		EndIf
		ExitLoop
	WEnd
EndFunc   ;==>LocateUpgrade4

Func LocateUpgrade5()
	checkMainScreen()
	If Not ZoomOut() Then
		SetLog(GetLangText("msgFailedZoomOut"), $COLOR_BLUE)
		Return False
	EndIf
	While 1
		$MsgBox = MsgBox(1 + 262144, GetLangText("boxUpgrade") & " 5", GetLangText("boxUpgradeb"), 0, $frmBot)
		If $MsgBox = 1 Then
			$BuildPos5[0] = FindPos()[0]
			$BuildPos5[1] = FindPos()[1]
			SetLog(GetLangText("msgLocBuilding") & " 5 =  " & "(" & $BuildPos5[0] & "," & $BuildPos5[1] & ")", $COLOR_GREEN)
			GUICtrlSetData($txtUpgradeX5, $BuildPos5[0])
			GUICtrlSetData($txtUpgradeY5, $BuildPos5[1])
		EndIf
		ExitLoop
	WEnd
EndFunc   ;==>LocateUpgrade5


Func LocateUpgrade6()
	checkMainScreen()
	If Not ZoomOut() Then
		SetLog(GetLangText("msgFailedZoomOut"), $COLOR_BLUE)
		Return False
	EndIf
	While 1
		$MsgBox = MsgBox(1 + 262144, GetLangText("boxUpgrade") & " 6", GetLangText("boxUpgradeb"), 0, $frmBot)
		If $MsgBox = 1 Then
			$BuildPos6[0] = FindPos()[0]
			$BuildPos6[1] = FindPos()[1]
			SetLog(GetLangText("msgLocBuilding") & " 6 =  " & "(" & $BuildPos6[0] & "," & $BuildPos6[1] & ")", $COLOR_GREEN)
			GUICtrlSetData($txtUpgradeX6, $BuildPos6[0])
			GUICtrlSetData($txtUpgradeY6, $BuildPos6[1])
		EndIf
		ExitLoop
	WEnd
EndFunc   ;==>LocateUpgrade6

Func LocateSpellFactory()
	checkMainScreen()
	If Not ZoomOut() Then
		SetLog(GetLangText("msgFailedZoomOut"), $COLOR_BLUE)
		Return False
	EndIf
	While 1
		$MsgBox = MsgBox(1 + 262144, GetLangText("boxFactory"), GetLangText("boxFactoryb"), 0, $frmBot)
		If $MsgBox = 1 Then
			$SpellPos[0] = FindPos()[0]
			$SpellPos[1] = FindPos()[1]
			SetLog(GetLangText("msgLocSpellFact") & " =  " & "(" & $SpellPos[0] & "," & $SpellPos[1] & ")", $COLOR_GREEN)
		EndIf
		ExitLoop
	WEnd

	$itxtspellCap = InputBox(GetLangText("inpSpell"), GetLangText("inpSpellb"), "3", " M1")
	If $itxtspellCap >= 1 And $itxtspellCap <= 5 Then
		GUICtrlSetData($txtSpellCap, $itxtspellCap)
	Else
		MsgBox(4096, GetLangText("boxError"), GetLangText("boxErrorb"))
	EndIf
EndFunc   ;==>LocateSpellFactory

Func LocateLab()
	checkMainScreen()
	If Not ZoomOut() Then
		SetLog(GetLangText("msgFailedZoomOut"), $COLOR_BLUE)
		Return False
	EndIf
	$MsgBox = MsgBox(1 + 262144, GetLangText("boxLab"), GetLangText("boxLabb"), 0, $frmBot)
	If $MsgBox = 1 Then
		$LabPos[0] = FindPos()[0]
		$LabPos[1] = FindPos()[1]
		SetLog(GetLangText("msgLocLab") & " =  " & "(" & $LabPos[0] & "," & $LabPos[1] & ")", $COLOR_GREEN)
	EndIf
EndFunc   ;==>LocateLab
