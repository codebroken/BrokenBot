Func experience()
	While 1
		Click(66, 607);attack button
		If _Sleep(500) Then ExitLoop

		For $i = 0 To 20
			ControlSend($Title, "", "", "{DOWN}") ; scroll up the goblin page
			If _Sleep(500) Then ExitLoop
		Next

		If _Sleep(3000) Then ExitLoop

		Click(674, 208);choose 2nd goblin base
		If _Sleep(500) Then ExitLoop
		Click(665, 247);attack goblin button
		SetLog("Attacking goblin", $COLOR_BLUE)

		_CaptureRegion()
		While 1
			If _ColorCheck(_GetPixelColor(430, 430), Hex(0x888844, 6), 20) Then
				ExitLoop
			Else
				If _Sleep(1000) Then ExitLoop
				_CaptureRegion()
			EndIf
		WEnd

		If _Sleep(500) Then ExitLoop
		Local $kingPos = getKingPos() ; find king, make sure you have king
		If $kingPos <> -1 Then dropKing(402, 325, $kingPos) ; drop you king

		_CaptureRegion()
		While 1
			If _ColorCheck(_GetPixelColor(430, 530), Hex(0xD0E873, 6), 20) Then
				ExitLoop
			Else
				If _Sleep(1000) Then ExitLoop
				_CaptureRegion()
			EndIf
		WEnd
		;	  If _Sleep(10000) Then ExitLoop ; wait for it to finish. increase the timer if it takes longer
		Click(428, 544) ;return home button

		If _Sleep(1000) Then ExitLoop

		_CaptureRegion()
		While 1
			If _ColorCheck(_GetPixelColor(820, 180), Hex(0xD0EC7C, 6), 20) Then
				ExitLoop
			Else
				If _Sleep(1000) Then ExitLoop
				_CaptureRegion()
			EndIf
		WEnd
		;DonateCC()
		;Sleep(1000)
		;Train()
		SetLog("Victory!", $COLOR_BLUE)
		If _Sleep(1000) Then ExitLoop
	WEnd
EndFunc   ;==>experience

Func getKingPos()
	;   SetLog("Finding king pos", $COLOR_BLUE)
	Local $pos = -1
	For $i = 0 To 8
		Local $troop = IdentifyTroopKind($i)
		If $troop = $eKing Then
			$pos = $i
			ExitLoop
		EndIf
	Next
	Return $pos
EndFunc   ;==>getKingPos

Func dropKing($x = 10, $y = 10, $num = 2)
	If $num <> -1 Then
		;	  SetLog("Dropping King", $COLOR_BLUE)
		Click(68 + (72 * $num), 595) ;Select King
		If _Sleep(500) Then Return
		Click($x, $y)
		If _Sleep(5000) Then Return ;  wait 5 seconds
		Click(68 + (72 * $num), 595) ; before activate king power
	EndIf
EndFunc   ;==>dropKing
