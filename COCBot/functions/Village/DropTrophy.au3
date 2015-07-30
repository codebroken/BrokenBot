;Gets trophy count of village and compares to max trophy input.
;Will drop a troop and return home with no screenshot or gold wait.

Func DropTrophy()
	Local $i
	Local $TrophyCount = getOther(50, 74, "Trophy")
	If Number($TrophyCount) > Number($itxtMaxTrophy) Then
		SetLog(GetLangText("msgTrophyCount") & $TrophyCount, $COLOR_GREEN)
		While Number($TrophyCount) > Number($itxtMinTrophy)
			If Number($TrophyCount) > Number($itxtMinTrophy) Then
				SetLog(GetLangText("msgDropTrophies"), $COLOR_BLUE)
				If StatusCheck() Then Return False

				PrepareSearch()

				$i = 0
				While getGold(51, 66) = "" ; Loops until gold is readable
					If _Sleep(100) Then ExitLoop (2)
					$i += 1
					If $i >= 100 Then
						Return True
					EndIf
				WEnd

				$KingAt = -1
				$QueenAt = -1
				$LSpellAt = -1
				For $i = 0 To 8
					If IdentifyTroopKind($i) = $eKing Then $KingAt = $i
					If IdentifyTroopKind($i) = $eQueen Then $QueenAt = $i
					If IdentifyTroopKind($i) = $eLSpell Then $LSpellAt = $i
				Next

				$Zapped = False
				If $LSpellAt <> -1 Then ; If we found a lightning spell
					$DarkElix = 0
					$Trophies = getTrophy(51, 66 + 90)
					If $Trophies <> "" Then
						$DarkElix = getDarkElixir(51, 66 + 57)
					EndIf
					If Number($DarkElix) >= GUICtrlRead($txtDENukeLimit) Then ; If there is enough DE present
						If checkDarkElix() Then ; If we can see the DE storage
							SelectDropTroupe($LSpellAt) ; All these checks passed so lets zap the damn thing
							If _Sleep(200) Then Return False
							$z = 0
							Do
								Click(Round(_Random_Gaussian($DEx, 2)), Round(_Random_Gaussian($DEy - 5, 2)))
								If _Sleep(200) Then Return False
								$nSpellQty = ReadTroopQuantity($LSpellAt)
								$z = $z + 1
							Until $nSpellQty = 0 Or $z = 100
							$Zapped = True ; We zapped, so don't bother dropping a troop
						EndIf
					EndIf
					If _Sleep(2000) Then Return False
				EndIf

				If Not $Zapped Then
					$DropTroop = 0 ; Default to dropping first troop available
					If $QueenAt <> -1 Then $DropTroop = $QueenAt
					If $KingAt <> -1 Then $DropTroop = $KingAt
					SelectDropTroupe($DropTroop)
					If _Sleep(200) Then Return False
					_CaptureRegion()
					$hAttackBitmap = _GDIPlus_BitmapCloneArea($hBitmap, 0, 0, 860, 720, _GDIPlus_ImageGetPixelFormat($hBitmap))
					SeekEdges()
					_GDIPlus_ImageDispose($hAttackBitmap)
					$i = 1
					Do
						Switch Random(0, 3, 1) ; I despise everything looking bottish -- lets randomly drop on some side
							Case 0
								$x = Round(_Random_Gaussian(((($FurthestTopLeft[4][0]-$FurthestTopLeft[0][0])/2)+$FurthestTopLeft[0][0]), (($FurthestTopLeft[4][0]-$FurthestTopLeft[0][0])/5)))
								$y = Round((($FurthestTopLeft[4][1] - $FurthestTopLeft[0][1]) / ($FurthestTopLeft[4][0] - $FurthestTopLeft[0][0])) * ($x - $FurthestTopLeft[0][0])) + $FurthestTopLeft[0][1]
							Case 1
								$x = Round(_Random_Gaussian(((($FurthestTopRight[4][0]-$FurthestTopRight[0][0])/2)+$FurthestTopRight[0][0]), (($FurthestTopRight[4][0]-$FurthestTopRight[0][0])/5)))
								$y = Round((($FurthestTopRight[4][1] - $FurthestTopRight[0][1]) / ($FurthestTopRight[4][0] - $FurthestTopRight[0][0])) * ($x - $FurthestTopRight[0][0])) + $FurthestTopRight[0][1]
							Case 2
								$x = Round(_Random_Gaussian(((($FurthestBottomLeft[4][0]-$FurthestBottomLeft[0][0])/2)+$FurthestBottomLeft[0][0]), (($FurthestBottomLeft[4][0]-$FurthestBottomLeft[0][0])/5)))
								$y = Round((($FurthestBottomLeft[4][1] - $FurthestBottomLeft[0][1]) / ($FurthestBottomLeft[4][0] - $FurthestBottomLeft[0][0])) * ($x - $FurthestBottomLeft[0][0])) + $FurthestBottomLeft[0][1]
							Case 3
								$x = Round(_Random_Gaussian(((($FurthestBottomRight[4][0]-$FurthestBottomRight[0][0])/2)+$FurthestBottomRight[0][0]), (($FurthestBottomRight[4][0]-$FurthestBottomRight[0][0])/5)))
								$y = Round((($FurthestBottomRight[4][1] - $FurthestBottomRight[0][1]) / ($FurthestBottomRight[4][0] - $FurthestBottomRight[0][0])) * ($x - $FurthestBottomRight[0][0])) + $FurthestBottomRight[0][1]
						EndSwitch
						If $i = 4 Then
							Click($x, $y)
						Else
							RedLineDeploy($x, $y)
						EndIf
						$DropFailed = False
						If _Sleep(100) Then Return False
						_CaptureRegion()
						If _ColorCheck(_GetPixelColor(200, 190), Hex(0xFF1919, 6), 20) Then
							$DropFailed = True
							If _Sleep(5000) Then Return False ; Wait 3 seconds for the error message to disappear
						EndIf
						$i += 1
					Until Not $DropFailed Or $i > 4
					If $DropTroop = 0 Then ; Don't just assume the troop you dropped was an archer
						Switch IdentifyTroopKind(0)
							Case $eArcher
								$CurArch += 1
							Case $eBarbarian
								$CurBarb += 1
							Case $eGiant
								$CurGiant += 1
							Case $eGoblin
								$CurGoblin += 1
							Case $eWallbreaker
								$CurWB += 1
							Case Else
								; I don't know what we dropped
						EndSwitch
					EndIf
					If _Sleep(300) Then ExitLoop
				EndIf

				ReturnHome(False, False) ;Return home no screenshot
				If StatusCheck() Then Return False
				$TrophyCount = getOther(50, 74, "Trophy")
				SetLog(GetLangText("msgTrophyCount") & $TrophyCount, $COLOR_GREEN)
			Else
				SetLog(GetLangText("msgDropComplete"), $COLOR_BLUE)
			EndIf
		WEnd
		Return True
	EndIf
EndFunc   ;==>DropTrophy
