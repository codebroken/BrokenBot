;                          x    y     color  tolerance
Global $IsMain[4] = [284, 28, 0x41B1CD, 20] ; origin: [284,  28, 0x41B1CD, 20]
Global $IsMainGrayed[4] = [284, 28, 0x215B69, 20] ; origin: [284,  28, 0x41B1CD, 20]
Global $TopLeftClient[2] = [1, 1]
Global $IsInactive[4] = [458, 311, 0x33B5E5, 20] ; origin: [458, 311, 0x33B5E5, 20]
Global $ReloadButton[2] = [416, 399] ; origin: [416, 399]
Global $AttaqueButton[2] = [60, 614] ; origin: [60, 614]
Global $MatchButton[2] = [217, 510] ; origin: [217, 510]
Global $HasShield[4] = [513, 416, 0x5DAC10, 50] ; origin  [513, 416, 0x5DAC10,  50]
Global $BreakShield[2] = [513, 416] ; origin: [513, 416]
Global $SurrenderButton[2] = [62, 519] ; origin: [62, 519]
Global $ConfirmSurrender[2] = [512, 394] ; origin: [512, 394]
Global $CancelFight[4] = [822, 48, 0xD80408, 20] ; origine:[822, 48, 0xD80408, 20]
Global $CancelFight2[4] = [830, 59, 0xD80408, 20] ; origine:[830,  59, 0xD80408, 20]
Global $CancelFightBtn[2] = [822, 48] ; origine:[822, 48]
Global $EndFightScene[4] = [429, 519, 0xB8E35F, 20] ; Victory or defeat scene
Global $ReturnHome[2] = [428, 544]
Global $CloseChat[4] = [330, 334, 0xF0A03C, 20] ;
Global $SomeXCancelBtn[4] = [819, 55, 0xD80400, 20]
Global $EndBattleBtn[4] = [71, 530, 0xC00000, 20]
Global $Attacked[4] = [235, 209, 0x9E3826, 20] ;
Global $AttackedBtn[2] = [429, 493] ;
Global $HasClanMessage[4] = [31, 313, 0xF80B09, 20] ;
Global $OpenChatBtn[2] = [10, 334] ;
Global $IsClanTabSelected[4] = [204, 20, 0x6F6C4F, 20] ;
Global $IsClanMessage[4] = [26, 320, 0xE70400, 20] ;

Global $ClanRequestTextArea[2] = [430, 140]
Global $ConfirmClanTroopsRequest[2] = [524, 228]
Global $CampFull[4] = [328, 535, 0xD03840, 20] ;

Global $DropTrophiesStartPoint = [34, 310]
Global $TrainBtn[4] = [541, 602, 0x728BB0, 20] ;
Global $TrainBarbarian[4] = [216, 325, 0xF09D1C, 30] ;
Global $TrainArcher[4] = [330, 323, 0xE84070, 30] ;
Global $TrainGiant[4] = [419, 319, 0xF88409, 30] ;
Global $TrainGoblin[4] = [549, 328, 0xFB4C24, 30] ;
Global $TrainWallbreaker[4] = [635, 335, 0x473940, 30] ;

Global $TrainMinion[4] = [261, 365, 0x43D9E2, 28] ;
;Global $TrainMinion[4]				= [261, 365, 0x5DDCE5, 10] ;
Global $TrainHog[4] = [369, 366, 0x39CBDA, 10] ;
Global $TrainValkyrie[4] = [475, 365, 0x3CD8E0, 10] ;

Global $NextBtn[2] = [750, 500]
; Someone asking troupes : Color 0xD0E978 in x = 121


Func SelectDropTroupe($troop)
	Click(68 + (72 * $troop), 595)
	_CaptureRegion()
	$GlobalColor = CommonColor(54 + (72 * $troop), 585, 30, 35)
EndFunc   ;==>SelectDropTroupe

