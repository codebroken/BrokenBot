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
Global $TrainBarbarian[4] = [261, 366, 0x39D8E0, 20] ;
Global $TrainArcher[4] = [369, 366, 0x2DA7B3, 20] ;
Global $TrainGiant[4] = [475, 366, 0x3DD8E0, 20] ;
Global $TrainGoblin[4] = [581, 366, 0x39D8E0, 20] ;
Global $TrainWallbreaker[4] = [688, 366, 0x3AD8E0, 20] ;

Global $TrainMinion[4] = [261, 365, 0x43D9E2, 28] ;
;Global $TrainMinion[4]				= [261, 365, 0x5DDCE5, 10] ;
Global $TrainHog[4] = [369, 366, 0x39CBDA, 10] ;
Global $TrainValkyrie[4] = [475, 365, 0x3CD8E0, 10] ;

Global $NextBtn[2] = [750, 500]
; Someone asking troupes : Color 0xD0E978 in x = 121


Func SelectDropTroupe($troop)
	Click(68 + (72 * $troop), 595)
EndFunc   ;==>SelectDropTroupe

; Read the quantity for a given troop
Func ReadTroopQuantity($troop)
	Return Number(getNormal(40 + (72 * $troop), 565))
EndFunc   ;==>ReadTroopQuantity

Func IdentifyTroopKind($position)
	_CaptureRegion()
	$TroopPixel = _GetPixelColor(68 + (72 * $position), 595)
	If _ColorCheck($TroopPixel, Hex(0xF8B020, 6), 5) Then Return $eBarbarian ;Check if slot is Barbarian
	If _ColorCheck($TroopPixel, Hex(0xD83F68, 6), 5) Then Return $eArcher ;Check if slot is Archer
	If _ColorCheck($TroopPixel, Hex(0x7BC950, 6), 5) Then Return $eGoblin ;Check if slot is Goblin
	If _ColorCheck($TroopPixel, Hex(0xF8D49E, 6), 5) Then Return $eGiant ;Check if slot is Giant
	If _ColorCheck($TroopPixel, Hex(0x60A4D0, 6), 5) Then Return $eWallbreaker ;Check if slot is Wallbreaker
	If _ColorCheck(_GetPixelColor(68 + (72 * $position), 586), Hex(0x162038, 6), 5) Then Return $eMinion ;Check if slot is Minions
	If _ColorCheck($TroopPixel, Hex(0x603B30, 6), 5) Then Return $eHog ;Check if slot is Hogs
	If _ColorCheck($TroopPixel, Hex(0xB9645F, 6), 5) Then Return $eValkyrie ;Check if slot is Valkyries
	If _ColorCheck($TroopPixel, Hex(0xF8EB79, 6), 5) Then Return $eKing ;Check if slot is King
	;$OtherPixel = _GetPixelColor(68 + (72 * $position), 588)

	If _ColorCheck(_GetPixelColor(68 + (72 * $position), 588), Hex(0x7031F0, 6), 5) Then Return $eQueen ;Check if slot is Queen
	If _ColorCheck(_GetPixelColor(68 + (72 * $position), 588), Hex(0x7832F8, 6), 5) Then Return $eQueen ;Check if slot is Queen
	If _ColorCheck(_GetPixelColor(68 + (72 * $position), 585), Hex(0x68ACD4, 6), 5) Then Return $eCastle ;Check if slot is Clan Castle
	If _ColorCheck(_GetPixelColor(68 + (72 * $position), 632), Hex(0x0426EC, 6), 7) Then Return $eLSpell ;Check if slot is Lightning Spell
	Return -1
EndFunc   ;==>IdentifyTroopKind