; Read the quantity for a given troop
Func ReadTroopQuantity($troop)
	_CaptureRegion()
	If _ColorCheck(_GetPixelColor(44 + (72 * $troop), 576), Hex(0xFFFFFF, 6), 20) Then
		$ReturnQty = ReadText(43 + (72 * $troop), 578, 54, $textDeployNumber)
	Else
		$ReturnQty = ReadText(43 + (72 * $troop), 583, 54, $textDeployNumber)
	EndIf
	$ReturnQty = StringStripWS($ReturnQty, 8)
	If StringLeft($ReturnQty, 1) = "x" Then $ReturnQty = StringRight($ReturnQty, StringLen($ReturnQty) - 1)
	Return $ReturnQty
EndFunc   ;==>ReadTroopQuantity

Func IdentifyTroopKind($position)

;~ 	If $position = 0 Then
;~ 		Click(68 + 72, 595)
;~ 	Else
;~ 		Click(68, 595)
;~ 	EndIf
;~ 	If $position < 2 Then
;~ 		If _Sleep(500) Then Return
;~ 	EndIf

	_CaptureRegion(32 + (72 * $position), 595, 104 + (72 * $position), 665)
	$sendHBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap)
	$resDeploy = DllCall(@ScriptDir & "\BrokenBot.org\BrokenBot32.dll", "str", "BrokenBotGetDeploy", "ptr", $sendHBitmap, "int", 201, "int", 3, "int", 1, "int", 0, "int", (IsChecked($chkSpeedBoost) ? (1) : (0)))
	_WinAPI_DeleteObject($sendHBitmap)
	If IsArray($resDeploy) Then
		If $resDeploy[0] = -1 Then
			$found = -1
			; check for a large troop image
			_CaptureRegion(32 + (72 * $position), 595, 104 + (72 * $position), 665)
			$sendHBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap)
			$resDeploy = DllCall(@ScriptDir & "\BrokenBot.org\BrokenBot32.dll", "str", "BrokenBotGetDeploy", "ptr", $sendHBitmap, "int", 203, "int", 3, "int", 1, "int", 0, "int", (IsChecked($chkSpeedBoost) ? (1) : (0)))
			_WinAPI_DeleteObject($sendHBitmap)
			If IsArray($resDeploy) Then
				If $resDeploy[0] = -1 Then
					$found = -1
				ElseIf $resDeploy[0] = -2 Then
					SetLog(GetLangText("msgLicense"), $COLOR_RED)
					$found = -1
				Else
					$deploySplit = StringSplit($resDeploy[0], "|", 2)
					$found = $deploySplit[5]
				EndIf
			Else
				$found = -1
				SetLog(GetLangText("msgDLLError"), $COLOR_RED)
			EndIf
		ElseIf $resDeploy[0] = -2 Then
			SetLog(GetLangText("msgLicense"), $COLOR_RED)
			$found = -1
		Else
			$deploySplit = StringSplit($resDeploy[0], "|", 2)
			$found = $deploySplit[5]
		EndIf
	Else
		$found = -1
		SetLog(GetLangText("msgDLLError"), $COLOR_RED)
	EndIf

	Switch $found
		Case 1
			Return $eBarbarian
		Case 2
			Return $eArcher
		Case 3
			Return $eGoblin
		Case 4
			Return $eGiant
		Case 5
			Return $eWallbreaker
		Case 6
			Return $eBalloon
		Case 7
			Return $eWizard
		Case 8
			Return $eHealer
		Case 9
			Return $eDragon
		Case 10
			Return $ePekka
		Case 11
			Return $eMinion
		Case 12
			Return $eHog
		Case 13
			Return $eValkyrie
		Case 14
			Return $eGolem
		Case 15
			Return $eWitch
		Case 16
			Return $eLavaHound
		Case 17
			Return $eKing
		Case 18
			Return $eQueen
		Case 19
			Return $eLSpell
		Case 20
			Return -1
		Case 21
			Return -1
		Case 22
			Return -1
		Case 23
			Return -1
		Case Else
			_CaptureRegion()
			If _ColorCheck(_GetPixelColor(43 + (72 * $position), 604), Hex(0x5B9CD0, 6), 20) Then Return $eCastle ;Check if slot is Clan Castle
			Return -1
	EndSwitch

EndFunc   ;==>IdentifyTroopKind
